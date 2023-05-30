require 'open-uri'
require 'httparty'
require 'nokogiri'

def get_companies(query)
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
    companies = []
    doc = Nokogiri::HTML.parse(response)
    raw_companies = doc.search('a')
    raw_companies.each do |company|
      companies.append(company)
    end
    return companies
  else
    return response.body
  end
end

def get_reports(raw_company)
  reports = []

  cik = raw_company.text.strip
  report_type = "10-K"
  annual_reports = "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=#{cik}&type=#{report_type}&dateb=&owner=include&count=40&search_text="
  options = {
    headers: { 'User-Agent': "Lucas Nseyep lucas.nseyep@gmail.com" },
  }
  response = HTTParty.get(annual_reports, options)
  reports_html = Nokogiri::HTML.parse(response)

  reports_html.search("tr").each_with_index do |report, index|
    if report.text.strip.include?(report_type)
      reports.append(report)
    end
  end
  return reports
end

def extract_report_url(raw_report)
  link = raw_report.search('a')[1].attribute("href").value
  pre_href = "https://www.sec.gov#{link}"
  options = {
    headers: { 'User-Agent': "Lucas Nseyep lucas.nseyep@gmail.com" },
  }
  response = HTTParty.get(pre_href, options)
  report_html = Nokogiri::HTML.parse(response)
  path = report_html.search("#menu_cat1").at_css("a")["href"]
  href = "https://www.sec.gov/#{path.match(/Archives.+/)}"
  return href
end

def analyze_report(url, key_word)
  options = {
    headers: { 'User-Agent': "Lucas Nseyep lucas.nseyep@gmail.com" },
  }
  response = HTTParty.get(url, options)
  report_html = Nokogiri::HTML.parse(response)
  puts `clear`
  report_html.search("span").each do |paragraph|
    if paragraph.text.include?(key_word)
      puts paragraph.text + "\n\n"
    end
  end
end

companies = get_companies("alphabet inc")

reports = get_reports(companies[0])

url = extract_report_url(reports[0])

analyze_report(url, "climate change")
