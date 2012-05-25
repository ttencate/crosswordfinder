require 'sinatra/base'
require 'singleton'

class Finder
  include Singleton

  def initialize
    lists_dir = File.dirname(__FILE__)
    language_files = Dir.glob(File.join(lists_dir, '*.list'))
    @languages = {}
    language_files.each do |language_file|
      puts "Loading #{language_file}..."
      key = File.basename(language_file, '.list')
      language = {}
      @languages[key] = language
      File.open(language_file).each do |line|
        line.strip!
        len = line.length
        language[len] ||= []
        language[len] << line
      end
      print_hist(key)
    end
  end

  def languages
    @languages.keys
  end

  def find(language, pattern)
    pattern.downcase!
    return [] unless /^[a-z.]+$/.match(pattern)
    return [] unless @languages[language]
    return [] unless @languages[language][pattern.length]
    regexp = Regexp.new("^#{pattern}$")
    return @languages[language][pattern.length].select do |word|
      regexp.match(word)
    end
  end

  private

  def print_hist(language)
    hist = @languages[language].to_a
    hist.map! { |kv| [kv[0], kv[1].length] }
    hist.sort!
    hist.each do |kv|
      printf "%2d  %6d\n", kv[0], kv[1]
    end
    printf "++  %6d\n", hist.map { |kv| kv[1] }.inject(0, :+)
  end
end

class CrosswordFinder < Sinatra::Base
  get '/' do
    l = params['l']
    q = params['q']
    if l and q
      results = Finder.instance.find(l, q)
    else
      results = nil
    end

    liquid :index, :locals => {
      :l => l,
      :q => q,
      :languages => Finder.instance.languages,
      :results => results
    }
  end
end
