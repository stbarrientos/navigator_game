###### Classes ######

class User
	@@users_hash = {}
	def initialize(name, password)
		@name = name
		@password = password
		@@users_hash[@name] = @password
	end

	def self.show_users
		@@users_hash.each { |name, password| puts "Name: #{name}" }
	end
end

class Apartment

	attr_accessor :status
	attr_accessor :price

	@@apartments_hash = {}

	def initialize(address, price, size = 1, city = "DC")
		@address = address
		@price = price
		@size = size
		@city = city
		@@apartments_hash[@address] = @price
	end

	def self.show_apartments
		@@apartments_hash.each { |address, price| puts "Apartment at: #{address}, for #{price}"}
	end

	def self.under(max_price)
		puts "These apartments are all less than $#{max_price}"
		@@apartments_hash.each { |address, price| puts price < max_price ? "#{address} @ $#{price}" : nil }
	end

	def self.print(file1, max_price = 2000)
		File.open(file1, 'w') { |f| f.write(Apartment.under(max_price)) }
	end

	def bought
		self.status = "Bought"
	end

	def rejected
		self.status = "Rejected"
		yield
	end
end

###### Procs ########

create_users = Proc.new { |x| User.new("user#{x}", "pass{x}")}
create_apartments = Proc.new { |x| Apartment.new("#{x} Street NW", x * 500) }

###### Lambdas #######

###### use_cases ########

# 5.times(&create_users)
# User.show_users

# 5.times(&create_apartments)
# Apartment.under(2000)
# Apartment.print("new.txt")

apt = Apartment.new("123 Freedom Heights", 1650)
apt.bought
puts apt.status
apt.rejected {  apt.price <= 2000 ?  apt.status = "Available" : nil }
puts apt.status