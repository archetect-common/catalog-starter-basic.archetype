# {{ description }} Catalog

{% if source-control == "Github" -%}
![Latest Release](https://img.shields.io/github/v/release/{{ organization-name }}/{{ project-name }}.archetype?style=flat-square&label=Latest%20Release&color=blue)
{%- endif -%}

This is an [Archetect](https://archetect.github.io/) catalog.

## Rendering

To generate content from this Archetype, copy and execute the following command:

```sh
archetect render {% if git-repo %}{{ git-repo }}{% else %}<git repo>{% endif %}
```
