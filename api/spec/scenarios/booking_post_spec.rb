describe "POST /equipos/{equipo_id}/bookings" do
  before(:all) do
    payload = { email: "cassia@gmail.com", password: "teste123" }
    result = Sessions.new.login(payload)
    @cassia_id = result.parsed_response["_id"]
  end

  context "solicitar locacao" do
    before(:all) do
      #dado que fernanda tem um equipamento para locação

      result = Sessions.new.login({ email: "fernanda@teste.com", password: "teste123" })
      fernanda_id = result.parsed_response["_id"]

      fender = {
        thumbnail: Helpers::get_thumb("fender-sb.jpg"),
        name: "Fender Strato",
        category: "Cordas",
        price: 150,
      }

      MongoDB.new.remove_equipo(fender[:name], fernanda_id)
      result = Equipos.new.create(fender, fernanda_id)
      fender_id = result.parsed_response["_id"]

      #quando solicito a locação da fender da fernanda
      @result = Equipos.new.booking(fender_id, @cassia_id)
    end

    it "deve retornar 200" do
      expect(@result.code).to eql 200
    end
  end
end
