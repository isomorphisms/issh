# Related RFCs not in the implementation mirror

These are useful around SSH but do not directly define the general-purpose SSH
wire protocol implemented by `issh`, so they are linked rather than mirrored
by `MANIFEST.tsv`.

- RFC 5592 — Secure Shell Transport Model for the Simple Network Management Protocol (SNMP)
- RFC 6242 — Using the NETCONF Protocol over Secure Shell (SSH)
- RFC 9644 — YANG Groupings for SSH Clients and SSH Servers
- RFC 9141 — Updating References to the IETF FTP Service; this administratively updates an old URI in RFC 4251 but does not change SSH wire semantics

Also useful as live protocol data rather than an RFC snapshot:

- IANA Secure Shell (SSH) Protocol Parameters: https://www.iana.org/assignments/ssh-parameters/
- RFC Editor SSH documents: https://www.rfc-editor.org/

If `issh` grows NETCONF, SNMP management, or YANG configuration surfaces,
move the corresponding RFC into the main manifest rather than duplicating its
requirements indirectly.
