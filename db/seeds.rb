# frozen_string_literal: true

require 'net/http'
require 'json'
api_url = URI.parse('http://localhost:3000/api/v1/users')
api_url_item = URI.parse('http://localhost:3000/api/v1/item')

def gender_from_name(name)
  first_name = name.split(' ')[0]
  last_letter = first_name[-1].downcase == '.' ? first_name[-2].downcase : first_name[-1].downcase

  if %w[a e i z].include?(last_letter)
    'Feminino'
  else
    'Masculino'
  end
end

100.times do
  random_name = Faker::Name.name
  user_data_json = [
    { name: random_name,
      age: %i[20 25 30 35 40 45 50].sample,
      gender: gender_from_name(random_name),
      latitude: Faker::Address.latitude.to_s,
      longitude: Faker::Address.longitude.to_s,
      created_at: Faker::Time.between(from: 2.days.ago, to: Time.now),
      updated_at: Faker::Time.between(from: 2.days.ago, to: Time.now) }
  ]

  def create_user(api_url, data)
    http = Net::HTTP.new(api_url.host, api_url.port)
    request = Net::HTTP::Post.new(api_url.path, { 'Content-Type' => 'application/json' })
    request.body = data.to_json

    response = http.request(request)

    # Verifique se a resposta foi bem-sucedida (código 2xx)
    if response.is_a?(Net::HTTPSuccess)
      puts 'Usuário cadastrado com sucesso!'
    else
      puts "Erro ao cadastrar usuário. Código de resposta: #{response.code}"
      puts "Resposta: #{response.body}"
    end
  end

  user_data_json.each do |dados|
    create_user(api_url, dados)
  end
end

items = [
  { description: 'Água', score: 4 },
  { description: 'Comida', score: 3 },
  { description: 'Medicamento', score: 2 },
  { description: 'Munição', score: 1 }
]

def create_item(api_url_item, data)
  http = Net::HTTP.new(api_url_item.host, api_url_item.port)
  request = Net::HTTP::Post.new(api_url_item.path, { 'Content-Type' => 'application/json' })
  request.body = data.to_json

  response = http.request(request)

  # Verifique se a resposta foi bem-sucedida (código 2xx)
  if response.is_a?(Net::HTTPSuccess)
    puts 'Item cadastrado com sucesso!'
  else
    puts "Erro ao cadastrar um item. Código de resposta: #{response.code}"
    puts "Resposta: #{response.body}"
  end
end

items.each do |item|
  create_item(api_url_item, item)
end
