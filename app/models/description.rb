class Description < ApplicationRecord
    belongs_to :describable, polymorphic: true
end
