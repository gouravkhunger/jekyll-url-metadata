require "open-uri"
require "nokogiri"

module Jekyll
  module URLMetadata

    def url_config
      begin
        @@url_config ||= @context.registers[:site].config['url_metadata'].nil? ? {} : 
          @context.registers[:site].config['url_metadata']
      rescue
        {}
      end
    end

    def cache
      @@cache ||= Jekyll::Cache.new("Jekyll::URLMetadata")
    end

    def metadata(input)
      return if !is_input_valid(input) || !is_config_valid()

      # The getset() API implements a cache first strategy
      cache.getset(input) do
        generate_hashmap(input)
      end
    end

    def generate_hashmap(input, testCase = false)
      # parse HTML from URL
      begin
        doc = Nokogiri::HTML(URI.open(input, { 
          :open_timeout => url_config["open_timeout"].nil? ? 1 : url_config["open_timeout"],
          :read_timeout => url_config["read_timeout"].nil? ? 1 : url_config["read_timeout"]
        }))
      rescue
        log("Failed to parse HTML from '#{input}'. Please double check for URL validity.") if !testCase
        return
      end

      hash = Hash.new

      # add first <title> tag's value to the hash
      doc.search("head title").each do | title |
        break if exists(hash["title"])
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

    def is_input_valid(input, testCase = false)
      if !input.is_a?(String)
        log("Expected input type 'String'. Got '#{input.class}'.") if !testCase

        return false
      end

      if input.nil? || input == ""
        log("Empty input string.") if !testCase

        return false
      end

      begin
        if URI.parse(input).kind_of?(URI::HTTP)
          return true
        else
          log("'#{input}' does not seem to be a valid URL.") if !testCase
        end
      rescue
        log("'#{input}' does not seem to be a valid URL.") if !testCase
      end

      false
    end

    def is_config_valid()
      if !url_config["open_timeout"].nil? && !url_config["open_timeout"].is_a?(Integer)
        log("Expected an 'Integer' value for config 'open_timeout'. Got '#{url_config["open_timeout"].class}'.")

        return false
      end

      if !url_config["read_timeout"].nil? && !url_config["read_timeout"].is_a?(Integer)
        log("Expected an 'Integer' value for config 'read_timeout'. Got '#{url_config["read_timeout"].class}'.")

        return false
      end

      true
    end

    def exists(obj)
      !obj.nil? && obj != ""
    end

    def get(obj, attr)
      obj.get_attribute(attr)
    end

    def log(msg)
      Jekyll.logger.error "URL Metadata:", msg
    end

  end # module Jekyll
end # module URLMetadata

Liquid::Template.register_filter(Jekyll::URLMetadata)
