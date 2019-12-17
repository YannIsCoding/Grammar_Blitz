//= require rails-ujs
//= require_tree .

document.querySelectorAll(".form-label").forEach((label) => {
  label.addEventListener("click", (event) => {
    event.currentTarget.classList.toggle("active-form")
  });
});
