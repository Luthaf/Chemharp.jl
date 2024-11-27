Julia interface to chemfiles
============================

This is the documentation for the `Julia`_ interface to the `chemfiles`_
library.

.. _Julia: http://julialang.org/
.. _chemfiles: https://github.com/chemfiles/chemfiles

Installation
^^^^^^^^^^^^

You will need to use a recet version of Julia (``Julia >= 0.5``), and then you
can install the ``Chemfiles`` package by running the following at Julia prompt:

.. code-block:: julia

    julia> Pkg.add("Chemfiles")

    julia> # You may also want to run the test suite with:

    julia> Pkg.test("Chemfiles")


User documentation
^^^^^^^^^^^^^^^^^^

This section contains example of how to use `Chemfiles.jl`, and the complete
interface reference for all the types and functions in chemfiles.

.. toctree::
   :maxdepth: 2

   tutorials
   reference
