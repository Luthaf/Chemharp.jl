Tutorials
=========

This section present some hand-on tutorials to the chemfiles Julia package. All
the code here is under the `CC-0 Universal Licence`_ which means that you are
free to do whatever you want with it (*i.e.* it is Public Domain code)

.. _CC-0 Universal Licence: https://creativecommons.org/publicdomain/zero/1.0/

Read a single frame
-------------------

In this tutorials we will read a frame from a trajectory, and print the indexes
of all the atom in the half-space ``x < 5``.

We start by ``using`` the ``Chemfiles`` package to bring in scope the needed
functions:

.. literalinclude:: ../examples/indexes.jl
   :language: julia
   :lines: 4-5

Then we open a Trajectory and read the first frame:

.. literalinclude:: ../examples/indexes.jl
   :language: julia
   :lines: 7-8

We can now create a list to store the indices of the atoms with ``x < 5``, and
get the positions of the atoms in the frame with the :jl:func:`positions`
function

.. literalinclude:: ../examples/indexes.jl
   :language: julia
   :lines: 10-11

Iterating through the atoms in the frame, we get the ones matching our
condition. ``size(frame)`` gives the number of atoms in the frame, which is also
the size of the ``positions`` array. This positions array shape is  ``(3,
size(frame))``.

.. literalinclude:: ../examples/indexes.jl
   :language: julia
   :lines: 13-17

And finally we can print our results

.. literalinclude:: ../examples/indexes.jl
   :language: julia
   :lines: 19-22

.. htmlhidden::
    :toggle: Click here to see the whole program
    :before-not-html: The whole code looks like this

    .. literalinclude:: ../examples/indexes.jl
       :language: julia
       :lines: 4-

For more information about reading frame in a trajectory, see the following
functions:

- :jl:func:`read_step` to directly read a given step.
- ``set_cell!`` and ``set_topology!`` to specify an unit cell or a topology for
  all frames in a trajectory.

Generating a structure
----------------------

Now that we know how to read frames from a trajectory, let's try to create a new
structure and write it to a file. As previsouly, we start by using the Chemfiles
package

.. literalinclude:: ../examples/generate.jl
   :language: julia
   :lines: 4-5

Everything starts in a :jl:type:`Topology`. This is the class that defines the
atoms and the connectivity in a system. Here, we add three :jl:type:`Atom` and
two bonds to create a water molecule.

.. literalinclude:: ../examples/generate.jl
   :language: julia
   :lines: 7-13

We can then create a :jl:type:`Frame` corresponding to this topology. We resize
the frame to ensure that the frame and the topology contains the same number of
atoms.

.. literalinclude:: ../examples/generate.jl
   :language: julia
   :lines: 15-17

We can then set the atomic positions:

.. literalinclude:: ../examples/generate.jl
   :language: julia
   :lines: 19-22

Another possibility is to directly add atoms to the frame. Here we define a
second molecule representing carbon dioxyde. ``add_atom!`` takes three
arguments: the frame, the atom, and the position of the atom.

.. literalinclude:: ../examples/generate.jl
   :language: julia
   :lines: 24-28

Finally, we can set the :jl:type:`UnitCell` associated with this frame.

.. literalinclude:: ../examples/generate.jl
   :language: julia
   :lines: 30

Now that our frame is constructed, it is time to write it to a file. For that,
we open a trajectory in write (``'w'``) mode, and write to it. You only need
to close the file if you are on the REPL and need to use the written trajectory
right awaty.

.. literalinclude:: ../examples/generate.jl
   :language: julia
   :lines: 32-36

.. htmlhidden::
    :toggle: Click here to see the whole program
    :before-not-html: Wrapping everything up, the whole code looks like this:

    .. literalinclude:: ../examples/generate.jl
       :language: julia
       :lines: 4-

Using selections
----------------

Now that we know how to read and write frame from trajectories, how about we do
a bit a filtering? In this tutorial, we will read all the frames from a file,
and use selections to filter which atoms we will write back to another file.
This example will also show how chemfiles can be used to convert from a file
format to another one.

We start by opening the two trajectories we will need

.. literalinclude:: ../examples/select.jl
   :language: julia
   :lines: 7-8

And we create a :jl:type:`Selection` object to filter the atoms we want to
remove.

.. literalinclude:: ../examples/select.jl
   :language: julia
   :lines: 10

Then we can iterate over all the frames in the trajectory, and use the selection
to get the list of atoms to remove. The result of :jl:func:`evaluate`
is a list containing the atoms matching the selection.

.. literalinclude:: ../examples/select.jl
   :language: julia
   :lines: 12-13

In order to remove the atoms from the frame, we need to sort the ``to_remove``
list in descending order: removing the atom at index i will shift the index of
all the atoms after i. So we start from the end and work toward the start of the
frame.

.. literalinclude:: ../examples/select.jl
   :language: julia
   :lines: 14-16

Finally, we can write the cleaned frame to the output file, and start the next
iteration.

.. literalinclude:: ../examples/select.jl
   :language: julia
   :lines: 17

Remember to close the file if you are on the REPL and need to use the written
trajectory right away.

.. literalinclude:: ../examples/select.jl
    :language: julia
    :lines: 21


.. htmlhidden::
    :toggle: Click here to see the whole program
    :before-not-html: The whole program look like this:

    .. literalinclude:: ../examples/select.jl
       :language: julia
       :lines: 4-
