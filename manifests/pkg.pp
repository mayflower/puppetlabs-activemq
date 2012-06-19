class activemq::pkg(
  $pkg_provider = $activemq::params::pkg_provider
) inherits activemq::params {

  package { "activemq":
    ensure   => present,
    provider => $pkg_provider,
  }

  # Not sure if this belongs here.
  file { '/var/log/activemq':
    ensure => directory,
    owner  => activemq,
    group  => activemq,
    mode   => '0750',
    before => Service['activemq'],
  }
}
