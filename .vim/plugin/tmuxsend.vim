function! SendBottomV() range
	let l:selected = getline(a:firstline, a:lastline)
	let result = system("tmux send -t bottom \"". join(l:selected,'\n') ."\n\" 2>&1 | cat")
endfunction

function! SendBottom()
	let result = system("tmux send -t bottom \"". getline(".") ."\n\" 2>&1 | cat")
endfunction

function! ClearBottom()
	let result = system("tmux send -t bottom \"\" 2>&1 | cat")
endfunction

function! BsBottom()
	let result = system("tmux send -t bottom \"\" 2>&1 | cat")
endfunction
