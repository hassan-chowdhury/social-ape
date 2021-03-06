# spec/controllers/application_controller_spec.rb
require "rails_helper"


RSpec.describe ApplicationController, type: :controller do
    # create test user
    let!(:user) { create(:user) }
    # set headers for authorization
    let(:header) { { 'Authorization' => token_generator(user.id) } }
    let(:invalid_headers) { { 'Authorization' => nil } }
    # Valid request subject
    let(:api_request) { AuthorizeApiRequest.new(header) }

    describe "#authenticate_request" do

        context "when auth token is passed" do

            # private method authorize_request returns current user
            it "sets the current user" do
                response = api_request.call
                expect(response.result).to eq(user)
            end
        end

        # context "when auth token is not passed" do
        #     before do 
        #         allow(request).to receive(:invalid_headers).and_return(invalid_headers)
        #     end

        #     it "raises MissingToken error" do
        #         # expect { subject.instance_eval { authorize_request } }
        #         #     .to raise_error(ExceptionHandler::MissingToken, "")

        #         expect(subject.__send__(:authenticate_request))
        #             .to raise_error(ExceptionHandler::MissingToken, "Missing token")
        #     end
        # end

    end
end