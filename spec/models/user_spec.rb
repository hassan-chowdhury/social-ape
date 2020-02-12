# spec/models/user_spec.rb
require 'rails_helper'


# Test suite for the User model
RSpec.describe User, type: :model do
    # Validation test
    # ensure columns name, email, password_digest are present before saving
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
end