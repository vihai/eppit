
require 'eppit'

describe 'EppIt' do
  it 'can initialize' do
    Epp::Session.new(
         :uri => 'https://pub-test.nic.it:443',
         :tag => 'REG-REG',
         :password => 'password',
         :logger => Logger.new(STDOUT),
         :debug => true,
         :services => ['urn:ietf:params:xml:ns:contact-1.0',
                       'urn:ietf:params:xml:ns:domain-1.0'],
         :extensions => ['http://www.nic.it/ITNIC-EPP/extepp-1.0',
                         'http://www.nic.it/ITNIC-EPP/extcon-1.0',
                         'http://www.nic.it/ITNIC-EPP/extdom-1.0',
                         'urn:ietf:params:xml:ns:rgp-1.0'],
         :store_file => 'accred.store.dat',
         :xml_log_file => 'accred.log.xml',
         :ca_file => '/etc/ssl/certs/ca-certificates.crt')
  end
end
