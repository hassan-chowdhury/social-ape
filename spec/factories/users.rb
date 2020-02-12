# spec/factories/users.rb
FactoryBot.define do
    factory :user do
        name { Faker::Name.name }
        email { "#{name.gsub(/[^0-9a-zA-Z]/i, '')}@example.com" }
        password "password"
    end
end