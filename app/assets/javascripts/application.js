//= require rails-ujs
//= require_tree .

document.querySelectorAll(".form-label").forEach((label) => {
  label.addEventListener("click", (event) => {
    event.currentTarget.classList.toggle("active-form")
  });
});


let button = document.getElementById("next-sentence")
let solution = document.getElementById("solution")
let exercice = document.getElementById("exercice")

// if(button){
//   button.focus();
// }

addEventListener("keypress", function(event){
  solution.style.display = "none";
  exercice.style.display = "block";
  const firstField = document.querySelector("#response_0")
  firstField.focus()
})

button.addEventListener("click", (event) => {
  solution.style.display = "none";
  exercice.style.display = "block";
  const firstField = document.querySelector("#response_0")
  firstField.focus()
})

