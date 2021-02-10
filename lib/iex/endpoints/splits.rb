module IEX
  module Endpoints
    module Splits
      def splits(symbol, range = nil, options = {})
        get([
          'stock',
          symbol,
          'splits',
          range
        ].compact.join('/'), { token: publishable_token }.merge(options)).map do |data|
          IEX::Resources::Splits.new(data)
        end
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end
    end
  end
end
