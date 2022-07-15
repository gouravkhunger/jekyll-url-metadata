# Jekyll::URLMetadata

A jekyll plugin to extract meta information from urls and expose them to liquid variables.

This gem was originally authored to be used as a custom plugin for the [static site](https://github.com/genicsblog/genicsblog.com) of [genicsblog.com](https://genicsblog.com)

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

This plugin is essentially a filter and works on any [valid URL string](https://en.wikipedia.org/wiki/URL#Syntax) provided inside a liquid tag. Use it as below:

```liquid
{% assign meta = "https://wikipedia.org" | metadata %}
```

The `metadata` filter extracts the meta data from the given url string.

These are the values that are extracted:

- The `<title>` tag.
- The `<meta>` tags that have a `name`, `property` or `charset` fields.
- The `<link>` tags with a `rel` attribute.

The expected output for `{{ meta }}` from the above example would be:

```
{
  "title" => "Wikipedia",
  "charset" => "utf-8",
  "description" => "Wikipedia is a free online encyclopedia, created and edited by volunteers around the world and hosted by the Wikimedia Foundation.",
  "viewport" => "initial-scale=1,user-scalable=yes",
  "apple-touch-icon" => "/static/apple-touch/wikipedia.png",
  "shortcut icon" => "/static/favicon/wikipedia.ico",
  "license" => "//creativecommons.org/licenses/by-sa/3.0/",
  "preconnect" => "//upload.wikimedia.org"
}
```

## Use cases

- Creating beautiful social previews for links by fetching meta data for URLs at build time.
- Determining meta data from a website at jekyll build time to evaluate and perform certain action.

## License

The gem is available as open source under the terms of the [MIT License](https://github.com/gouravkhunger/jekyll-url-metadata/blob/main/LICENSE).
