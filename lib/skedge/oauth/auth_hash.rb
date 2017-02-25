module Skedge
  module OAuth
    class AuthHash
      attr_reader :auth_hash
      def initialize(auth_hash)
        @auth_hash = auth_hash
      end

      def uid
        @uid ||= auth_hash.uid.to_s
      end

      def provider
        @provider ||= auth_hash.provider.to_s
      end

      def name
        @name ||= get_info(:name) || "#{get_info(:first_name)} #{get_info(:last_name)}"
      end

      def username
        @username ||= username_and_email[:username].to_s
      end

      def email
        @email ||= username_and_email[:email].to_s
      end

      def password
        @password ||= Devise.friendly_token[0, 8].downcase
      end

      def image
        image = get_info(:image) || get_info(:avatar)
        image = image.remove("_normal") # So we use the full image size from Twitter.
        image
      end

      def first_name
        get_info(:first_name)
      end

      def last_name
        get_info(:last_name)
      end

      def email?
        get_info(:email).present?
      end

      private

      def info
        auth_hash.info
      end

      def get_info(key)
        info[key]
      end

      def username_and_email
        @username_and_email ||= begin
          username  = get_info(:username).presence || get_info(:nickname).presence
          # Test if this username is taken already. if it is, we'll generate a
          # username below using #generate_username
          username  = nil if username && ::User.for_username(username).any?
          email     = get_info(:email).presence

          username ||= generate_username(email)             if email
          email    ||= generate_temporarily_email(username) if username

          {
            username:   username,
            email:      email
          }
        end
      end

      # Get the first part of the email address (before @)
      # In addtion in removes illegal characters
      def generate_username(email)
        username = email.match(/^[^@]*/)[0].mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/, '').to_s
        # add some randomness to the end
        username += rand(100..9999).to_s

        return generate_username(email) if ::User.for_username(username).any?

        username
      end

      def generate_temporarily_email(username)
        "temp-email-for-oauth-#{username}@skedge.localhost"
      end
    end
  end
end
