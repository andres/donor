class DonationsController < ApplicationController

  def index
    if params[:person_id].present?
      @person    = Person.find( params[:person_id] )
      @donations = @person.donations.order('date desc')
    elsif params[:campaign_id].present?
      @campaign  = Campaign.find( params[:campaign_id] )
      @donations = @campaign.donations.order('date desc')
    else
      @donations = Donation.order('id desc').paginate(per_page: 30, page: params[:page])
    end
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

