require 'rubygems'
require 'nokogiri'
require 'open-uri'

# URL de la page cible
PAGE_URL_MAIRIES = "https://annuaire-des-mairies.com/"
PAGE_URL_MAIRIES_95 = "https://annuaire-des-mairies.com/val-d-oise.html"

PAGE_URL_MAIRIE_TEST = "https://www.annuaire-des-mairies.com/95/ableiges.html"

# Récupère l'email de la mairie à partir de son URL
def get_townhall_email(townhall_url)
	page = Nokogiri::HTML(open(townhall_url))
	return page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
end




def get_townhall_urls()
	# Initialisation des du tableau qui va stocker tous les liens des mairies
	mairies = []
	mairies_mail = []

	# 1 On va remplir le tableau avec toutes les mairies du 95
	page = Nokogiri::HTML(open(PAGE_URL_MAIRIES_95))
	page.css('a.lientxt').each do |link|
			if link['href'] != ""
				mairies << [link.text, link['href']]
			end
	end

	# 2 On va récupérer l'adresse mail de chacune des mairies
	mairies.each do |link|
		# On concatene avec l'adresse du site et on retire le './'
		clean_link = "#{PAGE_URL_MAIRIES}#{link[1][2..-1]}" 
		puts "En cours de traitement : #{link[0]} "
		email = get_townhall_email(clean_link)
		mairies_mail << {link[0] => email}
	end

	return mairies_mail

end


def perform
	puts get_townhall_urls
end

perform