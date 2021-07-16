require 'rails_helper'

RSpec.describe 'Merchants API' do
  it 'sends all merchants in pages of 20' do
    create_list(:merchant, 40)

    get '/api/v1/merchants?page=1'

    expect(response).to be_successful
  end
end