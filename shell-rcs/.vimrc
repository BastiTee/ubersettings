"Making vim either more vi-compatible or more useful
set nocompatible

"If you write to an existing file (but do not append) while the 'backup', 'writebackup' or 'patchmode' option is on, a backup of the original file is made
set nobackup

"Make a backup before overwriting a file
set nowritebackup

"When on, Vim automatically saves undo history to an undo file
set noundofile

"Vim stores the things you changed in a swap file
set noswapfile

"Same as :print, but precede each line with its line number
set number

"Use the appropriate number of spaces to insert a Tab
set expandtab

"Number of spaces that a <Tab> in the file counts for
set tabstop=4

"Syntax highlighting enables Vim to show parts of the text in another font or color
syntax on

"Maps command 'Save and run the current script' to F9
:map <F9> :w<CR>:!%:p<CR>

"Keymap - F7 previous tab
:map <F7> :tabp<CR>

"Keymap - F8 next tab
:map <F8> :tabn<CR> 

"Required for http://eclim.org/install.html
filetype plugin indent on

