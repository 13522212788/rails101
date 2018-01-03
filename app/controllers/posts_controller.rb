class PostsController < ApplicationController
  before_action :find_group 
  before_action :authenticate_user!   
  before_action :member_required, only: [:new,:create]

  def new
    @post = @group.posts.new
  end
  def edit
    #@post = @group.posts.find(params[:id])
    @post= current_iser.posts.find(params[:id])
  end
  def create
    @post= @group.posts.build(post_params)
    @post.author =current_user
    if @post.save
      redirect_to group_path(@group), notice:"Post successed!"
    else
      render :new
    end
  end
  def update
    #@post = @group.posts.find(params[:id])
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to group_path(@group),notice: "Post update ok"
    else
      render :edit
    end
  end
  def destroy
    #@post  = @group.posts.find(params[:id])
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to group_path(@group), alert:"post delete ok"
  end



  private
  def find_group
    @group= Group.find(params[:group_id])
  end
  def post_params
    params.require(:post).permit(:content)
  end
  def member_required
    if !current_user.is_member_of?(@group)
      flash[:warning] = "you are not  member of the Group, can't post anything!"
      redirect_to group_path(@group)
    end
  end
end
