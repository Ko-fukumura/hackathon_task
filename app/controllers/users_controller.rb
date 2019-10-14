class UsersController < ApplicationController
  before_action :authenticate_user, only: [:index, :show, :edit, :update]
  before_action :forbid_login_user, only: [:new, :create, :login_form, :login]
  before_action :ensure_correct_user, only: [:edit, :update]
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
                      password: params[:user][:password],
                      image_name: "default_user.jpg")
    if @user.save
      session[:user_id] = @user.id
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

  def login_form
    @user = User.find_by(email: params[:email], password: params[:password])
  end

  def login
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to posts_url
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render 'login_form'
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to login_url
  end

  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end

  private

    def ensure_correct_user
      if @current_user.id != params[:id].to_i
        flash[:notice] = "権限がありません"
        redirect_to posts_url
      end
    end


end
