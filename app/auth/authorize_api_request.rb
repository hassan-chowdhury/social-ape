# app/auth/authorize_api_request.rb

class AuthorizeApiRequest
    prepend SimpleCommand
    attr_reader :headers

    def initialize(headers = {})
        @headers = headers
    end

    def call
        user
    end

    private

    def user
        @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
        # @user ||= errors.add(:token, 'Invalid token') && nil

    rescue ActiveRecord::RecordNotFound => e
        raise(ExceptionHandler::InvalidToken, "Invalid token")

    end

    def decoded_auth_token
        @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
    end

    def http_auth_header
        # if headers['Authorization'].present?
        #     return headers['Authorization'].split(' ').last
        # else
        #     errors.add(:token, 'Missing token')
        # end
        # nil
        
        if headers['Authorization'].present?
            return headers['Authorization'].split(' ').last
        end
        
        raise(ExceptionHandler::MissingToken, "Missing token")
    end
end