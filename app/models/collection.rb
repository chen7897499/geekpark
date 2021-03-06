# == Schema Information
#
# Table name: collections
#
#  id            :integer          not null, primary key
#  title         :string
#  description   :string
#  banner        :string
#  banner_mobile :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  deleted_at    :datetime
#
# Indexes
#
#  index_collections_on_deleted_at  (deleted_at)
#  index_collections_on_title       (title)
#

class Collection < ApplicationRecord
  acts_as_paranoid

  has_many :collection_items, dependent: :destroy
  has_many :posts, through: :collection_items

  validates_presence_of :title
  validates_presence_of :description

  include HasMembers
  def_add_members field: :posts
  def_reset_members field: :posts
end
