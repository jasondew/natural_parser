#!/usr/bin/ruby

# A parser for the NATURAL documentation;
# should parse out the syntax into something
# useful

require 'rubygems'
require 'hpricot'
require 'pp'

WANTED_TAG_NAMES = %w{code var img}

def syntax_table? token
  type, tag_name, attributes, rest = token
  attributes ||= {}
  css_class = attributes["class"]

  tag_name == "table" and css_class == "syntax"
end

def tag_wanted? name
  WANTED_TAG_NAMES.include? name.strip.downcase
end

Dir.glob("../../docs/natural-6.3.5/sm/*.htm").each do |syntax_filename|
  syntax_tables = []
  inside_syntax_table = false
  last_nonempty_text = ""

  Hpricot.scan(File.read(syntax_filename)) do |token|
    token.pop

    case token.first
      when :text then
        token[1].strip!

        unless token[1].empty?
          if inside_syntax_table
            syntax_tables.last.last << token 
          else
            last_nonempty_text = token[1]
          end
        end

      when :stag then
        if syntax_table?(token)
          syntax_tables << [last_nonempty_text, [token]] 
          inside_syntax_table = true
        else
          syntax_tables.last.last << token if inside_syntax_table and tag_wanted?(token[1])
        end

      when :etag then
        syntax_tables.last.last << token if inside_syntax_table and tag_wanted?(token[1])
        inside_syntax_table = false if token[1] == "table"

      else
        syntax_tables.last.last << token if inside_syntax_table
    end
  end

  pp syntax_tables

  exit 0 # only processing the first file for now
end
