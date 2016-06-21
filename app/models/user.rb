# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  include PeopleHelper

  has_many :deals
  has_many :accions
  has_many :participacions, class_name: "Participacion", 
                            foreign_key: "user_id",
                            dependent: :destroy
  has_many :codeals, through: :participacions, source: :deal
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :downcase_email
  before_create :create_activation_digest
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # Devuelve el hash de un string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Devuelve un token aleatorio
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Recuerda una sesion de usuario persistente
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Borra el remember_digest para que no se pueda registrar por cookie
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Devuelve true si el usuario tiene un token valido
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Devuelve true si el password está vencido
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # Activa la cuenta
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Envía el mail de activación
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # Setea los atributos para el reset del password
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Envía el mail de reseteo de password
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  private
    
    # Crea el activation_tokeny y digest
    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

end
