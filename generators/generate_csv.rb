# frozen_string_literal: true

module Generators
  class GenerateCsv
    def initialize(data, headers)
      @data = data
      @headers = headers
    end

    def call
      ::CSV.open(file_to_save, 'wb') do |csv|
        push_data_row_to_csv(csv, headers)
        push_data_to_csv(csv)
      end
    end

    private

    attr_reader :data, :headers

    def push_data_row_to_csv(csv, data_row)
      csv << data_row
    end

    def push_data_to_csv(csv)
      data.each do |data_row|
        push_data_row_to_csv(csv, data_row.values)
      end
    end

    def file_to_save
      File.join('.', 'exif_data.csv')
    end
  end
end
