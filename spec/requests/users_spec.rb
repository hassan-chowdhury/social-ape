# spec/requests/users_spec.rb
require 'rails_helper'


RSpec.describe 'Users API', type: :request do
    let(:user) { build(:user) }
    let(:headers) { valid_headers.except('Authorization') }
    let(:valid_attributes) do
        attributes_for(:user, password_confirmation: user.password)
    end
    # Test suite for POST /auth/register
    describe 'POST /auth/register' do

        context 'when request valid' do
            before { post '/auth/register', params: valid_attributes.to_json, headers: headers }

            it 'returns a success message' do
                expect(json['message']).to eq("User created successfully.")
            end

            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when invalid request' do
        
            context 'does not include name and email' do
                before { post '/auth/register', params: {}, headers: headers }
    
                it 'returns a validation failure message' do
                    expect(json.keys).to contain_exactly("name", "email", "password", "password_digest")
                    json.values.each { |v| expect(v[0]).to eq("can't be blank") }
                end
    
                it 'returns status code 400' do
                    expect(response).to have_http_status(400)
                end
            end

            context 'cannot register a new user using an existing email' do
                before do
                    post '/auth/register', params: valid_attributes.to_json, headers: headers
                    post '/auth/register', params: valid_attributes.to_json, headers: headers
                end
    
                it 'returns a validation failure message' do
                    expect(json['email'][0]).to eq("Email already in use!")
                end
    
                it 'returns status code 400' do
                    expect(response).to have_http_status(400)
                end
            end
        
        end

    end
end