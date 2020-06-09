
const toggle_charts = () => {
  const totalChart = document.querySelector('#chart-forecast');
  const detailChart = document.querySelector('#chart-re-forecast');
  const toggleButton = document.querySelector('.toggle-details');
  if (toggleButton) {
    toggleButton.addEventListener('click', (event) => {
        console.log("click")
        totalChart.classList.toggle("chart-visible");
        detailChart.classList.toggle("chart-hidden");
    });
  }
}

export { toggle_charts }


