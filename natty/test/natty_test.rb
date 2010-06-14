require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'lib/natty'

class NattyTest < Test::Unit::TestCase

  def try_parsing &block
    begin
      yield
    ensure
      reason = @parser.failure_reason
      puts reason if reason
    end
  end

  context "A Natty program" do

    setup { @parser = NaturalParser.new }

    should "fucking parse" do
      try_parsing do
        assert_nil @parser.parse("Foo 1000 Some statement\r\n")
        assert @parser.parse("1000 Some statement\r\n")
        assert @parser.parse("1000 Some statement\r\n1001 another statement\r\n")
      end
    end

    should "ignore comments" do
      try_parsing do
        assert_nil @parser.parse("1000 ** some comment\r\n").eval
      end
    end

  end

end
