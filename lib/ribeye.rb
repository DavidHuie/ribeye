require 'httpclient'
require 'ribeye/bloom_filter'

class Ribeye

  # Response codes
  TRUE_VALUE = 't'
  FALSE_VALUE = 'f'
  SUCCESS = '0'
  INVALID_PARAMETER_VALUE = '1'
  INVALID_PARAMETERS = '2'
  BLOOM_FILTER_EXISTS = '3'
  BLOOM_FILTER_DOES_NOT_EXIST = '4'

  # Response code exceptions
  class InvalidParameterValue < StandardError; end
  class InvalidParameters < StandardError; end
  class NonExistentBF < StandardError; end
  class BFExists < StandardError; end

  attr_accessor :uri, :client

  def initialize(uri = nil)
    @uri = uri || 'http://localhost:8080'
    @client = HTTPClient.new
  end

  def parse_errors(body)
    case body
    when INVALID_PARAMETER_VALUE
      raise InvalidParameterValue
    when INVALID_PARAMETERS
      raise InvalidParameters
    when BLOOM_FILTER_EXISTS
      raise BFExists
    when BLOOM_FILTER_DOES_NOT_EXIST
      raise NonExistentBF
    end
  end

  def make_request(path, success_value, params)
    response = client.get(URI.join(uri, path), params)
    parse_errors(response.body)
    response.body == success_value
  end

  def create(name, size)
    make_request('/create', SUCCESS, name: name, size: size)
  end

  def delete(name)
    make_request('/delete', SUCCESS, name: name)
  end

  def exists(name)
    make_request('/exists', TRUE_VALUE, name: name)
  end

  def insert(name, value)
    make_request('/insert', SUCCESS, name: name, value: value)
  end

  def check(name, value)
    make_request('/check', TRUE_VALUE, name: name, value: value)
  end

end
