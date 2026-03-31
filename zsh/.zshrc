# Source all conf.d files in order
for conf in "$ZDOTDIR/conf.d/"*.zsh(N); do
  source "$conf"
done

# Machine-specific overrides (must be last)
[[ -f "$ZDOTDIR/.zshrc.local" ]] && source "$ZDOTDIR/.zshrc.local"
