require 'rails_helper'

RSpec.describe Trade, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:giver_id) }
    it { should validate_presence_of(:giver_items) }
    it { should validate_presence_of(:receiver_id) }
    it { should validate_presence_of(:receiver_items) }
  end

  describe '#execute_trade' do
    let(:giver_inventory) { create(:inventory) }
    let(:receiver_inventory) { create(:inventory) }
    let(:giver_id) { giver_inventory.id }
    let(:receiver_id) { receiver_inventory.id }

    before do
      # Adicione itens aos inventários do doador e do receptor, se necessário
      # Crie e adicione inventário items aos inventários
      # giver_inventory_item = create(:inventory_item, inventory: giver_inventory)
      giver_inventory_item = create(:inventory_item, :agua, inventory: giver_inventory)
      receiver_inventory_item = create(:inventory_item, :comida, inventory: receiver_inventory)
    end

    it 'executes trade successfully' do
      # Permitindo os métodos para simular adição e remoção de itens
      allow(InventoryItem).to receive(:add_quantity).and_return(true)
      allow(InventoryItem).to receive(:remove_quantity).and_return(true)

      # Criando um item de Água e associando ao inventário do doador
      item_medicamento = create(:item, :medicamento)
      giver_inventory_item = create(:inventory_item, item: item_medicamento, inventory: giver_inventory)

      # Criando um item de Comida e associando ao inventário do receptor
      item_municao = create(:item, :municao)
      receiver_inventory_item = create(:inventory_item, item: item_municao, inventory: receiver_inventory)

      # Criando a troca com os IDs dos inventários e a quantidade dos itens
      trade = Trade.new(
        giver_id: giver_inventory.id,
        giver_items: { giver_inventory_item.item.id => 4 },
        receiver_id: receiver_inventory.id,
        receiver_items: { receiver_inventory_item.item.id => 4 }
      )

      # Executando a troca e esperando uma mensagem de sucesso
      expect(trade.execute_trade).to eq({ message: 'Troca realizada com sucesso' })
    end
  end
end
