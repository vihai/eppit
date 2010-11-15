require 'active_support/core_ext'

module Epp #:nodoc:

  class Differentiable
    attr_accessor :orig

    def snapshot
       @orig = Marshal.load(Marshal.dump(self))
    end

    def changed(var)
      @orig.instance_variable_get("@#{var.to_s}") != self.instance_variable_get("@#{var.to_s}")
    end
  end

  class Contact < Differentiable
    attr_accessor :nic_id
    attr_accessor :roid
    attr_accessor :statuses

    # Postal Info
    attr_accessor :name
    attr_accessor :org
    attr_accessor :addr

    # Posta Info Addr
    attr_accessor :street
    attr_accessor :city
    attr_accessor :sp
    attr_accessor :pc
    attr_accessor :cc

    attr_accessor :voice
    attr_accessor :fax
    attr_accessor :email

    attr_accessor :cl_id
    attr_accessor :cr_id
    attr_accessor :cr_date
    attr_accessor :up_id
    attr_accessor :up_date

    attr_accessor :auth_info_pw

    attr_accessor :consent_for_publishing
    attr_accessor :registrant_nationality_code
    attr_accessor :registrant_entity_type
    attr_accessor :registrant_reg_code

    def initialize(h = {})
      @statuses = []
      h.each { |k,v| instance_variable_set "@#{k}".to_sym, v }
    end
  end

  class Domain < Differentiable
    class NameServer
      attr_accessor :name

      def initialize(h = {})
        @ipv4 = []
        @ipv6 = []

        h.each { |k,v| instance_variable_set "@#{k}".to_sym, v }
      end

      def ==(other)
        self.name == other.name && self.ipv4 == other.ipv4 && self.ipv6 == other.ipv6
      end

      def eql?(other)
        self.name == other.name && self.ipv4 == other.ipv4 && self.ipv6 == other.ipv6
      end

      def hash
        self.name.hash + self.ipv4.hash + self.ipv6.hash
      end

      def ipv4=(val)
        if val.is_a(Array)
          @ipv4 = val
        else
          @ipv4 = [val]
        end
      end

      def ipv4
        @ipv4
      end

      def ipv6=(val)
        if val.is_a(Array)
          @ipv6 = val
        else
          @ipv6 = [val]
        end
      end

      def ipv6
        @ipv6
      end
    end

    attr_accessor :name
    attr_accessor :roid
    attr_accessor :period
    attr_accessor :statuses

    attr_accessor :registrant

    attr_accessor :admin_contacts
    attr_accessor :tech_contacts

    attr_accessor :nameservers

    attr_accessor :cl_id
    attr_accessor :cr_id
    attr_accessor :cr_date
    attr_accessor :up_id
    attr_accessor :up_date
    attr_accessor :ex_date
    attr_accessor :tr_date

    attr_accessor :auth_info_pw

    attr_accessor :nameservers_to_validate

    def initialize(h = {})
      @nameservers = []
      @admin_contacts = []
      @tech_contacts = []
      @statuses = []

      @nameservers_to_validate = []

      h.each { |k,v| instance_variable_set "@#{k}".to_sym, v }
    end
  end
end
