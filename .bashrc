# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# --------------------------------------------------
# Aliases
# --------------------------------------------------

alias vi='nvim'
alias vim='nvim'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias test-cfg='git --git-dir="$HOME/testing-bare" --work-tree="$HOME"'


# --------------------------------------------------
# PATH
# --------------------------------------------------

path_prepend() {
    case ":$PATH:" in
        *":$1:"*) ;;
        *) PATH="$1:$PATH" ;;
    esac
}

export PNPM_HOME="$HOME/.local/share/pnpm"

path_prepend "$PNPM_HOME/bin"
path_prepend "$HOME/.local/bin"

export PATH


# --------------------------------------------------
# Short Path
# --------------------------------------------------

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


# --------------------------------------------------
# Git Branch + Status
# --------------------------------------------------

parse_git_branch() {
    local branch

    branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return

    if git diff --quiet 2>/dev/null &&
       git diff --cached --quiet 2>/dev/null &&
       [[ -z "$(git ls-files --others --exclude-standard 2>/dev/null)" ]]; then

        # clean — green
        printf "\001\033[0;32m\002 (%s)\001\033[0m\002" "$branch"
    else

        # dirty/untracked — red
        printf "\001\033[0;31m\002 (%s)\001\033[0m\002" "$branch"
    fi
}


# --------------------------------------------------
# Prompt
# --------------------------------------------------

export PS1="\u@\h \$(short_path)\$(parse_git_branch) \$ "


# --------------------------------------------------
# Find Directory
# --------------------------------------------------

fd() {
    local dir

    dir=$(find "$HOME" -maxdepth 4 -type d \
        ! -path "*/.git*" \
        ! -path "*/node_modules*" |
        fzf --prompt="> ")

    if [[ -n "$dir" ]]; then
        cd "$dir" || return
    fi
}


# --------------------------------------------------
# Find File
# --------------------------------------------------

ff() {
    local file

    file=$(find "$HOME" -maxdepth 4 -type f \
        ! -path "*/.git*" \
        ! -path "*/node_modules*" |
        fzf --prompt="> ")

    if [[ -n "$file" ]]; then
        nvim "$file"
    fi
}
