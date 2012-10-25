define activemq::instance::authorization($type, $destination, $read, $write, $admin, $target_instance) {

  include activemq::params

  $instance_xml = "${activemq::params::amq_instancedir}/${target_instance}/activemq.xml"
  $data = inline_template("                  <authorizationEntry <%= @type %>=\"<%= destination %>\" write=\"<%= write %>\" read=\"<%= @read %>\" admin=\"<%= admin %>\" />\n")

  concat::fragment { "${target_instance}-authorization-${name}":
    content => $data,
    order   => '350',
    target  => $instance_xml,
  }
}
