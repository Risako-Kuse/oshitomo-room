class DirectmailSpace < ApplicationRecord

  # DM機能
  has_many :directmail, dependent: :destroy
  
end
