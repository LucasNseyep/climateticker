require_relative 'controller'
require_relative 'router'

controller = Controller.new

# Start the app
router = Router.new(controller)
