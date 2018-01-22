
def classifier(file, *statuses)
   type = ["New Feature", "Improvement", "Task", "Bug"]

  type.each do |type|
    tickets = []
     i = 0

    File.open(file).readlines.each do |line|
      if line.include?(type) && statuses.inject(false) { |memo, status| line.include?(status) || memo }
        i += 1
        tickets << line.split("\t")[1]
      end
    end

    if i>0
      puts "#{i} #{type.downcase}#{'s' if i > 1}"
      puts tickets
      puts "\n"
    end
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
classifier('last_sprint.txt', 'RELEASED', 'CLOSED', 'DONE')

puts "Tickets not delivered during last sprint (will be transferred to next sprint)\n\n"
classifier('last_sprint.txt','IN FUNCTIONAL REVIEW','IN REVIEW','IN DEVELOPMENT','OPEN / READY FOR DEV')

puts "Other tickets planned for next sprint)\n\n"
classifier('next_sprint.txt','IN FUNCTIONAL REVIEW','IN REVIEW','IN DEVELOPMENT','OPEN / READY FOR DEV')
