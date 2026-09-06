# libssh2 → Edric translation map

The complete source being translated is `old/`. Nothing in that tree is discarded; it remains the implementation oracle while Edric replaces it.

| libssh2 source area | Edric target | present state |
| --- | --- | --- |
| `include/libssh2.h` errors | `Error.idric` | error domain and exact numeric codes translated |
| `include/libssh2.h` host-key/disconnect constants | `Protocol.idric` | translated |
| RFC SSH message numbers used throughout `src/` | `Protocol.idric` | common transport/auth/channel messages represented; KEX method range retained explicitly |
| `src/misc.c` network integers | `Wire.idric` | u32/u64 encode/decode translated |
| `src/misc.c` SSH strings | `Wire.idric` | string and hybrid-string storage translated with overflow result |
| `src/misc.c` mpint byte storage | `Wire.idric` | leading-zero stripping and sign prefix translated |
| `src/transport.c`, packet machinery | `Transport.idric` | packet/sequence representation and RFC maximum validation established; cipher/MAC stream path next |
| `src/kex.c` and KEX implementations | `Kex.idric` | full bidirectional algorithm-list representation and negotiation established; exchange mathematics/crypto calls pending |
| `src/userauth.c` and auth implementations | `Auth.idric` | method/outcome/key identity domain established; packet/state-machine translation pending |
| `src/session.c` | `Session.idric` | session phases made explicit in the type; socket/packet-driving state machine pending |
| `src/channel.c` | `Channel.idric` | channel state/window domain established; channel packet state machines pending |
| `src/knownhost.c` | `KnownHosts.idric` | host/key/result domain established; parser/matcher pending |
| `src/agent.c` | `Agent.idric` | identity/request/response domain established; agent transport pending |
| `src/sftp.c` | `SFTP.idric` | SFTP v3 packet and attribute domain started; request state machines pending |
| `src/scp.c` | `SCP.idric` | transfer metadata/result domain established; protocol state machine pending |

## Acceptance

`WireTests.idric` is the first executable receipt. It checks the big-endian integer representation and SSH string/mpint cases translated directly from `old/src/misc.c`.

The translation is intentionally library-first. A later `issh` command is a caller of this library, not the owner of the SSH implementation, and `mbox` can embed the same modules directly.
