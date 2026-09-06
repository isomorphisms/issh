# SSH RFCs

Local reference copies of the RFCs that directly define, extend, update, or
deprecate parts of SSH.

`MANIFEST.tsv` is the source list. `text/` contains exact RFC Editor plain-text
copies produced by `update.sh`; `SHA256SUMS` records the mirrored bytes.

To reproduce the mirror:

```sh
sh rfc/update.sh
```

The manifest currently contains 38 implementation-oriented RFCs, from the
2006 SSH core through RFC 10042 (August 2026 post-quantum/traditional hybrid
key exchange) and RFC 9987 (May 2026 SSH agent protocol).

Start with these when implementing the protocol itself:

- RFC 4251 — architecture and wire data types
- RFC 4252 — user authentication
- RFC 4253 — transport, packets, key exchange framework
- RFC 4254 — channels and connection protocol
- RFC 4250 — assigned protocol numbers
- RFC 8308 — extension negotiation
- RFC 9142 — current key-exchange recommendations
- RFC 9519 — current IANA registry policy

The rest of the manifest covers authentication methods, public-key formats,
terminal behavior, SSHFP, encryption/MAC additions and deprecations, ECC,
Curve25519/448, RSA-SHA2, GSS-API, agent protocol, and newer hybrid
post-quantum key exchange.

This is deliberately an implementation-oriented set rather than every RFC
that merely uses SSH as a transport. See `RELATED.md` for nearby documents
and `DRAFTS.md` for current SSH work that has not yet become an RFC.

See `NOTICE.md` before redistributing or modifying RFC material. The RFC text
is not covered by libssh2's project license.
