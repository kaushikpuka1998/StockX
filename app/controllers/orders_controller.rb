class OrdersController < ApplicationController
  before_action :set_user

  def create
    order = @user.orders.new(order_params)
    if valid_funds?(order)
      order.state = 'pending'
      adjust_wallets(order)
      if order.save
        render json: { status: 'success', message: 'Successfully created', payload: order }
      else
        render json: { status: 'error', message: order.errors.full_messages.join(', ') }, status: :unprocessable_entity
      end
    else
      render json: { status: 'error', message: 'insufficient funds' }, status: :unprocessable_entity
    end
  end

  def cancel
    order = @user.orders.find(params[:id])
    if order.state == 'pending'
      order.state = 'cancelled'
      adjust_wallets(order, reverse: true)
      order.save
      render json: { status: 'success', message: 'Successfully cancelled', payload: '' }
    else
      render json: { status: 'error', message: 'Order cannot be cancelled' }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(request.headers["user-id"])
  end

  def order_params
    params.require(:order).permit(:side, :base_currency, :quote_currency, :price, :volume)
  end

  def valid_funds?(order)
    if order.side == 'sell'
      wallet = @user.wallets.find_by(currency: order.base_currency)
      wallet && wallet.balance >= order.volume
    else
      wallet = @user.wallets.find_by(currency: order.quote_currency)
      wallet && wallet.balance >= order.volume * order.price
    end
  end

  def adjust_wallets(order, reverse: false)
    if order.side == 'sell'
      wallet = @user.wallets.find_by(currency: order.base_currency)
      wallet.balance += reverse ? order.volume : -order.volume
    else
      wallet = @user.wallets.find_by(currency: order.quote_currency)
      wallet.balance += reverse ? order.volume * order.price : -order.volume * order.price
    end
    wallet.save
  end
end
