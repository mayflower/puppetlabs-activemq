# = activemq::instance::sections
#
# == Description
#
# This defines the general XML sections.
#
# == Ordering:
#
# * Destination policy: 010
# * Management context: 020
# * Plugins: 100 - 500
#   * generic plugins: 101 - 200
#   * authentication: 201 - 300
#   * authorization: 301 - 400
# * systam usage limits: 510
# * transport connectors: 700 - 800
#
# == Usage
#
# This is for use by activemq::instance; you shouldn't use it directly.
#
# == Caveats
#
# The elements contained in the broker element in activemq.xml MUST be in
# alphabetical order. Yes, this is insane. Yes, it's bizarre. If you start
# getting parse errors on clearly valid XML, make sure that those top level
# XML elements are in alphabetical order.
#
#     Beginning in ActiveMQ 5.4, the XML elements inside the <broker> element must
#     be ordered alphabetically. If you look at the XSD, this has always been the
#     case with ActiveMQ. The difference in 5.4 is that the XML configuration is
#     actually being validated against the XML schema.
#
# @see http://activemq.apache.org/xml-reference.html
#
define activemq::instance::sections($ssl = false) {

  include activemq::params

  $instance_xml = "${activemq::params::amq_instancedir}/${name}/activemq.xml"

  Concat::Fragment {
    target  => $instance_xml,
  }

  ######################################
  # Destination policy for garbage collection.
  # ORDER: 020
  #
  concat::fragment { "${name}-destinationpolicy":
    content => template('activemq/activemq.xml/destinationpolicy.xml.erb'),
    order   => '010',
  }

  ######################################
  # Management context.
  # ORDER: 020
  #
  concat::fragment { "${name}-management":
    content => template('activemq/activemq.xml/management.xml.erb'),
    order   => '020',
  }

  ##############################################################################
  # All plugins
  # ORDER 100 - 500
  #
  concat::fragment {
    "${name}-begin-plugins":
      content => "        <plugins>\n",
      order   => '100',
    "${name}-end-plugins":
      content => "        </plugins>\n",
      order  => '500',
  }

  ######################################
  # Various plugins
  # ORDER 101 - 200
  #
  concat::fragment { "${name}-plugin-statistics":
    content => "          <statisticsBrokerPlugin/>\n",
    order   => '110',
  }

  ######################################
  # Authentication
  # ORDER 201 - 300
  #
  concat::fragment {
    "${name}-plugin-begin-authn":
      content => template('activemq/activemq.xml/plugin-begin-authn.xml.erb'),
      order   => '201',
    "${name}-plugin-end-authn":
      content => template('activemq/activemq.xml/plugin-end-authn.xml.erb'),
      order   => '300',
  }

  ######################################
  # Authorization
  # ORDER 301 - 400
  #
  concat::fragment {
    "${name}-plugin-begin-authz":
      content => template('activemq/activemq.xml/plugin-begin-authz.xml.erb'),
      order   => '301',
    "${name}-plugin-end-authz":
      content => template('activemq/activemq.xml/plugin-end-authz.xml.erb'),
      order   => '400',
  }

  if $ssl {
    ########################################
    # Enable SSL
    # ORDER 505
    #
    concat::fragment { "${name}-ssl":
      content => template('activemq/activemq.xml/ssl.xml.erb'),
      order   => '505',
    }
  }

  ########################################
  # Limit system usage
  # ORDER 510
  #
  concat::fragment { "${name}-systemusage":
    content => template('activemq/activemq.xml/systemusage.xml.erb'),
    order   => '510',
  }

  ######################################
  # Transport connectors
  # ORDER 700 - 800
  #
  concat::fragment {
    "${name}-transportconnectors-begin":
      content => "        <transportConnectors>\n",
      order   => '700',
    "${name}-transportconnectors-end":
      content => "        </transportConnectors>\n",
      order   => '799',
  }
}
