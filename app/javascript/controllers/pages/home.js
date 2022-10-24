const card = document.querySelectorAll(".card");
const cardToggle = document.querySelectorAll(".toggle");

cardToggle.onclick = function () {
  card.classList.toggle("active");
};
