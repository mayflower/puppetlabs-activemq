define activemq::instance::stomp::protocol($protocol_name, $uri, $target_instance) {

  $instance_xml = "${activemq::params::amq_instancedir}/${target_instance}/activemq.xml"
  $data = inline_template("            <transportConnector name=\"<%= protocol_name %>\" uri=\"<%= @uri %>\"/>\n")

  concat::fragment { "${target_instance}-authorization-${name}":
    content => $data,
    order   => '750',
    target  => $instance_xml,
  }
}
