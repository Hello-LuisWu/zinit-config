### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk


# =====================================================
# 检查并安装 eza
# =====================================================

if ! command -v eza &>/dev/null; then
    echo "eza 未安装，正在安装..."
    # 判断操作系统
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if command -v brew &>/dev/null; then
            brew install eza
        else
            echo "未检测到 Homebrew，请先安装 Homebrew"
            exit 1
        fi
    elif [[ -f /etc/os-release ]]; then
        # Linux
        . /etc/os-release
        case "$ID" in
            ubuntu|debian)
                echo "正在安装 Debian/Ubuntu eza..."
                sudo apt update
                sudo apt install -y gpg wget
                sudo mkdir -p /etc/apt/keyrings
                wget -qO- \
                https://raw.githubusercontent.com/eza-community/eza/main/deb.asc \
                | sudo gpg --dearmor \
                -o /etc/apt/keyrings/gierens.gpg
                echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" \
                | sudo tee /etc/apt/sources.list.d/gierens.list >/dev/null
                sudo chmod 644 \
                /etc/apt/keyrings/gierens.gpg \
                /etc/apt/sources.list.d/gierens.list
                sudo apt update
                sudo apt install -y eza
                ;;
            arch|manjaro)
                echo "正在安装 Arch eza..."
                sudo pacman -Syu --noconfirm
                sudo pacman -S eza
                ;;
            fedora|rocky|rhel|centos)
                echo "正在安装 RHEL 系 eza..."
                if ! sudo dnf install -y eza; then
                    echo "使用 cargo 安装 eza"
                    sudo dnf install -y cargo
                    cargo install eza
                    export PATH="$HOME/.cargo/bin:$PATH"
                fi
                ;;
            *)
                echo "未知 Linux 发行版: $ID"
                echo "请手动安装 eza: https://github.com/eza-community/eza/blob/main/INSTALL.md"
                exit 1
                ;;
        esac
    else
        echo "无法检测系统类型，请手动安装 eza"
        exit 1
    fi
fi

# ============================================
# 检查有没有安装 fastfetch
# ============================================
if ! command -v fastfetch &>/dev/null; then
    echo "fastfetch 未安装，正在安装..."

    # 判断操作系统
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS 安装 fastfetch
        if command -v brew &>/dev/null; then
            brew install fastfetch
        else
            echo "未检测到 Homebrew，请先安装 Homebrew: https://brew.sh/"
            exit 1
        fi
    elif [[ -f /etc/os-release ]]; then
        # 读取 Linux 发行版信息
        . /etc/os-release
        case "$ID" in
            ubuntu|debian)
#                sudo add-apt-repository ppa:zhangsongcui3371/fastfetch
#                sudo apt update
                sudo apt install -y fastfetch
                ;;
            arch|manjaro)
                sudo pacman -S  --noconfirm fastfetch
                ;;
            fedora|rocky|rhel|centos)
                sudo dnf install -y fastfetch
                ;;
            *)
                echo "未知 Linux 发行版 ($ID)"
                echo "请手动安装 fastfetch:"
                echo "https://github.com/fastfetch-cli/fastfetch"
                exit 1
                ;;
        esac
    else
        echo "无法检测操作系统类型，请手动安装 fastfetch"
        exit 1
    fi
fi

# =================================================
# 检查有没有安装fzf
# =================================================
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
                sudo apt install -y fzf
                ;;
            arch|manjaro)
                sudo pacman -S  --noconfirm fzf
                ;;
            fedora|rocky|rhel|centos)
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


# =================================================
# 检查有没有安装 yazi
# =================================================
if ! command -v yazi &>/dev/null; then
    echo "yazi 未安装，正在安装..."

    # 判断操作系统
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS 安装 yazi
        if command -v brew &>/dev/null; then
            brew update
            brew install yazi ffmpeg-full sevenzip jq poppler zoxide resvg imagemagick-full font-symbols-only-nerd-font
            brew link ffmpeg-full imagemagick-full -f --overwrite
        else
            echo "未检测到 Homebrew，请先安装 Homebrew: https://brew.sh/"
            exit 1
        fi
    elif [[ -f /etc/os-release ]]; then
        # 读取 Linux 发行版信息
        . /etc/os-release
        case "$ID" in
            ubuntu|debian)
                sudo snap install yazi --classic
                ;;
            arch|manjaro)
                sudo pacman -S --noconfirm yazi ffmpeg 7zip jq poppler zoxide resvg imagemagick
                ;;
            fedora|rocky|rhel|centos)
                sudo dnf copr enable lihaohong/yazi
                sudo dnf install -y yazi
                ;;
            *)
                echo "未知 Linux 发行版 ($ID)，请使用 Git 安装 yazi..."
                ;;
        esac
    else
        echo "无法检测操作系统类型，请手动安装 yazi: https://yazi-rs.github.io/docs/installation"
        exit 1
    fi
