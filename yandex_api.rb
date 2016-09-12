class Translate
  require 'net/http'
  @@key = 'trnsl.1.1.20160907T074008Z.219370a649ad82f3.ba97d8a5ac874373ad4e10e673bcb293554230c4'#Ключ можно заменить на свой
  @@default_host = 'https://translate.yandex.net/api/v1.5/tr.json'

  def getLangs
    ui = "en"
    url_list_lang = @@default_host + "/getLangs?ui=#{ui}&key=#{@@key}"
    url_list_lang = URI(url_list_lang)
    req = Net::HTTP::Post.new(url_list_lang.to_s) 
    res = Net::HTTP.start(url_list_lang.host, url_list_lang.port, :use_ssl => url_list_lang.scheme == 'https') {|http|
      http.request(req)
    }
    res.body
  end

  def defLang(text_before)
    @text_before = text_before
    ident_url = @@default_host + "/detect?text=#{@text_before}&key=#{@@key}"
    ident_url = URI::encode(ident_url)
    ident_url = URI(ident_url)
    req = Net::HTTP::Post.new(ident_url.to_s)
    res = Net::HTTP::start(ident_url.host, ident_url.port, :use_ssl => ident_url.scheme == "https") {|http|
      http.request (req)
    }
    res.body
   end

  def lookUp(text_before)
    @text_before = text_before
    lang = "ru"
    transl_url = @@default_host + "/translate?text=#{@text_before}&lang=#{lang}&key=#{@@key}"
    transl_url = URI::encode(transl_url)
    transl_url = URI(transl_url)
    req = Net::HTTP::Post.new(transl_url.to_s)
    res = Net::HTTP::start(transl_url.host, transl_url.port, :use_ssl=> transl_url.scheme == "https") {|http|
      http.request (req)
    }
    res = res.body
  end
end

#-----------------
#p = Translate.new
#text = "Hello, world! How are you?"
#puts p.getLangs
#----------
#Код для примера запуска
