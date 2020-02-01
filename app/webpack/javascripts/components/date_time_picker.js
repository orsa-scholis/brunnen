import flatpickr from 'flatpickr';
import { German } from 'flatpickr/dist/l10n/de';

function bindDateTimePickers() {
  [...document.querySelectorAll('[data-type="time"]')].forEach((time) => {
    flatpickr(time, {
      locale: German,
      enableTime: true,
      enableSeconds: false,
      noCalendar: true,
      altInput: true,
      altFormat: ' h:i:S K',
      dateFormat: 'H:i:S' // H:i
    });
  });

  [...document.querySelectorAll('[data-type="datetime"]')].forEach((time) => {
    flatpickr(time, {
      enableTime: true,
      altInput: true,
      enableSeconds: false,
      locale: German,
      altFormat: 'l, j.m.Y H:i',
      dateFormat: 'Z' // Y-m-d H:i
    });
  });
}

document.addEventListener('turbolinks:load', function () {
  bindDateTimePickers();
});
