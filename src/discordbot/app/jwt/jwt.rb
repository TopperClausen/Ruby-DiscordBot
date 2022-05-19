class Jwt
  def generate_jwt(payload)
    JWT.encode(payload, ENV['JWT_SECRET'], 'HS256')
  end

  def user_id(jwt)
    decoded_array = JWT.decode(jwt, ENV['JWT_SECRET'], true, { algorithm: 'HS256' })
    payload = decoded_array[0]
    payload['id']
  rescue JWT::VerificationError
    nil
  end
end
