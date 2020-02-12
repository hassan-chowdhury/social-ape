class User < ApplicationRecord

    # Validations
    validates_presence_of :name, :email, :password_digest
    validates_uniqueness_of :email

    # encrypt password
    has_secure_password
    
end
