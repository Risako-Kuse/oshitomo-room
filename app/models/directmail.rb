class Directmail < ApplicationRecord

  # DM機能
  belongs_to :customer
  belongs_to :directmail_space

end
