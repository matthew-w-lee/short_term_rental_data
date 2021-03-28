class NeighborhoodSearchResult < ApplicationRecord
  belongs_to :listing
  has_many :pricing_quotes
end
