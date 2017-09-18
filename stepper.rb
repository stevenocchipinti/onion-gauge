require './gpio'

class Stepper
  def initialize(max_steps:, pins: [0, 1, 2, 3], file: "current_step")
    @max_steps = max_steps
    @pins = pins
    @file = file
    @current_step = File.exists?(@file) ? File.read(@file).to_i : 0
    initialise_gpio
  end

  def forward(steps: 1)
    steps.times { step(1) }
  end

  def backward(steps: 1)
    steps.times { step(-1) }
  end

  def set_percentage(percentage)
    desired_step = (percentage * @max_steps).round
    steps = desired_step - @current_step
    if steps > 0
      steps.times { forward }
    elsif steps < 0
      steps.abs.times { backward }
    end
  end

  def reset
    set_percentage 0
  end

  private

  def initialise_gpio
    @pins.each do |pin|
      GPIO.set_output pin
    end
  end

  def step(increment = 1)
    new_pins = @pins.each_with_index.map do |pin, index|
      index == (@current_step % @pins.size) ? 1 : 0
    end
    set_pins(*new_pins)
    @current_step += increment
    File.write @file, @current_step
  end

  def set_pins(*pins)
    pins.each_with_index do |value, index|
      GPIO.set @pins[index], value
    end
  end
end
