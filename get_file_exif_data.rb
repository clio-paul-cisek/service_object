# frozen_string_literal: true

class GetFileExifData
  def initialize(file_path, directory)
    @file_path = file_path
    @directory = directory
  end

  def call
    exif_data_map(
      file_name: file_name,
      file_path: relative_path,
      exif_lat: exif_lat,
      exif_long: exif_long
    )
  rescue StandardError
    puts "Something went wrong please double check file: #{file_path}"
    exif_data_map(file_path: file_path)
  end

  private

  attr_reader :file_path, :directory

  def relative_path
    Pathname.new(file_path).relative_path_from(Pathname.new(directory)).to_s
  end

  def exif_data_map(file_name: nil, file_path: nil, exif_lat: nil, exif_long: nil)
    {
      name: file_name,
      path: file_path,
      lat: exif_lat,
      long: exif_long
    }
  end

  def exif_gps
    exif_data.gps || OpenStruct.new
  end

  def exif_long
    exif_gps.longitude
  end

  def exif_lat
    exif_gps.latitude
  end

  def exif_data
    @exif_data ||= ::EXIFR::JPEG.new(file_path)
  end

  def file_name
    @file_name ||= File.basename(file_path)
  end
end
