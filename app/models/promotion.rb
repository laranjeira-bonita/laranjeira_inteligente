class Promotion < ApplicationRecord
    belongs_to :activity
    has_many :descriptions, as: :describable, dependent: :destroy
    has_many :tickers, dependent: :destroy
    has_many :participations, dependent: :destroy
    has_many :products, dependent: :destroy
    enum off_type: { gift_card: 0, discount: 1, pix: 2 }
    enum status: { pending: 0, achieved_limit: 1, completed: 2 }

    scope :completed, -> { where(status: :completed) }


    def self.active_one
        find_by(status: :pending)
    end

    def participations_result
        return [] unless target_number.present?
        participations.where('response is not null').closest_to(target_number)
    end

end
