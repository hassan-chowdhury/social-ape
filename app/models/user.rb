class User < ApplicationRecord

    # attr_accessor :name, :email, :password

    # Validations
    validates_presence_of :name, :password_digest
    validates :email, presence: true, uniqueness: { message: "Email already in use!" }

    # encrypt password
    has_secure_password
    
end
