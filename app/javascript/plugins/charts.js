require("chartkick")
require("chart.js")
import Chart from 'chart.js';


const smartPlugMonth = () => {
  const line = document.querySelector('#chart-line');
  if (line){
    new Chartkick.LineChart("chart-line", gon.smart_plug_data, {colors: ["#1fe5bd"]})
  };
}

const smartPlugMonthTest = () => {
  const line = document.querySelector('#smart-plug-month');
  let data = []
  let labels = []

  for (let [key, value] of Object.entries(gon.smart_plug_data)) {
    data.push(value);
    labels.push(key);
  }
  console.log(labels)
  console.log(data)

  var myChart = new Chart(line, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                data: data,
                label: 'Watts per day',
                borderColor: ["#1fe5bd"],
                backgroundColor: ["#1fe5bd"],
            }],
        },
        options: {
          legend: { position: 'bottom',
                    onClick:  stefan },
          elements: { point:{ radius: 3 }}
        }
    });

}

const donut_test = () => {
  const ctx = document.getElementById('donut-chart'); // .getContext('2d');
  let data = []
  let labels = []
  gon.donut_data.forEach(element => { data.push(element[1]), labels.push(element[0]) });
  var myChart = new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: labels,
            datasets: [{
                data: data,
                label: 'Renewables Doughnut',
                borderColor: ["#6DE676", "#F34A69", "#F5D671", "#FFFF3F"],
                backgroundColor: ["#6DE676", "#F34A69", "#F5D671", "#FFFF3F"],
            }],
        },
        options: {
          legend: { position: 'bottom',
                    onClick:  stefan }
        }
    });
}


const detailsBar = () => {
  let bar = document.querySelector('#chart-bar');
  if (bar){
    new Chartkick.BarChart("chart-bar",
                            gon.chart_data,
                            {colors: ["#6147FF"], suffix: " MW"})

  };
}

const renewableForecast = () => {
  let re_forecast = document.querySelector('#chart-re-forecast');
  if (re_forecast){
    new Chartkick.LineChart("chart-re-forecast",
                            gon.renewable_forecast,
                            {colors: ["#6147FF"],
                            legend: "bottom", ytitle: "MegaWatt",
                            label: "all renewables", points: false} )
  };

  let re_forecast_breakdown = document.querySelector('#chart-forecast');
  if (re_forecast_breakdown){
    new Chartkick.ColumnChart("chart-forecast",
                              gon.re_breakdown_data,
                              {stacked: true,
                              colors: ["#6147FF", "#9484ff", "#d5ceff"],
                              legend: "bottom", ytitle: "MegaWatt"})
  };
}

const donut = () => {
  const donut = document.querySelector('#chart-donut');
  if (donut) {
    new Chartkick.PieChart("chart-donut", gon.donut_data, {colors: ["#6DE676", "#F34A69", "#F5D671", "#FFFF3F"], legend: "bottom", donut: true})
  };
}

const showCharts = () => {

  donut();
  detailsBar();
  renewableForecast();
  smartPlugMonthTest();
  donut_test();
}


const stefan = () => {
  console.log("Stefan klickt")
}


export { showCharts }

