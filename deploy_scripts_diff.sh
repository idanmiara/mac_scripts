#!/bin/bash
# copy all scripts to the local scripts dir

d="/usr/local/bin"
echo "Copying scripts to $d..."
cd scripts && for f in *.sh; do
  echo "→ Copying $f to $d/${f%.sh}..."
  sudo cp "$f" "$d/${f%.sh}" && sudo chmod +x "$d/${f%.sh}"
done
