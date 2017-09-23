require "onion_omega"

# I think a full revolution is 2048 steps but our gauge is has a smaller range
stepper = OnionOmega::Stepper.new(
  max_steps: 1566,
  persist_to_file: "current_step"
)
stepper.set_percentage 0.0
