# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias test-cfg='git --git-dir=$HOME/testing-bare --work-tree=$HOME'

# Add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# -------- Short Path (parent/current) --------
short_path() {
  if [[ "$PWD" == "/" ]]; then
    echo "/"
    return
  fi

  local current parent
  current=$(basename "$PWD")
  parent=$(basename "$(dirname "$PWD")")

  if [[ "$(dirname "$PWD")" == "/" ]]; then
    echo "$current"
  else
    echo "$parent/$current"
  fi
}

# -------- Git Branch + Status --------
parse_git_branch() {
  local branch
  branch=$(git branch 2>/dev/null | grep '\*' | sed 's/* //')
  [ -z "$branch" ] && return

  if git diff --quiet 2>/dev/null && git diff --cached --quiet 2>/dev/null && [ -z "$(git ls-files --others --exclude-standard 2>/dev/null)" ]; then
    # clean — green
    printf "\001\033[0;32m\002 ($branch)\001\033[0m\002"
  else
    # dirty/untracked — red
    printf "\001\033[0;31m\002 ($branch)\001\033[0m\002"
  fi
}

# -------- Final Prompt --------
export PS1="\u@\h \$(short_path)\$(parse_git_branch) \$ "

# 'fn' -> find directory
fd() {
    local dir
    dir=$(find ~ -maxdepth 4 -type d \
        ! -path "*/.git*" \
        ! -path "*/node_modules*" | fzf --prompt="> ")
    
    if [[ -n "$dir" ]]; then
        cd "$dir" || return
    fi
}

# 'ff' -> find file
ff() {
    local file
    file=$(find ~ -maxdepth 4 -type f \
        ! -path "*/.git*" \
        ! -path "*/node_modules*" | fzf --prompt="> ")
    
    if [[ -n "$file" ]]; then
        nvim "$file"
    fi
}

# ---- jot ----
export JOT="$HOME/dev-root/jot"

# today's log
jl() {
  mkdir -p "$JOT/log"
  local f="$JOT/log/$(date +%Y-%m-%d).md"
  if [ ! -f "$f" ]; then
    printf "# %s %s\n\n## did\n\n\n## learned\n\n\n## thoughts\n\n" \
      "$(date +%Y-%m-%d)" "$(date +%A)" > "$f"
  fi
  cd "$JOT" && nvim "$f"
}

# open scratch
alias js='cd $JOT && nvim scratch.md'

# open ideas
alias ji='cd $JOT && nvim ideas.md'

# open refs
alias jr='cd $JOT && nvim refs.md'

# quick capture to scratch without opening editor
# usage: jq "fix the nginx timeout thing"
jq() { printf "%s\n" "$*" >> "$JOT/scratch.md" && echo "→ scratch"; }

# quick capture links without opening editor
# usage: ja "cli tool that diffs two directory trees"
ja() { printf -- "- %s\n" "$*" >> "$JOT/refs.md" && echo "→ refs"; }

# search all notes
# usage: jg "deadlock"
jg() { cd "$JOT" && grep -ri --color=auto "$1" --include='*.md'; }

# save: pull first to avoid conflicts, then commit and push
jc() {
  cd "$JOT" || return
  git pull --rebase -q 2>/dev/null
  git add -A
  git commit -m "$(date '+%Y-%m-%d %H:%M')" || return
  git push
}


# Tmux related 
tmux() {
    if [ -z "$TMUX" ]; then
        local name=$(basename $PWD | cut -c1-8)   # max 8 chars
        command tmux new-session -s "$name" 2>/dev/null || command tmux attach -t "$name"
    else
        command tmux "$@"
    fi
}
