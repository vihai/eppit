#!/usr/bin/env ruby

require 'bundler/setup'

require 'logger'
require 'pry'

require 'eppit/session'

class NicAccredSession

  def initialize
    #@uri = 'https://epp-acc1.nic.it:443'
    @uri = 'https://pub-test.nic.it:443'
    @tag = 'ISP-REG'
    @password = 'password'
  end

  def start
    @epp = Eppit::Session.new(
      :uri => @uri,
      :tag => @tag,
      :password => @password,
      :logger => Logger.new(STDOUT),
      :debug_http => true,
      :services => [
        'urn:ietf:params:xml:ns:contact-1.0',
        'urn:ietf:params:xml:ns:domain-1.0'
      ],
      :extensions => [
        'http://www.nic.it/ITNIC-EPP/extepp-1.0',
        'http://www.nic.it/ITNIC-EPP/extcon-1.0',
        'http://www.nic.it/ITNIC-EPP/extdom-1.0',
        'urn:ietf:params:xml:ns:rgp-1.0'
      ],
      :store_file => 'tmp/accred.store.dat',
      :xml_log_file => 'log/accred.log.xml',
      :ca_file => @ca_file,
      :session_handling => :disable
    )
  end

  def print_usage
    puts 'NIC.it accreditation tester'
    puts ' current parameters:'
    puts "   @uri = #{@uri}"
    puts "   @tag = #{@tag}"
    puts "   @password = #{@password}"
    puts ''
    puts 'Available commands:'
    puts '  start   : initialize all object with new parameters'
    puts ''
    puts 'Variables:'
    puts '  @epp    : EPP session as registry 1'
  end
end

sess = NicAccredSession.new

sess.print_usage

sess.pry
