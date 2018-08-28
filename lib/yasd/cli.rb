# frozen_string_literal: true

require 'thor'
require 'yaml'
require 'yasd/dataloader'

module Yasd
  class CLI < Thor
    desc 'load', 'Load to Salesforce with local file'
    method_option :query, type: :string, aliases: ['-q']
    method_option :config, type: :string, aliases: ['-c']
    method_option :username, type: :string, aliases: ['-u'], default: ENV['SALESFORCE_USERNAME']
    method_option :password, type: :string, aliases: ['-p'], default: ENV['SALESFORCE_PASSWORD']
    method_option :api_version, type: :string, default: ENV['SALESFORCE_API_VERSION']
    def export
      config = create_config(options.config)
      dataloader = Dataloader.new(config)
      dataloader.export(config.query)
    end

    desc 'insert', 'Insert records'
    method_option :file, type: :string, aliases: ['-f']
    method_option :object, type: :string, aliases: ['-o']
    method_option :config, type: :string, aliases: ['-c']
    method_option :mapping, type: :string, aliases: ['-m']
    method_option :convert, type: :string, aliases: ['-C']
    method_option :username, type: :string, aliases: ['-u'], default: ENV['SALESFORCE_USERNAME']
    method_option :password, type: :string, aliases: ['-p'], default: ENV['SALESFORCE_PASSWORD']
    method_option :api_version, type: :string, default: ENV['SALESFORCE_API_VERSION']
    def insert
      config = create_config(options.config)
      dataloader = Dataloader.new(config)
      dataloader.insert(config.object, config.file)
    end

    desc 'update', 'Update records'
    method_option :file, type: :string, aliases: ['-f']
    method_option :object, type: :string, aliases: ['-o']
    method_option :config, type: :string, aliases: ['-c']
    method_option :mapping, type: :string, aliases: ['-m']
    method_option :convert, type: :string, aliases: ['-C']
    method_option :username, type: :string, aliases: ['-u'], default: ENV['SALESFORCE_USERNAME']
    method_option :password, type: :string, aliases: ['-p'], default: ENV['SALESFORCE_PASSWORD']
    method_option :api_version, type: :string, default: ENV['SALESFORCE_API_VERSION']
    def update
      config = create_config(options.config)
      dataloader = Dataloader.new(config)
      dataloader.update(config.object, config.file)
    end

    desc 'upsert', 'Upsert records'
    method_option :file, type: :string, aliases: ['-f']
    method_option :object, type: :string, aliases: ['-o']
    method_option :upsert_key, type: :string, aliases: ['-k']
    method_option :mapping, type: :string, aliases: ['-m']
    method_option :convert, type: :string, aliases: ['-C']
    method_option :config, type: :string, aliases: ['-c']
    method_option :username, type: :string, aliases: ['-u'], default: ENV['SALESFORCE_USERNAME']
    method_option :password, type: :string, aliases: ['-p'], default: ENV['SALESFORCE_PASSWORD']
    method_option :api_version, type: :string, default: ENV['SALESFORCE_API_VERSION']
    def upsert
      config = create_config(options.config)
      dataloader = Dataloader.new(config)
      dataloader.upsert(config.object, config.upsert_key, config.file)
    end

    desc 'delete', 'Delete records'
    method_option :file, type: :string, aliases: ['-f']
    method_option :object, type: :string, aliases: ['-o']
    method_option :config, type: :string, aliases: ['-c']
    method_option :username, type: :string, aliases: ['-u'], default: ENV['SALESFORCE_USERNAME']
    method_option :password, type: :string, aliases: ['-p'], default: ENV['SALESFORCE_PASSWORD']
    method_option :api_version, type: :string, default: ENV['SALESFORCE_API_VERSION']
    def delete
      config = create_config(options.config)
      dataloader = Dataloader.new(config)
      dataloader.delete(config.object, config.file)
    end

    private

    def create_config(filepath)
      config = YAML.load_file(filepath)
      options.merge(config)
    end
  end
end
