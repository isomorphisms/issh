# Edric embedded boundary and internal SSH translation

`ISSH.idric` is the stable embedded surface. Embedded callers such as `mbox` import `ISSH` and construct a `ClientRequest` directly. They do not need to manufacture command-line arguments or depend on the eventual `issh` executable.

`CLI.idric` depends on `ISSH` and is only an adapter from command-line words to the same `ClientRequest`. The embedded API does not import the CLI parser. Before the destination, these spellings are exactly equivalent:

- `-T`
- `--no-terminal`
- `--no-terminal-this-time-thanks`

All three select `NoTerminal`. After the destination, `-T` is remote command data and is not consumed as an issh option. `--` ends option parsing explicitly.

The first useful transport/session work from the broader `issh` branch is now reconciled behind that seam. `Transport.idric` and `Session.idric` are built and tested but are not re-exported through `ISSH`. Transport currently models packet structure, sequence numbers, and packet-shape checks only. Session currently models phases through key exchange and then stops at `AwaitingHostKeyVerification`.

`RuntimeStatus.idric` makes the boundary explicit in executable form: transport/session are `DomainModelOnly`; authentication, host-key verification, and channel execution are `NotImplemented`. There is no unconditional `authenticated` transition and no path in this slice that claims a session is ready to execute a channel.

This slice still does not implement socket I/O, encryption/MAC processing, authentication exchange, known-host parsing/matching, host-key verification, channel open, PTY/shell requests, or remote-command execution. The imported libssh2 source remains unchanged at the repository root for now; the broader branch's `old/` relocation is intentionally kept out of this narrow reconciliation.

## Acceptance

A native Edric compiler should consume the canonical `.idric` sources directly. Stock Idris2 only resolves package modules with the `.idr` suffix, so the CI acceptance job creates transient `.idr` symlinks pointing at the canonical `.idric` files. It does not maintain a second source copy.

After that compatibility projection, the executable receipt is:

```text
idris2 --build tests.ipkg
./_/exec/issh-boundary-tests
```

The receipt keeps every PR #3 boundary check: default terminal behavior, all three no-terminal spellings, the destination/remote-command boundary, `--`, missing destinations, and construction through the embedded `ISSH` surface. It additionally checks packet-shape validation, rejection of a padding-length mismatch, the post-key-exchange host-key-verification gate, and the explicit `NotImplemented` status for authentication, host-key verification, and channel execution.

`.github/workflows/edric.yml` bootstraps the pinned Idris2 0.8.0 commit and runs that receipt on Ubuntu 24.04. `ci/edric-boundary.contract.tsv` separately watches the public seam, aliases, transport/session gate, explicit runtime statuses, exact source projection, runtime command, and fail-closed workflow structure. The structural watch does not substitute for the executable receipt.
