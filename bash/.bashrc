# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Defaults
source ~/.config/bash/defaults.sh

# Base environment
source ~/.config/bash/env.sh

# Path
source ~/.config/bash/path.sh

# Aliases (ls, grep, alert, etc.)
source ~/.config/bash/aliases.sh

# Shell functions
source ~/.config/bash/functions.sh

# Keybindings, readline options
source ~/.config/bash/keybinds.sh

# Local, machine-specific overrides (NOT in git)
[[ -f ~/.config/bash/local.sh ]] && source ~/.config/bash/local.sh

# Tool-specific integrations
source ~/.config/bash/tools.sh

