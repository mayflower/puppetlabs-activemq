class service::activemq::authorizations {

  Activemq::Instance::Authorization {
    target_instance => 'stomp',
  }

  # Grant admins to administer all queues and topics
  activemq::instance::authorization {
    'stomp-queue-all':
      type        => 'queue',
      destination => '>',
      allperms    => 'admins';
    'stomp-topic-all':
      type        => 'topic',
      destination => '>',
      allperms    => 'admins';
  }

  # Allow mcollective users to write to all mcollective queues and topics
  activemq::instance::authorization {
    'stomp-queue-mcollective':
      type        => 'queue',
      destination => 'mcollective.>',
      allperms    => 'mcollective';
    'stomp-topic-mcollective':
      type        => 'topic',
      destination => 'mcollective.>',
      allperms    => 'mcollective';
  }

  activemq::instance::authorization {
    'stomp-queue-qa':
      type        => 'queue',
      destination => 'qa-collective.>',
      allperms    => 'qa-collective';
    'stomp-topic-qa':
      type        => 'topic',
      destination => 'qa-collective.>',
      allperms    => 'qa-collective';
  }

  activemq::instance::authorization { 'stomp-topic-advisory':
    type        => 'topic',
    destination => 'ActiveMQ.Advisory.>',
    allperms    => 'advisory',
  }
}
