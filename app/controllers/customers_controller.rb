class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :customer_already_taken, only: :assign_customer

  def new
    @customer = Customer.new
  end

  def create
    @customer = current_org.customers.build(customer_params)

    if @customer.save
      @customer.build_chat.save
      flash[:success] = 'Customer created'
      redirect_to @customer
    else
      render :new
    end
  end

  def show
    @customer = Customer.find(params[:id])

    @chat = @customer.chat
  end

  def index
    @customers = current_org.customers
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])

    if @customer.update_attributes(customer_params)
      flash[:success] = 'Customer updated'
      redirect_to @customer
    else
      render :edit
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
  end

  def assign_customer
    @customer = Customer.find(params[:customer_id])
    @user = User.find(params[:user_id])

    if @customer.update_attributes(staff_id: @user.id)
      flash[:success] = 'User assigned to you.'
      redirect_to @customer
    else
      flash[:warning] = 'Error assigning you to that customer.'
      redirect_to @customer
    end
  end

  def close_customer
    @customer = Customer.find(params[:customer_id])

    if @customer.update_attributes(staff_id: nil)
      flash[:success] = 'Customer closed.'
      redirect_to @customer
    end
  end

  private

    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :email,
                                       :address_line_1, :address_line_2,
                                       :address_line_3, :city, :postal_code,
                                       :country, :wants_promotions,
                                       :phone_number)
    end

    def customer_already_taken
      if (customer = Customer.find(params[:customer_id])).staff_id.present?
        flash[:warning] = "This customer is already taken, please wait for #{customer.user.name} to close them."
        redirect_to customer
      end
    end
end
