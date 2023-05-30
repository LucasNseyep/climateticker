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

def list_companies(raw_company_list)
  companies = []
  reports = []
  doc = Nokogiri::HTML.parse(raw_company_list)
  raw_companies = doc.search('a')
  raw_companies.each do |company|
    companies.append(company)
  end
  companies.delete_at(-1)

  companies.each_with_index do |company, index|
    href = "https://www.sec.gov/edgar/#{company["href"]}"
    cik = company.text.strip
    report_type = "10-K"
    annual_reports = "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=#{cik}&type=#{report_type}&dateb=&owner=include&count=40&search_text="
    options = {
          headers: { 'User-Agent': "Lucas Nseyep lucas.nseyep@gmail.com" },
        }
    response = HTTParty.get(annual_reports, options)
    # pp response
    reports_html = Nokogiri::HTML.parse(response)

    reports_html.search("tr").each_with_index do |report, index|
      if report.text.strip.include?(report_type)
        reports.append(report)
      end
    end

    puts `clear`

    reports.first(5).each_with_index do |report, index|
      link = report.search('a')[1].attribute("href").value
      date = report.search("td")[3].text
      puts "#{index + 1}. #{date} https://www.sec.gov#{link}"
    end
  end
end

def find_company_reports(report_type, company_cik)

end

def read_report
  options = {
    headers: { 'User-Agent': "Lucas Nseyep lucas.nseyep@gmail.com" },
  }
  annual_report = "https://www.sec.gov/cgi-bin/viewer?action=view&cik=1018724&accession_number=0001018724-23-000004&xbrl_type=v"
  response = HTTParty.get(annual_report, options)
  report_html = Nokogiri::HTML.parse(response)
  path = report_html.search("#menu_cat1").at_css("a")["href"]
  href = "https://www.sec.gov/#{path.match(/Archives.+/)}"
  response = HTTParty.get(href, options)
  doc_html = Nokogiri::HTML.parse(response)
  doc_html.search("span").each do |paragraph|
    if paragraph.text.include?("climate change")
      puts paragraph.text
    end
  end
end

raw_companies = find_companies("amazon com")

list_companies(raw_companies)

read_report
