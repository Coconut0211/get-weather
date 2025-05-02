import net
import httpclient
import strutils
import htmlparser
import xmltree

const URL = "https://wttr.in/$1?0&lang=ru"


proc getWeather(city: string): string =
  let client = newHttpClient()
  var response: string = client.getContent(URL % city)
  client.close()
  result = parseHtml(response).findAll("pre")[0].innerText

when isMainModule:
  let server = newSocket()
  server.bindAddr(Port(8080))
  server.listen()
  while true:
    var client: Socket
    server.accept(client)
    var data = client.recvLine()
    client.send(getWeather(data))
    client.close()
  server.close()