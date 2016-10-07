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

      # Authenticate with Particle and create a new customer. Since the Particle
      # client errors if you include both basic_auth and token auth, you probably
      # want to create a new client when you create customers.
      #
      # @param email [String] The email (email) used to log in to
      #                          the Particle Cloud API
      # @return [Customer] The customer object
      def create_customer(email, product_slug)
        self.connection.basic_auth(self.client_id, self.client_secret)
        path = customer.product_customer_path(product_slug)
        result = post(path, email: email, no_password: true)
        customer(result)
      end
    end
  end
end
