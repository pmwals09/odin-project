# frozen_string_literal: true

require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyBBO1dUgm8_el1nps6EjCsKVXWEYXwpewg'
  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: %w[legislatorUpperBody legislatorLowerBody]
    ).officials
  rescue StandardError
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')
  filename = "output/thanks_#{id}.html"
  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def clean_phone_number(phone_number)
  phone_number = phone_number.gsub(/[^\d]/, '')
  if phone_number.length == 10
    phone_number
  elsif phone_number.length == 11 && phone_number[0] == '1'
    phone_number[1..]
  else
    'Invalid number'
  end
end

def registration_hours(regdate, hour_tracker)
  hour_tracker[regdate.hour] += 1
end

def registration_days(regdate, day_tracker)
  day_tracker[regdate.wday] += 1
end

puts 'Event Manager Initialized!'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

hour_tracker = Hash.new(0)
day_tracker = Hash.new(0)

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode row[:zipcode]
  legislators = legislators_by_zipcode(zipcode)
  form_letter = erb_template.result(binding)
  save_thank_you_letter(id, form_letter)
  parsed_regdate = DateTime.strptime(row[:regdate], '%m/%d/%y %H:%M')
  registration_hours(parsed_regdate, hour_tracker)
  registration_days(parsed_regdate, day_tracker)
end
puts hour_tracker.select { |_hour, n| n > 1 }.sort.to_h
puts day_tracker.sort_by { |_k, v| v }.reverse.to_h
