require_relative "../lib/controller"

describe Controller do
  let(:controller) { Controller.new }

  describe '#search_internet_for_company' do
    it 'should implement a method to retrieve a list of companies based on user input' do
      expect(controller).to respond_to :search_internet_for_company
    end
  end
end
