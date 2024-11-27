Julia interface to chemfiles
============================

This is the documentation for the `Julia`_ interface to the `chemfiles`_
library.

The `Julia`_ interface to chemfiles wraps around the C interface providing a
Julian API. All the functionalities are in the ``Chemfiles`` module, which can
be imported by the ``using Chemfiles`` expression. The ``Chemfiles`` module is
built around the main types of chemfiles: :ref:`Trajectory <Trajectory>`,
:ref:`Frame <Frame>`, :ref:`UnitCell <UnitCell>`, :ref:`Topology <Topology>`,
:ref:`Residue <Residue>`, :ref:`Atom <Atom>`, and :ref:`Selection <Selection>`.

.. _Julia: http://julialang.org/
.. _chemfiles: https://github.com/chemfiles/chemfiles

.. warning::

    All indexing in chemfiles is 0-based! That means that the first atom in a
    frame have the index 0, not 1. This is because no translation is made from
    the underlying C library.

    This may change in future release to use 1-based indexing, which is more
    familiar to Julia developers.


Installation
^^^^^^^^^^^^

You will need to use a recent version of Julia (``Julia >= 1.0``), and then you
can install the ``Chemfiles`` package by running the following at Julia prompt:

.. code-block:: julia

    pkg> add Chemfiles

    pkg> # You may also want to run the test suite with:

    pkg> test Chemfiles


User documentation
^^^^^^^^^^^^^^^^^^

This section contains example of how to use `Chemfiles.jl`, and the complete
interface reference for all the types and functions in chemfiles.

.. toctree::
   :maxdepth: 3

   tutorials
   reference/misc
   reference/trajectory
   reference/frame
   reference/cell
   reference/topology
   reference/residue
   reference/atom
   reference/selection
