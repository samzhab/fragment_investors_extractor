require 'nokogiri'
require 'yaml'
require 'logger'
require 'byebug'

DIRECTORY = 'fragment_search_data'
OUTPUT_FILE = 'frequent_searchers.yml'
LOG_FILE = 'script.log'
THRESHOLD = 10

# Initialize logger
logger = Logger.new(LOG_FILE)

def extract_frequent_searchers(logger)
  search_data = Hash.new { |hash, key| hash[key] = Hash.new(0) }  # Nested hash with default value 0

  Dir.glob("#{DIRECTORY}/*.html").each do |file|
    begin
      html = File.read(file)
      doc = Nokogiri::HTML(html)

      doc.css('div.text').each do |div|
        # Attempt to extract data from the newer format
        searched_for = div.at('strong:contains("Report on") + a')&.text&.strip
        searched_by = div.at('strong:contains("for") + a')&.text&.strip

        # If newer format isn't found, use regex to handle the older format
        unless searched_for && searched_by
          # Extract the first link in the div for 'searched_by'
          searched_by = div.css('a')[0]&.text&.strip
          # Extract the second link in the div for 'searched_for'
          searched_for = div.css('a')[1]&.text&.strip
        end

        # Only proceed if both searched_for and searched_by are present
        if searched_for && searched_by
          search_data[searched_by][searched_for] += 1
        end
      end

    rescue => e
      logger.error("Error processing file #{file}: #{e.message}")
    end
  end

  # Filter users who searched for more than THRESHOLD unique usernames
  frequent_searchers = search_data.select do |searcher, targets|
    targets.keys.size >= THRESHOLD
  end

  # Write eligible searchers to YAML file
  File.open(OUTPUT_FILE, 'w') do |file|
    file.write(frequent_searchers.to_yaml)
  end

  logger.info("Frequent Searchers have been successfully extracted and saved to #{OUTPUT_FILE}.")
end

extract_frequent_searchers(logger)
