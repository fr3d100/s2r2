require_relative '../lib/cryptos'

describe "get_data method" do 
	# Permet de vérifier qu'on récupère des données sur cette URL via nogokiri
	it "should return data" do
		expect(get_data("https://coinmarketcap.com/all/views/all/")).to be
	end
end

describe "get_currencies method" do
	# Permet de vérifier que le tableau n'est pas nul
	it "should return data" do
		expect(get_currencies(get_data("https://coinmarketcap.com/all/views/all/"))).to be
	end

	it "should at least find BTC" do
		# Vérifie qu'il existe bien le BTC dans le tableau
		expect(get_currencies(get_data("https://coinmarketcap.com/all/views/all/"))[0].key?("BTC")).to eq(true)
	end 
end