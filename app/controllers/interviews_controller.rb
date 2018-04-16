class InterviewsController < ApplicationController
  before_action :set_user
  before_action :set_interview, only: [:show, :edit, :update, :destroy]

  # GET /users/:user_id/interviews
  # GET /users/:user_id/interviews.json
  def index
    # 開始時間順にソート
    @interviews = @user.interviews.order("start_time")
  end

  # GET /users/:user_id/interviews/:id
  # GET /users/:user_id/interviews/:id.json
  def show
  end

  # GET /users/:user_id/interviews/new
  def new
    @interview = @user.interviews.build
  end

  # GET /users/:user_id/interviews/:id/edit
  def edit
  end

  # POST /users/:user_id/interviews
  # POST /users/:user_id/interviews.json
  def create
    @interview = @user.interviews.build(interview_params)

    respond_to do |format|
      # ログインユーザー以外の面接登録は禁止
      if view_context.my_interview? && @interview.save
        format.html { redirect_to user_interview_path(@user, @interview),
          notice: t("interviews.created") }
        format.json { render :show, status: :created, location: @interview }
      else
        format.html { render :new }
        format.json { render json: @interview.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/:user_id/interviews/:id
  # PATCH/PUT /users/:user_id/interviews/:id.json
  def update
    respond_to do |format|
      if @interview.update(interview_params)
        format.html { redirect_to user_interview_path(@user, @interview),
          notice: t("interviews.updated") }
        format.json { render :show, status: :ok, location: @interview }
      else
        format.html { redirect_back fallback_location: root_path,
                                    alert: @interview.errors&.full_messages&.first }
        format.json { render json: @interview.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/:user_id/interviews/:id
  # DELETE /users/:user_id/interviews/:id.json
  def destroy
    respond_to do |format|
      if @interview.destroy
        format.html { redirect_to user_interviews_url(@user),
          notice: t("interviews.destroyed") }
        format.json { head :no_content }
      else
        format.html { redirect_back fallback_location: root_path,
                                    alert: @interview.errors&.full_messages&.first }
        format.json { render json: @interview.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:user_id])
    end

    def set_interview
      @interview = @user.interviews.find_by(id: params[:id])
      # 面接日程の更新のセレクトボックスで、「選択してください」に無効な id を指定するので
      # nil の場合は前のページにリダイレクト
      redirect_back(fallback_location: root_path) if @interview.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interview_params
      if view_context.my_interview?
        # ログインユーザーのみ、面接開始日時を変更可能
        params.require(:interview).permit(:start_time, :user_id)
      else
        # ログインユーザー以外のみ、面接承認状態を変更可能
        params.require(:interview).permit(:status, :user_id)
      end
    end
end
