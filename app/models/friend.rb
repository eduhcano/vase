class Friend < ActiveRecord::Base
  # relations
  belongs_to :inviter, :class_name => "User", :foreign_key => "inviter_id"
  belongs_to :invited, :class_name => "User", :foreign_key => "invited_id"

  # statusses
  ACCEPTED = 1
  PENDING = 0

  # validates
  validates_presence_of :inviter, :invited
   
  def validate
    errors.add('inviter', 'inviter and invited can not be the same user') if invited == inviter
  end
  
  class << self
    def conn(inviter, invited)
      find_by_inviter_id_and_invited_id(inviter, invited)
    end
    
    def connected?(inviter, invited)
      exists?(inviter, invited) and accepted?(inviter, invited)
    end
    
    def exists?(inviter, invited)
      not conn(inviter, invited).nil?
    end
    
    def accepted?(inviter, invited)
      conn(inviter, invited).status == ACCEPTED
    end
    
    def pending?(inviter, invited)
      exists?(inviter, invited) and conn(inviter, invited).status == PENDING
    end
    
    def do_friends(inviter, invited, send_mail = nil) 
      unless inviter == invited 
        if Friend.exists?(inviter, invited) && pending?(inviter, invited)
          do_mutuals(inviter, invited)
        elsif !Friend.exists?(inviter, invited)
          transaction do
            create(:inviter => inviter, :invited => invited, :status => ACCEPTED)
            create(:inviter => invited, :invited => inviter, :status => PENDING)
          end
          # send mail
        end
      end
    end
    
    def break(inviter, invited)
      transaction do
        destroy(conn(inviter, invited))
        destroy(conn(invited, inviter))
      end
    end
  end
  
  class << self
    def do_mutuals(inviter, invited)
      conn = conn(inviter, invited)
      conn.update_attributes!(:status => ACCEPTED)
      conn
    end
  end
end
