// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

require("chartkick")
require("chart.js")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
import { scroller } from '../components/scroll_event';
import { toggle_charts } from '../components/toggle_button';



// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';
import { initSelect2 } from '../components/init_select2';


document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();
  scroller();
  toggle_charts();
  initSelect2();

  let donut = document.querySelector('#chart-donut');
  if (donut) {
    new Chartkick.PieChart("chart-donut", gon.donut_data, {colors: ["#6DE676", "#F34A69", "#F5D671", "#FFFF3F"], legend: "bottom", donut: true})
  };

  let bar = document.querySelector('#chart-bar');
  if (bar){
    new Chartkick.BarChart("chart-bar",
                            gon.chart_data,
                            {colors: ["#9484ff"], suffix: " MW"})

  };

  let line = document.querySelector('#chart-line');
  if (line){
    new Chartkick.LineChart("chart-line", gon.smart_plug_data, {colors: ["#d5ceff"]})
  };

  // chart for renewable forecast
  let re_forecast = document.querySelector('#chart-re-forecast');
  if (re_forecast){
    // gon.test_data to be replaced with forecast data
    new Chartkick.LineChart("chart-re-forecast",
                             gon.renewable_forecast,
                             {colors: ["#6147FF"], legend: "bottom",
                              label: "all renewables", points: false, suffix: " MW"})
  };
  // chart set up for forecast data
  let re_forecast_breakdown = document.querySelector('#chart-forecast');
  if (re_forecast_breakdown){
    // gon.test_data to be replaced with forecast data
    new Chartkick.ColumnChart("chart-forecast", gon.re_breakdown_data, {stacked: true, colors: ["#6147FF", "#9484ff", "#d5ceff"], legend: "bottom"})
  };
});
