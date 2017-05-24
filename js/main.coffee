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

Style = do ->
	s = document.createElement 'style'
	$('head')[0].appendChild s
	element: s
	css: (css) ->
		if s.styleSheet
			s.styleSheet.cssText = css
		else
			s.innerHTML = css
		@

if window.unidades

	window.ProjectList = PL = do ->

		control = $( '.breadcrumbs [data-turma-id]' )[0]
		list = $( '.post-list' )[0]
		btnIcon = control.getAttribute 'data-btn-icon'
		unidadeId = control.getAttribute 'data-unidade-id'
		turmaId = control.getAttribute 'data-turma-id'
		turmas = unidades.filter (unidade) -> unidade.id is unidadeId

		filterId: ''
		items: turmas[0].turmas
		init: () ->
			that = @
			controlBtn =  document.createElement 'a'
			controlBtn.className = 'breadcrumbs-btn'
			controlBtn.textContent = ( @.items[ turmaId ] or 'Selecione a turma ' ) + ' ' + btnIcon
			controlBtn.href = '#select'
			controlTrigger = document.createElement 'div'
			controlTrigger.className = 'breadcrumbs-submenu'
			for id, label of @.items
				controlTrigger.innerHTML += '''
					<a href="#select" data-turma-id="''' + id + '''">
						''' + label + '''
					</a>
					'''
			control.appendChild controlBtn
			control.appendChild controlTrigger
			control.addEventListener 'click', (e) ->
				return false unless id = e.target.getAttribute 'data-turma-id'
				that.filter id
				false
			control.addEventListener 'mouseover', (e) -> controlTrigger.classList.add 'active'
			control.addEventListener 'mouseleave', (e) -> controlTrigger.classList.remove 'active'
			@
		filter: (selectedId) ->
			@.filterId = selectedId
			unless selectedId? and selectedId
				return Style().css ''
			Style.css '''
				.post-list > :not([data-turma="''' + selectedId + '''"]) {
					display: none;
				}
				.post-list > [data-turma="''' + selectedId + '''"] {
					animation: appear .5s ease-in-out forwards
				}
				'''
	
	PL.init()