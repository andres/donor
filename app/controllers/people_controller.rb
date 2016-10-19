class PeopleController < ApplicationController

  def search
    people = Person::Search.with( params[:term] )
    if people.any?
      render json: people.map{|p| { value: p.id, label: p.screen_name } }
    else
      render json: { label: 'No matches' }
    end
  end

  def index
    @people = Person.by_name.paginate(page: params[:page], per_page: 25)
  end

  def new
    @person = Person.new
  end
  
  def create
    @person = Person.new( permitted_parameters ) 
    if @person.save
      redirect_to action: 'index'
    else
      render action: 'new'
    end
  end

  def edit
    @person = Person.find( params[:id] )
  end
  
  def update
    @person = Person.find( params[:id] )
    if @person.update_attributes( permitted_parameters )
      redirect_to action: 'index'
    else
      render action: 'edit'
    end
  end

  def destroy
    @person = Person.find( params[:id] )
    if @person.donations.empty?
      @person.destroy
      flash[:notice] = 'Deleted'
    else
      flash[:notice] = 'Can\'t delete'
    end
    redirect_to action: 'index'
  end

  def show
    @person = Person.find( params[:id] )
  end
   

  private
  def permitted_parameters
    params.require(:person).
           permit(:first_name, :last_name, :business_name, :address_1,
                  :address_2, :city, :state, :zip, :email,
                  :phone_1, :phone_2, :solicitor) 
  end
end
