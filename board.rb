require_relative "list"

class Board
  attr_reader :id, :lists, :name

  # rubocop:disable Style/ClassVars
  @@id_count = 0
  # rubocop:enable Style/ClassVars
  def initialize(name:, description:, lists: [], id: nil)
    @id = id || @@id_count.next
    # rubocop:disable Style/ClassVars
    @@id_count = @id
    # rubocop:enable Style/ClassVars
    @name = name
    @description = description
    @lists = lists.map { |list| List.new(**list) }
  end

  def details
    shw = ""
    @lists.each do |list|
      shw += @lists[@lists.size - 1] == list ? "#{list.name}(#{list.cards.size})" : "#{list.name}(#{list.cards.size}), "
    end
    [@id, @name, @description, shw]
  end

  def to_json(_optional)
    { id: @id, name: @name, description: @description, lists: @lists }.to_json
  end

  def update(name:, description:)
    @name = name unless name.empty?
    @description = description unless description.empty?
  end
end
