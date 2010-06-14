require 'rubygems'
require 'treetop'

require File.dirname(__FILE__) + '/natural/base'
Treetop.load File.dirname(__FILE__) + '/natural.treetop'

include Natural

class Natty
  class << self

    def run path
      parse(File.read path).eval
    end
    
    def parse string
      @parser ||= NaturalParser.new
      result = @parser.parse string.upcase
      p @parser.failure_reason unless result
      result
    end

  end
end

