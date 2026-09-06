# First Edric boundary

This slice deliberately leaves the imported libssh2 implementation unchanged. It remains the implementation reference while the Edric side acquires a stable caller boundary.

`ISSH.idric` is the embedded surface. Embedded callers such as `mbox` import `ISSH` and construct a `ClientRequest` directly. They do not need to manufacture command-line arguments or depend on the eventual `issh` executable.

`CLI.idric` depends on `ISSH` and is only an adapter from command-line words to the same `ClientRequest`. The embedded API does not import the CLI parser. Before the destination, these spellings are exactly equivalent:

- `-T`
- `--no-terminal`
- `--no-terminal-this-time-thanks`

All three select `NoTerminal`. After the destination, `-T` is remote command data and is not consumed as an issh option. `--` ends option parsing explicitly.

The boundary does not pretend that transport, authentication, host-key verification, or channel execution has been translated yet. Those operations should grow behind `ClientRequest` without making `mbox` depend on the CLI parser.

## Acceptance

Build and run the executable receipt with an Edric/Idris2-compatible compiler:

```text
idris2 --build tests.ipkg
./_/exec/issh-boundary-tests
```

The receipt checks the default terminal policy, all three no-terminal spellings, the destination/remote-command boundary, `--`, missing destinations, and construction through the embedded `ISSH` surface.

`.github/workflows/edric.yml` bootstraps the pinned Idris2 0.8.0 commit and runs that receipt on Ubuntu 24.04. `ci/edric-boundary.contract.tsv` separately watches the public seam, aliases, runtime command, and fail-closed workflow structure. The structural watch does not substitute for the executable receipt.
