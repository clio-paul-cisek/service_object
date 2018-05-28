# frozen_string_literal: true

describe Exceptions::NotADirectory do
  let(:path) { './some_path' }
  let(:error_message) do
    "Invalid directory path: #{path} please double check passed path"
  end
  it 'generates correct error message' do
    expect { raise(Exceptions::NotADirectory, path) }.to(
      raise_error(Exceptions::NotADirectory, error_message)
    )
  end
end
