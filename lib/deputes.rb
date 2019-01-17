require 'rubygems'
require 'nokogiri'
require 'open-uri'


#SITE DE LA LISTE DES DEPUTES (NOMS, PRENOMS, URL)
#https://www.nosdeputes.fr/deputes

#SITE POUR RECUPERER LES MAILS DES DEPUTES
#https://www.nosdeputes.fr/<nom-du-depute>



# --- METHODE PERMETTANT DE RECUPERER LE MAIL DU DEPUTE A PARTIR DE L'URL DE SA FICHE ---

def get_deputy_email(deputy_url) 

doc = Nokogiri::HTML(open(deputy_url))

    # J'utilise le xpath (position absolue du mail dans le tableau, 4eme ligne, 2ème colonne)en espérant qu'il soit le même sur chaque page de mairie
    # Une méthode plus sûr consisterait à récupérer le mail en regex dans le tableau
    mail = doc.xpath('//*[@id="b1"]/ul[2]/li[1]/ul/li[1]').text

return mail
end

# --- METHODE PERMETTANT DE RECUPERER UN TABLEAU AVEC DES COUPLES DE HASH NOM DEPUTES => LIEN PAGE DEPUTES ---

def get_deputy_urls(nb_deputy)

    my_array=[]
    myhash_each = {}

    doc = Nokogiri::HTML(open("https://www.nosdeputes.fr/deputes"))
    
    tr = doc.xpath('//*[@id="corps_page"]/div/div')
    nb_deputy.times do |i|
      little_url = tr.css('td/a')[i]['href']
      puts deputy_url = "https://www.nosdeputes.fr#{little_url}"
  
      #Mail du député
      puts mail_deputy = get_deputy_email(deputy_url)

      #Prénom du député -> je me place dans le tableau global (/td/a) et pour chaque colonne, je récupère le (prenom, nom) que je splite, puis mets en forme en supprimant les parasites
      puts first_name_deputy = tr.css('td/a')[i].css('.list_nom').text.split(",")[1][1..20].delete_suffix("    ")

      #Nom du député
      puts last_name_deputy = tr.css('td/a')[i].css('.list_nom').text.split(",")[0][7..20]

      #Hash {first_name > Jean, last_name > Durand, email > email.com}
      puts myhash_each = {first_name: first_name_deputy, last_name: last_name_deputy, email: mail_deputy}

      my_array << myhash_each

    end
    
return my_array   
end

get_deputy_urls(4)