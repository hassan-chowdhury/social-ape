# spec/requests/users_spec.rb
require 'rails_helper'


RSpec.describe 'Users API', type: :request do

    # Test suite for POST /auth/register
    describe 'POST /auth/register' do
        # valid payload
        let(:valid_attributes) { 
            { 
                name: 'example',
                email: 'example@example.com',
                password: 'example',
                password_confirmation: 'example'
            } 
        }

        context 'when the request is valid' do
            before { post '/auth/register', params: valid_attributes }

            it 'returns a success message' do
                expect(json['message']).to eq("User created successfully.")
            end

            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when the request does not include name and email' do
            before { post '/auth/register', params: { password: 'hello' } }

            it 'returns a validation failure message' do
                expect(json['name'][0]).to eq("can't be blank")
                expect(json['email'][0]).to eq("can't be blank")
            end

            it 'returns status code 400' do
                expect(response).to have_http_status(400)
            end
        end

        context 'cannot register a new user using an existing email' do
            before {
                post '/auth/register', params: valid_attributes
                post '/auth/register', params: valid_attributes
            }

            it 'returns a validation failure message' do
                expect(json['email'][0]).to eq("Email already in use!")
            end

            it 'returns status code 400' do
                expect(response).to have_http_status(400)
            end
        end

    end
end