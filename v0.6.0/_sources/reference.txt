.. _julia-api:

Julia interface reference
=========================

The `Julia`_ interface to chemfiles wrap around the C interface providing a Julian
API. All the functionalities are in the ``Chemfiles`` module, which can be imported
by the ``using Chemfiles`` expression. The ``Chemfiles`` module is built around the 5
main types of chemfiles: `Trajectory`_, `Frame`_, `UnitCell`_, `Topology`_, and
`Atom`_.

.. _Julia: http://julialang.org/
.. _overview: http://chemfiles.readthedocs.io/en/latest/overview.html

.. warning::
   All indexing in chemfiles is 0-based! That means that the first atom in a frame
   have the index 0, not 1. This is because no translation is made from the
   underlying C library.

   This may change in future release to use 1-based indexing, which is more familiar
   to Julia developers.

Error and logging functions
---------------------------

These functions are not exported, and should be called by there fully qualified name:

.. code-block:: julia

    Chemfiles.last_error()
    Chemfiles.loglevel(Chemfiles.ERROR)

.. jl:function:: Chemfiles.last_error()

    Get the last error message.

.. jl:function:: Chemfiles.clear_errors()

    Clear the last error message.

.. jl:function:: Chemfiles.loglevel()

    Get the current log level.

.. jl:function:: Chemfiles.set_loglevel(level)

    Set the current log level to ``level``.

 The following logging levels are available:

- ``Chemfiles.ERROR``: Only log errors;
- ``Chemfiles.WARNING``: Log warnings and erors. This is the default;
- ``Chemfiles.INFO``: Log infos, warnings and errors;
- ``Chemfiles.DEBUG``: Log everything.

.. jl:function:: Chemfiles.logfile(file)

    Redirect the logs to ``file``, overwriting the file if it exists.

.. jl:function:: Chemfiles.log_to_stdout()

    Redirect the logs to the standard output.

.. jl:function:: Chemfiles.log_to_stderr()

    Redirect the logs to the standard error output. This is enabled by default.

.. jl:function:: Chemfiles.log_silent()

    Remove all logging output

.. jl:function:: Chemfiles.log_callback(callback)

    Use a callback for logging, instead of the built-in logging system. The callback
    function will be called at each log event, with the event level and message.

    The ``callback`` function must have the following signature:

    .. code-block:: julia

        function callback(level::Chemfiles.LogLevel, message::AbstractString)
            # Do work as needed
            return nothing
        end

.. _Trajectory:

``Trajectory`` type and associated functions
--------------------------------------------

A `Trajectory`_ uses a file and a format together to read simulation data from the
file. It can read or write one or many `Frame`_ to this file. The file type and the
format are automatically determined from the extention.

.. jl:function:: Trajectory(filename::String, mode::Char)

    Open a trajectory file.

    :parameter filename: The path to the trajectory file
    :parameter mode: The opening mode: 'r' for read, 'w' for write and
                            'a' for append.

.. jl:function:: read(trajectory::Trajectory) -> Frame

    Read the next step of the `Trajectory`_, and return the corresponding `Frame`_.

.. jl:function:: read!(trajectory::Trajectory, frame::Frame)

    Read the next step of the `Trajectory`_ into an existing `Frame`_.

.. jl:function:: read_step(trajectory::Trajectory, step) -> Frame

    Read the given ``step`` of the `Trajectory`_, and return the corresponding
    `Frame`_.

.. jl:function:: read_step(trajectory::Trajectory, step, frame::Frame)

    Read the given ``step`` of the `Trajectory`_ into an existing `Frame`_.

.. jl:function:: write(trajectory::Trajectory, frame::Frame)

    Write a frame to the `Trajectory`_.

.. jl:function:: set_topology!(trajectory::Trajectory, topology::Topology)

    Set the `Topology`_ associated with a `Trajectory`_. This topology will be
    used when reading and writing the files, replacing any topology in the
    frames or files.

