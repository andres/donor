class Importer

  # imports matching csv separated by tab /
  # build your own importer to match your raw initial data
  # i = Importer.new
  # i = Importer.csv_file
  # i.import

  attr_accessor :csv_file, 
                :log

  Record = Struct.new(:date_string, :donation_type, :expected, :received, :donor_name, :payment, :campaign, :solicitor, :address, :city_state) do
    def date
      m,d,y = date_string.split('/')
      Date.new(y.to_i, m.to_i, d.to_i)
    end

    def city
      city_state.split',')[0]
    end

    def state
      city_state.split',')[1]
    end

    def zip
      city_state.match(/ddddd/).to_s
    end
  end

  def initialize
    @log = ''
  end

  def import
    records.each do |record|
      Importer::Processor.do record
    end
  end

  def records
    r = CSV.read(csv_file, { :col_sep => "\t" })
    r.shift #discard first line
    r
  end


  class Processor
    attr_accessor :record

    def self.do(record)
      p = Processor.new
      p.record = record
      p.process
    end

    def object
      @object ||= Importer::Record.new(*record)
    end

    def process
      if object.donor_name.present?
        unless donation_exists?
          create_donation
        end
      end
    end

    def donation_exists?
      Donation.where(amount_cents: amount_cents, 
                     donor_id:     person_id, 
                     campaign_id:  campaign_id, 
                     date: date).any?
    end

    def create_donation
      d = Donation.new
      d.amount_cents = amount_cents
      d.person_id    = person_id
      d.campaign_id  = campaign_id
      d.date         = date
      d.save(validate: false)
    end

    def amount_cents
      object.received.to_i * 100
    end

    def person_id
      @person_id ||= person.id
    end

    def person
      find_person || create_person
    end

    def find_person
      Person.where(name: object.donor_name).first
    end

    def create_person
      p = Person.new
      p.first_name = object.donor_name
      p.address_1  = object.address
      p.solicitor  = object.solicitor
      p.city       = object.city
      p.state      = object.state
      p.zip        = object.zip
      p.save(validate: false)
      p
    end

    def campaign_id
      @campaign_id ||= campaign.id
    end

    def campaign
      find_campaign || create_campaign
    end

    def find_campaign
      Campaign.where(label: object.campaign).first
    end

    def create_campaign
      c = Campaign.new
      c.label = object.campaign
      c.save(validate: false)
      c
    end

    def date
      object.date
    end

  end
end

