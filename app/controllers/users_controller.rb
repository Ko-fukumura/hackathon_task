class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(name: params[:user][:name],
                      email: params[:user][:email],
                      image_name: "default_user.jpg")
    if @user.save
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if (params[:user][:image])
      @user.image_name = "#{@user.id}.jpg"
      image = (params[:user][:image])
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end
    if @user.update(name: params[:user][:name],
       email: params[:user][:email])
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to user_url(@user)
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = ""
    redirect_to users_url
  end
end
