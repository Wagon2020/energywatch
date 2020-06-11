const top = () => {
  let navbar = document.querySelector('.side-nav');
  if (navbar) {
    window.addEventListener('scroll', (event) => {
      const scrollValue = $(window).scrollTop() / (240)
      navbar.style.background = `rgba(97, 71, 255, ${scrollValue})`;
      navbar.style.boxShadow = `0 0 15px rgba(0,0,0,${Math.min(scrollValue / 5, 0.2)})`;
      // console.log(scrollValue);
    });
  }
}

export {top}
