%w(scope function define_data find).each {|file| require File.dirname(__FILE__) + '/' + file }

module Natural

  include DefineData
  include Find

  class Program < Treetop::Runtime::SyntaxNode

    def initialize *args
      @scope = TopLevel.new
      super
    end

    def eval
      elements.each do |e|
        e.eval @scope
      end
    end

  end

  class IfSection < Treetop::Runtime::SyntaxNode

    def eval scope
      elements[0].eval scope
      then_statements.elements.each {|e| e.eval scope}

      if else_block
        puts "ELSE"
        else_block.else_statements.elements.each {|e| e.eval scope}
      end

      puts "END IF section"
    end

  end

  class ElseStatement < Treetop::Runtime::SyntaxNode

    def eval scope
      puts "ELSE"
    end

  end

  class BeginIfSection < Treetop::Runtime::SyntaxNode

    def eval scope
      puts "BEGIN IF section, condition = #{condition.text_value}"
    end

  end

  class Comment < Treetop::Runtime::SyntaxNode

    def eval scope
      puts "comment: #{comment_text.text_value}"
      nil
    end

  end

  class BlankLine < Treetop::Runtime::SyntaxNode

    def eval scope
      true
    end

  end

  class Unknown < Treetop::Runtime::SyntaxNode

    def eval scope
      puts "UNKNOWN: #{elements[1].text_value}"
      true
    end

  end

end
