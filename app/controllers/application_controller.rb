class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_cart

  helper_method :current_user,
                :current_admin?,
                :current_user_order?,
                :update_cart,
                :logged_in?

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :user_image,
                                 :username,
                                 :street_address,
                                 :city,
                                 :state,
                                 :zip_code,
                                 :password,
                                 :password_confirmation,
                                 :gender)
  end

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def update_cart
    session[:cart] = @cart.contents
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def path_based_on_role
    if current_admin?
      admin_dashboard_path
    else
      dashboard_path
    end
  end

  def current_user_order?
    order = Order.find(params[:id])
    order.user_id == current_user.id
  end

  def logged_in?
    redirect_to login_path unless current_user
  end
end
