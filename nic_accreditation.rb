#!/usr/bin/env ruby

require 'logger'
require 'eppit'

require 'irb'

class NicAccredSession

  def initialize
    #@uri = 'https://epp-acc1.nic.it:443'
    @uri = 'https://pub-test.nic.it:443'
    @tag = 'REGISTRAR-REG'
    @tag2 = 'REGISTRAR1-REG'
    @password = 'pippo'
    @new_password = 'pippo9999'
    @password2 = 'pluto'

    @hprefix = 'reg-test1-'
    @devmode =  true
    @ca_file = '/etc/ssl/certs/bundle.ca'

    start
  end

  def start
    @epp = Epp::Session.new(
                :uri => @uri,
                :tag => @tag,
                :password => @password,
                :logger => Logger.new(STDOUT),
                :debug => true,
                :services => ['urn:ietf:params:xml:ns:contact-1.0',
                              'urn:ietf:params:xml:ns:domain-1.0'],
                :extensions => ['http://www.nic.it/ITNIC-EPP/extepp-1.0',
                                'http://www.nic.it/ITNIC-EPP/extcon-1.0',
                                'http://www.nic.it/ITNIC-EPP/extdom-1.0',
                                'urn:ietf:params:xml:ns:rgp-1.0'],
                :store_file => 'tmp/accred.store.dat',
                :xml_log_file => 'log/accred.log.xml',
                :ca_file => @ca_file,
                :session_handling => :disable)

    @epp2 = Epp::Session.new(
                :uri => @uri,
                :tag => @tag2,
                :password => @password2,
                :logger => Logger.new(STDOUT),
                :debug => true,
                :services => ['urn:ietf:params:xml:ns:contact-1.0',
                              'urn:ietf:params:xml:ns:domain-1.0'],
                :extensions => ['http://www.nic.it/ITNIC-EPP/extepp-1.0',
                                'http://www.nic.it/ITNIC-EPP/extcon-1.0',
                                'http://www.nic.it/ITNIC-EPP/extdom-1.0',
                                'urn:ietf:params:xml:ns:rgp-1.0'],
                :store_file => 'tmp/accred1.store.dat',
                :xml_log_file => 'log/accred1.log.xml',
                :ca_file => @ca_file,
                :session_handling => :disable)

    @aa100=Epp::Contact.new
    @aa100.nic_id = @hprefix + 'AA100'
    @aa100.name = 'Arnoldo Asso'
    @aa100.org = 'Arnoldo Asso'
    @aa100.street = 'viale Garibaldi 23'
    @aa100.city = 'Pisa'
    @aa100.sp = 'PI'
    @aa100.pc = '56100'
    @aa100.cc = 'IT'
    @aa100.voice = '+39.050112112'
    @aa100.fax = '+39.050113113'
    @aa100.email = 'arnoldo@asso.it'
    @aa100.auth_info_pw = '1BAR-foo'
    @aa100.consent_for_publishing = 'true'
    @aa100.registrant_nationality_code = 'IT'
    @aa100.registrant_entity_type = 1
    @aa100.registrant_reg_code = 'SSARLD69A01G702E'

    @bb100=Epp::Contact.new
    @bb100.nic_id = @hprefix + 'BB100'
    @bb100.name = 'Carlo Verdi'
    @bb100.org = 'Banda Bassotti S.p.A.'
    @bb100.street = 'via Deposito 23'
    @bb100.city = 'Livorno'
    @bb100.sp = 'LI'
    @bb100.pc = '57100'
    @bb100.cc = 'IT'
    @bb100.voice = '+39.0586313131'
    @bb100.fax = '+39.0586313313'
    @bb100.email = 'rossi@bandabassotti.it'
    @bb100.auth_info_pw = '2fooBAR'
    @bb100.consent_for_publishing = 'true'
    @bb100.registrant_nationality_code = 'IT'
    @bb100.registrant_entity_type = 2
    @bb100.registrant_reg_code = @devmode ? '02118311006' : '12345678910'

    @ee100=Epp::Contact.new
    @ee100.nic_id = @hprefix + 'EE100'
    @ee100.name = 'Mario Lenzi'
    @ee100.org = 'Associazione Energia Economica'
    @ee100.street = 'via Energy 10'
    @ee100.city = 'Acireale'
    @ee100.sp = 'CT'
    @ee100.pc = '95094'
    @ee100.cc = 'IT'
    @ee100.voice = '+39.095999999'
    @ee100.fax = '+39.095888888'
    @ee100.email = 'info@saveenergy.it'
    @ee100.auth_info_pw = 'h2o-N2'
    @ee100.consent_for_publishing = 'true'
    @ee100.registrant_nationality_code = 'IT'
    @ee100.registrant_entity_type = 4
    @ee100.registrant_reg_code = '33300022200'

    @cc001=Epp::Contact.new
    @cc001.nic_id = @hprefix + 'CC001'
    @cc001.name = 'Corrado Camel'
    @cc001.org = 'Minerali srl'
    @cc001.street = 'viale Arno 11'
    @cc001.city = 'Pisa'
    @cc001.sp = 'PI'
    @cc001.pc = '56100'
    @cc001.cc = 'IT'
    @cc001.voice = '+39.050111222'
    @cc001.fax = '+39.0503222111'
    @cc001.email = 'glass@mineralwater.it'
    @cc001.auth_info_pw = 'Water-2008'
    @cc001.consent_for_publishing = 'true'

    @dd001=Epp::Contact.new
    @dd001.nic_id = @hprefix + 'DD001'
    @dd001.name = 'Donald Duck'
    @dd001.org = 'Warehouse Ltd'
    @dd001.street = 'Warehouse street 1'
    @dd001.city = 'London'
    @dd001.sp = 'London'
    @dd001.pc = '20010'
    @dd001.cc = 'GB'
    @dd001.voice = '+44.2079696010'
    @dd001.fax = '+44.2079696620'
    @dd001.email = 'donald@duck.uk'
    @dd001.auth_info_pw = 'Money-08'
    @dd001.consent_for_publishing = 'true'

    @hh100=Epp::Contact.new
    @hh100.nic_id = @hprefix + 'HH100'
    @hh100.name = 'Mario Lenzi'
    @hh100.org = 'Associazione Energia Economica'
    @hh100.street = 'via Energy 10'
    @hh100.city = 'Acireale'
    @hh100.sp = 'CT'
    @hh100.pc = '95094'
    @hh100.cc = 'IT'
    @hh100.voice = '+39.095999999'
    @hh100.fax = '+39.095888888'
    @hh100.email = 'info@saveenergy.it'
    @hh100.auth_info_pw = 'h2o-N2'
    @hh100.consent_for_publishing = 'true'
    @hh100.registrant_nationality_code = 'IT'
    @hh100.registrant_entity_type = 4
    @hh100.registrant_reg_code = '33300022200'

    @test1=Epp::Domain.new
    @test1.name = @hprefix + 'test1.it'
    @test1.period = 1
    @test1.nameservers = [ Epp::Domain::NameServer.new(:name => 'ns1.test1.it', :ipv4 => '192.168.10.100'),
                           Epp::Domain::NameServer.new(:name => 'ns2.test1.it', :ipv4 => '192.168.11.200') ]
    @test1.registrant = @hprefix + 'AA100'
    @test1.admin_contacts = [@hprefix + 'AA100']
    @test1.tech_contacts = [@hprefix + 'CC001']
    @test1.auth_info_pw = 'WWWtest-it'

    @testone=Epp::Domain.new
    @testone.name = @hprefix + 'test-one.it'
    @testone.period = 1
    @testone.nameservers = [ Epp::Domain::NameServer.new(:name => 'ns1.foo.com'),
                             Epp::Domain::NameServer.new(:name => 'ns2.bar.com') ]
    @testone.registrant = @hprefix + 'BB100'
    @testone.admin_contacts = [@hprefix + 'DD001']
    @testone.tech_contacts = [@hprefix + 'DD001']
    @testone.auth_info_pw = 'WWWtest-one'

    nil
  end

  def test1
    puts 'Connect'
    @epp.connect

    puts 'Hello'
    @epp.hello

    puts "session_id is now #{@epp.cookies}"

    :ok
  end

  def test2
    puts 'Login'

    begin
      @epp.login
    rescue Epp::Session::ErrorResponse => e
      puts "Ignoring error #{e}"
    end

    :ok
  end

  def test3
    puts 'Logout'
    begin
      @epp.logout
    rescue Epp::Session::ErrorResponse => e
      puts "Ignoring error #{e}"
    end

    puts 'Login (with pw change)'
    begin
      @epp.login(:newpw => @new_password)
    rescue Epp::Session::ErrorResponse => e
      puts "Ignoring error #{e}"
    end
    :ok
  end

  def test4
    puts 'Poll'
    poll = @epp.poll

    if poll.msg.response.msgq
      puts "Acking ##{poll.msg.response.msgq.id}"
      @epp.ack poll.msg.response.msgq.id
    else
      puts "!! There should be a message in queue !!"
      return :ko
    end
  end

  def test5
    puts "contact_check(['AA100','BB100','CC001','DD001','EE100'])"

    res = @epp.contact_check(['AA100','BB100','CC001','DD001','EE100'])

    res.object.each do |k,v|
      puts "#{k}: " + (v[:avail] ? 'AVAILABLE' : 'NOT AVAILABLE')
    end

    :ok
  end

  def test6
    puts 'contact_create(aa100)'
    @epp.contact_create(@aa100)

    puts 'contact_create(bb100)'
    @epp.contact_create(@bb100)

    puts 'contact_create(ee100)'
    @epp.contact_create(@ee100)

    :ok
  end

  def test7
    puts 'contact_create(cc001)'
    @epp.contact_create(@cc001)

    puts 'contact_create(dd001)'
    @epp.contact_create(@dd001)

    :ok
  end

  def test8
    @aa100.voice = 'aaa'
    @aa100.snapshot
    @aa100.voice = '+39.050222222'

    puts 'contact_update(aa100)'
    @epp.contact_update(@aa100)

    :ok
  end

  def test9
    puts "contact_info('AA100')"
    @epp.contact_info(@hprefix + 'AA100')

    :ok
  end

  def test10
    puts "domain_check(['test1.it', 'test-one.it'])"
    @epp.domain_check(['test1.it', 'test-one.it'])

    :ok
  end

  def test11

    puts 'domain_create(test1)'
    @epp.domain_create(@test1)

    puts 'domain_create(testone)'
    @epp.domain_create(@testone)

    :ok
  end

  def test12
    puts "domain_info('test1.it')"
    @epp.domain_info(@hprefix + 'test1.it')

    :ok
  end

  def test13
    @test1.snapshot
    @test1.nameservers.reject! { |ns| ns.name == 'ns2.test1.it' }
    @test1.nameservers << Epp::Domain::NameServer.new(:name => 'ns2.head1.com')

    puts 'domain_update(test1)'
    @epp.domain_update(@test1)

    :ok
  end

  def test14
    @test1.registrant = 'aaa' 
    @test1.snapshot
    @test1.registrant = @hprefix + 'EE100'
    @test1.auth_info_pw = 'new-WWWtest-it'

    puts 'domain_update(test1)'
    @epp.domain_update(@test1)

    :ok
  end

  def test15
    puts '@epp2.connect'
    @epp2.connect

    puts '@epp2.login'
    @epp2.login

    :ok
  end

  def test16
    puts "@epp2.domain_transfer_request('test1.it', 'new-WWWtest-it')"
    @epp2.domain_transfer_request(@hprefix + 'test1.it', 'new-WWWtest-it')

    puts "@epp2.domain_transfer_query('test1.it', 'new-WWWtest-it')"
    @epp2.domain_transfer_query(@hprefix + 'test1.it', 'new-WWWtest-it')

    :ok
  end

  def test17
    puts 'poll'
    poll = @epp.poll

    if !poll.msg.response.msgq
      puts "!! There should be a message in queue !!"
      return :ko
    end

    puts "domain_transfer_approve('test1.it', { :auth_info_pw => 'new-WWWtest-it' })"
    @epp.domain_transfer_approve(@hprefix + 'test1.it', { :auth_info_pw => 'new-WWWtest-it' })

    puts "Acking ##{poll.msg.response.msgq.id}"
    @epp.ack poll.msg.response.msgq.id


    # si aspetta un ack da epp1
    puts '@epp2.poll'
    poll = @epp2.poll

    if !poll.msg.response.msgq
      puts "!! There should be a message in queue !!"
      return :ko
    end

    puts "Acking ##{poll.msg.response.msgq.id}"
    @epp2.ack poll.msg.response.msgq.id

    :ok
  end

  def test18
    @test1.auth_info_pw = 'aaa'
    @test1.snapshot
    @test1.auth_info_pw = 'B-1-test-09'

    puts '@epp2.domain_update(test1)'
    @epp2.domain_update(@test1)

    :ok
  end

  def test19
    puts '@epp2.contact_create(hh100)'
    @epp2.contact_create(@hh100)

    @epp2.domain_transfer_request(@hprefix + 'test-one.it', 'WWWtest-one', { :new_registrant => @hprefix + 'HH100', :new_auth_info_pw => 'http-aa007'})

    :ok
  end

  def test20
    puts 'poll'
    poll = @epp.poll

    if !poll.msg.response.msgq
      puts "!! There should be a message in queue !!"
      return :ko
    end

    puts "domain_transfer_approve('test-one.it', 'WWWtest-one')"
    @epp.domain_transfer_approve(@hprefix + 'test-one.it', :auth_info_pw => 'WWWtest-one')

    :ok
  end

  def test21

    @testone.statuses = []
    @testone.snapshot
    @testone.statuses << 'domain:clientUpdateProhibited'

    puts '@epp2.domain_update(testone)'
    @epp2.domain_update(@testone)

    puts "domain_info('test-one.it')"
    @epp2.domain_info(@hprefix + 'test-one.it')

    @testone.snapshot
    @testone.statuses.delete('domain:clientUpdateProhibited')

    puts "@epp2.domain_update(@testone)"
    @epp2.domain_update(@testone)

    puts "@epp2.domain_info('test-one.it')"
    @epp2.domain_info(@hprefix + 'test-one.it')

    :ok
  end

  def test22
    puts "@epp2.domain_delete('test1.it')"
    @epp2.domain_delete(@hprefix + 'test1.it')

    puts "@epp2.domain_info('test1.it')"
    @epp2.domain_info('test1.it')

    :ok
  end

  def test23
    puts "@epp2.domain_undelete('test1.it')"
    @epp2.domain_undelete(@hprefix + 'test1.it')

    puts "@epp2.domain_info('test1.it')"
    @epp2.domain_info(@hprefix + 'test1.it')

    :ok
  end

  def test24
    puts "@epp.contact_delete('AA100')"
    @epp.contact_delete(@hprefix + 'AA100')

    puts "@epp.contact_check(['AA100'])"
    @epp.contact_check([@hprefix + 'AA100'])

    :ok
  end

  def runtest(num)
    puts "Running test #{num}"
    res = send("test#{num}")

    if res == :ko
      puts 'TEST FAILED!'
    end

    puts ''
    res
  end

  def all
    puts "Starting tests with session_id=#{@epp.cookies}"

    @tests.each do |i|
      res = runtest i

      break if res == :ko
    end
  end

  def prefix(val)
    @hprefix = val
    start
  end

  def print_usage
    puts 'NIC.it accreditation tester'
    puts ' current parameters:'
    puts "   @uri = #{@uri}"
    puts "   @tag = #{@tag}"
    puts "   @password = #{@password}"
    puts "   @new_password = #{@new_password}"
    puts "   @tag2 = #{@tag2}"
    puts "   @password2 = #{@password2}"
    puts "   @devmode = #{@devmode}"
    puts "   @hprefix = #{@hprefix}"
    puts "   @ca_file = #{@ca_file}"
    puts ''
    puts 'Available commands:'
    puts '  testX   : run test "X"'
    puts '  all     : run all tests'
    puts '  prefix  : set prefix prepended to nic handles and domain names, for development'
    puts '  start   : initialize all object with new parameters'
    puts ''
    puts 'Variables:'
    puts '  @epp    : EPP session as registry 1'
    puts '  @epp2   : EPP session as registry 2'
  end
end

module IRB # :nodoc:
  def self.start_session(binding)
    unless @__initialized
      args = ARGV
      ARGV.replace(ARGV.dup)
      IRB.setup(nil)
      ARGV.replace(args)
      @__initialized = true
    end

    workspace = WorkSpace.new(binding)

    irb = Irb.new(workspace)

    @CONF[:IRB_RC].call(irb.context) if @CONF[:IRB_RC]
    @CONF[:MAIN_CONTEXT] = irb.context

    catch(:IRB_EXIT) do
      irb.eval_input
    end
  end
end

sess = NicAccredSession.new

sess.print_usage

IRB.start_session(sess)

