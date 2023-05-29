class Controller
  def initialize
    @view = View.new
  end

  def search_internet_for_company
    name = @view.ask_for("company")
  end

  def list
    
  end
end
