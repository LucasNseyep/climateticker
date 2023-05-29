require 'open-uri'
require "litexbrl"
# require "pp"

html_content = URI.open("https://www.sec.gov/ix?doc=/Archives/edgar/data/1652044/000165204423000016/goog-20221231.htm").read

pp LiteXBRL::TDnet.parse html_content
