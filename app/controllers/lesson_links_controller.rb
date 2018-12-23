class LessonLinksController < ApplicationController
  before_action :set_lesson_link, only: [:show, :edit, :update, :destroy]

  # GET /lesson_links
  # GET /lesson_links.json
  def index
    @lesson_links = LessonLink.all
  end

  # GET /lesson_links/1
  # GET /lesson_links/1.json
  def show
  end

  # GET /lesson_links/new
  def new
    @lesson_link = LessonLink.new
  end

  # GET /lesson_links/1/edit
  def edit
  end

  # POST /lesson_links
  # POST /lesson_links.json
  def create
    @lesson_link = LessonLink.new(lesson_link_params)

    respond_to do |format|
      if @lesson_link.save
        format.html { redirect_to @lesson_link, notice: 'Lesson link was successfully created.' }
        format.json { render :show, status: :created, location: @lesson_link }
      else
        format.html { render :new }
        format.json { render json: @lesson_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lesson_links/1
  # PATCH/PUT /lesson_links/1.json
  def update
    respond_to do |format|
      if @lesson_link.update(lesson_link_params)
        format.html { redirect_to @lesson_link, notice: 'Lesson link was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson_link }
      else
        format.html { render :edit }
        format.json { render json: @lesson_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lesson_links/1
  # DELETE /lesson_links/1.json
  def destroy
    @lesson_link.destroy
    respond_to do |format|
      format.html { redirect_to lesson_links_url, notice: 'Lesson link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson_link
      @lesson_link = LessonLink.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_link_params
      params.require(:lesson_link).permit(:lesson_id, :name, :link_url)
    end
end
