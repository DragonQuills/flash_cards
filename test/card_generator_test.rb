require 'minitest'
require 'minitest/autorun'
require './lib/card_generator'
require './lib/card'

class CardGeneratorTest < Minitest::Test
  def test_card_generator_exits
    filename = "./test/cards_file.txt"
    generator = CardGenerator.new(filename)
    assert_instance_of CardGenerator, generator
  end

  def test_it_reads_from_a_file
    filename = "./test/cards_file.txt"
    generator = CardGenerator.new(filename)

    card_1 = Card.new("Who is the cutest cat in the whole world?", "Crona", :Pop_Culture)
    card_2 = Card.new("What is the corp that cares?", "Evo", :Corporate_Knowledge)
    card_3 = Card.new("Which corp will kill you if you fail a run?", "Mitsuhama", :Corporate_Knowledge)
    card_4 = Card.new("What area of Seattle is currently fighting to be classified as a district?", "Orc Underground", :Seattle_Street_Knowledge)

    cards_list = [card_1, card_2, card_3, card_4]

    assert_equal cards_list, generator.cards
  end
end
