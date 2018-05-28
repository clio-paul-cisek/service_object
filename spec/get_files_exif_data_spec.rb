# frozen_string_literal: true

describe GetFilesExifData do
  subject { described_class.new(directory).call }

  context 'when directory provided' do
    context 'when it is not a valid directory' do
      let(:directory) { File.join(File.dirname(__FILE__), 'fixtures', 'bad_one') }
      let(:error_message) do
        "Invalid directory path: #{directory} please double check passed path"
      end

      it 'raises Exceptions::NotADirectory error' do
        expect { subject }.to raise_error(Exceptions::NotADirectory, error_message)
      end
    end

    context 'when it is valid directory' do
      let(:directory) { File.join(File.dirname(__FILE__), 'fixtures', 'gps_images', 'cats') }
      let(:expected_result) do
        [
          {
            name: 'image_e.jpg',
            path: 'image_e.jpg',
            lat: 59.92475507998271,
            long: 10.695598120067395
          }
        ]
      end

      it { is_expected.to eq(expected_result) }
    end
  end

  context 'when directory not provided' do
    let(:directory) { nil }
    # rubocop:disable Metrics/BlockLength
    let(:expected_result) do
      [
        {
          name: 'image_e.jpg',
          path: 'spec/fixtures/gps_images/cats/image_e.jpg',
          lat: 59.92475507998271,
          long: 10.695598120067395
        },
        {
          name: 'image_d.jpg',
          path: 'spec/fixtures/gps_images/image_d.jpg',
          lat: nil,
          long: nil
        },
        {
          name: 'image_b.jpg',
          path: 'spec/fixtures/gps_images/image_b.jpg',
          lat: nil,
          long: nil
        },
        {
          name: 'image_c.jpg',
          path: 'spec/fixtures/gps_images/image_c.jpg',
          lat: 38.4,
          long: -122.82866666666666
        },
        {
          name: 'image_a.jpg',
          path: 'spec/fixtures/gps_images/image_a.jpg',
          lat: 50.09133333333333,
          long: -122.94566666666667
        }
      ]
    end
    # rubocop:enable Metrics/BlockLength

    it { is_expected.to eq(expected_result) }
  end
end
