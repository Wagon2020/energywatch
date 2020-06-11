const scrollToAppliance = () => {
  const btn = document.querySelector('.scroll-down');
  if (btn) {
    btn.addEventListener('click', event => {
        // window.scrollTo(0 , 0, { behavior: 'smooth' });
        window.scrollTo({ top: 700, behavior: 'smooth' });
      });
  }

}

export { scrollToAppliance }
