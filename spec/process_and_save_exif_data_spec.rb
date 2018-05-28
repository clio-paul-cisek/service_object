# frozen_string_literal: true

describe(ProcessAndSaveExifData) do
  subject { described_class.new.call }

  let(:file_path) { File.join(File.dirname(__FILE__), '..', file_name) }
  let(:fixture_path) { File.join(File.dirname(__FILE__), 'fixtures', file_name) }

  before do
    stub_const('ARGV', argv)
  end

  after do
    File.delete(file_path) if File.exist?(file_path)
  end

  context 'when no args' do
    let(:argv) { [] }
    let(:file_name) { 'exif_data.csv' }

    it 'scans script directory recursively and saves found data to csv file' do
      subject
      expect(File.exist?(file_path)).to eq(true)
      expect(File.open(file_path, 'rb').read).to eq(File.open(fixture_path, 'rb').read)
    end
  end

  context 'when --output option present' do
    context 'when csv' do
      let(:argv) { ['--output', 'csv'] }
      let(:file_name) { 'exif_data.csv' }

      it 'scans script directory recursively and saves found data to csv file' do
        subject
        expect(File.exist?(file_path)).to eq(true)
        expect(File.open(file_path, 'rb').read).to eq(File.open(fixture_path, 'rb').read)
      end
    end

    context 'when html' do
      let(:argv) { ['--output', 'html'] }
      let(:file_name) { 'exif_data.html' }

      it 'scans script directory recursively and saves found data to html file' do
        subject
        expect(File.exist?(file_path)).to eq(true)
        expect(File.open(file_path, 'rb').read).to eq(File.open(fixture_path, 'rb').read)
      end
    end
  end

  context 'when help or invalid option present' do
    let(:file_name) { 'exif_data.csv' }
    let(:help_message) do
      <<~HELP_MESSAGE
        Usage: app [options] [directory_to_scan]
        options:
                --output [OUTPUT]            Select output raport type (csv, html). CSV is default option
            -h, --help                       Shows available options
              HELP_MESSAGE
    end

    context 'when -h' do
      let(:argv) { %w[-h] }
      it 'raises SystemExit and outputs app description' do
        expect { subject }.to raise_error(SystemExit).and output(help_message).to_stdout
      end
    end
    context 'when --help' do
      let(:argv) { %w[--help] }
      it 'raises SystemExit and outputs app description' do
        expect { subject }.to raise_error(SystemExit).and output(help_message).to_stdout
      end
    end
    context 'when --wrong' do
      let(:argv) { %w[--wrong] }
      it 'raises SystemExit and outputs app description' do
        expect { subject }.to raise_error(SystemExit).and output(help_message).to_stdout
      end
    end
  end

  context 'when custom path present' do
    let(:directory) { File.join(File.dirname(__FILE__), 'fixtures', 'gps_images', 'cats') }
    let(:argv) { [directory] }
    let(:file_name) { 'exif_data.csv' }
    let(:fixture_path) { File.join(File.dirname(__FILE__), 'fixtures', 'cats_exif_data.csv') }

    it 'scans script directory recursively and saves found data to csv file' do
      subject
      expect(File.exist?(file_path)).to eq(true)
      expect(File.open(file_path, 'rb').read).to eq(File.open(fixture_path, 'rb').read)
    end

    context 'when path is not a valid directory path' do
      let(:directory) { './non_existing_dir' }
      let(:argv) { [directory] }
      let(:file_name) { 'exif_data.csv' }
      let(:expected_error) { Exceptions::NotADirectory.new(directory) }
      let(:error_message) { "#{expected_error}\n" }

      it 'prints to stdout error message' do
        expect { subject }.to output(error_message).to_stdout
      end
    end
  end
end
