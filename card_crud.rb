require_relative "storage"
require_relative "card"

def create_card(board_found, storage)
  show_select_list(board_found)
  list = gets.chomp.downcase
  list_found = board_found.lists.find { |list_item| list_item.name.downcase == list }
  while list_found.nil?
    puts "\n\n------- Enter a list valid --------\n\n".red
    show_select_list(board_found)
    list = gets.chomp.downcase
    list_found = board_found.lists.find { |list_item| list_item.name.downcase == list }
  end
  card_hash = list_form
  new_card = Card.new(**card_hash)
  storage.add_card_to_list(list_found, new_card)
end

def update_card(board_found, id_card, storage)
  # crear un nuevo card en donde nos dicen, si mandamos el id 6
  card_found = validate_card_id(board_found, id_card)
  if card_found == ""
    puts "\n\n-------Enter a Id Valid--------\n\n".red
    return
  end

  show_select_list(board_found)
  list = gets.chomp.downcase
  list_found = board_found.lists.find { |list_item| list_item.name.downcase == list }
  while list_found.nil?
    puts "\n\n------- Enter a list valid --------\n\n".red
    show_select_list(board_found)
    list = gets.chomp.downcase
    list_found = board_found.lists.find { |list_item| list_item.name.downcase == list }
  end

  card_hash = list_form("update")
  new_card = card_found.clone
  delete_card(board_found, id_card)
  storage.update_card_to_list(list_found, new_card, card_hash)
end

def delete_card(board_found, id_card, storage)
  card_found = validate_card_id(board_found, id_card)
  if card_found == ""
    puts "\n\n-------Enter a Id Valid--------\n\n".red
    return
  end
  storage.delete_card_to_list(board_found, id_card)
end
