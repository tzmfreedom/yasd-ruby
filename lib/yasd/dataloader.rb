# frozen_string_literal: true

require 'csv'
require 'yaml'
require 'soapforce'
require 'yasd/mapper'
require 'yasd/converter'

module Yasd
  class Dataloader
    attr_accessor :client

    BATCH_SIZE = 400

    def initialize(config)
      @client = Soapforce::Client.new
      @client.authenticate(username: config.username, password: config.password)
      @success_logger = Logger.new(config.success_log_path || "./results/#{Time.now.strftime("%Y-%m-%d")}_success.log")
      @error_logger = Logger.new(config.success_log_path || "./results/#{Time.now.strftime("%Y-%m-%d")}_error.log")
      @mapper = Mapper.new(config.mapping)
      @converter = Converter.new(config.convert)
      @batch_size = config.batch_size || BATCH_SIZE
    end

    def export(query)
      query_result = client.query(query)
      return if query_result.size == 0

      CSV do |csv_out|
        header = create_csv_header(query_result)
        csv_out << header

        query_result.each do |record|
          csv_out << header.map {|field| record[field] }
        end
      end
    end

    def insert(object, filename)
      insert_records = []
      total_record_size = 0

      CSV.foreach(filename, headers: true) do |data|
        total_record_size += 1
        insert_records << convert_and_mapping(data)
        if insert_records.length == @batch_size
          insert_results = client.create!(object, insert_records)
          log(insert_results)
          insert_records = []
        end
      end
      if insert_records.length > 0
        insert_results = client.create!(object, insert_records)
        log(insert_results)
      end
    end

    def update(object, filename)
      update_records = []
      total_record_size = 0

      CSV.foreach(filename, headers: true) do |data|
        total_record_size += 1
        update_records << convert_and_mapping(data)
        if update_records.length == @batch_size
          update_results = client.update(object, update_records)
          log(update_results)
          update_records = []
        end
      end
      if update_records.length > 0
        update_results = client.update(object, update_records)
        log(update_results)
      end
    end

    def delete(object, filename)
      delete_records = []
      total_record_size = 0

      CSV.foreach(filename, headers: true) do |data|
        total_record_size += 1
        delete_records << data[:Id]
        if delete_records.length == @batch_size
          delete_results = client.delete(object, delete_records)
          log(delete_results)
          delete_records = []
        end
      end
      if delete_records.length > 0
        delete_results = client.delete(object, delete_records)
        log(delete_results)
      end
    end

    def upsert(object, upsert_key, filename)
      upsert_records = []
      total_record_size = 0

      CSV.foreach(filename, headers: true) do |data|
        total_record_size += 1
        upsert_records << convert_and_mapping(data)
        if upsert_records.length == @batch_size
          upsert_results = client.upsert(object, upsert_key, upsert_records)
          log(upsert_results)
          upsert_records = []
        end
      end
      if upsert_records.length > 0
        upsert_results = client.upsert(object, upsert_key, upsert_records)
        log(upsert_results)
      end
    end

    private

    def log(results)
      results.each do |result|
        if result[:success]
          @success_logger.info(result.values.join(','))
        else
          @error_logger.info(result.values.join(','))
        end
      end
    end

    def convert_and_mapping(data)
      converted_data = @converter.call(data)
      @mapper.call(converted_data)
    end

    def create_csv_header(query_result)
      query_result.first.to_h.reject {|k, _v| %i[type @xsi:type].include?(k) }.keys
    end
  end
end
