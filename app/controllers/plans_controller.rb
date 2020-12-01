class PlansController < ApplicationController
  before_action :set_post_plan, only: [:new, :edit]

  def new
    @plans = Plan.where(post_id: params[:post_id])
    @plan = Plan.new
  end

  def create
    plan = Plan.new(plan_params)
    if plan.valid?
      plan.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @plan = Plan.find_by(id: params[:id], post_id: params[:post_id])
  end

  def update
    plan = Plan.find(params[:id])
    if plan.valid?
      plan.update(plan_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    plan = Plan.find_by(post_id: params[:post_id], id: params[:id])
    plan.destroy
    redirect_to "/posts/#{params[:post_id]}"
  end


  private

  def plan_params
    params.require(:plan).permit(:text, :place, :image).merge(post_id: params[:post_id])
  end

  def set_post_plan
    @post = Post.find(params[:post_id])
  end

end
