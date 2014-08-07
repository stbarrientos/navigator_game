
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
		return self.show_world
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
		until self.world.world_grid[@row][@col] == "*"
			direction = rand(4)
			case direction
			when "0"
				if self.world.world_grid[@row - 1][(@col)] == "." || (self.world.world_grid[(@row-1)][@col] == "*")
					self.world.world_grid[@row][@col] = "x"
					@row -= 1
					self.world.world_grid[@row][@col] = "@"
					self.world.show_world

				end
			when "1"
				if self.world.world_grid[@row][(@col + 1)] == "." || (self.world.world_grid[@row][(@col + 1)] == "*")
					self.world.world_grid[@row][@col] = "x"
					@col += 1
					self.world.world_grid[@row][@col] = "@"
					self.world.show_world
				end
			when "2"
				if self.world.world_grid[@row + 1][@col] == "." || (self.world.world_grid[@row + 1][@col] == "*")
					self.world.world_grid[@row][@col] = "x"
					@row += 1
					@world_grid[@row][@col] = "@"
					self.world.show_world
				end
			when "3"
				if self.world.world_grid[@row][@col - 1] == "." || (self.world.world_grid[@row][@col] == "*")
					self.world.world_grid[@row][@col] = "x"
					@col -= 1
					self.world.world_grid[@row][@col] = "@"
					self.world.show_world
				end
			end
			count += 1
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

# puts "Enter worldname"
# worldname = gets.chomp
# puts "Enter rows"
# rows = gets.chomp.to_i
# puts "Enter column"
# cols = gets.chomp.to_i

puts "welcome to the navigator. Start with World.new, Obstruction.new, Person.new, and Destination.new. See your world with show world"
new_world = World.new
new_world.generate
new_world.person.move
# new_world = World.new
# me = Person.new(new_world,9,9)
# ob1 = Obstruction.new(new_world,5,5)
# goal = Destination.new(new_world,0,0)
# new_world.show_world






