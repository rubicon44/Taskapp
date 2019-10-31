class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  # TOPページ画面
  def index
    @q = current_user.blogs.ransack(params[:q])
    @blogs = @q.result(distinct: true)
    # @blogs = current_user.blogs.order(created_at: :desc)
  end

  # タスクの詳細画面
  def show
  end

  # タスク登録画面
  def new
    @blog = Blog.new
  end

  # confirm_newメソッドを、createの前に記述しなければ、「NoMethodError」になる。
  def confirm_new
    @blog = current_user.blogs.new(blog_params)
    render :new unless @blog.valid?
  end

  # DB登録機能
  def create
    @blog = current_user.blogs.new(blog_params)

    if params[:back].present?
      render :new
      return
    end

    if @blog.save
      # logger.debug "blog: #{@blog.attributes.inspect}"
      BlogMailer.creation_email(@blog).deliver_now
      redirect_to @blog, notice: "タスク「#{@blog.name}」を登録しました。"
    else
      render :new
    end
  end

  # タスク編集ページ
  def edit
  end

  # タスク更新機能
  def update
    @blog.update!(blog_params)
    redirect_to blogs_url, notice: "タスク「#{@blog.name}」を更新しました。"
  end

  # タスク削除機能
  def destroy
    @blog.destroy
    # redirect_to blogs_url, notice: "タスク「#{@blog.name}」を削除しました。"
    # head :no_content
  end

  private

  def blog_params
    params.require(:blog).permit(:name, :description)
  end

  def set_blog
    @blog = current_user.blogs.find(params[:id])
  end

  # 以下の記述で、1日ごとに、「log/blog.log」にログを出力する。
  # def blog_logger
  #   @blog_logger ||= Logger.new('log/blog.log', 'daily')
  # end

  # blog_logger.debug 'blogのログを出力'
end
