require 'open-uri'
require 'httparty'
require 'nokogiri'

def find_companies(query)
  options = {
    body: {
      company: query,
    },
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    },
  }
  response = HTTParty.post('https://www.sec.gov/cgi-bin/cik_lookup', options)

  if response.code == 200
    return response
  else
    return response.body
  end
end

def list_companies(raw_companies)
  doc = Nokogiri::HTML.parse(raw_companies)

  # docs = doc.search('hr pre')
  # docs.class
  docs = []

  doc.search('pre').each do |element|
    docs.append(element)
  end
  docs.delete_at(0)
  docs.each_with_index do |element, index|
    puts "#{index + 1}. #{element.text.strip}"
    # puts "#{element.attribute}"
  end
end

raw_companies = find_companies("amazon com")

p list_companies(raw_companies)
