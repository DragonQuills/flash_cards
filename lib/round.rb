require './lib/card'
require './lib/deck'
require './lib/turn'

class Round
  attr_reader :deck, :turns, :current_card, :number_correct
  def initialize(deck)
    @deck = deck
    @turns = []
    @card_tracker = 0
    @current_card = deck.cards[@card_tracker]
    @number_correct = 0
  end

  def take_turn(guess)
    turn = Turn.new(guess, @current_card)
    return turn
  end
end
