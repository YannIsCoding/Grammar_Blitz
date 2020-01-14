//= require rails-ujs
//= require_tree .

// select option for exercice
document.querySelectorAll(".form-label").forEach((label) => {
  label.addEventListener("click", (event) => {
    event.currentTarget.classList.toggle("active-form")
  });
});


//Hide/show solution new sentence
let button = document.getElementById("next-sentence");
let solution = document.getElementById("solution");
let exercice = document.getElementById("exercice");

document.addEventListener("keydown", function (e) {
  if (e.keyCode === 32) {  //checks whether the pressed key is "Enter"
    solution.style.display = "none";
    exercice.style.display = "block";
    const firstField = document.querySelector("#response_0");
    firstField.focus();
    console.log('key down enter');
  }
});

button.addEventListener("click", (event) => {
  solution.style.display = "none";
  exercice.style.display = "block";
  const firstField = document.querySelector("#response_0")
  firstField.focus()
  console.log('click')
})

console.log('bottom')

