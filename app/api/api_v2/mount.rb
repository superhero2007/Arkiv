require_relative 'errors'
require_relative 'validations'

module APIv2
  class Mount < Grape::API
    prefix 'api'
    version 'v2', using: :path

    cascade false

    format :json
    default_format :json

    helpers ::APIv2::Helpers

    include ExceptionHandlers

    do_not_route_head!
    do_not_route_options!

    MARKETS = Market.all.map(&:id)

    # Grape will add default values to params after validation
    before { @raw_params = params.dup }

    mount Markets
    mount Tickers
    mount Members
    mount Orders
    mount OrderBooks
    mount Trades
  end
end
