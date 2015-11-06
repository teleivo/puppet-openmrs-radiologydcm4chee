require 'beaker-rspec'
require 'beaker/puppet_install_helper'

run_puppet_install_helper

UNSUPPORTED_PLATFORMS = [ 'Windows', 'Solaris', 'AIX', 'Suse', 'RedHat' ]

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  puppetfile_modules = File.join(proj_root, 'spec', 'fixtures', 'modules')

  # scp required files/folders onto master
  files = [ 'hieradata', 'site', 'Gemfile', 'hiera.yaml', 'Puppetfile', 'modules' ]

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module and dependencies
    #puppet_module_install(:source => proj_root, :module_name => 'dcm4chee')
    hosts.each do |host|
      # Install this module, this is required because symlinks are not
      # transferred in the step below
      # copy_module_to(host, :source => proj_root, :module_name => 'profiles"')
      # copies all the fixtures over
      #rsync_to(host, fixture_modules, '/etc/puppet/modules/')
    
      files.each do |file|
        scp_to host, File.expand_path(File.join(File.dirname(__FILE__), '..', file)), "/etc/puppet/#{file}"
      end
    end
  end
end
