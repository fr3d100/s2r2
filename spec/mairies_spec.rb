require_relative '../lib/mairies'


describe "get_townhall_urls method" do
    it "it should return an array" do
    expect(get_townhall_urls.is_a?Array).to eq(true)
     end

    it "it should contains ABLEIGES townhall" do
        expect(get_townhall_urls.join.include?('ABLEIGES')).to eq(true)   
      end

    it "it should matches ABLEIGES townhall with mairie.ableiges95@wanadoo.fr " do
        expect(get_townhall_urls[0]['ABLEIGES']).to eq("mairie.ableiges95@wanadoo.fr")   
      end


  end