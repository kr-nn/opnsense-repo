# os-unboundviews pkg repository

> Warning - totally vibecoded plugin only solves split-horizon DNS for me on OPNsense
> Although I spent a fair amount of time polishing it, I don't know how to make OPNsense plugins and this is completely vibecoded

OPNsense plugin for unbound dns views (Split-Horizon)

`os-unboundviews` extends existing OPNsense Unbound Host Overrides.

Example:

- Native Host Override: `service.example.com: 192.168.1.1`
- LAB view record: `A 192.168.3.1`
- DMZ view record: `NXDOMAIN`

Result:

- LAN clients receive the native/default answer.
- LAB clients receive the LAB-specific answer.
- DMZ clients receive NXDOMAIN.

## Features

- Add any number of per-interface View Records for a Host Override.
- Override records support `A`, `AAAA`, `MX`, and `TXT` data.
- Supports Local-zone and Local-data
- Local-zone actions include NXDOMAIN plus the other Unbound local-zone
  behavior types.
- Custom records can emit a single raw Unbound view line.
- Generated configuration can be reviewed from the Raw Config tab.

## Installation

- Add this repo to your firewall:
`/usr/local/etc/pkg/repos/unboundviews.conf`
```
UnboundViews: {
  url: "https://kr-nn.github.io/opnsense-repo/public/${ABI}/26.7/latest",
  signature_type: "pubkey",
  pubkey: "/usr/local/etc/pkg/keys/unboundviews-repo.pub",
  priority: 5,
  enabled: yes
}
```
- Install public key:
`/usr/local/etc/pkg/keys/unboundview-repo.pub`
```
-----BEGIN PUBLIC KEY-----
MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAjVCV4NPZMpefWOoBhhtO
8xyOgTE6nrVx+J9kDR1bFZRAho34NHgl8bxF8ozKHkiC3gJ04JmMdCCp9rlKpJSm
vKH7IrPlptnPLAqskkj561sQYwiXfgNDc7YzjpqyAHI+putWk+5zwVdFP0t1hvP9
qjpzkYtphYwbLF5IjysmgzFCPTHxdU+TVv3Ez84ydhVdA0vI+aduXCtW5xp+z05K
ZbzjXOP3GABZRZRH3r6X65wak032zzV2tGw7gVhfMvslOFGPbKHuVpBvpuT/oQj7
YVe6kF6S9GbnejoXHBm1NMcHpf6G19N6RejZKR4FypNE47ij/W5IOtJqEh/huBzy
ME7wDl34ZSinVDji0AqbzAaCZmne6QKB21ZDnBq/njEVYiEEZuJF2vo1wF9cTVBY
oQKRYeUdCvEXU/U5mRCGpx5vHQHtzMDQw2Ia5v4aQihPpsQnJoG+5POVTIipiWwY
RWWtYT8oOazpbbGpdo+LXNdjTrdkeC4m0Lr0Q2zbi6i97JG0rY1iRqv2fVlUtSq8
iCL6K48PQuSwoB6e/tZXW74TAUgnFfZDoH+RompAkvSGmnP8fPftN275mbQobVPE
MJzwrcNsRuMavCCj9W3kTBb4ys4r4Sbts9vWKhkxN+xFwybals1MZ2jVblsmUMS6
G13lEgDnz4IKpkvpqxPCIN0CAwEAAQ==
-----END PUBLIC KEY-----
```

The package should also appear in:

    System > Firmware > Plugins

The UI is available at:

    Services > Unbound View Overrides

## How to use
### Select an override
Select an override from Services > unbound > overrides
<img width="909" height="247" alt="image" src="https://github.com/user-attachments/assets/186c4dc2-7b74-4b3e-bf7f-060254fb06ec" />

### Create a record
Choose the interface this record applies to and make the record:
<img width="905" height="459" alt="image" src="https://github.com/user-attachments/assets/b857bc23-8f3c-49a9-abaf-63fdc7c6694a" />

### Confirm the config looks right when you apply
<img width="496" height="274" alt="image" src="https://github.com/user-attachments/assets/6ca7122d-7a73-4413-a2a3-8fe59257a95f" />

## Compatibility

Version 1.0 targets OPNsense 26.7 on `FreeBSD:15:amd64`. Interface network
discovery currently uses statically configured IPv4 interface networks for
view matching.
