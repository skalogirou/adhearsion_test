Before trying any tests configure punchbloch username/password in <strong>config/adhearsion.rb</strong>

```ruby

  config.punchblock.platform = :xmpp
  # Authentication credentials [AHN_PUNCHBLOCK_USERNAME]
  config.punchblock.username = "xxxxxxxxxxxxxxxx"
  # Authentication credentials [AHN_PUNCHBLOCK_PASSWORD]
  config.punchblock.password = "xxxxxxxxxxxxxxx" 
  # Host punchblock needs to connect (where rayo/asterisk/freeswitch is located) [AHN_PUNCHBLOCK_HOST]
  config.punchblock.host = "127.0.0.1"
  # Port punchblock needs to connect [AHN_PUNCHBLOCK_PORT]
  config.punchblock.port = 5038

```

Also in <strong>lib/main_call_controller.rb</strong>

```ruby

logger.info call.inspect
logger.info "Calling Through Adhearsion"
@call_to = "xxxxxxxxxxxxxxxxx"
status = dial_with_handler @call_to do |handler, dial|

```
change @call_to variable with your desired B-leg endpoint.



Try to run adhearsion in forground. Once you originate the call, then with the cli_commands try
c1 = calls["###call_id of main leg###"]
c2 = calls["###call_id of others leg"]

c1[:event_handler].trigger_handler :event, Event.new(:transfer_call, 1)

With this command call will be splitted. 
if you run c1.hangup, c2 will remain active but if you run c2.hangup c1 will also hangup



