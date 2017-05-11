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

areas = [{% for area in site.areas %}
	{
		title: '{{ area.title }}'
		icone: '{{ area.icone }}'
		content: '{{ area.content }}'
		url: '{{ area.url }}'
	}
{% endfor %}]

console.log areas

unidades = [{% for unidade in site.unidades %}
	{
		title: '{{ unidade.title }}'
		content: '{{ unidade.content }}'
		url: '{{ unidade.url }}'
		turmas: { {% assign tags = "" | split: "" %}
		{% for linha in site.data[site.semestre_data] order_by: 'Nível', 'Série', 'Turma' %}

			{% if linha["Unidade"] == unidade.title %}
				{% assign nivel = site.data.niveis | where: 'title', linha["Nível"] %}
				{% assign tag_id = nivel[0].tag | append: linha["Série"] | append: linha["Turma"] %}
				{% if tags contains tag_id %}{% continue %}{% endif %}{% assign tags = tags | push: tag_id %}

			{{ tag_id }}: 'Ensino {{ linha["Nível"] }} {{ linha["Série"] }}º {{ linha["Turma"] }}'

				{% endif %}

		{% endfor %}
		}
	}
{% endfor %}]

console.log unidades