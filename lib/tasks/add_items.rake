namespace :seed_data do
  desc 'Add Items in ZSSN'
  task insert_items: :environment do
    items = [
      { description: 'Água', score: 4 },
      { description: 'Comida', score: 3 },
      { description: 'Medicamento', score: 2 },
      { description: 'Munição', score: 1 }
    ]
    items.each do |item_data|
      Item.create!(description: item_data[:description], score: item_data[:score])
    end
    puts 'Items cadastrados com sucesso!'
  end
  # bundle exec rake seed_data:insert_items
end
