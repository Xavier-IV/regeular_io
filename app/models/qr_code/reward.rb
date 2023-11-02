# frozen_string_literal: true

class QrCode::Reward < QrCode
  self.table_name = 'qr_codes'

  has_one :customer_reward, class_name: 'Customer::Reward', foreign_key: 'qr_code_id', dependent: :destroy,
                            inverse_of: false
end
