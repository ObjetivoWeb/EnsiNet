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



dataTurmaArray = _ $('.post-list li')
if dataTurmaArray.length
	dataTurmas = {}
	dataTurmaArray
		.sort (a, b) ->
			aid = a.getAttribute 'data-turma'
			bid = b.getAttribute 'data-turma'
			return 1 if aid > bid
			return -1 if aid < bid
			0
		.forEach (li) ->
			dataTurmas[ li.getAttribute 'data-turma' ] = li.querySelector( '[data-turma-label]' ).textContent

	console.log dataTurmas

	for id, title of dataTurmas
		console.log id + ': ' + title
