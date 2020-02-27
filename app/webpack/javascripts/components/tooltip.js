import 'bootstrap/dist/js/bootstrap.bundle';
import * as $ from 'jquery'

const setupTooltips = () => $('[data-toggle="tooltip"]').tooltip();

if ('Turbolinks' in window && Turbolinks.supported) {
  document.addEventListener('turbolinks:load', setupTooltips);
} else {
  $(document).ready(setupTooltips);
}
