command -v starship >/dev/null && eval "$(starship init bash)"
command -v zoxide >/dev/null && eval "$(zoxide init bash)"
command -v thefuck >/dev/null && eval "$(thefuck --alias)"
command -v asdf >/dev/null && . <(asdf completion bash)

