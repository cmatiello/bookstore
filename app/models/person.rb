 class Person < ApplicationRecord
   validates :name, presence: true, length: { maximum: 50 }
   validates :email, allow_blank: true, allow_nil: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
   validates :born_at, presence: true
   validate  :age_limit
 
   private
 
   def age_limit
     if self.born_at.nil? || Date.today.year - self.born_at.year < 16
       errors.add(:born_at, I18n.t('activerecord.errors.messages.older_than_16')) 
       throw(:abort)
     end
   end
  end
