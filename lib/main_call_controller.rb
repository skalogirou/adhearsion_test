# encoding: utf-8
class MainCallController < Adhearsion::CallController
	def run
		logger.info call.inspect
		logger.info "Calling Through Adhearsion"
		@call_to = "xxxxxxxxxxxxxxxxx"
		status = dial_with_handler @call_to do |handler, dial|
			handler.transfer do
				dial.skip_cleanup
				transfer_call dial
			end
		end
	end
	def transfer_call(dial)
		blocker = Celluloid::Condition.new
		dial.split :main => WaitController, :others => WaitController,  main_callback: ->(call) { blocker.broadcast },  others_callback: ->(call) { blocker.broadcast }
		blocker.wait
	end
end
class WaitController < Adhearsion::CallController
	def run
		Thread.stop
	end
end
class Adhearsion::CallController
	def dial_with_handler(to, options = {}, &block)
		dial = Adhearsion::CallController::Dial::ParallelConfirmationDial.new to, options, call
		handler = CallControlEventHandler.new call
		handler.start
		dial.track_originating_call
		dial.prep_calls
		dial.place_calls
		yield handler, dial
		dial.await_completion
		dial.cleanup_calls
		dial.status
	end
	private
	def main_dial
		metadata['current_dial']
	end
end
