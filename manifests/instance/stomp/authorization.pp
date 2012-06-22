define activemq::instance::stomp::authorization(type, content, read, write, admin, target_instance) {

  $instance_xml = "${activemq::params::amq_instancedir}/${target_instance}/activemq.xml"
  $data => inline_template("                  <authorizationEntry <% @type %>=\"<%= content %>\" write=\"<%= write %>\" read=\"<%= @read %>\" admin=\"<%= admin %>\" />\n")

  concat::fragment { "${target_instance}-authorization-${name}":
    content => $data,
    order   => '350',
    target  => $instance_xml,
  }
}
