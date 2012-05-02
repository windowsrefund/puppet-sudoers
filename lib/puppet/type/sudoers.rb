module Puppet
  newtype(:sudoers) do
    @doc = "Manage the sudoers file"

    ensurable

		def munge_boolean(value)
			case value
				when true, "true", :true
					:true
				when false, "false", :false
					:false
			else
				fail("munge_boolean only takes booleans")
			end
		end

    newproperty(:nopasswd, :boolean => :true) do
      desc "NOPASSWD option."

      newvalues(:true, :false)
      defaultto :false

			munge do |val|
				@resource.munge_boolean(val)
			end
    end

    newproperty(:target) do
      desc "The location of the sudoers file."

      defaultto {
        if @resource.class.defaultprovider.ancestors.include?(Puppet::Provider::ParsedFile)
          @resource.class.defaultprovider.default_target
        else
          nil
        end
      }

    end

    newproperty(:commands, :array_matching => :all) do
      desc "Commands to allow. Multiple commands should be passed in as an array."

      defaultto :absent

      validate do |val|
        raise Puppet::Error, "Multiple commands must be provided as an array, not a comma separated list." if val != :absent and val.include?(',')
      end
    end

    newparam(:name, :namevar => :true) do
      desc "The user or group to manage."

      validate do |val|
        raise Puppet::Error, "Resource name must not contain whitespace: #{val}" if val =~ /\s/
      end
    end

    validate do
      # Go ahead if commands attribute is defined

      return if @parameters[:commands].shouldorig[0] != :absent

      raise Puppet::Error, "The sudoers type requires the 'commands' attribute."
    end

    autorequire(:user) do 
      should(:user) if should(:user)
    end

    autorequire(:group) do 
      should(:group) if should(:group) and @parameters[:isgroup] == :true
    end

  end
end
