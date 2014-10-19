class Vote2sController < ApplicationController
  before_action :set_vote2, only: [:show, :edit, :update, :destroy]

  # GET /vote2s
  # GET /vote2s.json
  def index
    @vote2s = Vote2.all
  end

  # GET /vote2s/1
  # GET /vote2s/1.json
  def show
  end

  # GET /vote2s/new
  def new
    @vote2 = Vote2.new
  end

  # GET /votes/input
  def input
    render :action => "thanks" if cookies[:done] == "done" 
    @vote2s = Array.new
    (1..8).each {|n|
      vote2 = Vote2.new
      vote2.team_no = n
      vote2.point1 = 3
      vote2.point2 = 3
      vote2.point3 = 3
      @vote2s.push vote2
    }
  end

  def thanks
    cookies[:done] = "done"
  end

  # GET /vote2s/1/edit
  def edit
  end

  # POST /vote2s
  # POST /vote2s.json
  def create
    @vote2 = Vote2.new(vote2_params)

    respond_to do |format|
      if @vote2.save
        format.html { redirect_to @vote2, notice: 'Vote2 was successfully created.' }
        format.json { render :show, status: :created, location: @vote2 }
      else
        format.html { render :new }
        format.json { render json: @vote2.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vote2s/1
  # PATCH/PUT /vote2s/1.json
  def update
    respond_to do |format|
      if @vote2.update(vote2_params)
        format.html { redirect_to @vote2, notice: 'Vote2 was successfully updated.' }
        format.json { render :show, status: :ok, location: @vote2 }
      else
        format.html { render :edit }
        format.json { render json: @vote2.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vote2s/1
  # DELETE /vote2s/1.json
  def destroy
    @vote2.destroy
    respond_to do |format|
      format.html { redirect_to vote2s_url, notice: 'Vote2 was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote2
      @vote2 = Vote2.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vote2_params
      params.require(:vote2).permit(:team_no, :point1, :point2, :point3)
    end
end
