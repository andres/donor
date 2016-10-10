class CampaignsController < ApplicationController
  def index
    @campaigns = Campaign.order('id desc').paginate(page: params[:page], per_page: 30)
  end

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new( permitted_params )
    if @campaign.save
      flash[:success] = 'Created'
      redirect_to campaigns_url
    else
      render action: 'new'
    end
  end

  def edit
    @campaign = Campaign.find( params[:id] )
  end

  def update
    @campaign = Campaign.find( params[:id] )
    if @campaign.update_attributes( permitted_params )
      flash[:success] = 'Updated'
      redirect_to campaigns_url
    else
      render action: 'edit'
    end
  end

  private
  def permitted_params
    params.require(:campaign).permit(:label, :date, :note)
  end
end
