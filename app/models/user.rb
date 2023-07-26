class User < ApplicationRecord
  #callbacks
  before_create :encrypt_password
  #relationships
  has_many :articles
  has_many :comments
  has_many :like_logs
  has_many :liked_articles, through: :like_logs, source: :article
  #一定要寫source:
  #validations
  validates :password, confirmation: true                
  validates :email, presence: true,
  uniqueness: true,
  format: {
  with: URI::MailTo::EMAIL_REGEXP,
  message: '格式有誤'
  }

  def display_name
    if self.name.present?
        self.name
    else 
        self.email.split("@").first.capitalize
    end
  end
      
  def liked?(record)
    liked_articles.include?(record)
  end

  def unlike!(record)
    liked_articles.destroy(record)
  end

  def like!(record)
    liked_articles << record
  end
  
  #登入的時候class methods
   def self.login(email, password)
    return nil if email.empty? or password.empty?
    password = "x#{password}y".reverse
    password = Digest::SHA1.hexdigest(password)
    find_by(email: email, password: password)
   end
   #註冊的時候
   #因為還抓不到實體變數
  private
  def encrypt_password
    password = "x#{self.password}y".reverse
    self.password = Digest::SHA1.hexdigest(password)
  end
     

end