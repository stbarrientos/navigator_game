require './score_keeper_proto.rb'
class World

	attr_accessor :world_grid
	attr_accessor :person

	def initialize(rows=10, cols=10)
		@tot_rows = rows
		@tot_cols = cols
		@world_grid = []
		@world_grid = Array.new(@tot_rows) { Array.new(@tot_cols) }
		@tot_rows.times do |x|
			@tot_cols.times do |y|
				@world_grid[x][y] = "."
			end
		end
	end

	def show_world
		@world_grid.each do |x|
			x.each { |y| print "#{y} " }
			puts ""
		end
	end

	def edit_world(row, col, val)
		@world_grid[row][col] = val
	end

	def generate
		(@tot_rows*@tot_cols/3).times { |x| ob_x = Obstruction.new(self,rand(@tot_rows-1),rand(@tot_cols-1)) }
		Destination.new(self, rand(@tot_rows-1),rand(@tot_cols-1))

		done = false
		while done == false
			x = rand(@tot_rows-1)
			y = rand(@tot_rows-1)
			if @world_grid[x][y] == "."
				@person = Person.new(self,rand(@tot_rows-1),rand(@tot_cols-1))
				done = true
			else
				done = false
			end
		end
		# return self.show_world
	end
end

class Person < World

	attr_accessor :world

	def initialize(world, row, col)
		@world = world
		@row = row
		@col = col
		@world.edit_world(@row,@col, "@")
	end

	def move
		count = 0
		done = false
		puts "\nYou are '@', can you get to '*' in as few moves as possible? Lets find out!\n\n"
		self.world.show_world
		while done == false
			puts "w=up, d=right, s=down, a=left, q=Surrender"
			# puts "user the arrows to navigate, press q to quit"
			system("stty raw -echo")
  			c = STDIN.getc
			system("stty -raw echo")
			# direction = gets.chomp
			# if direction == "w"
			if c == "w"
				count += 1
				if self.world.world_grid[@row - 1][(@col)] == "." || (self.world.world_grid[(@row-1)][@col] == "*")
					if self.world.world_grid[@row-1][@col] == "*"
						done = true
					else
						self.world.world_grid[@row][@col] = "x"
						@row -= 1
						self.world.world_grid[@row][@col] = "@"
						puts "\n"
						self.world.show_world
					end
				else
					puts "\n"
					self.world.show_world
					puts "can't go there"
					done = false
				end
			# elsif direction == "d"
			elsif c == "d"
				count += 1
				if self.world.world_grid[@row][(@col + 1)] == "." || (self.world.world_grid[@row][(@col + 1)] == "*")
					if self.world.world_grid[@row][@col+1] == "*"
						done = true
					else
						self.world.world_grid[@row][@col] = "x"
						@col += 1
						self.world.world_grid[@row][@col] = "@"
						puts "\n"
						self.world.show_world
					end
				
				else
					puts "\n"
					self.world.show_world
					puts "can't go there"
				end
			# elsif direction == "s"
			elsif c == "s"
				count += 1 
				if self.world.world_grid[@row + 1][@col] == "." || (self.world.world_grid[@row + 1][@col] == "*")
					if self.world.world_grid[@row+1][@col] == "*"
						done = true
					else
						self.world.world_grid[@row][@col] = "x"
						@row += 1
						self.world.world_grid[@row][@col] = "@"
						puts "\n"
						self.world.show_world
					end
				else
					puts "\n"
					self.world.show_world
					puts "can't go there"
				end
			# elsif direction == "a"
			elsif c == "a"
				count += 1
				if self.world.world_grid[@row][@col - 1] == "." || (self.world.world_grid[@row][@col-1] == "*")
					if self.world.world_grid[@row][@col-1] == "*"
						done = true
					else
						self.world.world_grid[@row][@col] = "x"
						@col -= 1
						self.world.world_grid[@row][@col] = "@"
						puts "\n"
						self.world.show_world
					end
				else
					puts "\n"
					self.world.show_world
					puts "can't go there"
				end
			elsif c == "q"
				puts "Quiters never win and winners never quit. You Lose!"
				done = true
			else
				done = false
				self.world.show_world
				puts "Invalid input, try again"
			end
		end
		return count
	end
end

class Destination

	def initialize(world,row, col)
		@world = world
		@row = row
		@col = col
		@world.edit_world(@row,@col, "*")
	end
end

class Obstruction

	def initialize(world, row, col)
		@world = world
		@row = row
		@col = col
		@world.edit_world(@row, @col, "!")
	end
end

def compare_score(filename,score)
	# create_score_card_at(filename)
	old_record = read_score_card_at(filename).to_i
	if score < old_record
		edit_score_card_at(filename,score)
		puts "New High Score!!"
	else
		puts "You Win! It took you #{score} moves!\nYour personal record is #{old_record}"
	end
end

# def read_char
#   begin
#     # save previous state of stty
#     old_state = `stty -g`
#     # disable echoing and enable raw (not having to press enter)
#     system "stty raw -echo"
#     c = STDIN.getc.chr
#     # gather next two characters of special keys
#     if(c=="\e")
#       extra_thread = Thread.new{
#         c = c + STDIN.getc.chr
#         c = c + STDIN.getc.chr
#       }
#       # wait just long enough for special keys to get swallowed
#       extra_thread.join(0.000000000000001)
#       # kill thread so not-so-long special keys don't wait on getc
#       extra_thread.kill
#     end
#   rescue => ex
#     puts "#{ex.class}: #{ex.message}"
#     puts ex.backtrace
#   ensure
#     # restore previous state of stty
#     system "stty #{old_state}"
#   end
#   return c
# end

# puts "Enter worldname"
# worldname = gets.chomp
# puts "Enter rows"
# rows = gets.chomp.to_i
# puts "Enter column"
# cols = gets.chomp.to_i

puts "\n<-------------<----<--<-WELCOME TO THE NAVIGATOR!->-->---->---------------->"
new_world = World.new
new_world.generate
score = new_world.person.move
puts "score = #{score}"
puts compare_score("score_card.txt",score)
# new_world = World.new
# me = Person.new(new_world,9,9)
# ob1 = Obstruction.new(new_world,5,5)
# goal = Destination.new(new_world,0,0)
# new_world.show_world




