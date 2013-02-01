class service::activemq::users {

  activemq::instance::user { 'stomp-admin':
    username        => 'admin',
    password        => 'password!',
    groups          => ['mcollective', 'admins', 'advisory'],
    target_instance => 'stomp',
  }
}
