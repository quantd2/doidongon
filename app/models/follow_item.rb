class FollowItem < ApplicationRecord
  belongs_to :tracer, :class_name => 'Item'
  belongs_to :exposer, :class_name => 'Item'
end
