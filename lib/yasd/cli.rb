# frozen_string_literal: true

require 'thor'
require 'yasd/dataloader'

module Yasd
  class CLI < Thor
    desc 'load', 'Load to Salesforce with local file'
    method_option :query, type: :string, aliases: ['-q']
    method_option :file, type: :string, aliases: ['-f']
    method_option :config, type: :string, aliases: ['-c']
    def export
      dataloader = Dataloader.new(username: ENV['SALESFORCE_USERNAME'],
                                  password: ENV['SALESFORCE_PASSWORD'],
                                  api_version: ENV['SALESFORCE_API_VERSION'],
                                  client_id: ENV['SALESFORCE_CLIENT_ID'],
                                  client_secret: ENV['SALESFORCE_CLIENT_SECRET'])
      dataloader.export(options[:query])
    end

    desc 'insert', 'Insert records'
    method_option :file, type: :string, aliases: ['-f']
    method_option :object, type: :string, aliases: ['-o']
    method_option :mapping, type: :string, aliases: ['-m']
    method_option :convert, type: :string, aliases: ['-C']
    method_option :config, type: :string, aliases: ['-c']
    def insert
      dataloader = Dataloader.new(username: ENV['SALESFORCE_USERNAME'],
                                  password: ENV['SALESFORCE_PASSWORD'],
                                  api_version: ENV['SALESFORCE_API_VERSION'],
                                  client_id: ENV['SALESFORCE_CLIENT_ID'],
                                  client_secret: ENV['SALESFORCE_CLIENT_SECRET'],
                                  mapping_file_path: options[:mapping],
                                  convert_file_path: options[:convert])
      dataloader.insert(options[:object], options[:file])
    end

    desc 'update', 'Update records'
    method_option :file, type: :string, aliases: ['-f']
    method_option :object, type: :string, aliases: ['-o']
    method_option :mapping, type: :string, aliases: ['-m']
    method_option :convert, type: :string, aliases: ['-C']
    method_option :config, type: :string, aliases: ['-c']
    def update
      dataloader = Dataloader.new(username: ENV['SALESFORCE_USERNAME'],
                                  password: ENV['SALESFORCE_PASSWORD'],
                                  api_version: ENV['SALESFORCE_API_VERSION'],
                                  client_id: ENV['SALESFORCE_CLIENT_ID'],
                                  client_secret: ENV['SALESFORCE_CLIENT_SECRET'],
                                  mapping_file_path: options[:mapping],
                                  convert_file_path: options[:convert])
      dataloader.update(options[:object], options[:file])
    end

    desc 'upsert', 'Upsert records'
    method_option :file, type: :string, aliases: ['-f']
    method_option :object, type: :string, aliases: ['-o']
    method_option :mapping, type: :string, aliases: ['-m']
    method_option :convert, type: :string, aliases: ['-C']
    method_option :upsert_key, type: :string, aliases: ['-k']
    method_option :config, type: :string, aliases: ['-c']
    def upsert
      dataloader = Dataloader.new(username: ENV['SALESFORCE_USERNAME'],
                                  password: ENV['SALESFORCE_PASSWORD'],
                                  api_version: ENV['SALESFORCE_API_VERSION'],
                                  client_id: ENV['SALESFORCE_CLIENT_ID'],
                                  client_secret: ENV['SALESFORCE_CLIENT_SECRET'],
                                  mapping_file_path: options[:mapping],
                                  convert_file_path: options[:convert])
      dataloader.upsert(options[:object], options[:upsert_key], options[:file])
    end

    desc 'delete', 'Delete records'
    method_option :file, type: :string, aliases: ['-f']
    method_option :object, type: :string, aliases: ['-o']
    method_option :config, type: :string, aliases: ['-c']
    def delete
      dataloader = Dataloader.new(username: ENV['SALESFORCE_USERNAME'],
                                  password: ENV['SALESFORCE_PASSWORD'],
                                  api_version: ENV['SALESFORCE_API_VERSION'],
                                  client_id: ENV['SALESFORCE_CLIENT_ID'],
                                  client_secret: ENV['SALESFORCE_CLIENT_SECRET'])
      dataloader.delete(options[:object], options[:file])
    end
  end
end
