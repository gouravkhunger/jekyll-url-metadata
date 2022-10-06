require "jekyll"
require "minitest/autorun"

require_relative "../lib/jekyll-url-metadata"
include Jekyll::URLMetadata

class InputValidatorTests
  describe "tests for input validation function" do

    it "should reject empty strings" do
      assert_equal false, is_input_valid("", testCase = true)
    end

    it "should accept valid url strings" do
      assert_equal true, is_input_valid("http://example.com", testCase = true)
    end

    it "should accept valid url strings" do
      assert_equal true, is_input_valid("https://gouravkhunger.me", testCase = true)
    end

    it "should reject non-url strings" do
      assert_equal false, is_input_valid("abc xyz", testCase = true)
    end

    it "should reject non-string inputs" do
      assert_equal false, is_input_valid(true, testCase = true)
    end

    it "should reject non strings inputs" do
      assert_equal false, is_input_valid({
        "key" => "value"
      }, testCase = true)
    end

  end
end

class ExistenceValidatorTests
  describe "tests for object existence checker function" do

    it "should respond false to an empty String object" do
      assert_equal false, exists("")
    end

    it "should respond true to a non-empty String object" do
      assert_equal true, exists("Checkout https://genicsblog.com")
    end

    it "should respond false to a nil object" do
      assert_equal false, exists(nil)
    end

    it "should respond true to a non-nil object" do
      assert_equal true, exists(69)
    end

  end
end

class AttributeParserTests
  describe "tests for attribute parser function" do

    it "should return the String 'website' for meta attribute 'content'" do
      Nokogiri::HTML("<meta name='description' content='website'>").search('meta').each do |meta|
        assert_equal "website", get(meta, "content")
      end
    end

    it "should return String 'author' for attribute 'name'" do
      Nokogiri::HTML("<meta name='author' content='Gourav'>").search('meta').each do |meta|
        assert_equal "author", get(meta, "name")
      end
    end

    it "should return String 'UTF-8' for attribute 'charset'" do
      Nokogiri::HTML("<meta charset='UTF-8'>").search('meta').each do |meta|
        assert_equal "UTF-8", get(meta, "charset")
      end
    end

  end
end

class HashValidationTests
  describe "tests to check for generated metadata hashmaps" do

    it "should return nil for invalid website" do
      assert_nil generate_hashmap("https://-abc.com", testCase = true)
    end

    # Since websites change frequently, we will not test the content of the generated hashmap.
    # Instead we validate just the existence of the hashmap itself. 

    it "should not return nil for valid website" do
      assert generate_hashmap("https://google.com", testCase = true) != nil
    end

  end
end
