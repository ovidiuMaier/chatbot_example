class WebhookController < ApplicationController
  skip_before_action :verify_authenticity_token

  def handle
    respond_to do |format|
      format.json {
        case params['result']['metadata']['intentName']
        when 'stackoverflow'
          query = params['result']['resolvedQuery']
          google_results = GoogleCustomSearchApi.search(query)
          title = google_results['items'][0].title
          link = google_results['items'][0].link
          @result = "<a href=#{link}>#{title}<a>"
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
