# issh

Edric SSH library, translated from the libssh2 source preserved under `old/`.

The goal is the SSH library, not an `mbox`-specific wrapper. `mbox` is one caller; other Edric programs should be able to embed the same session, authentication, channel, known-hosts, agent, SCP, and SFTP machinery.

The repository root contains the useful Edric source. The complete pre-translation libssh2 tree is preserved verbatim under `old/` as the compatibility and translation oracle.

## First translation slice

`Error.idric` and `Protocol.idric` translate public constants from `old/include/libssh2.h`. `Wire.idric` translates the network-order integer, SSH string, hybrid-string, and mpint storage rules from `old/src/misc.c`. The remaining modules establish typed Edric boundaries corresponding to the major libssh2 subsystems so the translation can proceed file by file without collapsing SSH into a small command wrapper.

## Build

    make

The package is currently a library target. `WireTests.idric` is the first executable acceptance target:

    make check

See `TRANSLATION.md` for the source-to-Edric map.
