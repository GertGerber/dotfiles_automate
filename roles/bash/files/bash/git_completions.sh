#!/usr/bin/env bash

if type -t __git_complete >/dev/null 2>&1; then
  __git_complete gc _git_checkout
  __git_complete gcb _git_checkout
  __git_complete gp _git_push
fi
