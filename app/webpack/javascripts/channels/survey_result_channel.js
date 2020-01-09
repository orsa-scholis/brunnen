import consumer from "./consumer"
import { chart } from "../chart";

consumer.subscriptions.create({ channel: "SurveyResultChannel", survey_id: EvawebDashboard.surveyId }, {
  connected() {},
  disconnected() {},

  received(data) {
    const chartDiv = document.getElementById("chart");

    if (chartDiv.classList.contains('col-12')) {
      const urlDiv = document.getElementById("url_infos");
      chartDiv.classList.replace('col-12', 'col-8');
      urlDiv.classList.replace('col-12', 'col-4');
    }

    const parsedData = JSON.parse(data);
    chart.render(parsedData);
  }
});
