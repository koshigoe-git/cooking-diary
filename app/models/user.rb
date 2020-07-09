class User < ApplicationRecord
  before_save {self.email.downcase! }
  validates :name, presence: true, length: { maximum: 10 }
  validates :email, presence: true, length: { maximum: 255 },
                    #メールアドレスの正しい形式を表示
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    #重複は不可（大文字小文字関係なし）
                    uniqueness: { case_sensitive: false }
  validates :introduce, presence: true, length: { maximum: 25 }
  has_secure_password
end
