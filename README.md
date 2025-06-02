# Jekyll::URLMetadata

[![Gem Version](https://img.shields.io/gem/v/jekyll-url-metadata)][ruby-gems]
[![Gem Total Downloads](https://img.shields.io/gem/dt/jekyll-url-metadata)][ruby-gems]

[ruby-gems]: https://rubygems.org/gems/jekyll-url-metadata

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

The `metadata` filter extracts the meta data from the given url string and returns the data as a `Hash`.

These are the values that are extracted:

- The `<title>` tag.
- The `<meta>` tags that have a `name`, `property` or `charset` fields.
- The `<link>` tags with a `rel` attribute.

The expected output for `{{ meta }}` from the above example would be:

```ruby
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

### Connection time-outs

By default, the connection request to the specified domain closes after about `1` second if there is an error.

To override the default behavior, add this block to the `_config.yml` file:

```yml
url_metadata:
  open_timeout: 5 # timeout after 5 second if connection doesn't open
  read_timeout: 3 # timeout after 3 second if there's no data returned
```

> **Note**: You may use any number for the timeout seconds, but generally a number less than `10` is ideal for better performance because the processing of the static pages is blocked until some data is returned from a website.

### Caching

Once the initial data is returned from the website, the extracted parameters are stored in the `.jekyll-cache` folder under `Jekyll--URLMetadata` plugin cache folder.

The cache improves subsequent build times in the local development environment.

If you wish to purge the cache, simple delete the `Jekyll--URLMetadata` folder and the plugin will re-generate the cache in the next run.

## Use cases

- Creating beautiful social previews for links by fetching meta data for URLs at build time.
- Determining meta data from a website at jekyll build time to evaluate and perform certain action.

See also the [example website](https://url-metadata.gourav.sh/) and
[its source code](https://github.com/gouravkhunger/jekyll-url-metadata/tree/main/example).

## Used by

<a href="https://github.com/gouravkhunger/jekyll-url-metadata/network/dependents">
  <img src="https://dependents.info/gouravkhunger/jekyll-url-metadata/image.svg" />
</a>

Made with [dependents.info](https://dependents.info).

## License

The gem is available as open source under the terms of the [MIT License](https://github.com/gouravkhunger/jekyll-url-metadata/blob/main/LICENSE).

```
MIT License

Copyright (c) 2022 Gourav Khunger

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
