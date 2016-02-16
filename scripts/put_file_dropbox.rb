#!ruby

# This program posts a file to Dropbox using the provided .env
# filepath. The usage is as follows:
#
# put_file_dropbox.rb path/to/.env path/to/file

require 'dropbox_sdk'

module DotenvFile
  class Editor
    attr_reader :key_order
    attr_reader :path
    attr_reader :data

    def initialize(path = nil)
      data = {}
      keys_ordered = []
      ordered_keys = {}
      unless path.nil?
        read path
      end
    end

    def read_file(path = '.env')
      @path = path
      text = IO.read(path)
      @data = read_text text
      return self
    end

    def read_text(text = {})
      data = {}
      keys_ordered = []
      ordered_keys = {}
      text.split.each do |line|
        if line =~ /^\s*([^=]+)\s*=\s*(.+)\s*$/
          k = $1
          v = $2
          keys_ordered.push k
          ordered_keys[k] = 1
          data[k] = v
        end
      end
      @keys_ordered = keys_ordered
      @ordered_keys = ordered_keys
      @data = data
    end

    def write(path = '.env')
      lines = []
      @keys_ordered.each do |key|
        if @data.key? key
          lines.push build_line(key, @data[key])
        end
      end

      @data.keys.sort.each do |key|
        unless @ordered_keys.key? key
          lines.push build_line(key, @data[key])
        end
      end

      File.open(path, 'w') do |fh|
        lines.each { |line| fh.puts line }
      end
    end

    def build_line(k, v)
      "#{k}=#{v}"
    end

    alias_method :read, :read_file
  end
end

def put_file(envpath, filepath_local)
  dotenv = DotenvFile::Editor.new.read envpath

  access_token = dotenv.data['DROPBOX_ACCESS_TOKEN']
  client = DropboxClient.new access_token

  file_local = open filepath_local
  filepath_remote = File.basename filepath_local
  response = client.put_file filepath_remote, file_local
  puts 'uploaded: ', response.inspect
end

envpath = ARGV[0].to_s
filepath = ARGV[1].to_s

if File.exists?(envpath) && File.exists?(filepath.to_s)
  put_file(envpath, filepath)
elsif envpath.to_s.length > 0 || filepath.to_s.length > 0
  puts "file not found: #{filepath}"
  puts 'usage: put_file_dropbox.rb path/to/.env path/to/file'
  puts 'example: put_file_dropbox.rb ../app/.env test_file.pdf'
else
  puts 'usage: put_file_dropbox.rb path/to/.env path/to/file'
  puts 'example: put_file_dropbox.rb ../app/.env test_file.pdf'
end

puts 'DONE'
