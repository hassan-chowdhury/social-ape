# spec/controllers/application_controller_spec.rb
require "rails_helper"


RSpec.describe ApplicationController, type: :controller do
    # create test user
    let!(:user) { create(:user) }
    # set headers for authorization
    let(:headers) { { 'Authorization' => token_generator(user.id) } }
    let(:invalid_headers) { { 'Authorization' => nil } }

    describe "#authorize_request" do
        
    end
end