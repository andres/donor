class Report::Donation

  def self.data
    Report::Donation.new.data
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
      'id',   'Campaign', 'Donor', 
      'Date', 'Solicitor', 'Amount'
    ]
  end

  def report_array
    l = []
    ::Donation.find_each do |donation|
      l << line_for(donation)
    end
    l
  end

  def line_for(donation)
    [
      donation.id,
      donation.campaign.label,
      donation.person.screen_name,
      donation.date.try(:strftime, '%Y-%m-%d'),
      donation.person.solicitor,
      donation.amount.to_s
    ]
  end

end
