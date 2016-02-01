class PhoneNumber < ActiveRecord::Base
#	validates :phone_number, presence: true
	def generate_pin
		self.pin = rand(000000..999999).to_s.rjust(6, "0")
		self.save
	end

	def send_pin
		twilio_client.messages.create(
    		to: phone_number,
    		from: ENV['TWILIO_PHONE_NUMBER'],
    		body: "Your PIN is #{pin}"
  		)
	end

	def verify(entered_pin)
  		update(verified: true) if self.pin == entered_pin
	end

	def twilio_client
  		Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
	end
end

#export TWILIO_ACCOUNT_SID="ACcb1b88114e0937d43e5e9e5ea65da8d1"
#export TWILIO_AUTH_TOKEN="a56b38f4c7e005057fb24418818efade"
#export TWILIO_PHONE_NUMBER="(201) 439-8966/+12014398966"
