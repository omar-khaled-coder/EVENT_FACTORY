document.addEventListener('DOMContentLoaded', () => {
  const thumbnails = document.querySelectorAll('.thumbnail');
  const currentImage = document.getElementById('current-image');

  thumbnails.forEach(thumbnail => {
    thumbnail.addEventListener('click', () => {
      currentImage.src = thumbnail.dataset.largeImage;
    });
  });
});
