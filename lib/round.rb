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
    @turns.append(turn)

    @card_tracker +=1
    @current_card = deck.cards[@card_tracker]

    @number_correct += 1 if turn.correct?

    return turn
  end

  def number_correct_by_category(category)
    correct = 0
    @turns.each do |turn|
      correct += 1 if turn.correct? && turn.card.category == category
    end
    return correct
  end
end
