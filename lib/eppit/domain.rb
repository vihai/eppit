
module Eppit

class Domain

  attr_accessor :name
  attr_accessor :roid
  attr_accessor :statuses
  attr_accessor :registrant
  attr_accessor :admin_contacts
  attr_accessor :tech_contacts
  attr_accessor :nameservers
  attr_accessor :cl_id
  attr_accessor :cr_id
  attr_accessor :cr_date
  attr_accessor :ex_date
  attr_accessor :up_id
  attr_accessor :up_date
  attr_accessor :tr_date
  attr_accessor :auth_info_pw
  attr_accessor :period

  attr_accessor :nameservers_to_validate

  def initialize(opts = {})
    @statuses = []
    @admin_contacts = []
    @tech_contacts = []
    @nameservers = []
    @nameservers_to_validate = []

    opts.each { |k,v| send("#{k}=", v) }
  end

  class Nameserver
    attr_accessor :name
    attr_accessor :ipv4
    attr_accessor :ipv6

    def initialize(opts)
      @ipv4 = []
      @ipv6 = []
      opts.each { |k,v| send("#{k}=", v) }
    end

    def ==(other)
      name == other.name && ipv4 == other.ipv4 && ipv6 == other.ipv6
    end

    def eql?(other)
      self == other
    end

    def hash
      (name.to_s + ipv4.to_s + ipv6.to_s).hash
    end
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
      add.admin_contacts = (new.admin_contacts - old.admin_contacts)
      add.tech_contacts = (new.tech_contacts - old.tech_contacts)
      add.statuses = (new.statuses - old.statuses)
      add.nameservers = new.nameservers - old.nameservers

      chg.registrant = new.registrant if new.registrant != old.registrant
      chg.auth_info_pw = new.auth_info_pw if new.auth_info_pw != old.auth_info_pw || new.registrant != old.registrant

      rem.admin_contacts = (old.admin_contacts - new.admin_contacts)
      rem.tech_contacts = (old.tech_contacts - new.tech_contacts)
      rem.statuses = (old.statuses - new.statuses)
      rem.nameservers = old.nameservers - new.nameservers

#              domain_statuses = domain.statuses.select { |x| x =~ /^domain:/ }.map { |x| x[7..-1] }
#              domain_orig_statuses = domain.orig.statuses.select { |x| x =~ /^domain:/ }.map { |x| x[7..-1] }

      self
    end

    class Add
      attr_accessor :admin_contacts
      attr_accessor :tech_contacts
      attr_accessor :statuses
      attr_accessor :nameservers

      def initialize(opts = {})
        opts.each { |k,v| send("#{k}=", v) }
      end
    end

    class Rem
      attr_accessor :admin_contacts
      attr_accessor :tech_contacts
      attr_accessor :statuses
      attr_accessor :nameservers

      def initialize(opts = {})
        opts.each { |k,v| send("#{k}=", v) }
      end
    end

    class Chg
      attr_accessor :registrant
      attr_accessor :auth_info_pw

      def initialize(opts = {})
        opts.each { |k,v| send("#{k}=", v) }
      end
    end
  end
end

end
