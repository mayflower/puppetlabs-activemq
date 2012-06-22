class activemq::instance::stomp {

  include activemq::params

  $instance_xml = "${activemq::params::amq_instancedir}/stomp/activemq.xml"

  activemq::instance {'stomp': ssl => true}

  # Management context.
  concat::fragment { 'stomp-management':
    content => template('activemq/instances/stomp/management.xml.erb'),
    order   => '020',
    target  => $instance_xml,
  }

  ##############################################################################
  # BEGIN: plugins
  # ORDER 100 - 500
  ##############################################################################
  concat::fragment { 'stomp-begin-plugins':
    content => "        <plugins>\n",
    order   => '100',
    target  => $instance_xml,
  }


  # Random things
  # ORDER 101 - 200
  concat::fragment { 'stomp-plugin-statistics':
    content => "          <statisticsBrokerPlugin/>\n",
    order   => '110',
    target  => $instance_xml,
  }

  ######################################
  # BEGIN: Authentication
  # ORDER 201 - 300
  ######################################
  concat::fragment { 'stomp-plugin-begin-authn':
    content => template('activemq/instances/stomp/plugin-begin-authn.xml.erb'),
    order   => '201',
    target  => $instance_xml,
  }

  concat::fragment { 'stomp-plugin-end-authn':
    content => template('activemq/instances/stomp/plugin-end-authn.xml.erb'),
    order   => '300',
    target  => $instance_xml,
  }
  ######################################
  # END: Authentication
  ######################################

  ######################################
  # BEGIN: Authorization
  # ORDER 301 - 400
  ######################################
  concat::fragment { 'stomp-plugin-begin-authz':
    content => template('activemq/instances/stomp/plugin-begin-authz.xml.erb'),
    order   => '301',
    target  => $instance_xml,
  }

  concat::fragment { 'stomp-plugin-end-authz':
    content => template('activemq/instances/stomp/plugin-end-authz.xml.erb'),
    order   => '400',
    target  => $instance_xml,
  }
  ######################################
  # END: Authorization
  ######################################

  concat::fragment { 'stomp-end-plugins':
    content => "        </plugins>\n",
    order  => '500',
    target => $instance_xml,
  }

  ##############################################################################
  # END: plugins
  ##############################################################################

  ##############################################################################
  # BEGIN: RANDOM AND SUNDRY THINGS
  # 500 - 900
  ##############################################################################

  # Limit system usage
  concat::fragment { 'stomp-systemusage':
    content => template('activemq/instances/stomp/systemusage.xml.erb'),
    order   => '510',
    target  => $instance_xml,
  }

  ######################################
  # BEGIN: Transport connectors
  # ORDER 700 - 800
  ######################################
  concat::fragment { 'stomp-transportconnectors-begin':
    content => "        <transportConnectors>\n",
    order   => '700',
    target  => $instance_xml,
  }

  concat::fragment { 'stomp-transportconnectors-end':
    content => "        </transportConnectors>\n",
    order   => '799',
    target  => $instance_xml,
  }

  ######################################
  # END: Transport connectors
  ######################################

  ##############################################################################
  # END: RANDOM AND SUNDRY THINGS
  ##############################################################################
}
