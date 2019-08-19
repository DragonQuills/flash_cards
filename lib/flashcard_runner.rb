require './lib/card'
require './lib/deck'
require './lib/turn'
require './lib/round'

card_1 = Card.new("Who is the cutest cat in the whole world?", "Crona", :Pop_Culture)
card_2 = Card.new("What is the corp that cares?", "Evo", :Corporate_Knowledge)
card_3 = Card.new("Which corp will kill you if you fail a run?", "Mitsuhama", :Corporate_Knowledge)
card_4 = Card.new("What area of Seattle is currently fighting to be classified as a district?", "Orc Underground", :Seattle_Street_Knowledge)

cards = [card_1, card_2, card_3, card_4]

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
