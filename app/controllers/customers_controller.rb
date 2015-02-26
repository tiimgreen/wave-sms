class CustomersController < ApplicationController

  def new
    @customer = Customer.new
  end

  def create
    @customer = current_org.customers.build(customer_params)

    if @customer.save
      @customer.build_chat.save
      flash[:success] = 'Customer created'
      redirect_to customer_path(@customer)
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
      redirect_to customer_path(@customer)
    else
      render :edit
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
  end

  private

    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :email,
                                       :address_line_1, :address_line_2,
                                       :address_line_3, :city, :postal_code,
                                       :country, :wants_promotions)
    end
end
