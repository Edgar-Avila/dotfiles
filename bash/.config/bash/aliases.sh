alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias avante='nvim -c "lua vim.defer_fn(function()require(\"avante.api\").zen_mode()end, 100)"'
alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'
alias setcaps='setxkbmap -option compose:caps'
alias fzfeh='find ~/wallpapers -maxdepth 1 -type f -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" | fzf --preview="feh --bg-scale {}" | xargs -I {} feh --bg-scale {}'
if command -v notify-send >/dev/null; then
    alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
fi
