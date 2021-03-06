require 'rspec_api_documentation'
require 'api_documentation_helper'

require 'carrierwave'

RspecApiDocumentation.configure do |config|
  config.request_headers_to_include = %w(Content-Type Cookie)
  config.response_headers_to_include = %w(Content-Type Set-Cookie)
  config.request_body_formatter = :json
  config.api_name = "more-shop API文档"
  config.api_explanation = %q{
    请求数据格式：默认使用JSON格式，但也支持 application/x-www-form-urlencoded 格式。
    状态码：200表示成功，400表示失败，422表示表单数据校验不通过，其他状态码请查阅维基百科。
  }
end
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
module SpecTestHelper
  def sign_in(user=nil )
    user ||= User.create! phone: '19999999999', password: '123456', password_confirmation: '123456'
    post '/sessions', params: {phone: user.phone, password: user.password}
    user
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups

end

def file_path( *paths )
  File.expand_path(File.join(File.dirname(__FILE__), 'fixtures', *paths))
end

def public_path( *paths )
  File.expand_path(File.join(File.dirname(__FILE__), 'public', *paths))
end

def tmp_path( *paths )
  File.expand_path(File.join(File.dirname(__FILE__), 'tmp', *paths))
end
CarrierWave.root = public_path