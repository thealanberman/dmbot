cmd = []

# create a tokenize method to break up command into Array
class String
  def tokenize
    self.
      split(/\s(?=(?:[^'"]|'[^']*'|"[^"]*")*$)/).
      select {|s| not s.empty? }.
      map {|s| s.gsub(/(^ +)|( +$)|(^["']+)|(["']+$)/,'')}
  end
end

# create roll method
def roll(dice, sides)
	unless (dice.is_a?(Integer))
		raise "Expected integer value"
	end
	unless (sides.is_a?(Integer))
		raise "Expected integer value"
	end
	return Array.new(dice) { rand(1...sides) }
end

# listener loop
while cmd[0] != "quit"
	print "Command? "
	cmd = gets.chomp.tokenize
#	p cmd

	if ! cmd[0].nil?
		case cmd[0].downcase

		when "help"
			puts 'The following commands are available:'
			puts '- roll [dice]d[sides]. e.g., \'roll 3d6\''
			puts '- set [character] [attribute] [value]. e.g., \'set conan strength 12\''
			puts '- quit'

		when "roll"
			if cmd[1].nil?
				puts "roll what?"
				puts "example: roll 3d6"
			else
				if cmd[1].scan(/d/i)
					num_dice = $`.to_i
					if num_dice.integer?
						sides = $'.to_i
						if sides.integer?
							puts roll(num_dice, sides)
						end
					end
				end
			end

		when "set"
			if cmd[1].nil?
				puts "set what?"
				puts "set 'character name' 'attribute' 'value'"
				puts "example: set 'zoltar' 'strength' '12'"
			else
				cmd[3] = cmd[3].strip
				puts "character = #{cmd[1].strip}"
				puts "attribute = #{cmd[2].strip}"
				puts "value = #{cmd[3].strip}"
			end

		when "quit"
			puts "Thanks for playing!"
			exit
		else
			puts "I don't understand. Try 'help'"
		end # case
	end # if nil
end # while
