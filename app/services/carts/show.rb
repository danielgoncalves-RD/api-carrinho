# frozen_string_literal: true

module Carts
  class Show
    def self.call(session:)
      new(session).call
    end

    def initialize(session)
      @session = session
    end

    def call
      return Cart.find(@session[:cart_id]) if @session[:cart_id]

      Cart.new
    end
  end
end
