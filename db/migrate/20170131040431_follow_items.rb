class FollowItems < ActiveRecord::Migration[5.0]
  def change
    create_table :follow_items do |t|
       t.references :follower
       t.references :interesting
     end
   end
end
