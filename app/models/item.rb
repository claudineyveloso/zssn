# frozen_string_literal: true

# main item class
class Item
  attr_accessor :id, :description, :score

  def initialize(id, description, score)
    @id = id
    @description = description
    @score = score
  end
end
