class CommandParser
  def self.parse(input)
    return Command.new(input)
  end

  class Command
    attr_reader :text, :due_date
    def initialize(input)
      @input = input
      parse_due_date
      if @due_date
        @due_date = Date.civil(@due_date.year, @due_date.month, @due_date.day)
      end
    end

    def due_display
      due_date&.strftime("%A, %B %d")
    end

    private
    def parse_due_date
      if @due.nil? && @input.downcase =~ /(.*?)\s+(tomorrow|today|next week|#{DateTime::DAYNAMES.join("|").downcase})\s*$/
        # they didn't write the word due, so we special case some common things
        @text = $1
        @due = $2
      end

      return if @due.nil?

      daynames = Date::DAYNAMES.map &:downcase
      if daynames.include?(@due.downcase)
        puts "Searching for next #{@due}"
        @due_date = Time.zone.now + 1.day
        while @due_date.strftime("%A").downcase != @due
          @due_date += 1.day
        end
        return
      end

      @due_date = case @due.downcase
      when "tomorrow"
        Time.zone.now + 1.day
      when "today", "eod", "cob", "now"
        Time.zone.now
      when "next week"
        Time.zone.now.end_of_week + 1.day
      else
        nil
      end
    end
  end
end