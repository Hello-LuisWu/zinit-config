# zinit-config

## install zinit

```sh
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
```

## install plugins

用 `vim ~/.zshrc` 命令将以下代码复制到 `.zshrc` 文件里

```sh

# 启动shell 检查有没有安装fzf
if ! command -v fzf &>/dev/null; then
    echo "fzf 未安装，正在安装..."

    # 判断操作系统
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS 安装 fzf
        if command -v brew &>/dev/null; then
            brew install fzf
        else
            echo "未检测到 Homebrew，请先安装 Homebrew: https://brew.sh/"
            exit 1
        fi
    elif [[ -f /etc/os-release ]]; then
        # 读取 Linux 发行版信息
        . /etc/os-release
        case "$ID" in
            ubuntu|debian)
                sudo apt update && sudo apt install -y fzf
                ;;
            arch|manjaro)
                sudo pacman -Sy --noconfirm fzf
                ;;
            fedora)
                sudo dnf install -y fzf
                ;;
            *)
                echo "未知 Linux 发行版 ($ID)，使用 Git 方式安装 fzf..."
                git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
                ~/.fzf/install
                ;;
        esac
    else
        echo "无法检测操作系统类型，请手动安装 fzf: https://github.com/junegunn/fzf"
        exit 1
    fi
fi


# 检查 starship 是否安装
if ! command -v starship &>/dev/null; then
    echo "starship 未安装，正在安装..."

    # 判断操作系统
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS 安装 starship
        if command -v brew &>/dev/null; then
            brew install starship
        else
            echo "未检测到 Homebrew，请先安装 Homebrew: https://brew.sh/"
            exit 1
        fi
    elif [[ -f /etc/os-release ]]; then
        # 读取 Linux 发行版信息
        . /etc/os-release
        case "$ID" in
            ubuntu|debian)
                sudo apt update && sudo apt install -y starship
                ;;
            arch|manjaro)
                sudo pacman -Sy --noconfirm starship
                ;;
            fedora)
                sudo dnf install -y starship
                ;;
            *)
                echo "未知 Linux 发行版 ($ID)，尝试使用官方安装方式..."
                curl -sS https://starship.rs/install.sh | sh
                ;;
        esac
    else
        echo "无法检测操作系统类型，请手动安装 starship: https://starship.rs/"
        exit 1
    fi
fi
# 判断 ~/.config/starship.toml 是否存在
if [[ ! -f ~/.config/starship.toml ]]; then
    starship preset pastel-powerline -o ~/.config/starship.toml
fi


# =========================================================
# History
# =========================================================
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_VERIFY
setopt EXTENDED_HISTORY

ZVM_AUTO_INSERT_PAIR=true
autoload -Uz compinit && compinit

zinit ice depth=1 lucid
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab
zinit light Freed-Wu/fzf-tab-source
zinit light zsh-users/zsh-autosuggestions
zinit snippet OMZP::sudo
zinit snippet https://raw.githubusercontent.com/Hello-LuisWu/zsh-config/refs/heads/main/.zshconf/config/vimode.zsh
zinit light hlissner/zsh-autopair
zinit light zsh-users/zsh-history-substring-search
# zinit light sindresorhus/pure
zinit light zdharma-continuum/fast-syntax-highlighting

# sudo 按键绑定 ------------------------------------------------------
bindkey -M emacs '^f' sudo-command-line
bindkey -M vicmd '^f' sudo-command-line
bindkey -M viins '^f' sudo-command-line

# vi mode 按键绑定 ------------------------------------------------------
bindkey -M vicmd 'H' vi-first-non-blank
bindkey -M vicmd 'L' vi-end-of-line
bindkey -M viins '^\\' vi-cmd-mode

# function zvm_after_init() {
bindkey '^k' history-substring-search-up
bindkey '^j' history-substring-search-down

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# }

# zsh-history-substring-search 取消高亮
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=''
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=''
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

eval "$(starship init zsh)" # starship

alias ..="cd .."
alias c="clear"
alias q="exit"
alias rm="rm -rf"
alias cp="cp -ri"
alias mkdir="mkdir -p"
alias mk="mkdir"
alias os="fastfetch"
alias l="eza -la --header --icons --time-style=long-iso --git --ignore-glob='.git|.DS_Store'"
alias ll="eza -la --header --icons --tree --time-style=long-iso --git --ignore-glob='.git|.DS_Store'"
alias ls="eza -aF --icons   --ignore-glob='.git|.DS_Store'"
alias re="source ~/.zshrc"
alias ga="git add ."
alias gc="git commit"
alias gl="git pull"
alias gp="git push"
alias gd="git diff"
alias gs="git status"
alias gw="git switch"
alias gb="git branch"
alias gk="git clone --depth 1"
alias gho='git config --global http.proxy http://127.0.0.1:7897 && git config --global https.proxy http://127.0.0.1:7897'
alias ghc='git config --global --unset http.proxy && git config --global --unset https.proxy'
alias ghp='git config --global --get http.proxy && git config --global --get https.proxy'
alias gg="lazygit"
alias n="nvim"
alias v="vim"
alias zz="nvim ~/.zshrc"
alias geg="git config --global --edit"
alias gel="git config --local --edit"
alias gedit="git config --global core.editor vim"
alias gname="git config --global user.name LuisWu"
alias gmail="git config --global user.email 1014150883@qq.com"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
```

用 `exec zsh` 命令重启 zsh
