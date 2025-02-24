require 'minitest'
require 'minitest/autorun'

require './lib/card'
require './lib/deck'
require './lib/round'
require './lib/turn'

class RoundTest < Minitest::Test
  def setup
    @card_1 = Card.new("Who is the cutest cat in the whole world?", "Crona", :Pop_Culture)
    @card_2 = Card.new("What is the corp that cares?", "Evo", :Corporate_Knowledge)
    @card_3 = Card.new("Which corp will kill you if you fail a run?", "Mitsuhama", :Corporate_Knowledge)

    @cards = [@card_1, @card_2, @card_3]

    @deck = Deck.new(@cards)

    @round = Round.new(@deck)
  end

  def test_round_exists
    assert_instance_of Round, @round
  end

  def test_round_exposes_attributes
    assert_equal @deck, @round.deck
    assert_equal [], @round.turns
    assert_equal @card_1, @round.current_card
    assert_equal 0, @round.number_correct
  end

  def test_take_turn_returns_a_turn
    temp_round = @round
    turn = temp_round.take_turn("Crona")
    assert_instance_of Turn, turn
  end

  def test_take_turn_tracks_turns
    temp_round = @round
    turn = temp_round.take_turn("Crona")

    assert_equal [turn], temp_round.turns
    assert_equal 1, temp_round.turns.count
    assert_equal "That's gay!", temp_round.turns.last.feedback

    turn2 = temp_round.take_turn("Shiawase")

    assert_equal [turn, turn2], temp_round.turns
    assert_equal 2, temp_round.turns.count
    assert_equal "Eww, that's straight.", temp_round.turns.last.feedback
  end

  def test_take_turn_tracks_current_card
    temp_round = @round
    temp_round.take_turn("Crona")

    assert_equal @card_2, temp_round.current_card

    temp_round.take_turn("I dunno...")

    assert_equal @card_3, temp_round.current_card
  end

  def test_take_turn_tracks_number_correct
    temp_round = @round
    temp_round.take_turn("Crona")

    assert_equal 1, temp_round.number_correct

    temp_round.take_turn("Shrug")

    assert_equal 1, temp_round.number_correct

    temp_round.take_turn("Mitsuhama")

    assert_equal 2, temp_round.number_correct
  end

  def test_number_correct_by_category
    temp_round = @round

    temp_round.take_turn("Crona")
    assert_equal 1, temp_round.number_correct_by_category(:Pop_Culture)
    assert_equal 0, temp_round.number_correct_by_category(:Corporate_Knowledge)
    assert_equal 0, temp_round.number_correct_by_category(:Seattle_Street_Knowledge)

    temp_round.take_turn("Evo")
    assert_equal 1, temp_round.number_correct_by_category(:Pop_Culture)
    assert_equal 1, temp_round.number_correct_by_category(:Corporate_Knowledge)
    assert_equal 0, temp_round.number_correct_by_category(:Seattle_Street_Knowledge)

    temp_round.take_turn("Mitsuhama")
    assert_equal 1, temp_round.number_correct_by_category(:Pop_Culture)
    assert_equal 2, temp_round.number_correct_by_category(:Corporate_Knowledge)
    assert_equal 0, temp_round.number_correct_by_category(:Seattle_Street_Knowledge)
  end

  def test_percent_correct
    temp_round = @round

    temp_round.take_turn("Crona")

    assert_equal 100.0, temp_round.percent_correct

    temp_round.take_turn("Burger King")
    assert_equal 50.0, temp_round.percent_correct

    temp_round.take_turn("Mitsuhama")
    assert_equal 66.7, temp_round.percent_correct
  end

  def test_percent_correct_by_category
    temp_round = @round

    temp_round.take_turn("Crona")
    assert_equal 100.0, temp_round.percent_correct_by_category(:Pop_Culture)
    assert_equal 0.0, temp_round.percent_correct_by_category(:Corporate_Knowledge)
    assert_equal 0.0, temp_round.percent_correct_by_category(:Seattle_Street_Knowledge)

    temp_round.take_turn("Evo")
    assert_equal 100.0, temp_round.percent_correct_by_category(:Pop_Culture)
    assert_equal 100.0, temp_round.percent_correct_by_category(:Corporate_Knowledge)
    assert_equal 0.0, temp_round.percent_correct_by_category(:Seattle_Street_Knowledge)

    temp_round.take_turn("Shiawase")
    assert_equal 100.0, temp_round.percent_correct_by_category(:Pop_Culture)
    assert_equal 50.0, temp_round.percent_correct_by_category(:Corporate_Knowledge)
    assert_equal 0.0, temp_round.percent_correct_by_category(:Seattle_Street_Knowledge)
  end

  def test_category_score_returns_categories_with_percent_correct
    temp_round = @round
    dict1 = {:Pop_Culture => 100.0}
    dict2 = {:Pop_Culture => 100.0 , :Corporate_Knowledge => 0.0}
    dict3 = {:Pop_Culture => 100.0 , :Corporate_Knowledge => 50.0}

    temp_round.take_turn("Crona")

    assert_equal dict1, temp_round.category_score

    temp_round.take_turn("Burger King")
    assert_equal dict2, temp_round.category_score

    temp_round.take_turn("Mitsuhama")
    assert_equal dict3, temp_round.category_score
  end
end
