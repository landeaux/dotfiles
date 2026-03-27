# Autoload functions (must be before conf.d so compinit sees them)
fpath=("$ZDOTDIR/functions" $fpath)
autoload -Uz tre yeet fzb fzclean fzwt fzstash

# Source all conf.d files in order
for conf in "$ZDOTDIR/conf.d/"*.zsh(N); do
  source "$conf"
done

# Machine-specific overrides (must be last)
[[ -f "$ZDOTDIR/.zshrc.local" ]] && source "$ZDOTDIR/.zshrc.local"
