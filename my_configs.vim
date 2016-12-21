"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fileformat
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Favorite filetype
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM userinterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set 7 lines to the curors - when moving vertical..
set so=7

"Turn on WiLd menu
set wildmenu

"Always show current position
set ruler

"The commandbar is 2 high
set cmdheight=2

"Show line number
set nu

"Do not redraw, when running macros.. lazyredraw
set lz

"Change buffer - without saving
set hid

"Set backspace
set backspace=indent,eol,start
"Bbackspace and cursor keys wrap to
set whichwrap+=<,>,h,l

"Ignore case when searching
"set ignorecase
set incsearch

"Set magic on
set magic

"No sound on errors.
set noerrorbells
set novisualbell
set t_vb=

"show matching bracet
set showmatch

"""" from https://github.com/MarcWeber/vim-addon-manager/blob/master/doc/vim-addon-manager.txt

fun! SetupVAM()
	" set advanced options like this:
	" let g:vim_addon_manager = {}
	" let g:vim_addon_manager['key'] = value

	" YES, you can customize this vam_install_path path and everything still works!
	let vam_install_path = expand('$HOME') . '/.vim/vim-addons'
	exec 'set runtimepath+='.vam_install_path.'/vim-addon-manager'

	" * unix based os users may want to use this code checking out VAM
	" * windows users want to use http://mawercer.de/~marc/vam/index.php
	" to fetch VAM, VAM-known-repositories and the listed plugins
	" without having to install curl, unzip, git tool chain first
	" -> BUG [4] (git-less installation)
	if !filereadable(vam_install_path.'/vim-addon-manager/.git/config') && 1 == confirm("git clone VAM into ".vam_install_path."?","&Y\n&N")
		" I'm sorry having to add this reminder. Eventually it'll pay off.
		call confirm("Remind yourself that most plugins ship with documentation (README*, doc/*.txt). Its your first source of knowledge. If you can't find the info you're looking for in reasonable time ask maintainers to improve documentation")
		exec '!p='.shellescape(vam_install_path).'; mkdir -p "$p" && cd "$p" && git clone --depth 1 git://github.com/MarcWeber/vim-addon-manager.git'
		" VAM run helptags automatically if you install or update plugins
		exec 'helptags '.fnameescape(vam_install_path.'/vim-addon-manager/doc')
	endif

	" Example drop git sources unless git is in PATH. Same plugins can
	" be installed form www.vim.org. Lookup MergeSources to get more control
	" let g:vim_addon_manager['drop_git_sources'] = !executable('git')

	call vam#ActivateAddons([], {'auto_install' : 0})
	" sample: call vam#ActivateAddons(['pluginA','pluginB', ...], {'auto_install' : 0})
	" - look up source from pool (<c-x><c-p> complete plugin names):
	" ActivateAddons(["foo", ..
	" ActivateInstalledAddons(["taglist", "mathit.zip", "the_NERD_tree", "bufexplorer.zip" ] , {'auto_install' : 0})
  ActivateInstalledAddons  taglist matchit.zip The_NERD_tree The_NERD_Commenter
				\ bufexplorer.zip cscope_macros minibufexplorer Command-T python%790
				\ Syntastic SuperTab%1643 EasyMotion NrrwRgn fugitive
	" - name rewritings:
	" ..ActivateAddons(["github:foo", .. => github://foo/vim-addon-foo
	" ..ActivateAddons(["github:user/repo", .. => github://user/repo
	" Also see section "2.2. names of addons and addon sources" in VAM's documentation
endfun
call SetupVAM()
" experimental [E1]: load plugins lazily depending on filetype, See
" NOTES
" experimental [E2]: run after gui has been started (gvim) [3]
" option1: au VimEnter * call SetupVAM()
" option2: au GUIEnter * call SetupVAM()
" See BUGS sections below [*]
" Vim 7.0 users see BUGS section [3]

""" supertab settings
let g:SuperTabDefaultCompletionType="<c-n>"

nnoremap gn :call DecAndHex(expand("<cWORD>"))<CR>

function! DecAndHex(number)
	let ns = '[.,;:''"<>()^_lL]'      " number separators
	if a:number =~? '^' . ns. '*[-+]\?\d\+' . ns . '*$'
		let dec = substitute(a:number, '[^0-9+-]*\([+-]\?\d\+\).*','\1','')
		echo dec . printf('  ->  0x%X, -(0x%X)', dec, -dec)
	elseif a:number =~? '^' . ns. '*\%\(h''\|0x\|#\)\?\(\x\+\)' . ns . '*$'
		let hex = substitute(a:number, '.\{-}\%\(h''\|0x\|#\)\?\(\x\+\).*','\1','')
		echon '0x' . hex . printf('  ->  %d', eval('0x'.hex))
		if strpart(hex, 0,1) =~? '[89a-f]' && strlen(hex) =~? '2\|4\|6'
			" for 8/16/24 bits numbers print the equivalent negative number
			echon ' ('.  float2nr(eval('0x'. hex) - pow(2,4*strlen(hex))) . ')'
		endif
		echo
	else
		echo "NaN"
	endif
endfunction

com Index !cscope-indexer -r;ctags --c++-kinds=+p --fields=+iaS --extra=+q -R
com AddIndex cs add cscope.out;set tags=tags
com S mks!
com Sh ConqueTermSplit bash --init-file ~/.vim/plugin/coque.sh
com Shv ConqueTermVSplit bash --init-file ~/.vim/plugin/coque.sh
com Shn ConqueTerm bash --init-file ~/.vim/plugin/coque.sh
se tabstop=4
com Ls TlistToggle
com Fs NERDTreeToggle
set tags=tags
let Tlist_File_Fold_Auto_Close=1
let Tlist_Use_Right_Window=1
nmap <C-]>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-]>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-]>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-]>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-]>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-]>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-]>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-]>d :cs find d <C-R>=expand("<cword>")<CR><CR>
#imap <C-k> <up>
#imap <C-j> <down>
#imap <C-h> <left>
#imap <C-l> <right>
#nmap <C-a> :bnext <CR>
#nmap <C-e> :bprev <CR>
#nmap <C-x> :b# <CR>