fi

# =================================================
# 检查有没有安装 lazygit
# =================================================
if ! command -v lazygit &>/dev/null; then
    echo "lazygit 未安装，正在安装..."

    # 判断操作系统
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS 安装 lazygit
        if command -v brew &>/dev/null; then
            brew install lazygit
        else
            echo "未检测到 Homebrew，请先安装 Homebrew: https://brew.sh/"
            exit 1
        fi
    elif [[ -f /etc/os-release ]]; then
        # 读取 Linux 发行版信息
        . /etc/os-release
        case "$ID" in
            ubuntu|debian)
                sudo apt install -y lazygit
                ;;
            arch|manjaro)
                sudo pacman -S --noconfirm lazygit
                ;;
            fedora|rocky|rhel|centos)
                sudo dnf copr enable dejan/lazygit
                sudo dnf install -y lazygit
                ;;
            *)
                echo "未知 Linux 发行版 ($ID)，请使用 Git 方式安装 lazygit..."
                ;;
        esac
    else
        echo "无法检测操作系统类型，请手动安装 lazygit: https://github.com/jesseduffield/lazygit"
        exit 1
    fi
fi


# =================================================
# 检查有没有安装 ripgrep
# =================================================
if ! command -v rg &>/dev/null; then
    echo "ripgrep 未安装，正在安装..."

    # 判断操作系统
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS 安装 ripgrep
        if command -v brew &>/dev/null; then
            brew install ripgrep
        else
            echo "未检测到 Homebrew，请先安装 Homebrew: https://brew.sh/"
            exit 1
        fi
    elif [[ -f /etc/os-release ]]; then
        # 读取 Linux 发行版信息
        . /etc/os-release
        case "$ID" in
            ubuntu|debian)
                sudo apt-get install ripgrep
                ;;
            arch|manjaro)
                sudo pacman -S --noconfirm ripgrep
                ;;
            fedora|rocky|rhel|centos)
                echo "rocky10 安装..."
                sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm
                sudo dnf install ripgrep
                ;;
            *)
                echo "未知 Linux 发行版 ($ID)，请使用 Git 方式安装 ripgrep..."
                ;;
        esac
    else
        echo "无法检测操作系统类型，请手动安装 ripgrep: https://github.com/BurntSushi/ripgrep"
        exit 1
    fi
fi


# =================================================
# 检查有没有安装 fd
# =================================================
if ! command -v fd &>/dev/null; then
    echo "fd 未安装，正在安装..."

    # 判断操作系统
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS 安装 fd
        if command -v brew &>/dev/null; then
            brew install fd
        else
            echo "未检测到 Homebrew，请先安装 Homebrew: https://brew.sh/"
            exit 1
        fi
    elif [[ -f /etc/os-release ]]; then
        # 读取 Linux 发行版信息
        . /etc/os-release
        case "$ID" in
            ubuntu|debian)
                sudo apt-get install fd-find
                ;;
            arch|manjaro)
                sudo pacman -S --noconfirm fd
                ;;
            fedora|rocky|rhel|centos)
                sudo dnf copr enable tkbcopr/fd
                sudo dnf install -y fd
                ;;
            *)
                echo "未知 Linux 发行版 ($ID)，请使用 Git 方式安装 fd..."
                ;;
        esac
    else
        echo "无法检测操作系统类型，请手动安装 fd: https://github.com/sharkdp/fd"
        exit 1
    fi
fi




# ========================================
# 检查 starship 是否安装
# ========================================
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
zinit snippet https://raw.githubusercontent.com/Hello-LuisWu/zinit-config/refs/heads/main/plugins/sudo.zsh
zinit snippet https://raw.githubusercontent.com/Hello-LuisWu/zsh-config/refs/heads/main/.zshconf/config/vimode.zsh
zinit light hlissner/zsh-autopair
zinit light zsh-users/zsh-history-substring-search
# zinit light sindresorhus/pure
zinit light zdharma-continuum/fast-syntax-highlighting

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

alias ..="cd .."
alias c="clear"
alias q="exit"
alias rm="rm -rf"
alias cp="cp -ri"
alias m="mkdir -p"
alias os="fastfetch"
alias l="eza -la --header --icons --time-style=long-iso --ignore-glob='.git|.DS_Store'"
alias ll="eza -la --header --icons --tree --time-style=long-iso --ignore-glob='.git|.DS_Store'"
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
alias f="yazi"
alias ff="fzf"
alias fg="rg"
alias fd="fd"
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

eval "$(starship init zsh)"
