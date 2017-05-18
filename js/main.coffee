---
---

$ = (selector) -> document.querySelectorAll(selector)
_ = (nodeList, fn) -> 
	if fn
		Array.prototype.map.call(nodeList, fn)
	else
		Array.prototype.slice.call(nodeList)
Element.prototype.prependChild = (child) ->
	this.insertBefore child, this.firstChild

turmasControl = $( '.breadcrumbs [data-turma-id]' )[0]
turmasLista = $( '.post-list' )[0]

Style = ->
	s = document.createElement 'style'
	$('head')[0].appendChild s
	element: s
	css: (css) ->
		if s.styleSheet
			s.styleSheet.cssText = css
		else
			s.innerHTML = css
		@

window.s = Style()
# s.css [
# 	'body { background: red }'
# 	'p {font-size: .5em}'
# 	].join ' '

if window.unidades
	unidades.forEach (unidade) ->
		console.groupCollapsed unidade.id
		console.log unidade.title
		console.log unidade.url
		console.groupCollapsed 'Turmas'
		for key, val of unidade.turmas
			console.log key, ':', val
		console.groupEnd 'Turmas'
		console.groupEnd unidade.id
