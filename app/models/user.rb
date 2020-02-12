class User < ApplicationRecord

    # Validations
    validates_presence_of :name, :password_digest
    validates :email, presence: true, uniqueness: { message: "Email already in use!" }

    # encrypt password
    has_secure_password
    
end
