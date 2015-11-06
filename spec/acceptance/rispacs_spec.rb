require 'spec_helper_acceptance'

describe 'rispacs class' do

  describe 'running puppet code' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      tmpdir = default.tmpdir('rispacs')
      pp = <<-EOS
        include role::rispacs
      EOS

      apply_manifest(pp, :catch_failures => true)
    end
  end
end

