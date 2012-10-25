define activemq::instance::authorization(
  $type,
  $destination,
  $target_instance,
  $read            = undef,
  $write           = undef,
  $admin           = undef,
  $allperms        = undef,
) {

  include activemq::params

  if !($read and $write and $admin) and !$allperms {
    crit("Either all of [read, write, admin] or [allperms] must be specified")
  }

  if $allperms {
    $read_real  = $allperms
    $write_real = $allperms
    $admin_real = $allperms
  }
  else {
    $read_real  = $read
    $write_real = $write
    $admin_real = $admin
  }

  $instance_xml = "${activemq::params::amq_instancedir}/${target_instance}/activemq.xml"
  $data = inline_template("                  <authorizationEntry <%= @type %>=\"<%= destination %>\" write=\"<%= write_real %>\" read=\"<%= read_real %>\" admin=\"<%= admin_real %>\" />\n")

  concat::fragment { "${target_instance}-authorization-${name}":
    content => $data,
    order   => '350',
    target  => $instance_xml,
  }
}
