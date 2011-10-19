require 'puppet/provider/parsedfile'

begin
  case Facter.operatingsystem
    when "Solaris"
      sudoers = '/opt/csw/etc/sudoers'
    else
      sudoers = '/etc/sudoers'
  end
rescue
  Facter.loadfacts()
end

Puppet::Type.type(:sudoers).provide(:parsed, 
                                    :parent => Puppet::Provider::ParsedFile, 
                                    :default_target => sudoers, 
                                    :filetype => :flat) do

  desc "The sudoers provider that used the ParsedFile class."

  text_line :comment, :match => /^#/;
  text_line :blank, :match => /^\s*$/;

  record_line :parsed,
    :fields => %w{name nopasswd commands},
    :pre_gen => proc { |h|
      h[:nopasswd] = h[:nopasswd] == :true ? "ALL=NOPASSWD:" : "ALL=(ALL)"
      h[:commands] = [] if h[:commands].include?(:absent)
      h[:commands] = h[:commands].join(', ')
    }

end
