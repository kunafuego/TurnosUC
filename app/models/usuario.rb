# frozen_string_literal: true

class Usuario < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nombre, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: Devise.email_regexp }
  validates :telefono, presence: true
  validates :direccion, presence: true

  has_many :turnos
end
