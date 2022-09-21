require "colorize"

class Card
  attr_accessor :id, :title, :checklist

  # rubocop:disable Style/ClassVars
  @@id_count = 0
  # rubocop:enable Style/ClassVars
  def initialize(title:, members:, labels:, due_date:, checklist: [], id: nil)
    @id = id || @@id_count.next
    # rubocop:disable Style/ClassVars
    @@id_count = @id
    # rubocop:enable Style/ClassVars
    @title = title
    @members = members
    @labels = labels
    @due_date = due_date
    @checklist = checklist
  end

  def details
    count = 0
    @checklist.each do |check|
      count += 1 if check[:completed]
    end
    message = "IMCOMPLETED".red
    message = "COMPLETED".green if count == @checklist.size && @checklist.size.positive?
    message = "EMPTY".yellow if @checklist.size.zero?

    [@id, @title, @members.join(", "), @labels.join(", "), @due_date, "#{count}/#{@checklist.size}  (#{message})"]
  end

  def to_json(_optional)
    { id: @id, title: @title, members: @members, labels: @labels, due_date: @due_date, checklist: @checklist }.to_json
  end

  def update(title:, members:, labels:, due_date:)
    @title = title unless title.empty?
    @members = members unless members.join.size.zero?
    @labels = labels unless labels.join.size.zero?
    @due_date = due_date unless due_date.empty?
  end
end
