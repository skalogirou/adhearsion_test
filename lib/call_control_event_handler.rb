Event = Class.new Struct.new(:type, :value)
class CallControlEventHandler
	def initialize(call)
		@call = call
		@transfer = {}
		@running =false
	end
	def start
		unless @running
			logger.info "Handler initialized"
			@call[:event_handler] = @component = Component.new
			@component.register_handler :event, :type => :transfer_call do |event|
				logger.info "Transfer Call Event Trigger"
				transfer_call_trigger
			end
		end
	end
	def transfer_call(controller=nil, &block)
		payload = if block_given?
			raise ArgumentError, "You cannot specify both a block and a controller name." if controller.is_a? Class
			block
		else
			raise ArgumentError, "You need to provide a block or a controller name." unless controller.is_a? Class
			controller
		end
		@transfer = payload
	end
	def transfer_call_trigger
		match = @transfer
		@call.execute_controller(nil,nil,&match)	
	end
end

class Component
	include HasGuardedHandlers
end