class ReportsController < ApplicationController

  def index

  end

  def show
    @report = Report.for( params )
  end

  def download
    report = Report.for( params )
    send_data report.data,
              :type => 'text/csv; charset=iso-8859-1; header=present',
              :disposition => "attachment; filename=#{report.file_name}.csv"
  end

end

