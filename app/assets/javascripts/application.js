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
    if (e.keyCode === 32) {  //checks whether the pressed key is "Enter"
      solution.style.display = "none";
      exercice.style.display = "block";
      const response = document.querySelector(".response");
      response.focus();
    }
  });

  button.addEventListener("click", (event) => {
    solution.style.display = "none";
    exercice.style.display = "block";
    const response = document.querySelector(".response")
    response.focus()
  })

}
