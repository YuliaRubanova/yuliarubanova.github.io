---
layout: page
permalink: /publications/
title: Publications
description: 
categories: [Vision, Learned simulation, Graph Networks,Neural ODE, Cancer modelling, Discrete optimization]
nav: true
nav_order: 1
sort_field: date
sort_reverse: true
---
<!-- _pages/publications.md -->
<div class="publications">

{%- for y in page.categories %}
  <h4 class="category">{{y}}</h4>
  {% bibliography -f {{ site.scholar.bibliography }} -q @*[category={{y}}]* %}
{% endfor %}

</div>
