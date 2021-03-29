module IEX
  module Endpoints
    module Intraday
      def intraday(symbol, options = {})
       
        options = options.dup
        # Historical prices IEX endpoint expects dates passed in a specific format - YYYYMMDD
     
        path = "stock/#{symbol}/intraday-prices"
      

        (get(path, { token: publishable_token }.merge(options)) || []).map do |data|
          IEX::Resources::Intraday.new(data)
        end
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end
    end
  end
end
