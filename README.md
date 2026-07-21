# zinit-config

## install zinit

```sh
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
```

## install plugins

用 `vim ~/.zshrc` 命令将以下代码复制到 `.zshrc` 文件里

```sh 
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
zinit light sindresorhus/pure
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
```

用 `exec zsh` 命令重启 zsh
