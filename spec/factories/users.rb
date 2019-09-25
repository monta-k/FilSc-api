FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    email { 'test@email.com' }
    uid { '1111111111111' }
    filmarks_id {}
  end
end
