#/bin/zsh
#This is the manual to configure zsh & tmux & vim. 
#Author : Huiming Lv
#Note : update to use spf13-vim on 2016/12/21

git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

ln -s ~/zsh_tmux_vim/.zshrc ~/.zshrc

ln -s ~/zsh_tmux_vim/.tmux.conf ~/.tmux.conf 

git clone https://github.com/altercatin/vim-colors-solarized.git ~/vim-colors-solarized

#install spf13-vim3
sh <(curl https://j.mp/spf13-vim3 -L)

ln -s ~/zsh_tmux_vim/.vimrc.local ~/.vimrc.local
ln -s ~/zsh_tmux_vim/.vimrc.bundles.local ~/.vimrc.bundles.local

chsh -s /bin/zsh
