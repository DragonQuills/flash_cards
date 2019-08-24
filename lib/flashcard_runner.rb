require './lib/card'
require './lib/deck'
require './lib/turn'
require './lib/round'
require './lib/card_generator'

generator = CardGenerator.new("./test/cards_file.txt")

cards = generator.cards

deck = Deck.new(cards)

round = Round.new(deck)

puts "Welcome! You're playing with " +  round.deck.count.to_s + " cards."
puts "-------------------------------------------------"

while round.turns.count < round.deck.count
  puts "This is card number " + (round.card_tracker + 1).to_s  + " out of " + round.deck.count.to_s + "."
  puts "Question: " + round.current_card.question
  answer = gets.chomp
  puts round.take_turn(answer).feedback
end

puts "****** Game over! ******"
puts "You had " + round.number_correct.to_s + " correct guesses out of " + round.deck.count.to_s + " for a total score of " + round.percent_correct.to_s + "%."

results = round.category_score

results.each do |category, percent_correct|
  puts category.to_s + " - " + percent_correct.to_s + "% correct."
end
