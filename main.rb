
def classifier_done(type)

   i = 0

  File.open("Text.txt").readlines.each do |line|
      if line.include?("JT") && (line.include?("RELEASED") || line.include?("CLOSED")) && line.include?(type)
         i += 1
      end
  end

  if i>0
  print "#{i}"+" "+type.downcase
    if i>1
      print "s"
    end
  puts "\n"
  i==0
  end

  File.open("Text.txt").readlines.each do |line|
      if line.include?("JT") && (line.include?("RELEASED") || line.include?("CLOSED")) && line.include?(type)
         puts line.split("\t")[1]
      end
  end

  if i>0
  puts "\n"
  end

end

def classifier_not_done(type)

   i = 0

  File.open("Text.txt").readlines.each do |line|
      if line.include?("JT") && line.include?(type)
       unless (line.include?("RELEASED")) || line.include?("CLOSED")
         i += 1
       end
      end
  end

  if i>0
  print "#{i}"+" "+type.downcase
    if i>1
      print "s"
    end
  puts "\n"
  i==0
  end

  File.open("Text.txt").readlines.each do |line|
      if line.include?("JT") && line.include?(type)
        unless  line.include?("RELEASED") || line.include?("CLOSED")
         puts line.split("\t")[1]
        end
      end
  end

  if i>0
  puts "\n"
  end

end

puts "Hi everybody,

Here is the email we send you on a weekly basis about the tickets that have been developed or that are scheduled in the Career Services Sprint.
This does not mean that everything will always be released on time (depending on the number of urgent bugs we have to solve for instance).
Feel free if you have questions about that,

Have a nice day,

Christophe & Laurent

"
puts "Tickets delivered during last sprint\n\n"
classifier_done ('New Feature')
classifier_done ('Improvement')
classifier_done ('Task')
classifier_done ('Bug')

puts "Tickets not delivered during last sprint (will be transferred to next sprint)\n\n"
classifier_not_done ('New Feature')
classifier_not_done ('Improvement')
classifier_not_done ('Task')
classifier_not_done ('Bug')
