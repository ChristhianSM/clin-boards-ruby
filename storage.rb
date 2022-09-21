require "json"
require_relative "board"

class Storage
  attr_reader :boards

  def initialize(filename)
    @filename = filename
    @boards = load_boards
  end

  def add_board(board)
    @boards << board
    save_boards_to_file
  end

  def update_board(id, data)
    board_found = @boards.find { |board| board.id == id }
    board_found.update(**data)
    save_boards_to_file
  end

  def delete_board(id)
    board_found = @boards.find { |board| board.id == id }
    @boards.delete(board_found)
    save_boards_to_file
  end

  # ---------- List -----------
  def add_list_to_board(id, new_list)
    board_found = @boards.find { |board| board.id == id }
    board_found.lists << new_list
    save_boards_to_file
  end

  def update_list_to_board(board_found, listname, data)
    list_found = board_found.lists.find { |list| list.name.downcase == listname }
    list_found.update(**data)
    save_boards_to_file
  end

  def delete_list_to_board(board_found, listname)
    board_found.lists.delete_if { |list| list.name.downcase == listname }
    save_boards_to_file
  end

  # -------------Card--------------
  def add_card_to_list(lists, card)
    lists.cards << card
    save_boards_to_file
  end

  def update_card_to_list(list_found, new_card, card_hash)
    p new_card
    p card_hash
    new_card.update(**card_hash)
    list_found.cards << new_card
    save_boards_to_file
  end

  def delete_card_to_list(board_found, id_card)
    board_found.lists.each do |list_item|
      list_item.cards.delete_if { |card| card.id == id_card }
    end
    save_boards_to_file
  end

  def add_check_to_card(card_found, hash_check)
    card_found.checklist.push(hash_check)
    save_boards_to_file
  end

  def toggle_check_to_card(card_found, index)
    card_found.checklist[index - 1][:completed] = !card_found.checklist[index - 1][:completed]
    save_boards_to_file
  end

  def remove_check_from_card(card_found, index)
    card_found.checklist.delete_at(index - 1)
    save_boards_to_file
  end

  private

  def load_boards
    data = JSON.parse(File.read(@filename), { symbolize_names: true })
    data.map { |board_hash| Board.new(**board_hash) }
  end

  def save_boards_to_file
    File.write(@filename, @boards.to_json)
  end
end