.. jl:function:: set_topology!(trajectory::Trajectory, filename:AbstractString)

    Set the `Topology`_ associated with a `Trajectory`_ by reading the first
    frame of ``filename``; and extracting the topology of this frame.

.. jl:function:: set_cell!(trajectory::Trajectory, cell::UnitCell)

    Set the `UnitCell`_ associated with a `Trajectory`_. This cell will be
    used when reading and writing the files, replacing any unit cell in the
    frames or files.

.. jl:function:: nsteps(trajectory::Trajectory) -> Integer

    Get the number of steps (the number of frames) in a `Trajectory`_.

.. jl:function:: sync(trajectory::Trajectory)

    Synchronize any buffered content to the hard drive.

.. jl:function:: close(trajectory::Trajectory)

    Close a `Trajectory`_, flushing any buffer content to the hard drive, and
    freeing the associated memory.


.. _Frame:

``Frame`` type and associated functions
---------------------------------------

A `Frame`_ holds data for one step of a simulation. As not all formats provides all
the types of informations, some fields may be initialized to a default value. A
`Frame`_ may contains the following data:

- Positions for all the atoms in the system;
- Velocities for all the atoms in the system;
- The `Topology`_ of the system;
- The `UnitCell`_ of the system.

.. jl:function:: Frame(natoms = 0)

    Create an empty `Frame`_ with initial capacity of ``natoms``. It will be
    automatically resized if needed.

.. jl:function:: natoms(frame::Frame) -> Integer

    Get the `Frame`_ size, i.e. the current number of atoms

.. jl:function:: size(frame::Frame) -> Integer

    Get the `Frame`_ size, i.e. the current number of atoms

.. jl:function:: resize!(frame::Frame, natoms::Integer)

    Resize the positions and the velocities in `Frame`_, to make space for `natoms`
    atoms. This function may invalidate any pointer to the positions or the
    velocities if the new size is bigger than the old one. In all the cases, previous
    data is conserved. This function conserve the presence or absence of velocities.

.. jl:function:: positions(frame::Frame) -> Array{Float32, 2}

    Get a pointer to the positions in a `Frame`_. The positions are readable and
    writable from this array. If the frame is resized (by writing to it, or calling
    ``resize``), the array is invalidated.

.. jl:function:: velocities(frame::Frame)

    Get a pointer to the velocities in a `Frame`_. The velocities are readable and
    writable from this array. If the frame is resized (by writing to it, or calling
    ``resize``), the array is invalidated.

    If the frame do not have velocity, this will return an error. Use
    ``add_velocities!`` to add velocities to a frame before calling this function.

.. jl:function:: add_velocities!(frame::Frame)

    Add velocities to this `Frame`_. The storage is initialized with the result of
    ``size(frame)`` as number of atoms. If the frame already have velocities, this
    does nothing.

.. jl:function:: has_velocities(frame::Frame) -> Bool

    Ask wether this `Frame`_ contains velocity data or not.

.. jl:function:: set_cell!(frame::Frame, cell::UnitCell)

    Set the `UnitCell`_ of a `Frame`_.

.. jl:function:: set_topology!(frame::Frame, topology::Topology)

    Set the `Topology`_ of a `Frame`_.

.. jl:function:: step(frame::Frame) -> Integer

    Get the `Frame`_ step, i.e. the frame number in the trajectory.

.. jl:function:: set_step!(frame::Frame, step)

    Set the `Frame`_ step to ``step``.

.. jl:function:: guess_topology!(frame::Frame)

    Guess the bonds, angles and dihedrals in the system using a distance criteria.

.. _UnitCell:

``UnitCell`` type and associated function
-----------------------------------------

An `UnitCell`_ describe the bounding box of a system. It is represented by three base
vectors of lengthes ``a``, ``b`` and ``c``; and the angles between these vectors are
``alpha``, ``beta`` and ``gamma``.

