EXIF extractor
================
App.rb is a script which allows user to retrieve **EXIF GPS** information from files with `.jpg` extension and save them to either `.csv` or `.html` format.

## NOTE: For the sake of demo script has been split into separate files.

## Setup
Install required gems
```
bundle install --without test development
```
and run help command to check options:
```
app.rb --help
Usage: app [options] [directory_to_scan]
options:
        --output [OUTPUT]            Select output raport type (csv, html). CSV is default option
    -h, --help                       Shows available options
```

## Usage
Example usage
```
./app.rb --output html './spec/fixtures/gps_images/cats'
```
This command will generate `./exif_data.html` file which contains all `*.jpg` exif gps data in given directory. (goes down directory recursively) If **[directory_to_scan]** is not provided script will default to `.` and starting directory.

## Test
For testing purpose `gem 'rspec'` is used. To run tests install needed gems.
```
bundle install --without development
bundle exec rspec
```

## Code quality
For keeping high code quality `gem 'rubocop'` is used. To check and verify code install needed gems and run check.
```
bundle install --without test
bundle exec rubocop
```

