---
layout: base
---

# Jekyll::URLMetadata

A jekyll plugin to extract meta information from urls and expose them to liquid variables.

This gem was originally authored to be used as a custom plugin for the [static site](https://github.com/genicsblog/genicsblog.com) of [genicsblog.com](https://genicsblog.com).

## Installation

Add this line to your application's Gemfile inside the `jekyll_plugins` group:

```ruby
group :jekyll_plugins do
    # other gems
    gem "jekyll-url-metadata"
end
```

Then, enable the plugin by adding it to the `plugins` section in the `_config.yml` file:

```yaml
plugins:
    # - other plugins
    - jekyll-url-metadata
```

And then execute:

```shell
bundle install
```

## Usage

This plugin is essentially a filter that works on any [valid URL string](https://en.wikipedia.org/wiki/URL#Syntax) provided inside a liquid tag. Use it as below:

```liquid
{% raw %}{% assign meta = "https://wikipedia.org" | metadata %}{% endraw %}
```

The `metadata` filter extracts the meta data from the given url string and returns the data as a `Hash`.

These are the values that are extracted:

- The `<title>` tag.
- The `<meta>` tags that have a `name`, `property` or `charset` fields.
- The `<link>` tags with a `rel` attribute.

The expected output for `{% raw %}{{ meta }}{% endraw %}` from the above example would be:

```liquid
{% raw %}{{ meta }}{% endraw %}
{% assign meta = "https://wikipedia.org" | metadata %}
{{ meta }}
```

Let us extract the `og:image` from the metadata of the article [Pagination in Android Room Database](https://genicsblog.com/gouravkhunger/pagination-in-android-room-database-using-the-paging-3-library) at Genics Blog. The following snippet does the same:

```liquid
{% raw %}{% assign article_meta = "https://genicsblog.com/gouravkhunger/pagination-in-android-room-database-using-the-paging-3-library" | metadata %}

{{ article_meta['og:image'] }}{% endraw %}
```

The output of the above code will be as follows:

```
{% assign article_meta = "https://genicsblog.com/gouravkhunger/pagination-in-android-room-database-using-the-paging-3-library" | metadata %}{{ article_meta['og:image'] }}
```

Thus, it can be used to generate link previews at build time. The [`linkpreview.html`](https://github.com/genicsblog/theme-files/blob/main/_includes/linkpreview.html) implementation at Genics Blog presents how to use the plugin to generate url cards in a production Jekyll blog.

### Simple link preview example

This is a link preview generated with this Jekyll package and some custom CSS.

{% include link_preview.html url="https://genicsblog.com/gouravkhunger/pagination-in-android-room-database-using-the-paging-3-library" %}

You need to create an include file called
[`_include/link_preview.html`](https://github.com/gouravkhunger/jekyll-url-metadata/blob/main/example/_includes/link_preview.html)

You also need to add some CSS. Using this website as example, you need to
extend the minima theme. All you need to do is to create a file called
[`_sass/minima/custom-styles.scss`](https://github.com/gouravkhunger/jekyll-url-metadata/blob/main/example/_sass/minima/custom-styles.scss). If you use other Jekyll themes you must follow their documentation.

Finally you need to add a couple of variables in the `_config.yml` file. These
are required and will truncate the title and the description to the desired
number of characters.

```yaml
link_preview:
  title_max_characters: 64
  description_max_characters: 128
```

To use this example you just need to include the `link_preview.html` file with
a `url` parameter, like this:

```liquid
{% raw %}{% include link_preview.html url="https://genicsblog.com/gouravkhunger/pagination-in-android-room-database-using-the-paging-3-library" %}{% endraw %}
```
