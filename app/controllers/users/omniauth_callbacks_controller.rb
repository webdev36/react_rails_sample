require 'skedge/oauth/user'

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :verify_authenticity_token

  Rails.application.config.o_auth_providers.each do |provider|
    define_method provider do
      handle_omniauth
    end
  end

  def handle_omniauth
    if current_user
      # If you're already signed in, we're just linking your provider account
      current_user.identities.find_or_create_by(
        provider_uid: oauth['uid'],
        provider: oauth['provider']
      )

      current_user.update_attribute(
        oauth['provider'] + '_username',
        oauth[:info][:username].presence || oauth[:info][:nickname].presence
      )

      return redirect_to '/', notice: 'Authentication method updated'
    else
      oauth_user = ::Skedge::OAuth::User.new(oauth)
      puts "0=======0======0=======0======0=======0======0=======0======"
      puts oauth_user.inspect
      puts "0=======0======0=======0======0=======0======0=======0======"
      oauth_user.save
      @user = oauth_user.skedge_user
    end

    continue_login_process
  end

  def continue_login_process
    if @user.persisted? && @user.valid?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: oauth['provider'].capitalize)
    else
      if @user.errors[:email].any? && @user == User.find_by(email: @user.email)
        # This user tried to sign up with oauth but we have a user with that
        # email already. Send them an email so they can login and link up this
        # oauth provider with their user.
        # TODO
        # UserMailer.send_oauth_claim_email(@user, oauth['provider']).deliver_now!
      end

      redirect_to root_url, notice: 'It looks like you already have an account with the linked email address - we sent you an email. Please confirm to link your accounts.'
    end
  end

  def oauth
    @oauth ||= request.env['omniauth.auth']
  end
end
