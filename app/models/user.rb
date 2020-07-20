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
  #有効なパスワード = アルファベットと数字のみ（=仮名でのpassword入力は無効）
  VALID_PASSWORD_REGEX = /\A[a-z0-9]+\z/i
  validates :password, length: { minimum: 8 }, format: { with: VALID_PASSWORD_REGEX }
  
  has_many :posts
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post
 
  #お気に入りは自分自身の投稿もして良いので、フォローのようにunlessメソッドは不要
  def favorite(post)
      self.favorites.find_or_create_by(post_id: post.id)
  end

  def unfavorite(post)
    favorite = self.favorites.find_by(post_id: post.id)
    favorite.destroy if favorite
  end
  #self.favorite_posts(自分がお気に入りしている投稿)により、お気に入りのpost達を取得
  #include?に既にフォローしているか確認するメソッド
  #よってお気に入りにしようとしているpostが既に含まれているか確認ししている
  #含まれている場合には、true を返し、含まれていない場合には、false を返す。
  def favorite_post?(post)
    self.favorite_posts.include?(post)
  end
  
end