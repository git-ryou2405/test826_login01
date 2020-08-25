
# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def line
    debug_log("[debug] line")  # デバッグ出力
    callback_from(:line)
  end

  def facebook
    # debug_log("[debug] facebook")  # デバッグ出力
    callback_from(:facebook)
  end

  def google_oauth2
    # debug_log("[debug] google_oauth2")  # デバッグ出力
    callback_from(:google_oauth2)
  end

  private
  def callback_from(provider)
    # debug_log("[debug] callback_from ： provider = #{provider}")  # デバッグ出力

    provider = provider.to_s

    @user = User.find_for_oauth(request.env['omniauth.auth'])

    # debug_log("@user = #{@user.inspect}")  # デバッグ出力

    if @user.persisted?
      # debug_log("[debug] callback_from：if ok (@user.persisted?)")  # デバッグ出力
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      flash[:notice] = "ログインしました"

      # @userがアクティブ化されていない場合スローされる
      sign_in_and_redirect @user, event: :authentication
    else
      # debug_log("[debug] callback_from：if ng (@user.persisted?)")  # デバッグ出力
      session["devise.#{provider}_data"] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end
