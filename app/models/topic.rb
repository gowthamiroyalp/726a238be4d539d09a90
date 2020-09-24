class Topic < ActiveRecord::Base
  has_many :questions
  
  # is topic follewed by user
  def follow(id)
	@user.topic_id == id ? true : doFollow(id)
  end
  
  
  def doFollow(id)
    @topic_user.follow = true
    false
  end
  
end
