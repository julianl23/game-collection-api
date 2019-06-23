class User < ApplicationRecord
  has_one :game_collection, dependent: :destroy

  validates :email, presence: true, format: { with: Devise.email_regexp }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true

  after_commit :create_game_collection, on: :create

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable

  devise :database_authenticatable,
         :registerable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JWTBlacklist

  def create_game_collection
    GameCollection.create(user: self)
  end



  # should probably have a cascading delete here for game colelction


end
