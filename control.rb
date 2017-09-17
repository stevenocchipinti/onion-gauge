require "./stepper"

# I think a full revolution is 2048 steps but our gauge is has a smaller range
stepper = Stepper.new(steps_per_rev: 1566)
stepper.set_percentage 0.0
