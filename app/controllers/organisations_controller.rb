class OrganisationsController < ApplicationController
  before_action :authenticate_user!, except: %i( new_customer create_new_customer )
  before_action :authenticate_org_member, only: %i( edit show )
  before_action :authenticate_has_phone_number, only: %i( choose_phone_number activate_phone_number )
  before_action :authenticate_org_exists

  def index
  end

  def show
  end

  def upgrade
    @page_title = 'Upgrade Account'
  end

  def edit
  end

  def update
    @org = Organisation.find_by(permalink: params[:id])

    if @org.update_attributes(organisation_params)
      flash[:success] = 'Organisation updated'
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  def choose_phone_number
    @org = Organisation.find_by(permalink: params[:id])

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
    @org = Organisation.find_by(permalink: params[:organisation_id])
    @customer = Customer.new

    Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
  end

  def create_new_customer
    @org = Organisation.find_by(permalink: params[:organisation_id])
    @customer = @org.customers.build(parse_phone_number_in_params(customer_params))

    if @customer.save
      @customer.build_chat.save
      flash[:success] = "Your details have been saved with #{@org.name}!"
      redirect_to organisation_after_signup_path
    else
      render :new_customer
    end

    # Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
    # Stripe::Charge.create(
    #   amount: 400,
    #   currency: "gbp",
    #   source: "tok_14mBggEonafcEKzyf3YVUkJw", # obtained with Stripe.js
    #   description: "Charge for test@example.com"
    # )
  end

  def after_customer_signup
    @org = Organisation.find_by(permalink: params[:organisation_id])
  end

  private

    def authenticate_org_member
      org = Organisation.find_by(permalink: params[:id]) || current_org

      unless current_user.organisation_id == org.id
        flash[:warning] = 'You need to be the organisation owner to do that.'
        redirect_to dashboard_path
      end
    end

    def authenticate_org_exists
      unless current_org.present?
        permalink = params[:id].present? ? params[:id] : params[:organisation_id]
        render_404 unless Organisation.find_by(permalink: permalink).present?
      end
    end

    def authenticate_has_phone_number
      org = Organisation.find(current_org)

      if org.phone_number.present?
        flash[:warning] = 'You already have a phone number.'
        redirect_to dashboard_path
      end
    end

    def organisation_params
      params.require(:organisation).permit(:name, :area_code)
    end

    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :email,
                                       :address_line_1, :address_line_2,
                                       :address_line_3, :city, :postal_code,
                                       :country, :wants_promotions,
                                       :phone_number)
    end

    def client
      Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])
    end
end
