# frozen_string_literal: true

require 'yasd/version'

module Yasd
  class Config
    attr_accessor :username, :password, :security_token, :client_id, :client_secret, :api_version

    def initialize
      yield(self) if block_given?
    end
  end
end
