class Friend < ActiveRecord::Base
  # relations
  belongs_to :inviter, :class_name => "Profile", :foreign_key => "inviter_id"
  belongs_to :invited, :class_name => "Profile", :foreign_key => "invited_id"

  # validates
  validates_presence_of :inviter, :invited
   
  def validate
    errors.add('inviter', 'inviter and invited can not be the same user') if invited == inviter
  end
  
  class << self
    def conn(inviter, invited)
      find_by_inviter_id_and_invited_id(inviter, invited)
    end
    
    def exists?(inviter, invited)
      not conn(inviter, invited).nil?
    end
    
    def do_friends(inviter, invited, send_mail = nil)
      unless inviter != invited && Friend.exists?(inviter, invited)
        create(:inviter => inviter, :invited => invited)
      end
    end
    
    def break(inviter, invited)
      destroy(conn(inviter, invited))
    end
  end
end
