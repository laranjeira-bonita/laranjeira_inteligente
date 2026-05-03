module PromotionsHelper

    def current_access
        @promotion.products.find_by(category: [:ticket, :gift_card], multi_number: 1)
    end

    def current_promo
        Promotion.active_one
    end

    def current_access_price
        number_to_currency(current_access.price, unit: "R$", separator: ",")
    end

    def invite_link
        "#{ENV.fetch('APP_HOST')}?invite_code=#{current_user&.uuid}"
    end

    def biggest_reward(promotion)
        promotion.multi_rewards.max
    end

    def my_participations(promotion)
        promotion.participations.from_user_id(current_user&.id)
    end

    def participation_nickname(participation, current_user_response)
        participation.nickname || (current_user_response ? 'Você' : 'Anônimo')
    end
end
