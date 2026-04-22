class Ticker < ApplicationRecord
    acts_as_paranoid
    belongs_to :promotion
    belongs_to :user
    has_many :descriptions, through: :promotion
    has_one :activity, through: :promotion
    enum off_type: { gift_card: 0, discount: 1, invitation: 2 }
    after_create :check_inviter_bonus

    private
    def check_inviter_bonus
        invite_limit = 3
        tickers = user.tickers.where(off_type: :invitation, deleted_at: nil).first(invite_limit)
        if tickers.size.eql? invite_limit
          Promotion.active_one&.participations&.create(user: user)
          tickers.each(&:destroy)
        end
    end
end
