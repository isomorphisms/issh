# First Edric boundary

This slice deliberately leaves the imported libssh2 implementation unchanged. It remains the implementation reference while the Edric side acquires a stable caller boundary.

`Client.idric` owns that boundary. Embedded callers such as `mbox` import `ISSH` and construct a `ClientRequest` directly. They do not need to manufacture command-line arguments or depend on the eventual `issh` executable.

`CLI.idric` is only an adapter from command-line words to the same `ClientRequest`. Before the destination, these spellings are exactly equivalent:

- `-T`
- `--no-terminal`
- `--no-terminal-this-time-thanks`

All three select `NoTerminal`. After the destination, `-T` is remote command data and is not consumed as an issh option. `--` ends option parsing explicitly.

The boundary does not pretend that transport, authentication, host-key verification, or channel execution has been translated yet. Those operations should grow behind `ClientRequest` without making `mbox` depend on the CLI parser.

## Acceptance

Build and run the executable receipt with an Edric/Idris2-compatible compiler:

```text
idris2 --build tests.ipkg
./build/exec/issh-boundary-tests
```

The receipt checks the default terminal policy, all three no-terminal spellings, the destination/remote-command boundary, `--`, missing destinations, and construction by an embedded caller.

The `ai-ci` contract watches that this public seam and its acceptance cases remain present. It is a structural watch, not a substitute for compiling and running `BoundaryTests.idric`.
