
class PurchasesController < ApplicationController
    before_action :store_user_location!, if: :storable_location?
    before_action :authenticate_user!
    before_action :set_course

    def new
    end

    def create
        # Amount in cents
        @amount = @course.price

        customer = Stripe::Customer.create(
            :email => current_user.email,
            :source  => params[:stripeToken]
        )

        charge = Stripe::Charge.create(
            :customer    => customer.id,
            :amount      => @amount,
            :description => @course.name,
            :currency    => 'cad'
        )

        #todo create student
        Student.create(user_id: current_user.id, course_id: @course.id)


    rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_course_purchase_path(@course)
    end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
        @course = Course.find(params[:course_id])
    end

    def storable_location?
        request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
    end

    def store_user_location!
        # :user is the scope we are authenticating
        store_location_for(:user, request.fullpath)
    end

    def after_sign_in_path_for(resource)
        stored_location_for(resource) || super
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
        params.require(:purchase).permit(:stripeToken)
    end
end