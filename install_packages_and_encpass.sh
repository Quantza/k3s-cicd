#!/bin/bash

set -e

yay -Sy
yay -S curl git kubectl helm ansible-core ansible

curl https://raw.githubusercontent.com/ahnick/encpass.sh/master/encpass.sh -o ./bin/encpass.sh
chmod +x ./bin/encpass.sh

./bin/encpass.sh lite > ./bin/encpass-lite.sh
chmod +x ./bin/encpass-lite.sh
