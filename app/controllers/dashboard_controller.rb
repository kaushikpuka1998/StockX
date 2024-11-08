class DashboardController < ApplicationController
  def index
    from_time = params[:from_time].to_datetime
    to_time = params[:to_time].to_datetime
    orders = Order.where(created_at: from_time..to_time)
    volumes = orders.group(:base_currency).sum(:volume)
    render json: { status: 'success', message: 'Data fetched successfully', payload: volumes }
  end
end
