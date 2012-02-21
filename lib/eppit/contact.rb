
module Epp

class Contact
  attr_accessor :nic_id
  attr_accessor :roid
  attr_accessor :statuses
  attr_accessor :name
  attr_accessor :org
  attr_accessor :street
  attr_accessor :city
  attr_accessor :sp
  attr_accessor :pc
  attr_accessor :cc
  attr_accessor :voice
  attr_accessor :fax
  attr_accessor :email
# attr_accessor  :auth_info_pw
  attr_accessor :cl_id
  attr_accessor :cr_id
  attr_accessor :cr_date
  attr_accessor :up_id
  attr_accessor :up_date
  attr_accessor :consent_for_publishing
  attr_accessor :registrant_nationality_code
  attr_accessor :registrant_entity_type
  attr_accessor :registrant_reg_code

  def initialize(opts)
    opts.each { |k,v| send("#{k}=", v) }
  end

  class Diff
    attr_accessor :add
    attr_accessor :chg
    attr_accessor :rem

    def initialize(*opts)
      if opts.count == 1
        @add = Add.new(opts[0][:add])
        @rem = Rem.new(opts[0][:rem])
        @chg = Chg.new(opts[0][:chg])

      elsif opts.count == 2
        @add = Add.new
        @rem = Rem.new
        @chg = Chg.new

        compute(opts[0], opts[1])
      else
        raise 'Expected 1 or 2 parameters'
      end
    end

    def compute(old, new)
      add.statuses = (new.statuses - old.statuses)

      rem.statuses = (old.statuses - new.statuses)

      chg.name = new.name if old.name != new.name
      chg.org = new.org if old.org != new.org

      if old.street != new.street || old.sp != new.sp ||
         old.sp != new.city || old.pc != new.pc || old.cc != new.cc
        chg.street = new.street
        chg.sp = new.sp
        chg.city = new.city
        chg.pc = new.pc
        chg.cc = new.cc
      end

      chg.voice = new.voice if old.voice != new.voice
      chg.fax = new.fax if old.fax != new.fax
      chg.email = new.email if old.email != new.email
      chg.consent_for_publishing = new.consent_for_publishing if old.consent_for_publishing != new.consent_for_publishing
      chg.registrant_nationality_code = new.registrant_nationality_code if old.registrant_nationality_code != new.registrant_nationality_code
      chg.registrant_entity_type = new.registrant_entity_type if old.registrant_entity_type != new.registrant_entity_type
      chg.registrant_reg_code = new.registrant_reg_code if old.registrant_reg_code != new.registrant_reg_code

      self
    end

    class Add
      attr_accessor :statuses

      def initialize(opts = {})
        opts.each { |k,v| send("#{k}=", v) }
      end
    end

    class Rem
      attr_accessor :statuses

      def initialize(opts = {})
        opts.each { |k,v| send("#{k}=", v) }
      end
    end

    class Chg
      attr_accessor :name
      attr_accessor :org
      attr_accessor :street
      attr_accessor :sp
      attr_accessor :city
      attr_accessor :pc
      attr_accessor :cc
      attr_accessor :voice
      attr_accessor :fax
      attr_accessor :email
      attr_accessor :consent_for_publishing
      attr_accessor :registrant_nationality_code
      attr_accessor :registrant_entity_type
      attr_accessor :registrant_reg_code

      def initialize(opts = {})
        opts.each { |k,v| send("#{k}=", v) }
      end
    end
  end
end

end
