class service::activemq::protocols {

  # Don't need this till we have multiple brokers
  #activemq::instance::protocol { 'stomp-openwire':
  #  protocol_name => openwire,
  #  uri           => 'tcp://0.0.0.0:6166',
  #  target_instance => 'stomp',
  #}

  activemq::instance::protocol { 'stomp-stomp+ssl':
    protocol_name => 'stompssl',
    uri           => 'stomp+ssl://0.0.0.0:61614?needClientAuth=true',
    target_instance => 'stomp',
  }
}
