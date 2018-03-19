class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # ログインチェック
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # 追加カラムのための設定
  # https://github.com/plataformatec/devise#strong-parameters
  def configure_permitted_parameters
    added_attrs = [ :name, :birthday, :gender, :school_name ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end

end
