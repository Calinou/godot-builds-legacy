# Patches

## `always_tty.patch`

This patch ensures that non-verbose output is always available, even when run
in a non-interactive environment (such as CI).
This makes build logs much smaller.
