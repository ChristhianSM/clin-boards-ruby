require "date"
require_relative "board"

# Se valida el nombre del board ya que no pueden haber dos pizarras con el mismo nombre
def validate_name_board(boards, name)
  boards.any? { |board| board.name == name }
end

def validate_name_list(boards, name, id)
  board_found = boards.find { |board| board.id == id }
  board_found.lists.any? { |list| list.name == name }
end

def validate_id(id, iterator)
  iterator.find { |iter| iter.id == id }
end

def validate_list_name(name, storage)
  storage.lists.find { |iter| iter.name.downcase == name }
end

def validate_card_id(board_found, id_card)
  card_found = ""
  board_found.lists.each do |list_item|
    list_item.cards.each do |card|
      card_found = card if card.id == id_card
    end
  end
  card_found
end

def validate_index_check(card_found, index)
  card_found.checklist[index - 1] if index.to_i.positive?
end

def message_validation(month, day)
  message = "YYYY-MM-DD"
  message = "Ingresa un mes correcto " if month > 12
  message = "Ingresa un dia correcto " if day > 31
  message = "Ingresa un mes correcto y un dia correcto" if day > 31 && month > 12
  message
end

def validate_date(date)
  return date if date.empty?

  y, m, d = date.split "-"
  valid = Date.valid_date?(y.to_i, m.to_i, d.to_i)
  message = message_validation(m.to_i, d.to_i)

  until valid
    puts "Type a valid date: #{message}"
    print "Due Date: "
    date = gets.chomp
    return date if date.empty?

    y, m, d = date.split "-"
    valid = Date.valid_date?(y.to_i, m.to_i, d.to_i)
    message = message_validation(m.to_i, d.to_i)
  end
  date
end
