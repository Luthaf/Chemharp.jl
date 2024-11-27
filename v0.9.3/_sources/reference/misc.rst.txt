Miscellaneous functions
=======================

None of the miscellaneous functions are exported, and should be called by their
fully qualified name:

.. code-block:: julia

    # Get the last error message from the chemfiles runtime.
    Chemfiles.last_error()

    # Set the global warning `callback` to be used for each warning event.
    # The `callback` function must take a `String` and return nothing.
    Chemfiles.set_warning_callback(my_callback)


.. jl:autofunction:: src/Chemfiles.jl version

Error handling
--------------

.. jl:autofunction:: src/misc.jl last_error

.. jl:autofunction:: src/misc.jl clear_errors

Warnings
--------

.. jl:autofunction:: src/misc.jl set_warning_callback


Configuration files
-------------------

.. jl:autofunction:: src/misc.jl add_configuration
