require "open-uri"
require "nokogiri"

module Jekyll
  module URLMetadata

    def metadata(input)
      if !input.is_a?(String)
        log("Expected input type \"String\". Got \"#{input.class}\".")
        return
      end

      if input.nil? || input == ""
        log("Empty input string.")
        return
      end

      # parse HTML from URL
      doc = Nokogiri::HTML(URI.open(input))
      if !doc
        log("Failed to parse HTML from #{input}. Please double check for URL validity.")
      end

      hash = Hash.new

      # add <title> tag's value to the hash
      doc.search("title").each do | title |
        next if title.content == ""
        hash["title"] = title.content
      end

      # add possible <meta> tag attribute's value to the hash
      doc.search("meta").each do | meta |
        name = get(meta, "name")
        property = get(meta, "property")
        charset = get(meta, "charset")
        content = get(meta, "content")

        if exists(name)
          hash[name] = content
        elsif exists(property)
          hash[property] = content
        elsif exists(charset)
          hash["charset"] = charset
        end
      end

      # add possible <link> tag attribute's value to the hash
      doc.search("link").each do | link |
        hash[get(link, "rel")] = get(link, "href")
      end
  
      hash
    end

    def log(msg)
      Jekyll.logger.error "URL Metadata:", msg
    end

    def exists(obj)
      !obj.nil? && obj != ""
    end

    def get(obj, attr)
      obj.get_attribute(attr)
    end

  end # module Jekyll
end # module URLMetadata

Liquid::Template.register_filter(Jekyll::URLMetadata)
