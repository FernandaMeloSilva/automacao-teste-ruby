describe "POST /signup" do
  context "novo usuario" do
    before(:all) do
      payload = { name: "Pitty", email: "pitty@bol.com", password: "teste123" }
      MongoDB.new.remove_user(payload[:email])

      @result = Signup.new.create(payload)
    end

    it "valida status code" do
      expect(@result.code).to eql 200
    end

    it "valida id do usuario" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end

  context "usuario ja existe" do
    before(:all) do
      payload = { name: "João", email: "joao@bol.com", password: "teste123" }
      MongoDB.new.remove_user(payload[:email])

      Signup.new.create(payload)
      @result = Signup.new.create(payload)
    end

    it "deve retornar 409" do
      expect(@result.code).to eql 409
    end

    it "deve retornar mensagem" do
      expect(@result.parsed_response["error"]).to eql "Email already exists :("
    end
  end

  # examples = [
  #   {
  #     title: "nome em branco",
  #     payload: { name: "", email: "ana@bol.com", password: "teste123" },
  #     code: 412,
  #     error: "required name",
  #   },
  #   {
  #     title: "sem campo nome",
  #     payload: { email: "ana@bol.com", password: "teste123" },
  #     code: 412,
  #     error: "required name",
  #   },
  #   {
  #     title: "email em branco",
  #     payload: { name: "Ana", email: "", password: "teste123" },
  #     code: 412,
  #     error: "required email",
  #   },
  #   {
  #     title: "sem o campo email",
  #     payload: { name: "Ana", password: "teste123" },
  #     code: 412,
  #     error: "required email",
  #   },
  #   {
  #     title: "senha em branco",
  #     payload: { name: "Ana", email: "ana@bol.com", password: "" },
  #     code: 412,
  #     error: "required password",
  #   },
  #   {
  #     title: "sem o campo senha",
  #     payload: { name: "Ana", email: "ana@bol.com" },
  #     code: 412,
  #     error: "required password",
  #   },
  # ]

  # puts (examples.to_json)+

  examples = Helpers::get_fixture("signup")
  examples.each do |e|
    context "#{e[:title]}" do
      before(:all) do
        @result = Signup.new.create(e[:payload])
      end

      it "valida status code #{e[:code]}" do
        expect(@result.code).to eql e[:code]
      end

      it "valida id do usuário" do
        expect(@result.parsed_response["error"]).to eql e[:error]
      end
    end
  end
end
