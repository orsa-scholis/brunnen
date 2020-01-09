import consumer from "./consumer"
import { chart } from "../chart";

consumer.subscriptions.create({ channel: "SurveyResultChannel", survey_id: EvawebDashboard.surveyId }, {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log('connected');

  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const parsedData = JSON.parse(data);
    console.log(parsedData);
    chart.render(parsedData);
  }
});
