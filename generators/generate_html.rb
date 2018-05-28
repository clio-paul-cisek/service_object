# frozen_string_literal: true

module Generators
  class GenerateHtml
    # rubocop:disable Metrics/LineLength
    HTML_TEMPLATE = %(
      <!DOCTYPE html>
      <html lang="en">
      <head>
        <title>Exif Data</title>
        <meta charset="utf-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
      </head>
      <body>
        <div class="container">
          <table class="table table-striped">
            <thead>
              <tr>
                <% @headers.each do |header| %>
                  <th scope="col"><%= header %></th>
                <% end %>
              </tr>
            </thead>
            <tbody>
              <% @data.each do |data_row| %>
                <tr>
                  <% data_row.values.each do |data_row_value| %>
                    <td> <%= data_row_value %> </td>
                  <% end %>
                </tr>
              <% end %>
            </tbody>
          </table>
        </div>
      </body>
      </html>
          )
    # rubocop:enable Metrics/LineLength
    private_constant :HTML_TEMPLATE

    def initialize(data, headers)
      @data = data
      @headers = headers
    end

    def call
      File.open(file_to_save, 'w+') do |f|
        f.write(render)
      end
    end

    private

    attr_reader :data

    def file_to_save
      File.join('.', 'exif_data.html')
    end

    def render
      ::ERB.new(HTML_TEMPLATE).result(binding)
    end
  end
end
