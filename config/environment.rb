# Don't buffer output (for Foreman)
STDOUT.sync = true

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
JimmycuadraCom::Application.initialize!
