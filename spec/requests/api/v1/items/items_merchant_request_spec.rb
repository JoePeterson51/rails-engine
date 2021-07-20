RSpec.describe 'merchant items request' do
  it 'can return all the merchants items' do
    merchant1 = FactoryBot.create(:merchant)
    item1 = FactoryBot.create(:item, merchant: merchant1)

    get "/api/v1/items/#{item1.id}/merchant"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:id].to_i).to eq(merchant1.id)
  end
end