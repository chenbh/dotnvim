#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  sudo apt-get install -y build-essential cmake python3-dev
elif [[ "$OSTYPE" == "darwin"* ]]; then
  brew install cmake python
else
  echo "you poor soul"
  exit 1
fi

# install neovim python3 bindings
pip3 install pynvim
