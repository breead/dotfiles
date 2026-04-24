### Public key SSH login
After generating a key with `ssh-keygen -t ed25519 -C "your_email@example.com"`, `ssh-copy-id user@your.uni.server` will automatically send the key over.

### Checking git config
Checking from where your git config is getting changed can be done with

`$ git config --list --show-origin`

This is good if you run something like `git config --local user.name "John Doe` but don't remember exactly what config file that affects.
