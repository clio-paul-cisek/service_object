# frozen_string_literal: true

class GenerateFileOutput
  def initialize(data, output)
    @data = data
    @output = output
  end

  def call
    if data.empty?
      puts 'No data to be saved!'
      return
    end
    generator.new(data, headers).call
  end

  private

  attr_reader :data, :output

  def headers
    data.first.keys
  end

  def generator
    available_generators[output] || default_generator
  end

  def default_generator
    available_generators[:csv]
  end

  def available_generators
    {
      html: Generators::GenerateHtml,
      csv: Generators::GenerateCsv
    }
  end
end
