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
		unidade = unidades.filter( (unidade) -> unidade.id is unidadeId )[0]
		controlBtn =  document.createElement 'a'
		controlBtn.className = 'breadcrumbs-btn'
		controlBtn.textContent = ( unidade.turmas[ turmaId ] or 'Selecione a turma ' ) + ' ' + btnIcon
		controlBtn.href = '#select'
		controlTrigger = document.createElement 'div'
		controlTrigger.className = 'breadcrumbs-submenu'
		controlTrigger.innerHTML = '<a href="#select" data-turma-id="reset">Todas</a>'
		for id, label of unidade.turmas
			controlTrigger.innerHTML += '<a href="#select" data-turma-id="' + id + '">' + label + '</a>'

		filterId: ''
		items: unidade.turmas
		init: () ->
			that = @
			control.innerHTML = ''
			control.appendChild controlBtn
			control.appendChild controlTrigger
			control.addEventListener 'click', (e) ->
				e.preventDefault()
				return false unless id = e.target.getAttribute 'data-turma-id'
				that.filter id
				controlBtn.textContent = ( that.items[ id ] or 'Selecione a turma ' ) + ' ' + btnIcon
				controlTrigger.classList.remove 'active'
				return false
			control.addEventListener 'mouseenter', (e) -> controlTrigger.classList.add 'active'
			control.addEventListener 'mouseleave', (e) -> controlTrigger.classList.remove 'active'
			@.reset()
			@
		filter: (selectedId) ->
			@.filterId = selectedId
			return Style.css '' unless selectedId? and selectedId
			if selectedId is 'reset'
				return @.reset()
			Style.css '''
				.post-list > :not([data-turma="''' + selectedId + '''"]) {
					display: none;
				}
				.post-list > [data-turma="''' + selectedId + '''"] {
					animation: appear 1s ease-in-out forwards
				}
				'''
		reset: () ->
			Style.css '''
				.post-list {
					animation: appear 1s ease-in-out forwards
				}
				'''
	
	PL.init()