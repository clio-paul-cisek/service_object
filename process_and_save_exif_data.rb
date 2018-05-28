# frozen_string_literal: true

class ProcessAndSaveExifData
  def initialize
    @options ||= GetOptions.new.call
  end

  def call
    GenerateFileOutput.new(exif_files_data, options[:output]).call
  rescue Exceptions::NotADirectory => error
    puts error
  end

  private

  attr_reader :options

  def exif_files_data
    @exif_files_data ||= GetFilesExifData.new(directory).call
  end

  def directory
    ARGV.first
  end
end
