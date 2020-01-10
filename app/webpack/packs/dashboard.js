import '../javascripts/application'
import '../javascripts/channels';
import {chart} from "../javascripts/chart";

document.addEventListener("DOMContentLoaded", () => {
  if (Evaweb.data.hasOwnProperty('averages') &&
    Evaweb.data.averages.hasOwnProperty('group_values') &&
    Evaweb.data.averages.group_values.some(function (el) {
      return el !== null;
    })) {
    chart.render(Evaweb.data);
  }
});
