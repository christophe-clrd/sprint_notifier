$tickets_list = []
STATUSES_DONE = ['DONE'].freeze
STATUSES_ONGOING = ['TO DO','IN DEV','TECH REVIEW','FUNCTIONAL REVIEW'].freeze
STATUSES_ALL = (STATUSES_DONE + STATUSES_ONGOING).freeze
TITLE_DELIVERED = "Tickets delivered during last sprint"
TITLE_NOT_DELIVERED = "Tickets not delivered during last sprint (will be transferred to next sprint)"
TITLE_PLANNED = "Other tickets planned for next sprint"

def mail_builder()
  return get_file_as_string('edito.txt')+ section_builder('last_sprint.txt', TITLE_DELIVERED, *STATUSES_DONE) + section_builder('last_sprint.txt', TITLE_NOT_DELIVERED, *STATUSES_ONGOING) + section_builder('next_sprint.txt', TITLE_PLANNED, *STATUSES_ALL)
end

# Method to build a section (i.e "Tickets delivered during last sprint")
def section_builder(file, section_title, *statuses)
  type = ["New Feature", "Improvement", "Task", "Bug"]
  text = []

  type.each do |type|
    type_builder(type, file, statuses, text)
  end
  section_builder(section_title, text)
end

# Method to list the tickets of a type part (i.e "bugs")
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

# Method to build a type section (i.e "1 improvement")
def section_builder(title, content)
  return nil if content.empty?
  return title + "\n" + content.join("\n")
end

# Method to get the edito as a string
def get_file_as_string(filename)
  data = ''
  f = File.open(filename, "r")
  f.each_line do |line|
    data += line
  end
  return data
end

@mail_content = mail_builder()
#puts mail_builder()

# render template
template = File.read('./template.html.erb')
result = ERB.new(template).result(binding)

# write result to file
# File.open('filename.html', 'w+') do |f|
File.new('filename.html', 'w+') do |f|
  f.write result
end
