require_relative 'view'
require_relative 'service'
require "nokogiri"

class Controller
  def initialize
    @view = View.new
  end

  def search_internet_for_company
    company_names = []
    name = @view.ask_for("company")
    companies = get_companies(name)
    companies.each do |company|
      company_names.append(get_company_name(company))
    end
    return @view.display_list(company_names)
  end

  def method_name
    
  end
end

controller = Controller.new
controller.search_internet_for_company
