$tickets_list = []
STATUSES_DONE = ['DONE'].freeze
STATUSES_ONGOING = ['TO DO','IN DEV','TECH REVIEW','FUNCTIONAL REVIEW'].freeze
STATUSES_ALL = (STATUSES_DONE + STATUSES_ONGOING).freeze
TITLE_DELIVERED = "Tickets delivered during last sprint"
TITLE_NOT_DELIVERED = "Tickets not delivered during last sprint (will be transferred to next sprint)"
TITLE_PLANNED = "Other tickets planned for next sprint"

def section_builder(file, section_title, *statuses)
  type = ["New Feature", "Improvement", "Task", "Bug"]
  text = []

  type.each do |type|
    type_builder(type, file, statuses, text)
  end
  section_printer(section_title, text)
end

def type_builder(type, file, statuses, text)
  tickets = []
  i = 0
  File.open(file).readlines.each do |line|
    if line.include?(type) && statuses.inject(false) { |memo, status| line.include?(status) || memo }
      unless $tickets_list.include?(line.split("\t")[1])
      i += 1
      tickets << line.split("\t")[1]
      end
    end
  end

  if i>0
    text << "#{i} #{type.downcase}#{'s' if i > 1}"
    text << tickets
    tickets << "\n"
    $tickets_list = tickets + ($tickets_list - tickets)
  end
end

def section_printer(title, content)
  return nil if content.empty?
  puts title
  puts content
end

puts "Hi everybody,

Here is the email we send you on a weekly basis about the tickets that have been developed or that are scheduled in the Career Services Sprint.
This does not mean that everything will always be released on time (depending on the number of urgent bugs we have to solve for instance).
Feel free if you have questions about that,

Have a nice day,

Christophe & Laurent

"

section_builder('last_sprint.txt', TITLE_DELIVERED, *STATUSES_DONE)

section_builder('last_sprint.txt', TITLE_NOT_DELIVERED, *STATUSES_ONGOING)

section_builder('next_sprint.txt', TITLE_PLANNED, *STATUSES_ALL)
