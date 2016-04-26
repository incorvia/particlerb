require 'particle/model'

module Particle

  # Domain model for one Particle customer
  class Customer < Model
    attribute_reader :token_type, :access_token, :refresh_token, :expires_in, :scope

    # Customers can't be loaded. What you see is what you get...
    def get_attributes
      @loaded = true
      @attributes
    end

    # Create a Particle customer
    # @param email [String] The email used to log in to the Particle Cloud API
    def create(email)
      @client.create_customer(email)
    end

    def base_path
      "/v1/orgs/#{@client.organization}/customers"
    end
  end
end
