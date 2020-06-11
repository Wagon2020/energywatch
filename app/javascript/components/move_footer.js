const move = () => {
  let navbar = document.querySelector('.side-nav');
  if (navbar) {
      document.getElementById('footer').classList.add("move_footer");
  }
}

export {move}
