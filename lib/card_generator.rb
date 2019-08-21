require './lib/card'
require 'csv'

class CardGenerator
  attr_reader :cards

  def initialize (filename)
      @cards = []
      file_data = CSV.read(filename)
      file_data.each do |line|
        new_card = Card.new(line[0].to_s, line[1].to_s, line[2].to_sym)
        @cards.append(new_card)
      end
  end
end
