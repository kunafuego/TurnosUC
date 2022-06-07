class Mensaje < ApplicationRecord
  belongs_to :usuario
  belongs_to :turno
  after_create_commit { broadcast_append_to self.turno }

end
