class FishController < ApplicationController
  before_action :authenticate_user!
  before_action :set_fish, only: [:show, :edit, :update, :destroy]
  before_action :admin_user
  
  

  # GET /fish
  # GET /fish.json
  def index
    @fish = Fish.all.order(created_at: :desc)
  end

  # GET /fish/1
  # GET /fish/1.json
  def show
  end

  # GET /fish/new
  def new
    @fish = Fish.new
    @form_title ="データを作成"
  end

  # GET /fish/1/edit
  def edit
      @form_title ="データを編集"
  end

  # POST /fish
  # POST /fish.json
  def create
    @fish = Fish.new(fish_params)

    respond_to do |format|
      if @fish.save
        format.html { redirect_to "/fish", notice: '魚のデータを作成しました' }
        format.json { render :fish, status: :created, location:fish}
      else
        format.html { render :new }
        format.json { render json: @fish.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fish/1
  # PATCH/PUT /fish/1.json
  def update
    respond_to do |format|
      if @fish.update(fish_params)
        format.html { redirect_to"/fish", notice: '魚のデータを編集しました' }
        format.json { render :index, status: :ok, location:fish }
      else
        format.html { render :edit }
        format.json { render json: @fish.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fish/1
  # DELETE /fish/1.json
  def destroy
    @fish.destroy
    respond_to do |format|
      format.html { redirect_to fish_index_url, notice: '魚のデータを削除しました.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fish
      @fish = Fish.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fish_params
      params.require(:fish).permit(:name, :level, :season_begin,:season_end)
    end
end
