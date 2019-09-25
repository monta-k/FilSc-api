require 'rails_helper'

describe 'UserApi' do
  include_context :authenticated_user
  it 'FilmarksIDを設定' do

    patch '/api/v1/users', params: { user: { filmarks_id: 'test.id' } }
    json = JSON.parse(response.body)

    expect(response.status).to eq(200)

    expect(json['filmarksId']).to eq('test.id')
  end
end