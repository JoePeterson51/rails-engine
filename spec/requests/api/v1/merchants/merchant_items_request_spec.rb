RSpec.describe 'merchant items request' do
  it 'can return all the merchants items' do
    merchant1 = FactoryBot.create(:merchant)
    item1 = FactoryBot.create(:item, merchant: merchant1)

    get "/api/v1/merchants/#{merchant1.id}/items"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data].first[:id].to_i).to eq(item1.id)
  end
end