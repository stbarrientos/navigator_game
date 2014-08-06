# World is a grid. A person wants to know how far it is from an object


class World

	attr_accessor :world_grid

	def initialize(rows=10, cols=10)
		@object_hash = {}
		@tot_rows = rows
		@tot_cols = cols
		@world_grid = []
		@world_grid = Array.new(@rows) { Array.new(@cols) }
		@rows.times do |x|
			@cols.times do |y|
				@world_grid[x][y] = "."
			end
		end
		return "done"
	end

	def show_world
		@world_grid.each do |x|
			x.each { |y| print "#{y} " }
			puts ""
		end
		return "done"
	end

	def edit_world(row, col, val)
		@world_grid[row][col] = val
	end

	def generate
		(@rows*@cols/3).times { |x| obx = Obstruction.new(self,rand(@rows-1),rand(@cols-1)) }
		Destination.new(self,rand(@rows-1),rand(@cols-1))

		done = false
		while done == false
			x = rand(@rows-1)
			y = rand(@rows-1)
			if @world_grid[x][y] == "."
				Person.new(self,rand(@rows-1),rand(@cols-1))
				done = true
			else
				done = false
			end
		end
		return self
	end

end

class Person

	def initialize(world, row, col)
		@world = world
		@row = row
		@col = col
		@world.edit_world(@row,@col, "@")
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
		@obstruction_position = [@row,@col]
	end
end

# mine = World.new(4,5)
# obi = Obstruction.new(mine,1,2)
# me = Person.new(mine,1,4)
# dest = Destination.new(mine,1,0)
# mine.show_world

puts "welcome to the navigator. Start with World.new, Obstruction.new, Person.new, and Destination.new. See your world with show world"
new_world = World.new.generate.show_world
new_world.object_hash






