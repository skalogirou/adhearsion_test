# encoding: utf-8

Adhearsion.config do |config|

  # Centralized way to specify any Adhearsion platform or plugin configuration
  # - Execute rake config:show to view the active configuration values
  #
  # To update a plugin configuration you can write either:
  #
  #    * Option 1
  #        Adhearsion.config.<plugin-name> do |config|
  #          config.<key> = <value>
  #        end
  #
  #    * Option 2
  #        Adhearsion.config do |config|
  #          config.<plugin-name>.<key> = <value>
  #        end

  # Active environment. Supported values: development, production, staging, test [AHN_PLATFORM_ENVIRONMENT]
  config.platform.enviroment = ENV["RAILS_ENV"]
  # Adhearsion process name, useful to make it easier to find in the process list
  # Pro tip: set this to your application's name and you can do "killall myapp"
  # Does not work under JRuby. [AHN_PLATFORM_PROCESS_NAME]
  config.platform.process_name = "ahn"

  ##
  # Logging Configuration
  #

  config.development do |dev|
    # An array of log outputters to use. The default is to log to stdout and log/adhearsion.log.
    # Each item must be either a string to use as a filename, or a valid Logging appender (see http://github.com/TwP/logging) [AHN_PLATFORM_LOGGING_OUTPUTTERS]
    dev.platform.logging.outputters = "log/adhearsion_development"
    # Supported levels (in increasing severity) -- :trace < :debug < :info < :warn < :error < :fatal [AHN_PLATFORM_LOGGING_LEVEL]
    dev.platform.logging.level = :trace
  end
  config.production.platform.logging.level = :debug


  ##
  # Platform punchblock shall use to connect to the Telephony provider. Currently supported values:
  # - :xmpp
  # - :asterisk
  # - :freeswitch [AHN_PUNCHBLOCK_PLATFORM] 
  config.punchblock.platform = :xmpp
  # Authentication credentials [AHN_PUNCHBLOCK_USERNAME]
  config.punchblock.username = "adhearsion@127.0.0.1"
  # Authentication credentials [AHN_PUNCHBLOCK_PASSWORD]
  config.punchblock.password = "xxxxxxxxxxxxxxx" 
  # Host punchblock needs to connect (where rayo/asterisk/freeswitch is located) [AHN_PUNCHBLOCK_HOST]
  config.punchblock.host = "127.0.0.1"
  # Port punchblock needs to connect [AHN_PUNCHBLOCK_PORT]
  config.punchblock.port = 5038
  # Delay between connection attempts [AHN_PUNCHBLOCK_RECONNECT_TIMER]
  config.punchblock.reconnect_timer = 5
  # The root domain at which to address the server [AHN_PUNCHBLOCK_ROOT_DOMAIN]
  config.punchblock.root_domain = nil
  # The media engine to use. Defaults to platform default. [AHN_PUNCHBLOCK_MEDIA_ENGINE]
  config.punchblock.media_engine = nil
  # The domain at which to address mixers [AHN_PUNCHBLOCK_MIXERS_DOMAIN]
  config.punchblock.mixers_domain = nil
  # The domain at which to address calls [AHN_PUNCHBLOCK_CALLS_DOMAIN]
  config.punchblock.calls_domain = nil
  # The amount of time to wait for a connection [AHN_PUNCHBLOCK_CONNECTION_TIMEOUT]
  config.punchblock.connection_timeout = 60
  # The default TTS voice to use. [AHN_PUNCHBLOCK_DEFAULT_VOICE]
  config.punchblock.default_voice = nil

  ##
  # Use with Asterisk
  #
  # config.punchblock.platform = :asterisk # Use Asterisk
  # config.punchblock.username = "adhearsion" # Your AMI username
  # config.punchblock.password = "NZcvQwR5u7dNpR22" # Your AMI password
  # config.punchblock.host = "127.0.0.1" # Your AMI host
  # config.punchblock.port = 5038

  ##
  # Use with FreeSWITCH via EventSocket
  #
  # This configuration is no longer recommended and mod_rayo is preferred
  #
  # config.punchblock.platform = :freeswitch # Use FreeSWITCH
  # config.punchblock.password = "" # Your Inbound EventSocket password
  # config.punchblock.host = "127.0.0.1" # Your IES host
end


Adhearsion::Events.draw do

  # Register global handlers for events
  #
  # eg. Handling Punchblock events
  # punchblock do |event|
  #   ...
  # end
  #
  # eg Handling PeerStatus AMI events
  # ami :name => 'PeerStatus' do |event|
  #   ...
  # end
  #
end

Adhearsion.router do

  #
  # Specify your call routes, directing calls with particular attributes to a controller
  #

  route 'adhearsion', MainCallController

#  openended do
#    route 'Everyone else' do
#      answer
#      # hand back to extensions.conf
#    end
#  end

end
