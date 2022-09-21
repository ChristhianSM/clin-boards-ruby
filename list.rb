require_relative "card"

class List
  attr_reader :name, :cards

  # rubocop:disable Style/ClassVars
  @@id_count = 0
  # rubocop:enable Style/ClassVars
  def initialize(name:, cards: [], id: nil)
    @id = id || @@id_count.next
    # rubocop:disable Style/ClassVars
    @@id_count = @id
    # rubocop:enable Style/ClassVars
    @name = name
    @cards = cards.map { |card| Card.new(**card) }
  end

  def details
    shw = ""
    @lists.each do |list|
      shw += @lists[@lists.size - 1] == list ? "#{list.name}(#{list.cards.size})" : "#{list.name}(#{list.cards.size}), "
    end
    [@id, @name, @description, shw]
  end

  def update(name:)
    @name = name unless name.empty?
  end

  def to_json(_optional)
    { id: @id, name: @name, cards: @cards }.to_json
  end
end
