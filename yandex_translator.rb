require "yandex_translator/version"

module YandexTranslator
  class Client

  require 'net/http'
  require 'json'
  
    def initialize(token)
      @api_key = (token)
      @base_uri = "https://translate.yandex.net/api/v1.5/tr.json/"
    end

    def get_langs(ui=nil)
      data = {"ui" => ui}
      langs = connect("/getLangs", data)
    end

    def detect(text)
      data = {"text" => text}
      lang = connect("/detect", data)
    end

    def translate(text, lang)
      data = {"text" => text, "lang" => lang}
      translate = connect("/translate", data)['text']
    end

    def connect(path, data)
      url = URI(@base_uri + "#{path}?")
      request = Net::HTTP::Post.new(url)
      data.store("key", @api_key)
      request.set_form_data(data,"&")
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      response = http.request(request)
      response = JSON.parse(response.body)
      check_response(response)
    end

    def check_response(response)
      if response.include?("code") && response["code"].to_i != 200
        return "Error. Code #{response['code']}. #{response['message']}"
      else
        response
      end
    end
  end
end
