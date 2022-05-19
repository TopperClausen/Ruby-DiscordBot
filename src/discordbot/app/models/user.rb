class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true, allow_nil: false
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: false

  def compare_password?(password:)
    self.password == password
  end

  def user_response_data
    {
      id: id,
      email: email,
      first_name: first_name,
      last_name: last_name
    }
  end

  def generate_jwt
    Jwt.new.generate_jwt(jwt_payload)
  end

  private

  def jwt_payload
    { id: id }
  end
end
