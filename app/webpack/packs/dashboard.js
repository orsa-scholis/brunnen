import '../javascripts/application'
import '../javascripts/channels';
import '../javascripts/chart'
import {chart} from "../javascripts/chart";

document.addEventListener("DOMContentLoaded", () => {
  chart.render(Evaweb.data);
});
