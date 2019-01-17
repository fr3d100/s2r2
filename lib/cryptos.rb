require 'rubygems'
require 'nokogiri'
require 'open-uri'

# URL de la page cible
PAGE_URL = "https://coinmarketcap.com/all/views/all/"

# Méthode de récupération des données de la page dont on passe l'URL
def get_data(url)
		return page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
end

# Méthode de récupération des cryptos et de leurs valeurs
def get_currencies(page)	
	# Définition de l'array qui sera return
	a = []
	# Variable itérative
	i = 0

	# Determiner le nombre de cryptos à récupérer
	currency_nb = page.css('td.currency-name span.currency-symbol a').length

	# Comme expliqué dans le perform, je limite le tableau à 5 résultats sinon le scrapping et beaucoup trop long
	# Sinon, il suffirait d'ouvrir la boucle comme cela : currency_nb.times do
	5.times do 
		# On récupère le symbole de la crypto
		currency_name =  page.css('td.currency-name span.currency-symbol a')[i].text
		# On récupère sa valeur
		currency_price =  page.css('a.price')[i]["data-usd"]
		# On créé un hash
		h = {currency_name => currency_price}
		# On ajoute le hash au tableu
		a.push(h)
		# itération
		i += 1
	end
	#On renvoi le tableau
	return a
end

def perform
	puts "==== DISCLAIMER ===="
	puts " Je ne remonte ici dans mon perform que 5 crypto VOLONTAIREMENT"
	puts "Le temps pour extraire les 2109 cryptos du site serait beaucoup trop long"
	puts "(voir le contenu du programme pour où j'explique la ligne à modifier pour scrapper toutes les cryptos"
	puts "===================="
	# Récupération des données de la page
	page = get_data(PAGE_URL)
	# récupération des données cryptos
	puts get_currencies(page)
end

perform