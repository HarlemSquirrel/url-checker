require_relative '../config/environment'

class URLChecker
  attr_reader :file_path

  def initialize(file_path:)
    @file_path = file_path
  end

  def call
    @results = [['Response', 'URL']]
    @num_issues = 0
    check_urls_from_csv
    display_summary
    write_results
  end

  def self.call
    if ARGV.length == 1 && ARGV.first.match?(/\.csv\z/)
      new(file_path: ARGV.first).call
    else
      puts 'Please call with one CSV file with URLs in the first column'.red
    end
  end

  private

  attr_accessor :num_issues, :results

  def check_url(url)
    uri = URI(url)
    response = Net::HTTP.get_response uri
    collect_result response, url
    display_result response, url
  end

  def check_urls_from_csv
    CSV.foreach(file_path) do |row|
      url = row[0]
      check_url url if url.match? /http/
    end
  end

  def collect_result(response, url)
    line = ["#{response.code} #{response.message}", url]
    results << line
  end

  def display_result(response, url)
    msg =  " #{response.code} #{response.message} #{url}"
    case response
    when Net::HTTPSuccess, Net::HTTPRedirection
      puts msg.green
    else
      @num_issues += 1
      puts msg.red
    end
  end

  def display_summary
    num_checked = results.length - 1
    msg = "  #{num_checked} URLs checked with #{num_issues} issue(s)."
    num_issues > 0 ? puts(msg.yellow) : puts(msg.green)
  end

  def write_results
    time = Time.now.strftime('%Y-%m-%d-%H:%M:%S')
    results_file_path = file_path.gsub('.csv', "_results_#{time}.csv")
    puts "  Results saved to #{results_file_path}"
    CSV.open(results_file_path, "wb") do |csv|
      results.each { |r| csv << r }
    end
  end
end
