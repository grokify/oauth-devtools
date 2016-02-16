#!ruby

require 'dotenv'
require 'dropbox_sdk'
require 'multi_json'
require 'sinatra'

Dotenv.load

DROPBOX_APP_KEY = ENV['DROPBOX_APP_KEY']
DROPBOX_APP_SECRET = ENV['DROPBOX_APP_SECRET']
DROPBOX_OAUTH2_REDIRECT_URI = ENV['DROPBOX_OAUTH2_REDIRECT_URI']
DROPBOX_CSRF_TOKEN_SESSION_KEY = :dropbox_auth_csrf_token

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
  end
end

def dotenv_add(params = {})
  dotenvfile = DotenvFile::Editor.new.read_file
  params.each { |k,v| dotenvfile.data[k] = v }
  dotenvfile.write
end

def get_dropbox_oauth2_flow(session, csrf_token_session_key = :dropbox_auth_csrf_token)
  flow = DropboxOAuth2Flow.new(
    DROPBOX_APP_KEY,
    DROPBOX_APP_SECRET,
    DROPBOX_OAUTH2_REDIRECT_URI,
    session,
    csrf_token_session_key)
end

get '/' do
  session = {}
  flow = get_dropbox_oauth2_flow(session)

  dotenv_add('DROPBOX_AUTH_CSRF_TOKEN' => session[DROPBOX_CSRF_TOKEN_SESSION_KEY])

  erb :index, locals: {
    dropbox_app_key: DROPBOX_APP_KEY,
    dropbox_app_secret: DROPBOX_APP_SECRET,
    dropbox_oauth2_redirect_uri: DROPBOX_OAUTH2_REDIRECT_URI,
    dropbox_authorize_uri: flow.start()
  }
end

get '/authorize' do
  flow = DropboxOAuth2Flow.new(DROPBOX_APP_KEY, DROPBOX_APP_SECRET)
  authorize_url = flow.start()
  redirect authorize_url
end

get '/oauth_redirect_dropbox' do
  code = params['code'] || ''
  token_json = ''
  if code
    dotenv_add(
      'DROPBOX_AUTHORIZATION_CODE' => code,
      'DROPBOX_REDIRECT_PARAMS' => MultiJson.encode(params))

    session = {DROPBOX_CSRF_TOKEN_SESSION_KEY => params['state'] || ''}

    flow = get_dropbox_oauth2_flow(session)
    access_token, user_id = flow.finish(params)

    dotenv_add(
      'DROPBOX_ACCESS_TOKEN' => access_token,
      'DROPBOX_USER_ID' => user_id)
  end

  erb :oauth, locals: {
    code: code,
    token: access_token
  }
end
