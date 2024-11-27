.. _julia-api:

Julia interface reference
=========================

The `Julia`_ interface to chemfiles wrap around the C interface providing a
Julian API. All the functionalities are in the ``Chemfiles`` module, which can
be imported by the ``using Chemfiles`` expression. The ``Chemfiles`` module is
built around the main types of chemfiles: `Trajectory`_, `Frame`_, `UnitCell`_,
`Topology`_, `Residue`_, `Atom`_, and `Selection`_.

.. _Julia: http://julialang.org/

.. warning::
   All indexing in chemfiles is 0-based! That means that the first atom in a frame
   have the index 0, not 1. This is because no translation is made from the
   underlying C library.

   This may change in future release to use 1-based indexing, which is more familiar
   to Julia developers.

Miscelaneous functions
----------------------

These functions are not exported, and should be called by there fully qualified name:

.. code-block:: julia

    Chemfiles.last_error()
    Chemfiles.set_warning_callback(my_callback)

.. jl:autofunction:: src/utils.jl last_error

.. jl:autofunction:: src/utils.jl clear_errors

.. jl:autofunction:: src/utils.jl set_warning_callback

.. jl:autofunction:: src/utils.jl add_configuration

.. jl:autofunction:: src/Chemfiles.jl version

.. _Trajectory:

``Trajectory`` type and associated functions
--------------------------------------------

.. jl:autotype:: src/Chemfiles.jl Trajectory

.. jl:autofunction:: src/Trajectory.jl Trajectory

.. jl:autofunction:: src/Trajectory.jl read

.. jl:autofunction:: src/Trajectory.jl read!

.. jl:autofunction:: src/Trajectory.jl read_step

.. jl:autofunction:: src/Trajectory.jl read_step!

.. jl:autofunction:: src/Trajectory.jl write

.. jl:autofunction:: src/Trajectory.jl set_topology!

.. jl:autofunction:: src/Trajectory.jl set_cell!

.. jl:autofunction:: src/Trajectory.jl nsteps

.. jl:autofunction:: src/Trajectory.jl close

.. jl:autofunction:: src/Trajectory.jl isopen

.. _Frame:

``Frame`` type and associated functions
---------------------------------------

.. jl:autotype:: src/Chemfiles.jl Frame

.. jl:autofunction:: src/Frame.jl Frame

.. jl:autofunction:: src/Frame.jl deepcopy

.. jl:autofunction:: src/Frame.jl size

.. jl:autofunction:: src/Frame.jl resize!

.. jl:autofunction:: src/Frame.jl positions

.. jl:autofunction:: src/Frame.jl velocities

.. jl:autofunction:: src/Frame.jl add_velocities!

.. jl:autofunction:: src/Frame.jl has_velocities

.. jl:autofunction:: src/Frame.jl add_atom!

.. jl:autofunction:: src/Frame.jl remove_atom!

.. jl:autofunction:: src/Frame.jl set_cell!

.. jl:autofunction:: src/Frame.jl set_topology!

.. jl:autofunction:: src/Frame.jl step

.. jl:autofunction:: src/Frame.jl set_step!

.. jl:autofunction:: src/Frame.jl guess_bonds!

.. jl:autofunction:: src/Frame.jl add_bond!

.. jl:autofunction:: src/Frame.jl remove_bond!

.. jl:autofunction:: src/Frame.jl add_residue!

.. jl:autofunction:: src/Frame.jl distance

.. jl:autofunction:: src/Frame.jl angle

.. jl:autofunction:: src/Frame.jl dihedral

.. jl:autofunction:: src/Frame.jl out_of_plane

.. jl:autofunction:: src/Frame.jl property

.. jl:autofunction:: src/Frame.jl set_property!

.. _UnitCell:

``UnitCell`` type and associated function
-----------------------------------------

.. jl:autotype:: src/Chemfiles.jl UnitCell

.. jl:autofunction:: src/UnitCell.jl UnitCell

.. jl:autofunction:: src/UnitCell.jl deepcopy

.. jl:autofunction:: src/UnitCell.jl volume

