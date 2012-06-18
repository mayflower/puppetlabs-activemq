# Generic activemq instance define.
define activemq::instance($template, $template_options = {}) {

  include activemq::params

  $instance_dir     = "${activemq::params::amq_instancedir}/${name}"
  $instance_xml     = "${activemq::params::amq_instancedir}/${name}/activemq.xml"
  $instance_logging = "${activemq::params::amq_instancedir}/${name}/log4j.properties"

  file { $instance_dir:
    ensure => directory,
    owner   => 'root',
    group   => 'root',
  }

  file { $instance_xml:
    ensure  => file,
    content => template($template),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    require => Class['activemq::pkg'],
    notify  => Class['activemq::service'],
  }

  # REVIEW: This properties file is hardcoded, but it might be better to
  # allow logging injection
  file { $instance_logging:
    ensure  => file,
    source  => 'puppet:///modules/activemq/log4j.properties',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    require => Class['activemq::pkg'],
    notify  => Class['activemq::service'],
  }
}
