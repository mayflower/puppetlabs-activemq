class service::activemq {

  motd::register { 'Apache ActiveMQ': }

  activemq::instance { 'stomp':
    ssl           => true,
    min_stacksize => '512M',
    max_stacksize => '3G',
    starttime     => '20',
  }

  include service::activemq::users
  include service::activemq::authorizations
  include service::activemq::protocols
}
