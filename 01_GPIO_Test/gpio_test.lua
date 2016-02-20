--
-- Test Board: WeMos D1 board (ESP8266, ESP-12F)
--

gpio_pin = 4
gpio.mode(gpio_pin, gpio.OUTPUT)

while 1 do
  gpio.write(gpio_pin, gpio.HIGH)
  tmr.delay(1000000) -- wait 1,000,000 us = 1 second
  gpio.write(gpio_pin, gpio.LOW)
  tmr.delay(1000000) -- wait 1,000,000 us = 1 second
end

