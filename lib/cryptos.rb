require 'rubygems'
require 'nokogiri'
require 'open-uri'

URL = "https://coinmarketcap.com/all/views/all/"

def get_data(url)
	return page = Nokogiri::HTML(open(url))
end

def get_currencies(page)
	# Initialisation des variables
	a = []
	hash_crypto = {}

	page.xpath('//tbody//tr').each do |node|
		crypto_name = node.css('span.currency-symbol a').text
		crypto_price = node.css('a.price').text
		# Gestion du cas où il y aurait une donnée vide au milieu du tableau 
		if crypto_name != "" && crypto_price != ""
		 hash_crypto = {crypto_name => crypto_price}
		 a << hash_crypto
		end
	end

	return a

end


def perform
	page = get_data(URL)
	puts get_currencies(page)
end

perform
