# placemakers.theme.sh - minimal, readable theme
# Prompt: user@host:cwd on git_branch (exit_code) $
safe_git_branch() {
  git rev-parse --abbrev-ref HEAD 2>/dev/null | sed -e 's/[^[:alnum:]_.-]/_/g'
}

_omb_theme_prompt_command() {
  local EXIT="$?"
  local BRANCH="$(safe_git_branch)"
  local BRANCH_SEGMENT=""
  if [[ -n "$BRANCH" ]]; then
    BRANCH_SEGMENT=" on ${BRANCH}"
  fi
  PS1="\\u@\\h:\\W${BRANCH_SEGMENT} (${EXIT}) \\$ "
}

_omb_util_add_prompt_command _omb_theme_prompt_command
