class Report::Label

  def self.data
    Report::Label.new.data
  end

  def data
    @data = CSV.generate_line( self.csv_header )
    report_array.each do |report_line|
      @data << CSV.generate_line( report_line ) 
    end
    @data
  end

  def csv_header
    [ 
      'id',
      'First Name', 'Last Name', 'Business Name',
      'Address',   'Address 2', 'City',
      'State',     'Zip',       'Phone',
      'Phone 2',   'Solicitor', 'Donations',
      'Last Date', 'Last Amount'
    ]
  end

  def report_array
    l = []
    Person.find_each do |person|
      l << line_for(person)
    end
    l
  end

  def line_for(person)
    [
      person.id,
      person.first_name,
      person.last_name,
      person.business_name,
      person.address_1,
      person.address_2,
      person.city,
      person.state,
      person.zip,
      person.phone_1,
      person.phone_2,
      person.solicitor,
      person.total_donations.to_s,
      person.last_donation.try(:date).try(:strftime, '%D'),
      person.last_donation.try(:amount).to_s
    ]
  end
end

