//= require rails-ujs
//= require jquery
//= require_tree .

// select option for exercice
// document.querySelectorAll(".form-label").forEach((label) => {
//   label.addEventListener("click", (event) => {
//     event.currentTarget.classList.toggle("active-form")
//   });
// });


//Hide/show solution new sentence

const showResult = () => {
  const button = document.getElementById("next-sentence");
  let solution = document.getElementById("solution");
  let exercice = document.getElementById("form-container");

  document.addEventListener("keydown", function (e) {
    if (e.code === 'Enter' && exercice.style.display != "block") {  //checks whether the pressed key is "Enter"
      e.preventDefault();
      showNextExercice();
    }
  });

  button.addEventListener("click", (event) => {
    showNextExercice();
  })

  const showNextExercice = () => {
    solution.style.display = "none";
    exercice.style.display = "block";
    const response = document.querySelector(".response")
    response.focus()
  }

}
