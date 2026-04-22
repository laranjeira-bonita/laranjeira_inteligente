module ProductsHelper

    def price_in_brl(price)
        number_to_currency(price, unit: "R$", separator: ",", delimiter: ".")
    end
end
