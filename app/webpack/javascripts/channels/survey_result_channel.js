import consumer from "./consumer"

consumer.subscriptions.create({ channel: "SurveyResultChannel", survey_id: EvawebDashboard.surveyId }, {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log('connected');
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log('received data');
    console.dir(data);
    document.write(data.message);
  }
});
