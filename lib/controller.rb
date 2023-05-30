require_relative 'view'
require_relative 'service'
require "nokogiri"

class Controller
  def initialize
    @view = View.new
  end

  def search_internet_for_company
    company_names = []
    report_dates = []
    name = @view.ask_for("company")
    @view.looking_for(name)
    companies = get_companies(name)
    companies.each do |company|
      company_names.append(get_company_name(company))
    end
    @view.display_list(company_names)
    index = @view.ask_for_index.to_i
    @view.retrieving(company_names[index], "annual reports")
    reports = get_reports(companies[index])
    reports.each do |report|
      report_dates.append(date = report.search("td")[3].text)
    end
    @view.display_list(report_dates)
    index = @view.ask_for_index.to_i
    url = extract_report_url(reports[index])
    key_word = @view.ask_for("key word")
    analyze_report(url, key_word)
  end
end
