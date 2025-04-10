class SearchLog < ApplicationRecord
  belongs_to :user
  belongs_to :session
  belongs_to :search
end
