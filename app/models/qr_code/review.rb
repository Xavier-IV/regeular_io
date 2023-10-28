# frozen_string_literal: true

class QrCode::Review < QrCode
  self.table_name = 'qr_codes'

  belongs_to :review, class_name: 'Review', foreign_key: 'qr_code_id', optional: true, inverse_of: false
end
