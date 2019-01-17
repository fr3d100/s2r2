require_relative '../lib/deputes'


describe "get_deputy_urls method" do
    it "it should return an array" do
    expect(get_deputy_urls(10).is_a?Array).to eq(true)
     end

    it "should return results" do
       expect(get_deputy_urls(10).length>5).to eq(true)
     end

    it "first deputee is DaMr Abad" do
        expect(get_deputy_urls(10)[0][:last_name]).to eq("Abad")   
      end


  end