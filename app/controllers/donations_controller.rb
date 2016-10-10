class DonationsController < ApplicationController

  def index
    @donations = Donation.order('id desc').paginate(per_page: 30, page: params[:page])
  end

  def new
    @donation = Donation.new( campaign_default )
    @campaigns = Campaign.order("id desc")
  end

  def create
    @donation = Donation.new( permitted_params )
    if @donation.save
      flash[:success] = 'Created'
      redirect_to donations_url
    else
      @campaigns = Campaign.order("id desc")
      render action: 'new'
    end
  end

  def edit
    @donation = Donation.find(params[:id])
    @campaigns = Campaign.order("id desc")
  end

  def update
    @donation = Donation.find(params[:id])
    if @donation.update_attributes( permitted_params )
      flash[:success] = 'Updated'
      redirect_to donations_url
    else
      @campaigns = Campaign.order("id desc")
      render action: 'edit'
    end
  end

  private
  def permitted_params
    params.require(:donation).permit(:person_id, :campaign_id, :amount, :date)
  end

  def campaign_default
    {
      campaign: Donation.last.try(:campaign),
      date:     Donation.last.try(:date)
    }
  end
end

