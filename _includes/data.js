var areas = [{% for area in site.areas %}
	{
		title: '{{ area.title }}',
		icone: '{{ area.icone }}',
		url: '{{ area.url }}'
	}{% if forloop.last == false %},{% endif %}{% endfor %}
];

{% assign site_data_ordered = site.data[include.semestre_data] order_by: 'Nível', 'Série', 'Turma' %}
var unidades = [{% for unidade in site.unidades %}
	{	
		id: '{{ unidade.id | remove: '/unidades' }}',
		title: '{{ unidade.title }}',
		url: '{{ site.baseurl }}{{ unidade.url }}',
		turmas: { {% assign tags = "" | split: "" %}{% assign labels = "" | split: "" %}{% for linha in site_data_ordered %}{% if linha["Unidade"] == unidade.title %}{% assign nivel = site.data.niveis | where: 'title', linha["Nível"] %}{% assign tag_id = nivel[0].tag | append: linha["Série"] | append: linha["Turma"] %}{% if tags contains tag_id %}{% continue %}{% endif %}{% assign tags = tags | push: tag_id %}{% capture label %}Ensino {{ linha["Nível"] }} {{ linha["Série"] }}º {{ linha["Turma"] }}{% endcapture %}{% assign labels = labels | push: label %}{% endif %}{% endfor %}{% for tag in tags %}{% capture label %}{{ labels[forloop.index0] }}{% endcapture %}
			{{ tag }}: '{{ label }}'{% if forloop.last == false %},{% endif %}{% endfor %}
		}
	}{% if forloop.last == false %},{% endif %}{% endfor %}
];
