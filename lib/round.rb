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

  def percent_correct
    correct = 0
    @turns.each do |turn|
      correct += 1 if turn.correct?
    end
    percent = (correct.to_f / turns.count.to_f) * 100.0
    percent.round(1)
  end

  def percent_correct_by_category(category)
    correct = number_correct_by_category(category)
    total = 0
    @turns.each do |turn|
      total += 1 if turn.card.category == category
    end
    total = 1 if total == 0
    percent = (correct.to_f / total.to_f) * 100.0
    percent.round(1)
  end
end
