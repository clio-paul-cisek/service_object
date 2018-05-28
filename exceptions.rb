# frozen_string_literal: true

module Exceptions
  class NotADirectory < StandardError
    def initialize(path)
      super(custom_message(path))
    end

    private

    def custom_message(path)
      "Invalid directory path: #{path} please double check passed path"
    end
  end
end
