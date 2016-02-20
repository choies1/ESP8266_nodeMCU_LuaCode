--[[
Searching WiFi near ESP8266 board
--]]

wifi.setmode(wifi.STATION)

-- print ap list
function listap(t)
      for ssid,v in pairs(t) do
        authmode, rssi, bssid, channel = 
          string.match(v, "(%d),(-?%d+),(%x%x:%x%x:%x%x:%x%x:%x%x:%x%x),(%d+)")
        print(ssid,authmode,rssi,bssid,channel)
      end
end
      
wifi.sta.getap(listap)
tmr.delay(1000000)

wifi.sta.config("Junho","chlwnsgh0910")
wifi.sta.connect()
tmr.delay(1000000)   -- wait 1,000,000 us = 1 second
print(wifi.sta.status())
print(wifi.sta.getip())
