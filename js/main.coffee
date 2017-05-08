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

turmas = {}

dataTurmaArray = _ $('.post-list li')
    .forEach (li) ->
        turmas[ li.getAttribute 'data-turma' ] = li.querySelector( '[data-turma-label]' ).textContent

window.turmas = turmas

console.log turmas

for key, value of turmas
    console.log key + ': ' + value