#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'csv'
require 'erb'
require 'exifr/jpeg'
require 'ostruct'
require 'pathname'

require './exceptions'
require './get_options'
require './generators/generate_csv'
require './generators/generate_html'
require './generate_file_output'
require './get_files_exif_data'
require './get_file_exif_data'
require './process_and_save_exif_data'

ProcessAndSaveExifData.new.call
