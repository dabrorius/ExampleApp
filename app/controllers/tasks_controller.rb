class TasksController < ApplicationController
  before_action :restrict_access!

  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = current_user.tasks.order("id")
    @task = Task.new
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.user = current_user
    
    respond_to do |format|
      if @task.save
        format.js # render create.js.erb
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.js # render create.js.erb
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.js
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render json: @task, status: :ok, location: @task }
      else
        format.js
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task_id = @task.id
    @task.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = current_user.tasks.find_by_id(params[:id])
      head :unauthorized if @task.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:description, :due_at, :priority, :user_id, :completed)
    end

    def restrict_access!
      access_token = params[:access_token]
      if access_token.blank?
        authenticate_user!
      else
        sign_in_with_token(access_token)
      end
    end

    def sign_in_with_token(access_token)
      current_user = User.find_by_access_token(access_token)
      if current_user 
        sign_in(current_user)
      else
         head :unauthorized
      end
    end
end
