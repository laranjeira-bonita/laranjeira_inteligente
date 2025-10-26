require 'mercadopago'

MERCADOPAGO_SDK = Mercadopago::SDK.new(ENV.fetch('MERCADOPAGO_ACCESS_TOKEN'))