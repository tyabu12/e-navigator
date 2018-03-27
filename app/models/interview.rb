class Interview < ApplicationRecord
  belongs_to :user

  enum status: { approved: 0, on_hold: 1, rejected: 2 }
end
