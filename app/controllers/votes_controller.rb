class VotesController < ApplicationController
  before_action :set_vote, only: [:show, :edit, :update, :destroy]

  # GET /votes
  # GET /votes.json
  def index
    # redirect_to :action => "input"
    @votes = Vote.all
  end

  # GET /votes/1
  # GET /votes/1.json
  def show
  end

  # GET /votes/new
  def new
    @vote = Vote.new
  end

  # GET /votes/input
  def input
    redirect_to :action => "thanks" if cookies[:done] == "done" 
    @vote = Vote.new
  end

  def thanks
    # cookies[:done] = "done"
  end

  def done
  end

  def total
    @vote_summaries = create_total_summaries
  end

  def create_total_summaries
    vote_summaries = create_vote_summaries
    vote_summaries.sort_by! { |n| [-n.score, n.team_no] }
    rank = 0
    last_score = 0
    vote_summaries.each {|n|
      rank += 1 if n.score != last_score
      n.rank = rank
      last_score = n.score
    }
    vote_summaries = top_ranking vote_summaries
    return vote_summaries
  end

  def create_vote_summaries
    vote_summaries = Array.new
    votes = Vote.all
    votes.map { |vote| vote.team_no }.uniq.each {|n|
      team_votes = votes.select { |vote| vote.team_no == n }
      vote_summary = VoteSummary.new
      vote_summary.team_no = n
      vote_summary.score = team_votes.count
      vote_summaries.push vote_summary
    }
    return vote_summaries
  end

  def top_ranking(vote_summaries)
    return vote_summaries.select { |n| n.rank <= 1 }
  end

  # GET /votes/1/edit
  def edit
  end

  # POST /votes
  # POST /votes.json
  def create
    @vote = Vote.new(vote_params)
    @vote.save
    redirect_to :action => "thanks"
  end

  # PATCH/PUT /votes/1
  # PATCH/PUT /votes/1.json
  def update
    respond_to do |format|
      if @vote.update(vote_params)
        format.html { redirect_to @vote, notice: 'Vote was successfully updated.' }
        format.json { render :show, status: :ok, location: @vote }
      else
        format.html { render :edit }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1
  # DELETE /votes/1.json
  def destroy
    @vote.destroy
    respond_to do |format|
      format.html { redirect_to votes_url, notice: 'Vote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_params
      params.require(:vote).permit(:team_no)
    end
end
