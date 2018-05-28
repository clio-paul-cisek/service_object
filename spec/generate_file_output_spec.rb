# frozen_string_literal: true

describe GenerateFileOutput do
  subject { described_class.new(data, argument_output).call }

  context 'when data is empty' do
    let(:data) { [] }
    let(:argument_output) { 'nvm' }
    let(:output_message) { "No data to be saved!\n" }

    it 'outputs message to stdout' do
      expect { subject }.to output(output_message).to_stdout
    end
  end

  context 'when data is present' do
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

    after do
      File.delete(file_path) if File.exist?(file_path)
    end

    context 'when output is valid' do
      context 'when csv' do
        let(:file_path) { File.join(File.dirname(__FILE__), '..', 'exif_data.csv') }
        let(:fixture_path) { File.join(File.dirname(__FILE__), 'fixtures', 'csv_exif_data.csv') }
        let(:argument_output) { :csv }

        it 'creates exif_data.csv file with provided data' do
          subject
          expect(File.exist?(file_path)).to eq(true)
          expect(File.open(file_path, 'rb').read).to eq(File.open(fixture_path, 'rb').read)
        end
      end

      context 'when html' do
        let(:file_path) { File.join(File.dirname(__FILE__), '..', 'exif_data.html') }
        let(:fixture_path) { File.join(File.dirname(__FILE__), 'fixtures', 'html_exif_data.html') }
        let(:argument_output) { :html }

        it 'creates exif_data.html file with provided data' do
          subject
          expect(File.exist?(file_path)).to eq(true)
          expect(File.open(file_path, 'rb').read).to eq(File.open(fixture_path, 'rb').read)
        end
      end
    end

    context 'when output is invalid' do
      let(:file_path) { File.join(File.dirname(__FILE__), '..', 'exif_data.csv') }
      let(:fixture_path) { File.join(File.dirname(__FILE__), 'fixtures', 'csv_exif_data.csv') }
      let(:argument_output) { 'nvm' }

      it 'creates exif_data.csv file with provided data' do
        subject
        expect(File.exist?(file_path)).to eq(true)
        expect(File.open(file_path, 'rb').read).to eq(File.open(fixture_path, 'rb').read)
      end
    end
  end
end
