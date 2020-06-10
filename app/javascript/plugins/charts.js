require("chartkick")
require("chart.js")
import Chart from 'chart.js';


const ctx = document.getElementById('myChart').getContext('2d');

const test_donut = () => {
    let data = []
    let labels = []
    gon.donut_data.forEach(element => { data.push(element[1]), labels.push(element[0]) });

        // var ctx = document.getElementById("myChart").getContext('2d');
        var myChart = new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: labels,
            datasets: [{
                label: 'This week',
                borderColor: ["#1fe5bd", "#FB1E7F", "#A6D9F7", "#FFFF3F"],
                backgroundColor: ["#1fe5bd", "#FB1E7F", "#A6D9F7", "#FFFF3F"],
                data: data,
            }]
        },
    });



// var myChart = new Chart(ctx, {
//     type: 'bar',
//           labels: ["1","2","3","4"],
//           datasets: [{
//               label: 'This week',
//               data: [1,2,3,4]
//           }],
//           options: {
//               scales: {
//                   yAxes: [{
//                       ticks: {
//                           beginAtZero: true
//                       }
//                   }]
//               },
//               legend: {
//                   position: 'top',
//                   onClick: function (event, elem) {
//                       stefan();
//                       console.log("legend click @ x: " + event.clientX + ", y:" + event.clientY);
//                   }
//               }
//           }
// });


  const donut = document.querySelector('#chart-donut');
  if (donut) {
    new Chartkick.PieChart("chart-donut", gon.donut_data, {colors: ["#1fe5bd", "#FB1E7F", "#A6D9F7", "#FFFF3F"], legend: "bottom", donut: true})
  };

  let bar = document.querySelector('#chart-bar');
  if (bar){
    new Chartkick.BarChart("chart-bar",
                            gon.chart_data,
                            {colors: ["#1fe5bd"], suffix: " MW"})

  };

  // let re_forecast = document.querySelector('#chart-re-forecast');
  // if (re_forecast){
  //   new Chartkick.LineChart("chart-re-forecast",
  //                            gon.renewable_forecast,
  //                            { library: { legend: { position: "top", onClick: function (event) { stefan(); } },
  //                                                 { title: "all renewables"}
  //                                       }
  //                             }
  //                           )


  //                            // {colors: ["#1fe5bd"], legend: "bottom",
  //                            // ytitle: "MegaWatt",
  //                            // label: "all renewables", points: false},
  //                            // library: {legend: {position: "top"}})
  // };

  let re_forecast_breakdown = document.querySelector('#chart-forecast');
  if (re_forecast_breakdown){
    new Chartkick.ColumnChart("chart-forecast",
                              gon.test_data,
                              {stacked: true,
                                colors: ["#1fe5bd", "#FB1E7F", "#FFFF3F"],
                                // legend: { onClick: function (event) { stefan(); } },
                                ytitle: "MegaWatt"})
  };

}


const stefan = () => {
  console.log("Stefan klickt")
}


export { test_donut }

