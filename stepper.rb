IN1 = 0
IN2 = 1
IN3 = 2
IN4 = 3
LOW = 0
HIGH = 1

steps = 1551
#steps = 2048  # Full revolution
@current_step = 0

`fast-gpio set-output #{IN1}`
`fast-gpio set-output #{IN2}`
`fast-gpio set-output #{IN3}`
`fast-gpio set-output #{IN4}`

def step
  case @current_step
  when 0
    set_pin(IN1, LOW)
    set_pin(IN2, LOW)
    set_pin(IN3, LOW)
    set_pin(IN4, HIGH)
  when 1
    set_pin(IN1, LOW)
    set_pin(IN2, LOW)
    set_pin(IN3, HIGH)
    set_pin(IN4, LOW)
  when 2
    set_pin(IN1, LOW)
    set_pin(IN2, HIGH)
    set_pin(IN3, LOW)
    set_pin(IN4, LOW)
  when 3
    set_pin(IN1, HIGH)
    set_pin(IN2, LOW)
    set_pin(IN3, LOW)
    set_pin(IN4, LOW)
  end

  @current_step = (@current_step + 1) % 4
end

def set_pin(pin, value)
  `fast-gpio set #{pin} #{value}`
end

steps.times { step }
