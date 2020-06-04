const scroller = () => {
  let navbar = document.querySelector('.home_nav');
  if (navbar) {
    window.addEventListener('scroll', (event) => {
      navbar.style.background = `rgba(31, 229, 189, ${event.pageY * (1 / 140)})`;
      navbar.style.boxShadow = "box-shadow: 0 0 15px rgba(0,0,0,0.2)";
      console.log(event.pageY);
    });
  }
}

export {scroller}
