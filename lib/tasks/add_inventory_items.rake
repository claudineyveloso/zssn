namespace :seed_data do
  desc 'Add Items in ZSSN'
  task insert_inventory_items: :environment do
    users_without_inventory_items = User.includes(inventory: :inventory_items)
                                        .where(inventory_items: { id: nil })
                                        .order(:id)

    items = Item.all.order(:id)

    users_without_inventory_items.each do |user|
      inventory = user.inventory || user.build_inventory

      items.each do |item|
        quantity = [5, 6, 7, 8].sample
        inventory.inventory_items.create!(item:, quantity:)
      end
    end

    puts 'Items do inventário cadastrados com sucesso!'
  end
  # bundle exec rake seed_data:insert_inventory_items
end
