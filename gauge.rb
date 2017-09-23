require "onion_omega"
require "open-uri"
require "json"

URL = ENV.fetch("GAUGE_ENDPOINT")

# I think a full revolution is 2048 steps but our gauge is has a smaller range
stepper = OnionOmega::Stepper.new(
  max_steps: 1566,
  persist_to_file: "current_step"
)

data = JSON.parse open(URL).read
stepper.set_percentage data["used_percentage"]
