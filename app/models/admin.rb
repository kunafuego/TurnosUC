# frozen_string_literal: true

class Admin < ApplicationRecord
  has_and_belongs_to_many :usuarios, join_table: :usuarios_admins

  belongs_to :resource,
             polymorphic: true,
             optional: true

  validates :resource_type,
            inclusion: { in: Rolify.resource_types },
            allow_nil: true

  scopify
end
