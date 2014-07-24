require 'UPnP'

module MCollective
  module Agent
    class Upnp < RPC::Agent
      action 'add_port_mapping' do
        validate :port, Integer
        validate :client, :ipv4address unless request[:client].nil?
        validate :local_port, Integer
        validate :protocol, ['tcp', 'udp']
        validate :description, String

        protocol = { 'tcp' => UPnP::Protocol::TCP, 'udp' => UPnP::Protocol::UDP }[request[:protocol]]

        begin
          upnp = UPnP::UPnP.new

          begin
            upnp.portMapping(request[:port], protocol)

            reply.fail("#{request[:protocol].upcase} mapping of port #{request[:port]} already exists")
            return
          rescue UPnP::UPnPException
          end

          upnp.addPortMapping(request[:port], request[:local_port], protocol, request[:description], request[:client])

          reply[:status] = "#{request[:port]} -> #{request[:client] || upnp.lanIP}:#{request[:local_port]} (#{request[:protocol].upcase})"
        end
      end

      action 'delete_port_mapping' do
        validate :port, Integer
        validate :protocol, ['tcp', 'udp']

        proto = { 'tcp' => UPnP::Protocol::TCP, 'udp' => UPnP::Protocol::UDP }[request[:protocol]]

        UPnP::UPnP.new.deletePortMapping(request[:port], proto)
      end

      action 'list_port_mappings' do
        upnp = UPnP::UPnP.new
        reply[:redirects] = upnp.portMappings.map { |m| { :client => m.client, :lport => m.lport, :nport => m.nport } }
      end
    end
  end
end
