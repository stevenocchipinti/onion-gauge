class Stepper
  FILE = "current_step"

  def initialize(steps_per_rev:, pins: [0, 1, 2, 3])
    @steps_per_rev = steps_per_rev
    @pins = pins
    @current_step = File.exists?(FILE) ? File.read(FILE).to_i : 0
    initialise_gpio
  end

  def forward(steps: 1)
    steps.times { step(1) }
  end

  def backward(steps: 1)
    steps.times { step(-1) }
  end

  def set_percentage(percentage)
    desired_step = (percentage * @steps_per_rev).round
    puts "desired step = #{desired_step}"
    steps = desired_step - @current_step
    puts "steps = #{steps}"
    if steps > 0
      steps.times { forward }
    elsif steps < 0
      steps.abs.times { backward }
    end
  end

  private

  def initialise_gpio
    @pins.each do |pin|
      `fast-gpio set-output #{pin}`
    end
  end

  def step(increment)
    case @current_step % 4
    when 0
      set_pins(0, 0, 0, 1)
    when 1
      set_pins(0, 0, 1, 0)
    when 2
      set_pins(0, 1, 0, 0)
    when 3
      set_pins(1, 0, 0, 0)
    end
    @current_step += increment
    File.write FILE, @current_step
  end

  def set_pin(pin, value)
    `fast-gpio set #{pin} #{value}`
  end

  def set_pins(*pins)
    pins.each_with_index do |value, index|
      set_pin @pins[index], value
    end
  end
end
