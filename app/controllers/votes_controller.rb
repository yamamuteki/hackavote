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
    @votes = Array.new
    (1..8).each {|n|
      vote = Vote.new
      vote.team_no = n
      vote.point1 = 3
      vote.point2 = 3
      vote.point3 = 3
      @votes.push vote
    }
  end

  def regist
    votes = params["votes"]

    votes.each {|vote|
      puts vote
      entity = Vote.new
      entity.team_no = vote["team_no"]
      entity.point1 = vote["point1"]
      entity.point2 = vote["point2"]
      entity.point3 = vote["point3"]
      entity.save
    }

    redirect_to :action => "thanks"
  end

  def thanks
    # cookies[:done] = "done"
  end

  def done
  end

  def score1
    @vote_summaries = create_vote_summaries
    delete_1st_rank @vote_summaries
    @vote_summaries.sort_by! { |n| [-n.score1, n.team_no] }
    rank = 0
    last_score = 0
    @vote_summaries.each {|n|
      rank += 1 if n.score1 != last_score
      n.rank = rank
      last_score = n.score1
    }
    @vote_summaries = top_ranking @vote_summaries
  end

  def score2
    @vote_summaries = create_vote_summaries
    delete_1st_rank @vote_summaries
    @vote_summaries.sort_by! { |n| [-n.score2, n.team_no] }
    rank = 0
    last_score = 0
    @vote_summaries.each {|n|
      rank += 1 if n.score2 != last_score
      n.rank = rank
      last_score = n.score2
    }
    @vote_summaries = top_ranking @vote_summaries
  end

  def score3
    @vote_summaries = create_vote_summaries
    delete_1st_rank @vote_summaries
    @vote_summaries.sort_by! { |n| [-n.score3, n.team_no] }
    rank = 0
    last_score = 0
    @vote_summaries.each {|n|
      rank += 1 if n.score3 != last_score
      n.rank = rank
      last_score = n.score3
    }
    @vote_summaries = top_ranking @vote_summaries
  end

  def total
    @vote_summaries = create_total_summaries
  end

  def create_total_summaries
    vote_summaries = create_vote_summaries
    vote_summaries.sort_by! { |n| [-n.total_score, n.team_no] }
    rank = 0
    last_score = 0
    vote_summaries.each {|n|
      rank += 1 if n.total_score != last_score
      n.rank = rank
      last_score = n.total_score
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
      puts team_votes
      vote_summary.score1 = team_votes.inject(0) { |sum, n| sum + n.point1 }
      vote_summary.score2 = team_votes.inject(0) { |sum, n| sum + n.point2 }
      vote_summary.score3 = team_votes.inject(0) { |sum, n| sum + n.point3 }
      vote_summaries.push vote_summary
    }
    return vote_summaries
  end

  def top_ranking(vote_summaries)
    return vote_summaries.select { |n| n.rank <= 3 }
  end

  def delete_1st_rank(vote_summaries)
    create_total_summaries.select{|n| n.rank == 1}
      .each{|n|vote_summaries.delete_if{|s| s.team_no == n.team_no}}
  end

  # GET /votes/1/edit
  def edit
  end

  # POST /votes
  # POST /votes.json
  def create
    @vote = Vote.new(vote_params)

    respond_to do |format|
      if @vote.save
        format.html { redirect_to @vote, notice: 'Vote was successfully created.' }
        format.json { render :show, status: :created, location: @vote }
      else
        format.html { render :new }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
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
      params.require(:vote).permit(:team_no, :point1, :point2, :point3)
    end
end
