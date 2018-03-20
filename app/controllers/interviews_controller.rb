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
      if @interview.save
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
        format.html { render :edit }
        format.json { render json: @interview.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/:user_id/interviews/:id
  # DELETE /users/:user_id/interviews/:id.json
  def destroy
    @interview.destroy
    respond_to do |format|
      format.html { redirect_to user_interviews_url(@user),
        notice: t("interviews.destroyed") }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:user_id])
    end

    def set_interview
      @interview = @user.interviews.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interview_params
      params.require(:interview).permit(:start_time, :status, :user_id)
    end
end
