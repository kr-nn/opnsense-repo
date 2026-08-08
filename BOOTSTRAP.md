# Bootstrap a Firewall

These steps configure a compatible OPNsense firewall to use the repository as
an additional package source. They do not disable the official OPNsense
repositories.

Replace:

    https://REPLACE-ME.example/opnsense/

with the HTTPS URL where `public/` is hosted.

## Install Trust Material

Copy the repository public key to:

    /usr/local/etc/pkg/keys/unboundviews-repo.pub

The private key must never be copied to a firewall.

## Install Repository Configuration

Create:

    /usr/local/etc/pkg/repos/UnboundViews.conf

with:

    UnboundViews: {
      url: "https://REPLACE-ME.example/opnsense/${ABI}/26.7/latest",
      signature_type: "pubkey",
      pubkey: "/usr/local/etc/pkg/keys/unboundviews-repo.pub",
      priority: 5,
      enabled: yes
    }

The official OPNsense repository remains enabled. The custom repository has a
distinctive name and should contain only private `os-*` plugin packages.

## Update and Install

Run:

    pkg update -f
    pkg search -r UnboundViews os-unboundviews

Then install either from the CLI:

    pkg install os-unboundviews

or from:

    System > Firmware > Plugins

After installation, the plugin UI is available at:

    Services > Unbound View Overrides

## Future Bootstrap Package

A tiny `os-unboundviews-repo` bootstrap package would be a reasonable future
improvement. It should install only:

- `/usr/local/etc/pkg/repos/UnboundViews.conf`
- `/usr/local/etc/pkg/keys/unboundviews-repo.pub`

That package creates a chicken-and-egg problem for first install unless it is
distributed separately, so the file-copy bootstrap above is the simplest first
step.

