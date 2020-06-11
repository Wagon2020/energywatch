const top = () => {
  let navbar = document.querySelector('.side-nav');
  if (navbar) {
    document.querySelectorAll('.icon-nav').forEach(item => {
      item.addEventListener('click', event => {
        // window.scrollTo(0 , 0, { behavior: 'smooth' });
        window.scrollTo({ top: 0, left: 100, behavior: 'smooth' });
      });
    });
  };
};

export {top}
