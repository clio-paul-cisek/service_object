# frozen_string_literal: true

class GetFilesExifData
  def initialize(directory)
    @directory = directory || File.dirname(__FILE__)
  end

  def call
    raise Exceptions::NotADirectory, directory unless Dir.exist?(directory)
    file_paths.map do |file_path|
      GetFileExifData.new(file_path, directory).call
    end
  end

  private

  attr_reader :directory

  def file_paths
    @file_paths ||= Dir.glob(directory_to_scan)
  end

  def directory_to_scan
    @directory_to_scan ||= File.join(directory, '**', '*.jpg')
  end
end
