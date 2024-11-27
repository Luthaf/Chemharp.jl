Julia interface to chemfiles
============================

This is the documentation for the `Julia`_ interface to the `chemfiles`_ library.

.. _Julia: http://julialang.org/
.. _chemfiles: https://github.com/chemfiles/chemfiles

Installation
^^^^^^^^^^^^

You will need to install the last released version of Julia (``Julia >= 0.4``), and
then you can install the ``Chemfiles`` package by running the following at Julia
prompt:

.. code-block:: julia

    julia> Pkg.clone("http://github.com/chemfiles/Chemfiles.jl")

    julia> Pkg.build("Chemfiles")

    julia> #You can also test the Julia interface with:

    julia> Pkg.test("Chemfiles")


User documentation
^^^^^^^^^^^^^^^^^^

This section contains example of how to use `Chemfiles.jl`, and the complete
interface reference for all the types and subroutines in chemfiles.

.. toctree::
   :maxdepth: 2

   examples
   reference
