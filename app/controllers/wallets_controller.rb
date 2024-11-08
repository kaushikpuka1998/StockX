class WalletsController < ApplicationController
  before_action :set_user

  def deposit
    wallet = @user.wallets.find_or_create_by(currency: params[:currency])
    wallet.balance = wallet.balance.to_d + params[:amount].to_d
    wallet.save
    render json: { status: 'success', msg: 'successfully deposited funds', payload: { balance: wallet.balance, currency: wallet.currency } }
  end

  def withdrawal
    wallet = @user.wallets.find_by(currency: params[:currency])
    if wallet && wallet.balance >= params[:amount].to_d
      wallet.balance = wallet.balance.to_d - params[:amount].to_d
      wallet.save
      render json: { status: 'success', msg: 'successfully withdrawn funds', payload: { balance: wallet.balance, currency: wallet.currency } }
    else
      render json: { status: 'error', msg: 'insufficient funds' }, status: :unprocessable_entity
    end
  end

  def balances
    balances = @user.wallets.map { |wallet| { balance: wallet.balance, currency: wallet.currency } }
    render json: { status: 'success', msg: 'successfully fetched funds', payload: balances }
  end

  private

  def set_user
    @user = User.find(request.headers["user-id"])
  end
end
