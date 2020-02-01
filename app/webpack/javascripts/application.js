require('@rails/ujs').start();
require('turbolinks').start();
require('@rails/activestorage').start();
require('channels');

require('../stylesheets/application.scss');
require('@fortawesome/fontawesome-free/css/solid.min.css');
require('jquery/dist/jquery');
require('bootstrap/dist/js/bootstrap.bundle');

import * as $ from 'jquery';

$(document).ready(() => $('[data-toggle="tooltip"]').tooltip());
