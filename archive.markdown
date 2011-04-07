---
layout: default
title: Archive
---
<h2 id="intro">The list of all {{ site.posts.size }} posts.</h2>
<div id="post" markdown="1">
  {% for post in site.posts %}{{ post.date | date: "%b %d, %Y" }} | <img class="archive" src="/images/{{ post.layout }}.gif"> | <a href="{{ post.url }}">{{ post.title }}</a>
{% endfor %}
</div>