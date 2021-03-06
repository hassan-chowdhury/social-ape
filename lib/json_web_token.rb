# lib/json_web_token.rb

class JsonWebToken

    class << self

        HMAC_SECRET = Rails.application.secrets.secret_key_base

        def encode(payload, exp = 2.hours.from_now)
            # set token expiration time
            payload[:exp] = exp.to_i
            # encode user data (payload) with the secret key
            JWT.encode(payload, HMAC_SECRET)
        end

        def decode(token)
            # decode the token to get the user data (payload)
            body = JWT.decode(token, HMAC_SECRET)[0]
            HashWithIndifferentAccess.new body
        
        rescue JWT::ExpiredSignature, JWT::VerificationError => e
            raise ExceptionHandler::ExpiredSignature, e.message
        
        rescue JWT::DecodeError, JWT::VerificationError => e
            raise ExceptionHandler::DecodeError, e.message
        end
        
    end

end