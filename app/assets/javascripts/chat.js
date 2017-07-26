var accessToken = "412306eae02b46329db2e34ff232dab9";

message_appender = function(content) {
  $message = $('.message').clone();
  $message.removeClass('message');
  $message.html(content);
  $message.appendTo($('.messages'));
}

function makeAIcall(text) {
  var url = "https://api.api.ai/v1/";
  $.ajax({
    type: "POST",
    url: url + "query?v=20160415",
    contentType: "application/json; charset=utf-8",
    dataType: "json",
    headers: {
      "Authorization": "Bearer " + accessToken
    },
    data: JSON.stringify({query: text, lang: "en", sessionId: '1'}),
    success: function(data) {
      showAgentResponse(data);
    },
    error: function() {
      showAgentResponse("There has been an internal error");
    }
  });
}

async function showAgentResponse(data) {
  var msgs = data.result.fulfillment.messages;
  var response = msgs[0]['speech'];
  message_appender(response);
}

$(document).ready(function() {
  $('.user_message').keyup(function(e) {
    if (e.which === 13) {
      $user_message = $('.user_message');
      message_appender($user_message.val());
      makeAIcall($user_message.val());
      $(".user_message").val('');
    }
  });
});
