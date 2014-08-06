# First challenge
100.times { |x| puts x + 1 }

# Second challenge

array = [1,2,3,4,5]
array.each { |x| puts x }

# Third challenge

def greet(name)
	puts "hello #{name}"
end

greet("Sam")

# Fourth challenge

def double(num)
	puts num * 2
end

double(2)

# Fifth challenge

def is_even?(num)
	puts num % 2 == 0 ? true : false
end

is_even?(4)
is_even?(5)

#  Sixth challenge

for x in 1...100
	if x % 5 == 0 && x % 3 == 0 then puts "fizzbuzz"
	elsif x % 5 ==0 then puts "fizz"
	elsif x % 3 == 0 then puts "buzz"
	else puts x end
end


