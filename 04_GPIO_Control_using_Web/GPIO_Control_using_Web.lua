-- Original source
-- http://www.cnx-software.com/2015/10/29/getting-started-with-nodemcu-board-powered-by-esp8266-wisoc/

-- You MUST reset before downloading


SSID = "your_SSID"
SSID_PASSWORD = "your_SSID_PASSWORD"

wifi.setmode (wifi.STATION)
wifi.sta.config (SSID, SSID_PASSWORD)

print(wifi.sta.getip())
led1 = 5 -- ESP8266 GPIO14
led2 = 1 -- ESP8266 GPIO05

gpio.mode(led1, gpio.OUTPUT)
gpio.mode(led2, gpio.OUTPUT)

srv=net.createServer(net.TCP, 30)
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        local buf = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
            end
        end
        buf = buf.."<h1> ESP8266 Web Server</h1>";
        buf = buf.."<p>LED1(GPIO14) <a href=\"?pin=ON1\"><button>ON</button></a>&nbsp;<a href=\"?pin=OFF1\"><button>OFF</button></a></p>";
        buf = buf.."<p>LED2(GPIO05) <a href=\"?pin=ON2\"><button>ON</button></a>&nbsp;<a href=\"?pin=OFF2\"><button>OFF</button></a></p>";
        local _on,_off = "",""
        if(_GET.pin == "ON1")then
            gpio.write(led1, gpio.HIGH);
        elseif(_GET.pin == "OFF1")then
            gpio.write(led1, gpio.LOW);
        elseif(_GET.pin == "ON2")then
            gpio.write(led2, gpio.HIGH);
        elseif(_GET.pin == "OFF2")then
            gpio.write(led2, gpio.LOW);
        end
        client:send(buf);
        client:close();
        collectgarbage();
    end)
end)
