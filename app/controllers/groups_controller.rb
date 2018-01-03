class GroupsController < ApplicationController
  before_action :authenticate_user! ,only: [:new,:edit,:create,:update,:destroy]

  def index
    @groups = Group.all
  end
  def new
    @group = Group.new
  end
  def show
    @group = Group.find(params[:id])
    @posts = @group.posts 
 end
  def create
    #@group = Group.new(group_params)
    @group= current_user.groups.new(group_params)
    if @group.save
      current_user.join!(@group)
      redirect_to groups_path , notice: "新增讨论版成功"
    else
      render :new
    end
  end
  def edit
    # @group= Group.find(params[:id])
    @group= current_user.groups.find(params[:id])
  end
  def update
    #@group= Group.find(params[:id] )
    @group = current_user.groups.find(params[:id])
    if  @group.update(group_params)
      redirect_to groups_path,notice:"update successed!"
    else
      render :edit
    end
  end
  def destroy
    #@group= Group.find(params[:id])
    @group = current_user.groups.find(params[:id])
    @group.destroy
    redirect_to groups_path,alert: "destroy successed!"
  end

  def join
    @group = Group.find(params[:id])
    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice] = "join ok!"
    else
      flash[:warning] = "你已经是本版成员了！"
    end
    redirect_to group_path(@group)
  end
 
  def quit
    @group = Group.find(params[:id])
    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:alert] = "已经退出本讨论版"
    else
      flash[:warning] = "你不是本讨论版成员,怎么退出 xd "
    end
    redirect_to group_path(@group)
  end



  private
  def group_params
    params.require(:group).permit(:title,:description)
  end
end




