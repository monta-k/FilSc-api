require 'rails_helper'

describe 'UserApi' do
  include_context :authenticated_user
  it 'FilmarksIDを設定' do
    patch '/api/v1/users', params: { user: { filmarks_id: 'test.id' } }
    json = JSON.parse(response.body)

    expect(response.status).to eq(200)

    expect(json['filmarksId']).to eq('test.id')
  end

  it '名前を変更' do
    patch '/api/v1/users', params: { user: { name: 'changedName' } }
    json = JSON.parse(response.body)

    expect(response.status).to eq(200)

    expect(json['name']).to eq('changedName')
  end

  it 'ユーザーを削除' do
    expect { delete '/api/v1/users' }.to change(User, :count).by(-1)

    expect(response.status).to eq(204)
  end
end
