define activemq::instance::user($username, $password, $groups, $target_instance) {

  include activemq::params

  $groups_str = is_string($groups) ? {
    true  => $groups,
    false => join($groups, ','),
  }

  $instance_xml = "${activemq::params::amq_instancedir}/${target_instance}/activemq.xml"
  $data = "              <authenticationUser username=\"${username}\" password=\"${password}\" groups=\"${groups_str}\"/>\n"

  concat::fragment { "${target_instance}-user-${name}":
    content => $data,
    order   => '250',
    target  => $instance_xml,
  }
}
