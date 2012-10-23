puppetlabs-activemq
===================

Deploy and configure activemq without writing XML

Synopsis
--------

Define an ActiveMQ instance that we can attach configuration to:

    activemq::instance { 'stomp': ssl => true }

Add users to that stomp instance:

    activemq::instance::user {
      'stomp-admin':
        username        => 'admin',
        password        => 'my super secret password',
        groups          => ['mcollective', 'subcollective', 'admins', 'everyone'],
        target_instance => 'stomp';
      'stomp-mcollective':
        username        => 'mcollective',
        password        => 'my super duper secret password',
        groups          => ['mcollective', 'subcollective', 'everyone'],
        target_instance => 'stomp';
      'stomp-subcollective':
        username        => 'subcollective',
        password        => 'my extra super secret password',
        groups          => ['subcollective', 'everyone'],
        target_instance => 'stomp';
    }

Create queues and topics for MCollective:

    Activemq::Instance::Authorization {
      target_instance => 'stomp',
    }

    # Grant admins to administer all queues and topics
    activemq::instance::authorization {
      'stomp-queue-all':
        type            => 'queue',
        content         => '>',
        read            => 'admins',
        write           => 'admins',
        admin           => 'admins';
      'stomp-topic-all':
        type            => 'topic',
        content         => '>',
        read            => 'admins',
        write           => 'admins',
        admin           => 'admins';
    }

    # Allow mcollective users to write to all mcollective queues and topics
    activemq::instance::authorization {
      'stomp-queue-mcollective':
        type            => 'queue',
        content         => 'mcollective.>',
        read            => 'mcollective',
        write           => 'mcollective',
        admin           => 'mcollective';
      'stomp-topic-mcollective':
        type            => 'topic',
        content         => 'mcollective.>',
        read            => 'mcollective',
        write           => 'mcollective',
        admin           => 'mcollective';
    }

    # Allow subcollective users to write to the collective topics and queues
    activemq::instance::authorization {
      'stomp-queue-subcollective':
        type            => 'queue',
        content         => 'subcollective.>',
        read            => 'subcollective',
        write           => 'subcollective',
        admin           => 'subcollective';
      'stomp-topic-subcollective':
        type            => 'topic',
        content         => 'subcollective.>',
        read            => 'subcollective',
        write           => 'subcollective',
        admin           => 'subcollective';
    }

    activemq::instance::authorization { 'stomp-topic-advisory':
      type            => 'topic',
      content         => 'ActiveMQ.Advisory.>',
      read            => 'everyone',
      write           => 'everyone',
      admin           => 'everyone',
    }

Finally, turn on the stomp protocol:

    activemq::instance::protocol { 'stomp-stomp+ssl':
      protocol_name => 'stompssl',
      uri           => 'stomp+ssl://0.0.0.0:61614?needClientAuth=true',
      target_instance => 'stomp',
    }

Did you see all that XML that we had to write? Me neither.

Limitations
-----------

This module is built around Debian Wheezy, mainly because it's one of the
easiest ways to get recent versions of ActiveMQ. As such it expects the Wheezy
layout of independent instances in `/etc/activemq/instances-enabled`.

Requirements
------------

  * puppet-concat: https://github.com/ripienaar/puppet-concat
  * puppetlabs-stdlib: https://github.com/puppetlabs/puppetlabs-stdlib
