require 'minitest'
require 'minitest/autorun'
require './lib/card_generator'
require './lib/card'

class CardGeneratorTest < Minitest::Test
  def test_card_generator_exits
    generator = CardGenerator.new("cards.txt")
    assert_instance_of CardGenerator, generator
  end
end
