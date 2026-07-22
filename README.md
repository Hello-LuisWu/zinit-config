# zinit-config

## 清除 zinit 残留文件（如果之前安装过 zinit）
```
rm -rf ~/.local/share/zinit ~/.cache/zinit ~/.zinit ~/.zinit/plugins
```


## 安装 zinit 和 zsh 插件

```sh
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/Hello-LuisWu/zinit-config/refs/heads/main/install.sh)"
```


用 `exec zsh` 命令重启 zsh
