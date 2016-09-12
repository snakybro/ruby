class API
  require 'net/http'
  @@default_host = 'https://translate.yandex.net/api/v1.5/tr.json/'
  @@key = 'trnsl.1.1.20160907T074008Z.219370a649ad82f3.ba97d8a5ac874373ad4e10e673bcb293554230c4'

  def send_request(method, lang, *text)
    url = URI (@@default_host + "/#{method}?")
    req = Net::HTTP::Post.new(url)
    if method == "getLangs"
      req.set_form_data({"ui" => lang, "key" => @@key},"&")
    elsif method == "detect"
      req.set_form_data({"text" => text, "key" => @@key},"&")
    elsif method == "translate" 
      req.set_form_data({"lang" => lang, "text" => text, "key" => @@key},"&")
    else print "Choose right method: getLangs, translate, detect"
    return
    end
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    res = http.request(req)
    res = res.body
  end

end

#-----------------
p = API.new
puts p.send_request("translate", "ru", "hello world")
#----------
#Код для примера запуска
