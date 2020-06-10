const scroller = () => {
  let navbar = document.querySelector('.home_nav');
  if (navbar) {
    window.addEventListener('scroll', (event) => {
      const scrollValue = $(window).scrollTop() / (140)
      navbar.style.background = `rgba(31, 229, 189, ${scrollValue})`;
      navbar.style.boxShadow = `0 0 15px rgba(0,0,0,${Math.min(scrollValue / 5, 0.2)})`;
      // console.log(scrollValue);
    });
  }
}

export {scroller}
