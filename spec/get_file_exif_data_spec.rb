# frozen_string_literal: true

describe GetFileExifData do
  subject { described_class.new(file_path, directory).call }

  let(:file_path) { File.join(directory, file_name) }
  let(:directory) { File.join(File.dirname(__FILE__), 'fixtures', 'gps_images') }
  let(:relative_path) { Pathname.new(file_path).relative_path_from(Pathname.new(directory)).to_s }
  context 'when unexpected error occurred' do
    let(:file_name) { 'non_existing.jpg' }
    let(:expected_result) do
      {
        lat: nil,
        long: nil,
        name: nil,
        path: file_path
      }
    end
    let(:error_message) { "Something went wrong please double check file: #{file_path}\n" }

    it 'returns default value and writes message to stdout' do
      expect { expect(subject).to eq(expected_result) }.to output(error_message).to_stdout
    end
  end

  context 'when file data was read' do
    context 'when gps data does not exist' do
      let(:file_name) { 'image_d.jpg' }
      let(:expected_result) do
        {
          lat: nil,
          long: nil,
          name: file_name,
          path: relative_path
        }
      end

      it { is_expected.to eq(expected_result) }
    end

    context 'when gps data does exist' do
      let(:file_name) { 'image_a.jpg' }
      let(:expected_result) do
        {
          lat: 50.09133333333333,
          long: -122.94566666666667,
          name: file_name,
          path: relative_path
        }
      end

      it { is_expected.to eq(expected_result) }
    end
  end
end
