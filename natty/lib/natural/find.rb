module Find

  class ::FindSection < Treetop::Runtime::SyntaxNode

    def eval scope
      elements[0].eval scope
      elements[1].elements.each {|e| e.eval scope }
      elements[2].eval scope
      true
    end

  end

  class ::BeginFindSection < Treetop::Runtime::SyntaxNode

    def eval scope
      print "BEGIN FIND section view = #{view_name.text_value} "
      print "limit #{limit_clause.limit.text_value} " if limit_clause
      print "with_clause #{with_clause.text_value} " if with_clause
      puts
    end

  end

  class ::EndFindSection < Treetop::Runtime::SyntaxNode

    def eval scope
      puts "END FIND section"
    end

  end

  class ::WhereStatement < Treetop::Runtime::SyntaxNode

    def eval scope
      puts "WHERE statement: #{where_filter.text_value if where_filter}"
      true
    end

  end

  class ::AssignmentStatement < Treetop::Runtime::SyntaxNode

    def eval scope
      puts "assignment statement: #{assignee.text_value} = #{assign.text_value}"
      true
    end

  end

  class ::IfNoRecSection < Treetop::Runtime::SyntaxNode

    def eval scope
      puts "BEGIN IF NOREC section"
      statements.elements.each {|s| s.eval scope }
      puts "END IF NOREC section"
      true
    end

  end

  class ::EscapeClause < Treetop::Runtime::SyntaxNode

    def eval scope
      puts "escape clause: #{to.text_value}"
      true
    end

  end

end
