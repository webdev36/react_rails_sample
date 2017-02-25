require 'skedge/oauth/auth_hash'

module Skedge
  module OAuth
    class User
      attr_accessor :auth_hash, :skedge_user

      def initialize(auth_hash)
        self.auth_hash = auth_hash
        @send_welcome_email = false
      end

      def persisted?
        skedge_user.try(:persisted?)
      end

      def new?
        !persisted?
      end

      def valid?
        skedge_user.try(:valid?)
      end

      def save
        skedge_user.save!

        Rails.logger.info(
          "(#{auth_hash.provider}) saving user #{auth_hash.email} from login with provider_uid => #{auth_hash.uid}"
        )

        # TODO
        # UserMailer.welcome_email(@user).deliver_later if @send_welcome_email
        skedge_user
      rescue ActiveRecord::RecordInvalid => e
        Rails.logger.info "(#{auth_hash.provider}) Error saving user: #{skedge_user.errors.full_messages}"
        return self, e.record.errors
      end

      def skedge_user
        @user ||= find_by_uid_and_provider
        @user ||= build_new_user

        @user
      end

      protected

      def auth_hash=(auth_hash)
        @auth_hash = Skedge::OAuth::AuthHash.new(auth_hash)
      end

      def find_by_uid_and_provider
        identity = Identity.find_by(provider: auth_hash.provider, provider_uid: auth_hash.uid)
        identity && identity.user
      end

      def build_new_user
        @send_welcome_email = true
        user = ::User.new(user_attributes)
        user.identities.new(provider_uid: auth_hash.uid, provider: auth_hash.provider)
        user
      end

      def user_attributes
        username ||= auth_hash.username
        email ||= auth_hash.email
        image ||= auth_hash.image
        name ||= auth_hash.name

        {
          username:        username,
          email:           email,
          image_url:       image,
          name:            name,
          "#{auth_hash.provider}_username" => username
        }
      end
    end
  end
end
