class ChargesController < ApplicationController
  # class Amount
  #   attr_accessor :amount
  #
  #   def initialize(amount=1500)
  #     @amount = amount
  #   end
  #
  #   def self.default
  #     @amount
  #   end
  # end

  # GET /charges/new
  # def new
  #    @stripe_btn_data = {
  #      key: "#{ Rails.configuration.stripe[:publishable_key] }",
  #      description: "BigMoney Membership - #{current_user.email}",
  #      amount: Amount.default
  #    }
  # end
  #
  #
  # # POST /charges
  # def create
  #   @amount = 1500
  #  customer = Stripe::Customer.create(
  #    email: current_user.email,
  #    card: params[:stripeToken]
  #  )
  #
  #  # Where the real magic happens
  #  charge = Stripe::Charge.create(
  #    customer: customer.id,
  #    amount: @amount,
  #    description: "BigMoney Membership - #{current_user.email}",
  #    currency: 'usd'
  #  )
  #
  #  flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
  #  redirect_to user_path(current_user)
  #
  #  rescue Stripe::CardError => e
  #    flash[:alert] = e.message
  #    redirect_to new_charge_path
  #
  # end
def new
end

def create
  @amount = params[:amount]

  @amount = @amount.gsub('$', '').gsub(',', '')

  begin
    @amount = Float(@amount).round(2)
  rescue
    flash[:error] = 'Charge not completed. Please enter a valid amount in USD ($).'
    redirect_to new_charge_path
    return
  end

  @amount = (@amount * 100).to_i # Must be an integer!

  if @amount < 500
    flash[:error] = 'Charge not completed. Donation amount must be at least $5.'
    redirect_to new_charge_path
    return
  end

  customer = Stripe::Customer.create(
     email: current_user.email,
     card: params[:stripeToken]
  )

  Stripe::Charge.create(
    customer: customer.id,
    :amount => @amount,
    :currency => 'usd',
    # :source => params[:stripeToken],
    :description => 'Custom donation'
  )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
