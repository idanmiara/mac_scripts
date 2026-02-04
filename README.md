## Mac Scripts

This repository contains simple Bash utilities located under `scripts/`.

• `deploy.sh` — deploys the scripts to a system-wide location  
• `verify.sh` — verifies that the deployed versions match the source files  

---

## Deployment

The deployment script copies all `*.sh` files from the `scripts/` directory into `/usr/local/bin`, removes the `.sh` extension, and marks them as executable.

### Deploy scripts

```bash
./deploy.sh

## Verification

The verification script checks whether each script was deployed correctly and prints a diff if differences are found.

```
./verify.sh
```
