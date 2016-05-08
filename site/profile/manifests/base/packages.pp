# Profile for installing necessary packages
class profile::base::packages {

  $packages_present = hiera_array('packages_present', [])
  ensure_resource('package', $packages_present, {'ensure' => 'present'})
}
