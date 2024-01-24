# frozen_string_literal: true

# main item class
class Item
  attr_accessor :description, :score

  def initialize(description, score)
    @description = description
    @score = score
  end
end
