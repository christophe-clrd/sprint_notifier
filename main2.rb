require "erb"
require "date"

$tickets_list = []

email = {
  title: "Career Services Sprint Update",
  sprint_end_date: "#{(Time.now).strftime("%B")} #{Time.now.day},#{Time.now.year}",
  edito: "edito blabla",
  first_section: {
    title: "Tickets delivered during last sprint",
    statuses: ['DONE'],
    file: 'last_sprint.txt',
    new_features: {
      type: "New Feature",
      nb_tickets: 0,
      tickets: []
    },
    improvements: {
      type: "Improvement",
      nb_tickets: 0,
      tickets: []
    },
    tasks: {
      type: "Task",
      nb_tickets: 0,
      tickets: []
    },
    bugs: {
      type: "Bug",
      nb_tickets: 0,
      tickets: []
    },
  },
  second_section: {
    title: "Tickets not delivered during last sprint (will be transferred to next sprint)",
    statuses: ['TO DO','IN DEV','TECH REVIEW','FUNCTIONAL REVIEW'],
    file: 'last_sprint.txt',
    new_features: {
      type: "New Feature",
      nb_tickets: 0,
      tickets: []
      },
    improvements: {
      type: "Improvement",
      nb_tickets: 0,
      tickets: []
    },
    tasks: {
      type: "Task",
      nb_tickets: 0,
      tickets: []
    },
    bugs: {
      type: "Bug",
      nb_tickets: 0,
      tickets: []
    },
  },
  third_section: {
    title: "Other tickets planned for next sprint",
    statuses: ['TO DO','IN DEV','TECH REVIEW','FUNCTIONAL REVIEW', 'DONE'],
    file: 'next_sprint.txt',
    new_features: {
      type: "New Feature",
      nb_tickets: 0,
      tickets: []
    },
    improvements: {
      type: "Improvement",
      nb_tickets: 0,
      tickets: []
    },
    tasks: {
      type: "Task",
      nb_tickets: 0,
      tickets: []
    },
    bugs: {
      type: "Bug",
      nb_tickets: 0,
      tickets: []
    }
  }
}

def section_looper(email)
  section = [:first_section, :second_section, :third_section]
  section.each do |section|
    type_looper(email, section)
  end
end

def type_looper(email, section)
  type = [:new_features, :improvements, :tasks, :bugs]
  type.each do |type|
    type_builder(email, section, email[section][type][:type], email[section][:file], email[section][:statuses], email[section][type][:tickets], email[section][type][:nb_tickets])
  end
end

def type_builder(email, section, type, file, statuses, tickets, i)
  File.open(file).readlines.each do |line|
    if line.include?(type) && statuses.inject(false) { |memo, status| line.include?(status) || memo }
      unless $tickets_list.include?(line.split("\t")[1])
      i += 1
      tickets << line.split("\t")[1]
      end
    end
  end

  if i>0
    $tickets_list = tickets + ($tickets_list - tickets)
  end
end

def pluralize(string, n)
  if n > 1
    return "#{string}s"
  else
    return "#{string}"
  end
end

section_looper(email)
puts email
