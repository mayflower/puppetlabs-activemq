class activemq::base {
  class { 'activemq': }
  class { 'activemq::pkg': }
  class { 'activemq::service': }
}
