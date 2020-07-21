fun! TheTabLine()
	let attr = []
	let text = []

  for i in range(tabpagenr('$'))
		let a = ''
		let t = ''

    let tab = i + 1
    let buflist = tabpagebuflist(tab)
		let bufnr = buflist[tabpagewinnr(tab) - 1]
    let bufname = bufname(bufnr)
		for j in buflist 
			let bufmodified = getbufvar(j, "&mod")
			if bufmodified | break | endif
		endfor
		let bufisdir = (getbufvar(bufnr, "&filetype") == "netrw") " consider changing this 

    let a .= '%' . tab . 'T'
    let a .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let t .= ' ' . tab . ' '
    let t .= (bufname != '' ? fnamemodify(bufname, ':t') : '[No Name]')
		let t .= (bufisdir ? '/' : '')
		let i  = (len(buflist)>1? len(buflist) : '') . (bufmodified ? '+' : '')
		let t .= (len(i)>0? ' ['.i.']' : '')
    let t .= (tab == tabpagenr() || tab == tabpagenr()-1 || tab == tabpagenr('$') ? ' ' : ' |')

		let attr += [a]
		let text += [t]
  endfor

	if len(join(text, '')) > &columns && tabpagenr('$') > 1
		let isfull = [] | let l = 0
		for i in range(tabpagenr('$'))
			let isfull += [0]
			if i == tabpagenr()-1 | continue | endif
			let text[i] = (i == tabpagenr()-2 || i == tabpagenr('$')-1 ? text[i][1:-2] : text[i][1:-3].text[i][-1:-1])
		endfor
		let isfull[tabpagenr()-1] = 1
		while 1
			let l = &columns
			for i in range(tabpagenr('$'))
				let l -= len(text[i])*isfull[i]
			endfor
			exe 'let sum = ' . tabpagenr('$') . '-'. join(isfull, '-')
			if sum>0 | let l = l / sum | else | let l = &columns | endif
			for i in range(tabpagenr('$'))
				if i == tabpagenr()-1 | continue | endif
				let isfull[i] = (l >= len(text[i]) ? 1:0)
			endfor

			exe 'let q = ' . join(isfull, '+') .'+'. (sum-tabpagenr('$'))
			if q <= 0 | break | endif
		endwhile
		let l = l/2
		let c = &columns
		for i in range(tabpagenr('$'))
			let c -= len(text[i])*isfull[i]
		endfor
		let c -= 2*l*sum
		for i in range(tabpagenr('$'))
			if !isfull[i]
				let t = text[i]
				let text[i] =  t[:l+(c>0)-1] . '*'
				let c -= 1
				let text[i].= t[-l-(c>0)+1:]
				let c -= 1
			endif
			" … * . 
		endfor
	endif 

	let line = ''
	for i in range(tabpagenr('$'))
		let line .= attr[i] . text[i]
	endfor
  return line . '%#TabLineFill#%999T%='
endfun

set tabline=%!TheTabLine()
