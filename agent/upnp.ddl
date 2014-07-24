# vim:syntax=ruby:
metadata :name        => 'upnp',
         :description => 'UPnP configuration agent for MCollective',
         :author      => 'Romain Tartière',
         :license     => 'MIT',
         :version     => '1.0',
         :url         => 'https://github.com/sante-link/mcollective-upnp',
         :timeout     => 10

action "add_port_mapping", :description => 'Add a port mapping on the router' do
  display :always

  input :port,
        :prompt      => 'Network port',
        :description => 'Port to listen from on the Internet',
        :type        => :integer,
        :optional    => false

  input :client,
        :prompt      => 'Client',
        :description => 'Address of the client',
        :type        => :string,
        :validation  => '.',
        :maxlength   => 50,
        :optional    => true

  input :local_port,
        :prompt      => 'Local port',
        :description => 'Port to connect to on the client',
        :type        => :integer,
        :optional    => false

  input :protocol,
        :prompt      => 'Protocol',
        :description => 'Port to connect to on the client',
        :type        => :list,
        :list        => ['tcp', 'udp'],
        :optional    => false

  input :description,
        :prompt      => 'Description',
        :description => 'Description of the port mapping',
        :type        => :string,
        :validation  => '.',
        :maxlength   => 256,
        :optional    => true

  output :status,
         :description => 'The status of the insertion',
         :display_as  => 'Status'
end

action "delete_port_mapping", :description => 'Delete a port mapping on the router' do
  display :always

  input :port,
        :prompt      => 'Network port',
        :description => 'Port to listen from on the Internet',
        :type        => :integer,
        :optional    => false

  input :protocol,
        :prompt      => 'Protocol',
        :description => 'Port to connect to on the client',
        :type        => :list,
        :list        => ['tcp', 'udp'],
        :optional    => false

  output :status,
         :description => 'The status of the removal',
         :display_as  => 'Status'
end

action "list_port_mappings", :description => 'List port mapping on the router' do
  display :always
  output :redirects,
         :description => 'Configured port mappings',
         :display_as  => 'Redirects'
end
