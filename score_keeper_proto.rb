def create_score_card_at(filename)
	begin
	unless system( "mv #{filename} #{filename}")
		cmd = "touch #{filename}"
		`#{cmd}`
	end
	rescue
		puts "rescued"
	end
end

def read_score_card_at(filename)
	File.open(filename, 'r') do |f1|  
  		while line = f1.gets
  			return line
		end
	end  
end  

def edit_score_card_at(filename,score)
	#{}`rm #{filename}; touch #{filename}`
	File.open(filename, 'w') do |f2|  
	  # use "\n" for two lines of text  
	  f2.puts "#{score}"  
	end  
end

# create_score_card_at("score_card.txt")
# edit_score_card_at("score_card.txt",8)
# puts read_score_card_at("score_card.txt")

if read_score_card_at("score_card.txt").to_i < 20
	edit_score_card_at("score_card.txt",20)
 	high_score = read_score_card_at("score_card.txt").to_i
 	puts "Congrats! Your new high score is #{high_score}!!"
end


