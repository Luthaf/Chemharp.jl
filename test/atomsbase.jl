using Unitful
using UnitfulAtomic

@testset "AtomsBase support" begin
    import AtomsBase
    using AtomsBase: AbstractSystem, FlexibleSystem
    using AtomsBase: PeriodicCell, IsolatedCell
    using AtomsBase: atomic_symbol
    using AtomsBaseTesting

    function make_chemfiles_system(D=3; drop_atprop=Symbol[], infinite=false, kwargs...)
        dropkeys = [:covalent_radius, :vdw_radius]  # Cannot be mutated in Chemfiles
        data = make_test_system(D; drop_atprop=append!(drop_atprop, dropkeys),
                                extra_sysprop=(; extra_data=42.0),
                                cellmatrix=:upper_triangular,
                                kwargs...)
        if infinite
            cell = IsolatedCell(3)
        else
            cell = PeriodicCell(; data.cell_vectors, periodicity=(true, true, true))
        end
        system = AtomsBase.FlexibleSystem(data.atoms, cell; data.sysprop...)
        merge(data, (; system))
    end

    @testset "Conversion AtomsBase -> Chemfiles (periodic, velocity)" begin
        data = make_chemfiles_system(; infinite=false)
        system, atoms, cell, cell_vectors, periodicity, atprop, sysprop = data
        frame = convert(Frame, system)

        D = 3
        cell = Chemfiles.matrix(Chemfiles.UnitCell(frame))
        for i in 1:D
            @test cell[i, :] ≈ ustrip.(u"Å", cell_vectors[i]) atol=1e-12
        end
        @test Chemfiles.shape(Chemfiles.UnitCell(frame)) in (Chemfiles.Triclinic,
                                                             Chemfiles.Orthorhombic)
        for (i, atom) in enumerate(frame)
            @test(Chemfiles.positions(frame)[:, i]
                  ≈ ustrip.(u"Å", atprop.position[i]), atol=1e-12)
            @test(Chemfiles.velocities(frame)[:, i]
                  ≈ ustrip.(u"Å/ps", atprop.velocity[i]), atol=1e-12)

            species_i = atprop.species[i]
            @test Chemfiles.name(atom)            == string(atomic_symbol(species_i))
            @test Chemfiles.atomic_number(atom)   == atomic_number(species_i)
            @test Chemfiles.mass(atom)            == ustrip(u"u", atprop.mass[i])
            @test Chemfiles.charge(atom)          == ustrip(u"e_au", atprop.charge[i])
            @test Chemfiles.list_properties(atom) == ["magnetic_moment"]
            @test Chemfiles.property(atom, "magnetic_moment") == atprop.magnetic_moment[i]

            if atomic_number(atprop.species[i]) == 1
                @test Chemfiles.vdw_radius(atom)      == 1.2
                @test Chemfiles.covalent_radius(atom) == 0.37
            end
        end

        @test Chemfiles.list_properties(frame)    == ["charge", "extra_data", "multiplicity"]
        @test Chemfiles.property(frame, "charge") == ustrip(u"e_au", sysprop.charge)
        @test Chemfiles.property(frame, "extra_data") == sysprop.extra_data
        @test Chemfiles.property(frame, "multiplicity") == sysprop.multiplicity
    end

    @testset "Conversion AtomsBase -> Chemfiles (infinite, no velocity)" begin
        system = make_chemfiles_system(; infinite=true, drop_atprop=[:velocity]).system
        frame  = convert(Frame, system)
        @test Chemfiles.shape(Chemfiles.UnitCell(frame)) == Chemfiles.Infinite
        @test iszero(Chemfiles.velocities(frame))
    end

    @testset "Warning about setting invalid data" begin
        data = make_test_system()
        system, atoms, cell, cell_vectors, periodicity, atprop, sysprop = data
        frame  = @test_logs((:warn, r"Atom vdw_radius in Chemfiles cannot be mutated"),
                            (:warn, r"Atom covalent_radius in Chemfiles cannot be mutated"),
                            (:warn, r"Ignoring unsupported property type Int[0-9]+.*key extra_data"),
                            (:warn, r"Ignoring specified boundary conditions:"),
                            match_mode=:any, convert(Frame, system))

        D = 3
        cell = Chemfiles.matrix(Chemfiles.UnitCell(frame))
        for i in 1:D
            @test cell[i, :] ≈ ustrip.(u"Å", cell_vectors[i]) atol=1e-12
        end
        @test Chemfiles.shape(Chemfiles.UnitCell(frame)) in (Chemfiles.Triclinic,
                                                             Chemfiles.Orthorhombic)
    end

    @testset "Conversion AtomsBase -> Chemfiles -> AtomsBase" begin
        import AtomsBase

        system    = make_chemfiles_system().system
        frame     = convert(Frame, system)
        newsystem = convert(AtomsBase.AbstractSystem, frame)
        test_approx_eq(system, newsystem;
                       rtol=1e-12, ignore_atprop=[:covalent_radius, :vdw_radius])
    end

    @testset "Make sure the water example can be parsed without error" begin
        import AtomsBase
        traj  = Chemfiles.Trajectory(joinpath(@__DIR__, "data", "water.xyz"))
        frame = Chemfiles.read_step(traj, 0)
        sys   = convert(AtomsBase.FlexibleSystem, frame)
        @test length(sys) == length(frame)
    end
end
