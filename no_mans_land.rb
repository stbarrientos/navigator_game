# def mda(width,height)
# 	a = Array.new(width)
# 	a.map! { Array.new(height) }
# 	a.each do |sub|
#   		sub.each do |int|
#     		int = "."
#   		end
# 	end
# end

# a = [[1, 2], [3, 4]]
# a.each do |sub|
#   sub.each do |int|
#     a[int] = 1
#   end
# end

mat = Array.new(3) { Array.new(3) }

3.times do |x|
	3.times do |y|
		mat[x][y] = "."
		puts mat[x][y]
	end
end

mat[1][2] = "!"
puts mat




