const deKeyboard = () => {
  console.log('in the keyboard')
  // Grab the first input field
  var firstField = document.querySelectorAll(".input-field")[0];
  firstField.focus()
  firstField.select();
  firstField.classList.add("focus-field");
  const elements = document.querySelectorAll(".letter");

  // Which of the field is the user filling in now?
  focusedField()
  elements.forEach((element) => {

    element.addEventListener("click", (event) => {
      let focused = document.querySelector(".focus-field");
      firstField.value = firstField.value + element.innerText;
      firstField.select();
      firstField.focus();
    })

  });

}

const focusedField = () => {
  // select all fields
  const fields = document.querySelectorAll(".input-field")
  //find the one focus
  fields.forEach((el) => {
    el.addEventListener('focus', (event) => {
      fields.forEach((elx) => {
        elx.classList.remove("focus-field");
      })
      el.classList.add("focus-field");
    })
  })

}

export { deKeyboard };
