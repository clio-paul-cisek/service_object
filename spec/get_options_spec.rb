# frozen_string_literal: true

describe GetOptions do
  subject { described_class.new.call }

  before do
    stub_const('ARGV', argv)
  end
  context 'when no options provided' do
    let(:argv) { [] }
    let(:expected_result) { {} }

    it { is_expected.to eq(expected_result) }
  end

  context 'when options provided' do
    context 'when --output' do
      let(:argv) { %w[--output html] }
      let(:expected_result) { { output: :html } }

      it { is_expected.to eq(expected_result) }
    end
    context 'when help or invalid' do
      let(:help_message) do
        <<~HELP_MESSAGE
          Usage: app [options] [directory_to_scan]
          options:
                  --output [OUTPUT]            Select output raport type (csv, html). CSV is default option
              -h, --help                       Shows available options
                HELP_MESSAGE
      end

      context 'when invalid --wrong' do
        let(:argv) { %w[--wrong] }

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

      context 'when -h' do
        let(:argv) { %w[-h] }

        it 'raises SystemExit and outputs app description' do
          expect { subject }.to raise_error(SystemExit).and output(help_message).to_stdout
        end
      end
    end
  end
end
