class LessonsController < ApplicationController
  before_action :authenticate_admin, except: [:index, :show]
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]
  before_action :set_course, only: [:new, :create]

  # GET /lessons
  # GET /lessons.json
  def index
    if is_admin?
      @lessons = Lesson.all
    else
      @lessons = Lesson.is_published
    end
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
  end

  # GET /lessons/new
  def new
    @lesson = @course.lessons.build
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @lesson = @course.lessons.build(lesson_params)

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to @lesson, notice: 'Lesson was successfully created.' }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to @lesson, notice: 'Lesson was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to lessons_url, notice: 'Lesson was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson

      if is_admin?
        @lesson = Lesson.find_by_id(params[:id])
      else
        @lesson = Lesson.get_by_id_if_published(params[:id])
      end

      redirect_to '/', alert: 'No Lesson Found.' if @lesson.blank? 
    end

    def set_course
      if is_admin?
        @course = Course.find(params[:course_id])
      else
        @course = Course.get_by_id_if_published(params[:course_id])
      end

      redirect_to '/', alert: 'No Course Found.' if @course.blank? 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_params
      params.require(:lesson).permit(:course_id, :title, :transcript, :length, :video_url, :published, :image, :tag_list, :tag, { tag_ids: [] }, :tag_ids)
    end
end
