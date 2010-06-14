module DefineData

  class ::DefineDataSection < Treetop::Runtime::SyntaxNode

    def eval scope
      puts "BEGIN define data section"
      elements[1].elements.map {|e| e.eval scope }
      puts "END define data section"
      true
    end

  end

  class ::LocalStatement < Treetop::Runtime::SyntaxNode

    def eval scope
      puts "local statement: #{using.text_value if using}"
      true
    end

  end

  class ::ParameterStatement < Treetop::Runtime::SyntaxNode

    def eval scope
      puts "parameter statement: #{using.text_value if using}"
      true
    end

  end

  class ::VariableDefinition < Treetop::Runtime::SyntaxNode

    def eval scope
      puts "VARIABLE DEF'N: level = #{level.text_value}, identifier = #{identifier.text_value}, type = #{type.text_value}"
      true
    end

  end

end
