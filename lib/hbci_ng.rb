# frozen_string_literal: true

require 'active_support/concern'

require 'hbci_ng/subject'
# require 'hbci_ng/value'
# require 'hbci_ng/element'
# require 'hbci_ng/element_group'
require 'hbci_ng/segment_schema'
require 'hbci_ng/segment'
require 'hbci_ng/message'

Dir["#{File.expand_path('..', __dir__)}/lib/hbci_ng/element_group_builders/*.rb"].each { |f| require f }
Dir["#{File.expand_path('..', __dir__)}/lib/hbci_ng/errors/*.rb"].each { |f| require f }
Dir["#{File.expand_path('..', __dir__)}/lib/hbci_ng/schemas/*.rb"].each { |f| require f }
Dir["#{File.expand_path('..', __dir__)}/lib/hbci_ng/segments/*.rb"].each { |f| require f }
Dir["#{File.expand_path('..', __dir__)}/lib/hbci_ng/services/*.rb"].each { |f| require f }

module HbciNg
  def self.logger
    @logger ||= Logger.new(STDOUT, level: Logger::DEBUG)
  end
end
