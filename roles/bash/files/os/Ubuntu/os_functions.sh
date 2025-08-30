#!/usr/bin/env bash

if command -v nala >/dev/null 2>&1; then
  alias update='sudo nala upgrade -y && sudo nala autoremove -y'
else
  alias update='sudo apt-get update -y && sudo apt-get upgrade -y && sudo apt-get autoremove -y'
fi
