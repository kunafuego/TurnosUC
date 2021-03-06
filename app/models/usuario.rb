# frozen_string_literal: true

class Usuario < ApplicationRecord
  rolify role_cname: 'Admin'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nombre, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: Devise.email_regexp }
  validates :telefono, presence: true
  validates :calle, presence: true
  validates :numero, presence: true, numericality: { only_integer: true }
  validates :comuna, presence: true
  validates :imagen, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp }

  has_many :pertenece_as, dependent: :destroy, foreign_key: 'id_usuario'
  has_many :turnos, through: :pertenece_as
  has_many :solicituds, inverse_of: :usuario, dependent: :destroy, foreign_key: 'id_usuario'

  has_many :turnos, foreign_key: 'id_creador', dependent: :destroy
  has_many :resenas, dependent: :destroy

  has_many :mensajes, dependent: :destroy
end
