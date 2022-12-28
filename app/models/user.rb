class User < ApplicationRecord
    has_secure_password
    has_many :notes
    validates_presence_of :username
    validates_uniqueness_of :username
    
    validates_presence_of :email
    validates_uniqueness_of :email, case_sensitive: false
    validates_format_of :email, with: /@/
    validates_format_of :email, with: /.com/

    validates_length_of :password, :minimum => 6

    before_save :downcase_email
    before_create :generate_confirmation_instructions

    def downcase_email
        self.email = self.email.delete(' ').downcase
    end
    
    def generate_confirmation_instructions
        self.confirmation_sent_at = Time.now.utc
    end
     
end
