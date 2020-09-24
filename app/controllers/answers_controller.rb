class AnswersController < ApplicationController

  # GET /answers for appropriate question
  def show
    @question.answers.all
  end
  
end
