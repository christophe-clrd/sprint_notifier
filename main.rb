$tickets_list = []

def classifier(file, section_title, *statuses)
  type = ["New Feature", "Improvement", "Task", "Bug"]
  text = []

  type.each do |type|
    tickets = []
    i = 0

    section_reader(type, file, statuses, text, i, tickets)
    if i>0
      text << "#{i} #{type.downcase}#{'s' if i > 1}"
      text << tickets
      tickets << "\n"
      $tickets_list = tickets + ($tickets_list - tickets)
    end
  end

  puts section_title
  puts text

end

def section_reader(type, file, statuses, text, i, tickets)
  File.open(file).readlines.each do |line|
    if line.include?(type) && statuses.inject(false) { |memo, status| line.include?(status) || memo }
      unless $tickets_list.include?(line.split("\t")[1])
      i += 1
      tickets << line.split("\t")[1]
      end
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

classifier('last_sprint.txt', "Tickets delivered during last sprint\n", 'RELEASED', 'CLOSED', 'DONE')

classifier('last_sprint.txt',"Tickets not delivered during last sprint (will be transferred to next sprint)\n", 'IN FUNCTIONAL REVIEW','IN REVIEW','IN DEVELOPMENT','OPEN / READY FOR DEV')

classifier('next_sprint.txt', "Other tickets planned for next sprint\n", 'TO DO','IN FUNCTIONAL REVIEW','IN REVIEW','IN DEVELOPMENT','OPEN / READY FOR DEV', 'RELEASED', 'CLOSED', 'DONE')