.. jl:function:: UnitCell(a, b, c, alpha=90, beta=90, gamma=90)

    Create an `UnitCell`_ from the three lenghts and the three angles.

.. jl:function:: UnitCell(frame::Frame)

    Get a copy of the `UnitCell`_ of a frame.

.. jl:function:: lengths(cell::UnitCell) -> (Float64, Float64, Float64)

    Get the three `UnitCell`_ lenghts (a, b and c) in angstroms.

.. jl:function:: set_lengths!(cell::UnitCell, a, b, c)

    Set the `UnitCell`_ lenghts to ``a``, ``b`` and ``c`` in angstroms.

.. jl:function:: angles(cell::UnitCell) -> (Float64, Float64, Float64)

    Get the three `UnitCell`_ angles (alpha, beta and gamma) in degrees.

.. jl:function:: set_angles!(cell::UnitCell, alpha, beta, gamma)

    Set the `UnitCell`_ angles to ``alpha``, ``beta`` and ``gamma`` in degrees.

.. jl:function:: cell_matrix(cell::UnitCell) -> Array{Float64, 2}

    Get the `UnitCell`_ matricial representation, i.e. the representation of the
    three base vectors as::

        | a_x   b_x   c_x |
        |  0    b_y   c_y |
        |  0     0    c_z |

.. jl:function:: type(cell::UnitCell) -> CellType

    Get the `UnitCell`_ type.

.. jl:function:: set_type!(cell::UnitCell, celltype::CellType)

    Set the `UnitCell`_ type to ``celltype``.

The following cell types are defined:

- ``Chemfiles.ORTHORHOMBIC`` : The three angles are 90°
- ``Chemfiles.TRICLINIC`` : The three angles may not be 90°
- ``Chemfiles.INFINITE`` : Cell type when there is no periodic boundary conditions

.. jl:function:: volume(cell::UnitCell) -> Float64

    Get the unit cell volume

.. _Topology:

``Topology`` type and associated function
-----------------------------------------

A `Topology`_ describes the organisation of the particles in the system. What are
there names, how are they bonded together, *etc.* A `Topology`_ is a list of `Atom`_
in the system, together with the list of bonds these atoms forms.

.. jl:function:: Topology()

    Create an empty `Topology`_.

.. jl:function:: Topology(frame::Frame)

    Extract the `Topology`_ from a frame.

.. jl:function:: size(topology::Topology)

    Get the `Topology`_ size, i.e. the current number of atoms.

.. jl:function:: natoms(topology::Topology)

    Get the `Topology`_ size, i.e. the current number of atoms.

.. jl:function:: push!(topology::Topology, atom::Atom)

    Add an `Atom`_ at the end of a `Topology`_.

.. jl:function:: remove!(topology::Topology, i)

    Remove an atom from a `Topology`_ by index.

.. jl:function:: isbond(topology::Topology, i, j) -> Bool

    Tell if the atoms ``i`` and ``j`` are bonded together.

.. jl:function:: isangle(topology::Topology, i, j, k) -> Bool

    Tell if the atoms ``i``, ``j`` and ``k`` constitues an angle.

.. jl:function:: isdihedral(topology::Topology, i, j, k, m) -> Bool

    Tell if the atoms ``i``, ``j``, ``k`` and ``m`` constitues a dihedral angle.

.. jl:function:: nbonds(topology::Topology) -> Integer

    Get the number of bonds in the system.

.. jl:function:: nangles(topology::Topology) -> Integer

    Get the number of angles in the system.

.. jl:function:: ndihedrals(topology::Topology) -> Integer

    Get the number of dihedral angles in the system.

.. jl:function:: bonds(topology::Topology) -> Array{UInt, 2}

    Get the bonds in the system, arranged in a 2x ``nbonds`` array.

.. jl:function:: angles(topology::Topology) -> Array{UInt, 2}

    Get the angles in the system, arranges as a 3x ``nangles`` array.

