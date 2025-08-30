#!/usr/bin/env bash

alias k=kubectl
alias kctx='kubectl config use-context $(kubectl config get-contexts -o name | fzf)'
source <(kubectl completion bash)
complete -F __start_kubectl k
