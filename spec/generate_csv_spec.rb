# frozen_string_literal: true

describe Generators::GenerateCsv do
  subject { described_class.new(data, headers).call }

  let(:data) do
    [
      {
        first_header: 'test',
        second_header: 'test2'
      },
      {
        first_header: 'test3',
        second_header: 'test4'
      }
    ]
  end
  let(:headers) { %w[first_header second_header] }
  let(:file_path) { File.join(File.dirname(__FILE__), '..', 'exif_data.csv') }
  let(:fixture_path) { File.join(File.dirname(__FILE__), 'fixtures', 'csv_exif_data.csv') }

  after do
    File.delete(file_path) if File.exist?(file_path)
  end

  it 'creates exif_data.csv file with provided data and headers' do
    subject
    expect(File.exist?(file_path)).to eq(true)
    expect(File.open(file_path, 'rb').read).to eq(File.open(fixture_path, 'rb').read)
  end
end
