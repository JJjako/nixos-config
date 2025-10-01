# 1. Tippe deinen Suchbegriff
read -p "Search term: " term
[[ -z "$term" ]] && exit

# 2. Suche rekursiv mit rg und wähle den Treffer mit fzf
file=$(rg --line-number --color=always "$term" ~/nixos-config \
       | fzf --ansi --preview 'echo {} | cut -d: -f1 | xargs -I % head -n 20 %' \
       | cut -d: -f1)

# 3. Öffne ausgewählte Datei in Sublime Text
[[ -n "$file" ]] && subl "$file"