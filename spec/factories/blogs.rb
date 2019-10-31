FactoryBot.define do
    factory :blog do
        name { 'テストを書く' }
        description { 'RSpec & Capybara & FactoryBotを準備する' }
        user
    end
end