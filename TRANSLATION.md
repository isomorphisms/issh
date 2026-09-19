# Transport/session reconciliation

This branch reconciles the useful pure Edric domain work from the broader `issh` branch at `84332a9bb90f2d4ca9f60839912bd0ace0f9a9b2` behind the `ClientRequest` seam established by PR #3.

The public embedded surface remains `ISSH.idric`, which re-exports `Client` only. `Transport.idric`, `Session.idric`, and `RuntimeStatus.idric` are built and tested but are not re-exported through `ISSH`.

## Reconciled now

- `Types.idric`: shared byte/count/port domains used by the translated internals.
- `Transport.idric`: SSH packet representation, sequence-number state, and packet-shape checks. `validate_packet_shape` checks only lengths and padding shape; it does not authenticate, decrypt, verify a MAC, or perform I/O.
- `Session.idric`: explicit session phases through version exchange and key-exchange bookkeeping. After key exchange it stops at `AwaitingHostKeyVerification`.
- `RuntimeStatus.idric`: executable status declarations. Transport/session are `DomainModelOnly`; authentication, host-key verification, and channel execution are `NotImplemented`.

The broader branch had an unconditional `authenticated` state transition. It is deliberately not copied here: there is no transition from `AwaitingHostKeyVerification` into `UserAuthentication` or `Ready` until host-key verification and authentication have real implementations and receipts.

## Not reconciled in this slice

The broader branch also relocates the imported libssh2 tree under `old/`. That is mechanically large and independent of the caller seam, so it remains separate rather than obscuring this review with mass renames.

No socket transport, cipher/MAC processing, authentication exchange, known-host parsing/matching, host-key verification, channel open, PTY request, shell request, or remote-command execution is claimed here.
