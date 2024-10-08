# Fragment Bidder Extractor

This script extracts bidders with a bid of whatever is assigned in THRESHOLD or more from HTML files located in the `fragment_bid_data` directory.

## Setup Instructions

### Prerequisites

- Ruby 3.1.0 installed
- RVM (Ruby Version Manager) installed

### Steps

## Getting Started

1. Clone the repository:
    ```sh
    git clone https://github.com/samzhab/fragment_investors_extractor.git
    ```
2. Crete a Gemset:
    ```sh
    rvm 3.1.0@fragment_investors_extract --create
    ```

3. Install dependencies:
    ```sh
    bundle install
    ```

4. Create necessary directories
    ```sh
    mkdir fragment_bid_data
    mkdir fragment_search_data
    ```

5. Place HTML files - Go to https://t.me/Fragment_Monitor and https://t.me/https://t.me/fragmentanalytics and extract the chats and Place your HTML files containing auction bidding data into the fragment_bid_data directory and search analytic into fragment_search_data.

6. Run the script - The script will generate an eligible_bidders.yml file containing the bidders with a balance of 1000 TON or more.

    ```sh
    ruby ExtractEligibleBidders.rb
    ```
and
    ```sh
    ruby ExtractFrequentSearchers.rb
    ```

 ## License
 This work is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/).

 ![CC BY-SA 4.0](https://i.creativecommons.org/l/by-sa/4.0/88x31.png)

 Attribution: This project is published by Samael (AI Powered), 2024.

 You are free to:
 - Share — copy and redistribute the material in any medium or format
 - Adapt — remix, transform, and build upon the material for any purpose, even commercially.
 Under the following terms:
 - Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
 - ShareAlike — If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original.

 No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.

 Notices:
 You do not have to comply with the license for elements of the material in the public domain or where your use is permitted by an applicable exception or limitation.

 No warranties are given. The license may not give you all of the permissions necessary for your intended use. For example, other rights such as publicity, privacy, or moral rights may limit how you use the material.
