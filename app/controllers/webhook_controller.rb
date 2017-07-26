class WebhookController < ApplicationController
  skip_before_action :verify_authenticity_token

  def handle
    respond_to do |format|
      format.json {
        case params['result']['metadata']['intentName']
        when 'stackoverflow'
          @result = "Dude, think for yourself!"
        when 'joke'
          @result = "What's the matter with you? Robots aren't funny."
        end
        response.headers['Content-type'] = 'application/json'
        render json: {
          speech: @result,
          displayText: @result,
          data: "",
          contextOut: [],
          source: "webhook"
        }
      }
    end
  end

end
