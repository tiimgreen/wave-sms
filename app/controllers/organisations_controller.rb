class OrganisationsController < ApplicationController
  before_action :authenticate_user!, except: :new_customer
  before_action :authenticate_org_owner, only: :edit
  before_action :authenticate_has_phone_number, only: [:choose_phone_number, :activate_phone_number]

  def index
  end

  def show
  end

  def edit
    @org = Organisation.find(params[:id])
  end

  def update
    @org = Organisation.find(params[:id])

    if @org.update_attributes(organisation_params)
      flash[:success] = 'Organisation updated'
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  def choose_phone_number
    @org = Organisation.find(params[:organisation_id])

    if params[:area_code] == 'none'
      @numbers = client.available_phone_numbers.get('GB').local.list
    else
      area_code = twilio_area_code(current_user.organisation.area_code)
      @numbers = client.available_phone_numbers.get('GB').local.list(contains: area_code)
    end
  end

  def activate_phone_number
    org = Organisation.find(params[:organisation_id])

    client.incoming_phone_numbers.create(phone_number: params[:phone_number])

    if org.update_attributes(phone_number: params[:phone_number])
      flash[:success] = 'Phone number activated!'
      redirect_to dashboard_path
    end
  end

  # Customer visits to sign up and save card details
  def new_customer
    Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
  end

  def create_new_customer
    Stripe.api_key = ENV["STRIPE_SECRET_KEY"]

    Stripe::Charge.create(
      amount: 400,
      currency: "gbp",
      source: "tok_14mBggEonafcEKzyf3YVUkJw", # obtained with Stripe.js
      description: "Charge for test@example.com"
    )
  end

  private

    def authenticate_org_owner
      org = Organisation.find(params[:id])

      unless current_user == org.owner
        flash[:warning] = 'You need to be the organisation owner to do that.'
        redirect_to dashboard_path
      end
    end

    def authenticate_has_phone_number
      org = Organisation.find(params[:organisation_id])

      if org.phone_number.present?
        flash[:warning] = 'You already have a phone number.'
        redirect_to dashboard_path
      end
    end

    def organisation_params
      params.require(:organisation).permit(:name, :area_code)
    end

    def client
      Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])
    end
end
