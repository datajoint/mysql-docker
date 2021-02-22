Documentation for the DataJoint's MySQL Image
#############################################

| A DataJoint-ready MySQL docker image base docker image with ``conda``.
| For more details, have a look at `prebuilt images <https://hub.docker.com/r/datajoint/miniconda3>`_, `source <https://github.com/datajoint/miniconda3-docker>`_, and `documentation <https://datajoint.github.io/miniconda3-docker>`_.

.. toctree::
   :maxdepth: 2
   :caption: Contents:

Launch Locally
**************

Debian
======
.. code-block:: shell

   docker-compose up -d

Features
********

- Provides a minimal docker image with ``conda``, ``python``, and ``pip``.
- Adds ``conda-forge`` channel as default.
- Disables ``conda`` auto-update functionality. This prevents image from growing large between builds. To update, invoke ``conda update`` explicitly.
- As long as container user is member of ``anaconda`` group, they should have acccess to perform ``conda`` and ``pip`` operations within the default environment i.e. ``base``.
- To properly shell into the container and activate the default environment, see the ``CMD`` specification in the ``Dockerfile``. For example:

  .. code-block:: shell

     docker exec -it debian_app_1 bash || docker exec -it alpine_app_1 sh -l

Miniconda3 Release Archive
**************************

- Miniconda3 releases are pulled from 2 mirrored targets:

  - `<https://repo.anaconda.com/miniconda>`_
  - `<https://repo.continuum.io/miniconda>`_

- Compatible ``conda`` releases obey the following regex:

  .. code-block:: regex
  
     Miniconda3-py[0-9]+_[0-9.]+-Linux-x86_64\.sh

Notes
*****

Development for this image was heavily borrowed from `<https://github.com/ContinuumIO/docker-images>`_.