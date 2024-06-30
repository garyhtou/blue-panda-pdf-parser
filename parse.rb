require "csv"
require_relative "pdftotext"

puts FILEPATH = File.join(File.dirname(__FILE__), "24 NLC HS CE Finalists Blue Panda.pdf")
PAGE_BREAK = ""
text = PdfToText.new(FILEPATH).text

pages = text.split PAGE_BREAK
puts "#{pages.count} pages"

EVENTS = {}

pages.each_with_index do |page, i|
  lines = page.split "\n"
  date = lines.shift.match(/Event When:(.*)/)[1].strip
  time_range = lines.shift

  # Remove "Event Schedule"
  raise ArgumentError if lines.shift != "Event Schedule"

  event_title = lines.shift
  until lines.first.match? /Arrival Location:.*/
    # Handle multi-line event titles
    event_title += " " + lines.shift
  end

  event_location = lines.shift.match(/Arrival Location:(.*)/)[1].strip

  3.times { lines.shift } # Remove footer and "Arrival Time"

  finalists = []

  until lines.empty?
    debugger if lines.count < 3
    finalist_school = lines.shift
    finalist_state = lines.shift
    finalist_names = []

    until lines.first.match?(/(\d{1,2}:\d{1,2} [AP]M)/)
      finalist_names << lines.shift
    end

    if (name_with_date = lines.first.match(/(?<individual_name>.*) (?<time>\d{1,2}:\d{1,2} [AP]M)/))
      finalist_names << name_with_date[:individual_name]
      finalist_time = name_with_date[:time]
      lines.shift # Remove the line after using it
    else
      # Just time!
      finalist_time = lines.shift
    end

    finalists << {
      names: finalist_names,
      school: finalist_school,
      state: finalist_state,
      time: finalist_time,
    }
  end

  {
    title: event_title,
    location: event_location,
    date:,
    time_range:
  }.tap do |e|
    EVENTS[e] ||= []
    EVENTS[e].concat finalists
  end

end

CSV.open("finalists.csv", "w") do |csv|
  csv << ["Event", "Arrival Location", "Date", "Arrival Time", "School", "State", "Names"]
  EVENTS.each do |event, finalists|
    finalists.each do |finalist|
      csv << [
        event[:title],
        event[:location],
        event[:date],
        finalist[:time],
        finalist[:school],
        finalist[:state],
        finalist[:names].join(", "),
      ]
    end
  end
end