.. jl:function:: dihedrals(topology::Topology) -> Array{UInt, 2}

    Get the dihedral angles in the system, arranged as a 4x ``ndihedrals`` array.

.. jl:function:: add_bond!(topology::Topology, i, j)

    Add a bond between the atoms ``i`` and ``j`` in the system.

.. jl:function:: remove_bond!(topology::Topology, i, j)

    Remove any existing bond between the atoms ``i`` and ``j`` in the system.

.. _Atom:

``Atom`` type and associated function
-------------------------------------

An `Atom`_ contains basic information about a single atom in the system: the name (if
it is disponible), mass, type of atom and so on.

.. jl:function:: Atom(name)

    Create an `Atom`_ from an atomic name.

.. jl:function:: Atom(frame::Frame, idx::Integer)

    Get the `Atom`_ at index ``idx`` from the frame.

.. jl:function:: Atom(topology::Topology, idx::Integer)

    Get the `Atom`_ at index ``idx`` from the topology.

.. jl:function:: mass(atom::Atom) -> Float64

    Get the mass of an `Atom`_, in atomic mass units.

.. jl:function:: set_mass!(atom::Atom, mass::Number)

    Set the mass of an `Atom`_ to ``mass``, in atomic mass units.

.. jl:function:: charge(atom::Atom) -> Float64

    Get the charge of an `Atom`_, in number of the electron charge e.

.. jl:function:: set_charge!(atom::Atom, charge::Number)

    Set the charge of an `Atom`_ to ``charge``, in number of the electron charge e.

.. jl:function:: name(atom::Atom) -> ASCIIString

    Get the name of an `Atom`_.

.. jl:function:: set_name!(atom::Atom, name::ASCIIString)

    Set the name of an `Atom`_ to ``name``.

.. jl:function:: full_name(atom::Atom) -> ASCIIString

    Try to get the full name of an `Atom`_ (``"Helium"``) from the short name (``"He"``).

.. jl:function:: vdw_radius(atom::Atom) -> Float32

    Try to get the Van der Waals radius of an `Atom`_ from the short name. Returns -1 if
    no value could be found.

.. jl:function:: covalent_radius(atom::Atom) -> Float32

    Try to get the covalent radius of an `Atom`_ from the short name. Returns -1 if no
    value could be found.

.. jl:function:: atomic_number(atom::Atom) -> Integer

    Try to get the atomic number of an `Atom`_ from the short name. Returns -1 if no
    value could be found.

.. jl:function:: atom_type(atom::Atom) -> AtomType

    Get the `Atom`_ type

.. jl:function:: set_atom_type!(atom::Atom, type::AtomType)

    Set the `Atom`_ type

The following atom types are available:

- ``Chemfiles.ELEMENT``: Element from the periodic table of elements
- ``Chemfiles.COARSE_GRAINED``: Coarse-grained atom are composed of more than one
  element: CH3 groups, amino-acids are coarse-grained atoms.
- ``Chemfiles.DUMMY_ATOM``: Dummy site, with no physical reality
- ``Chemfiles.UNDEFINED_ATOM``: Undefined atom type

.. _Selection:

``Selection`` type and associated function
------------------------------------------

A `Selection`_ allow to select a group of atoms. Examples of selections are
"name H" and "(x < 45 and name O) or name C". See the `full documentation
<http://chemfiles.readthedocs.io/en/latest/selections.html>`_ for more
information about the selection language.

.. jl:function:: size(selection::Selection) -> Integer

    Get the size of the `Selection`_, *i.e.* the number of atoms we are
    selecting together.

.. jl:function:: evaluate(selection::Selection, frame::Frame) -> Array(Match, 1)

    Evaluate a `Selection`_ on a given `Frame`_. This function return a list of
    indexes or tuples of indexes of atoms in the frame matching the selection.
