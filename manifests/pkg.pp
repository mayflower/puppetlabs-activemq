class activemq::pkg(
  $pkg_provider = $activemq::params::pkg_provider
) inherits activemq::params {

  package { "activemq":
    ensure   => present,
    provider => $pkg_provider,
  }

  # Not sure if this belongs here.
  file { $activemq::params::amq_logdir:
    ensure => directory,
    owner  => activemq,
    group  => activemq,
    mode   => '0750',
    before => Service['activemq'],
  }
}
