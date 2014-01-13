module Braspag
  class ResponseErrors
    include Enumerable

    def initialize(error_report_collection)
      if error_report_collection
        @base_errors = [error_report_collection[:error_report]]
        @base_errors.flatten!
        @base_errors.compact!
      else
        @base_errors = []
      end
    end

    def codes
      @base_errors.map{ |base| base[:error_code] }
    end

    def messages
      @base_errors.map{ |base| base[:error_message] }
    end

    def each(&block)
      @base_errors.each(&block)
    end

    def size
      @base_errors.size
    end
  end
end
