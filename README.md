
# rootfiles

This is the collection of my configuration files installable on the system per
the root user of the system.

## Installation

The Makefiles assist you in installing this configuration. *The installation process actually creates symlinks in relevant directories for each program*. **Those symlinks replace your configuration files in your system.** For the list of available rules that are expected to be called, you may use the following:

```
# make help
```

For installing, you simply do:

```sh
# make
```

You may have to clean the files already present on your system. Then, you do as
follows:
```sh
# make clean && make
```

<!-- vim: set sts=2 ts=2 sw=2 tw=80 et :-->