.. jl:autofunction:: src/UnitCell.jl lengths

.. jl:autofunction:: src/UnitCell.jl set_lengths!

.. jl:autofunction:: src/UnitCell.jl angles

.. jl:autofunction:: src/UnitCell.jl set_angles!

.. jl:autofunction:: src/UnitCell.jl cell_matrix

.. jl:autofunction:: src/UnitCell.jl shape

.. jl:autofunction:: src/UnitCell.jl set_shape!

.. jl:autotype:: src/UnitCell.jl CellShape


.. _Topology:

``Topology`` type and associated function
-----------------------------------------

.. jl:autotype:: src/Chemfiles.jl Topology

.. jl:autofunction:: src/Topology.jl Topology

.. jl:autofunction:: src/Topology.jl deepcopy

.. jl:autofunction:: src/Topology.jl size

.. jl:autofunction:: src/Topology.jl add_atom!

.. jl:autofunction:: src/Topology.jl remove!

.. jl:autofunction:: src/Topology.jl bonds_count

.. jl:autofunction:: src/Topology.jl angles_count

.. jl:autofunction:: src/Topology.jl dihedrals_count

.. jl:autofunction:: src/Topology.jl impropers_count

.. jl:autofunction:: src/Topology.jl bonds

.. jl:autofunction:: src/Topology.jl angles

.. jl:autofunction:: src/Topology.jl dihedrals

.. jl:autofunction:: src/Topology.jl impropers

.. jl:autofunction:: src/Topology.jl add_bond!

.. jl:autofunction:: src/Topology.jl remove_bond!

.. jl:autofunction:: src/Topology.jl add_residue!

.. jl:autofunction:: src/Topology.jl count_residues

.. jl:autofunction:: src/Topology.jl are_linked

.. jl:autofunction:: src/Topology.jl resize!

.. _Atom:

``Atom`` type and associated function
-------------------------------------

.. jl:autotype:: src/Chemfiles.jl Atom

.. jl:autofunction:: src/Atom.jl Atom

.. jl:autofunction:: src/Atom.jl deepcopy

.. jl:autofunction:: src/Atom.jl mass

.. jl:autofunction:: src/Atom.jl set_mass!

.. jl:autofunction:: src/Atom.jl charge

.. jl:autofunction:: src/Atom.jl set_charge!

.. jl:autofunction:: src/Atom.jl name

.. jl:autofunction:: src/Atom.jl set_name!

.. jl:autofunction:: src/Atom.jl fullname

.. jl:autofunction:: src/Atom.jl vdw_radius

.. jl:autofunction:: src/Atom.jl covalent_radius

.. jl:autofunction:: src/Atom.jl atomic_number

.. jl:autofunction:: src/Atom.jl atom_type

.. jl:autofunction:: src/Atom.jl set_atom_type!

.. jl:autofunction:: src/Atom.jl property

.. jl:autofunction:: src/Atom.jl set_property!

.. _Residue:

``Residue`` type and associated function
------------------------------------------

.. jl:autotype:: src/Chemfiles.jl Residue

.. jl:autofunction:: src/Residue.jl Residue

.. jl:autofunction:: src/Residue.jl residue_for_atom

.. jl:autofunction:: src/Residue.jl deepcopy

.. jl:autofunction:: src/Residue.jl name

.. jl:autofunction:: src/Residue.jl id

.. jl:autofunction:: src/Residue.jl size

.. jl:autofunction:: src/Residue.jl add_atom!

.. jl:autofunction:: src/Residue.jl contains

.. jl:autofunction:: src/Residue.jl deepcopy

.. _Selection:

``Selection`` type and associated function
------------------------------------------

.. jl:autotype:: src/Chemfiles.jl Selection

.. jl:autofunction:: src/Selection.jl Selection

.. jl:autofunction:: src/Selection.jl deepcopy

.. jl:autofunction:: src/Selection.jl size

.. jl:autofunction:: src/Selection.jl evaluate

.. jl:autofunction:: src/Selection.jl selection_string
