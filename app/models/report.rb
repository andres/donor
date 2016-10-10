class Report

  attr_accessor :params

  def self.for( params )
    report = Report.new
    report.params = params
    report
  end

  def file_name
    report_type + '-' + timestamp + '.csv'
  end

  def report_type
    params[:report_type]
  end

  def timestamp
    Time.zone.now.strftime('%Y-%d-%m_%H:%M')
  end

  def data
    report_class.data
  end

  def report_class
    "Report::#{report_type}".constantize
  end

  def report_type
    case params[:report_type]
    when 'labels'
      "Label"
    when 'donations'
      "Donation"
    end
  end

end

