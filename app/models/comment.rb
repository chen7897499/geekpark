# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :string
#  username         :string
#  state            :string
#  commentable_type :string
#  commentable_id   :integer
#  parent_id        :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  deleted_at       :datetime
#
# Indexes
#
#  index_comments_on_commentable_type_and_commentable_id  (commentable_type,commentable_id)
#  index_comments_on_deleted_at                           (deleted_at)
#  index_comments_on_parent_id                            (parent_id)
#  index_comments_on_state                                (state)
#  index_comments_on_username                             (username)
#

class Comment < ApplicationRecord
  acts_as_paranoid

  belongs_to :commentable

  belongs_to :parent, class_name: 'Comment'
  has_many :children, class_name: 'Comment', foreign_key: 'parent_id'

  enum state: [:normal, :filtered]

  validates_presence_of :content
  validates_presence_of :state
end
