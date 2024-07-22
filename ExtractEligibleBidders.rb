require 'nokogiri'
require 'yaml'
require 'logger'
require 'byebug'

THRESHOLD = 1000
DIRECTORY = 'fragment_investors_data'
OUTPUT_FILE = 'eligible_bidders.yml'
LOG_FILE = 'script.log'

# Initialize logger
logger = Logger.new(LOG_FILE)


def extract_eligible_bidders(logger)
  eligible_bidders = []

  Dir.glob("#{DIRECTORY}/*.html").each do |file|
    begin
      html = File.read(file)
      doc = Nokogiri::HTML(html)

      # Extract bids from the HTML
      doc.css('.message.default').each do |message|
        bid_info = {}

        # Extract bid number
        bid_number = message.at_css('strong:contains("Bid")')&.next_element&.text&.strip
        bid_info[:number] = bid_number if bid_number

        # Extract price
        price = message.at_css('code')&.text&.strip
        bid_info[:price] = price.to_i if price && price.match?(/^\d+$/) # Convert to integer if valid

        # Extract bidder information
        bidder_element = message.at_css('a[href*="tonviewer.com"]')
        if bidder_element
          bid_info[:bidder] = {
            name: bidder_element.text.strip,
            url: bidder_element['href']
          }
        end

        # Extract ad information
        ad_element = message.at_css('a[href*="fragment.com/username"]')
        ad_seller_element = message.at_css('a[href*="t.me/"]')
        if ad_element && ad_seller_element
          bid_info[:ad] = {
            seller: ad_seller_element.text.strip,
            link: ad_element['href']
          }
        end

        # Add to eligible bidders if price exceeds threshold
        if bid_info[:price] && bid_info[:price] >= THRESHOLD
          eligible_bidders << bid_info
        end
      end

    rescue => e
      logger.error("Error processing file #{file}: #{e.message}")
    end
  end

  # Write eligible bidders to YAML file
  File.open(OUTPUT_FILE, 'w') do |file|
    file.write(eligible_bidders.to_yaml)
  end

  logger.info("Eligible bidders have been successfully extracted and saved to #{OUTPUT_FILE}.")
end


extract_eligible_bidders(logger)
