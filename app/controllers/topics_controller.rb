class TopicsController < ApplicationController

  # GET /topics/1
  def show
  end

  # GET /topics/1/edit
  def edit
  end

  # is topic follewed by user
  def is_follow
	@user.follow(@topic.id)
  end
  
end
