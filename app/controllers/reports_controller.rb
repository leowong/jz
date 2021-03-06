class ReportsController < ApplicationController
  before_filter :login_required

  def index
    @reports = Report.all
  end

  def show
    @report = Report.find(params[:id])
    @note = @report.notes.build()
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(params[:report].merge(:user_id => current_user.id))
    if @report.save
      redirect_to @report, :notice => t('notice.create_successful')
    else
      render :action => 'new'
    end
  end

  def edit
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    params[:report].delete(:user_id) if params[:report] and params[:report][:user_id]
    if @report.update_attributes(params[:report])
      redirect_to @report, :notice  => t('notice.update_successful')
    else
      render :action => 'edit'
    end
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy
    redirect_to reports_url, :notice => t('notice.destroy_successful')
  end
end
