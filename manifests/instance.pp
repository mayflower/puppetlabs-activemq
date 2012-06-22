# Generic activemq instance define.
define activemq::instance($ssl = false) {

  include activemq
  include activemq::params

  $instance_dir     = "${activemq::params::amq_instancedir}/${name}"
  $instance_xml     = "${instance_dir}/activemq.xml"
  $instance_logging = "${instance_dir}/log4j.properties"
  $instance_options = "${instance_dir}/options"

  file { $instance_dir:
    ensure => directory,
    owner   => 'root',
    group   => 'root',
  }

  file { $instance_logging:
    ensure  => file,
    content => template('activemq/log4j.properties.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    require => Class['activemq::pkg'],
    notify  => Class['activemq::service'],
  }

  file { $instance_options:
    ensure  => file,
    source  => 'puppet:///modules/activemq/options',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    require => Class['activemq::pkg'],
    notify  => Class['activemq::service'],
  }

  # ---
  # Build our activemq.xml out of itsy bitsy little chunks so that
  # functionality like users and protocols can be broken out into other 
  # defines.

  concat { $instance_xml:
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    require => Class['activemq::pkg'],
    notify  => Class['activemq::service'],
  }

  # Add the XML header
  concat::fragment { "${name}-header":
    target  => $instance_xml,
    content => template('activemq/activemq.xml/header.xml.erb'),
    order   => '000',
  }

  # Close the XML document
  concat::fragment { "${name}-footer":
    target  => $instance_xml,
    content => template('activemq/activemq.xml/footer.xml.erb'),
    order   => '999',
  }

  if $ssl {
    include activemq::instance::ssl

    concat::fragment { "${name}-ssl":
      target  => $instance_xml,
      content => template('activemq/activemq.xml/ssl.xml.erb'),
      order   => '050',
    }
  }
}
