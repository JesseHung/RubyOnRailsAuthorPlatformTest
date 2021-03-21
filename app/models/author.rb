class Author < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
      
  def self.from_omniauth(auth)
    # Case 1: Find existing user by facebook uid
    author = Author.find_by_fb_uid( auth.uid )
    if author
        author.fb_token = auth.credentials.token
        #author.fb_raw_data = auth
        author.save!
      return author
    end

    # Case 2: Find existing author by email
    existing_author = Author.find_by_email( auth.info.email )
    if existing_author
      existing_author.fb_uid = auth.uid
      existing_author.fb_token = auth.credentials.token
      #existing_author.fb_raw_data = auth
      existing_author.save!
      return existing_author
    end

    # Case 3: Create new password
    author = Author.new
    author.fb_uid = auth.uid
    author.fb_token = auth.credentials.token
    author.email = auth.info.email
    author.password = Devise.friendly_token[0,20]
    #author.fb_raw_data = auth
    author.save!
    return author
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
