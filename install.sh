#/bin/zsh
#This is the manual to configure zsh & tmux & vim. 
#Author : Huiming Lv

git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

ln -s ~/zsh_tmux_vim/.zshrc ~/.zshrc

ln -s ~/zsh_tmux_vim/.tmux.conf ~/.tmux.conf 

git clone https://github.com/altercatin/vim-colors-solarized.git ~/vim-colors-solarized

#install vim_runtime
git clone git://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

ln -s ~/zsh_tmux_vim/my_configs.vim ~/.vim_runtime/my_configs.vim     

chsh -s /bin/zsh
