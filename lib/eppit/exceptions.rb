module Eppit
class Session

class ErrorResponse < StandardError #:nodoc:
  attr_accessor :epp_message
  attr_accessor :response
  attr_accessor :response_code
  attr_accessor :reason
  attr_accessor :reason_code

  # Generic EPP exception. Accepts a response code and a message
  def initialize(epp_msg)
    @response = epp_msg.response.result.msges['en']
    @response_code = epp_msg.response.result.code
    @reason = epp_msg.response.result.ext_value ? epp_msg.response.result.ext_value.reasons['en'] : nil
    @reason_code = epp_msg.response.result.ext_value ? epp_msg.response.result.ext_value.reason_code : nil
    @cl_tr_id = epp_msg.response.cl_tr_id
    @sv_tr_id = epp_msg.response.sv_tr_id
    @xml = epp_msg.to_xml.to_s

    super("#{@response_code}:#{epp_msg.response.result.msges['en'].strip} (#{@reason_code}:#{@reason})")
  end
end

class TransportError < StandardError #:nodoc:
end

end
end
