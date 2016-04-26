require 'particle/customer'
require 'uri'

module Particle
  class Client

    # Client methods for the Particle Organization Customer API
    #
    # @see https://docs.particle.io/reference/api/#create-a-customer---client-credentials
    module Customers

      # Create a domain model for a Particle customer
      #
      # @param target [String, Hash, Customer] A customer id, hash of attributes or {Customer} object
      # @return [Customer] A customer object to interact with
      def customer(target = {})
        if target.is_a? Customer
          target
        else
          Customer.new(self, target)
        end
      end

      # Authenticate with Particle and create a new customer
      #
      # @param email [String] The email (email) used to log in to
      #                          the Particle Cloud API
      # @return [Customer] The customer object
      def create_customer(email)
        data = URI.encode_www_form({
          email: email,
          no_password: true
        })
        http_options = {
          headers: { content_type: "application/x-www-form-urlencoded" },
          client_id: self.client_id,
          client_secret: self.client_secret
        }
        result = request(:post, customer.base_path, data, http_options)
        customer(result)
      end
    end
  end
end
