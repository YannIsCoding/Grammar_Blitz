const disgustingjs = () => {
  // Grab the first input field
  var firstField = $('[id^="response"]')[0];
  // const firstField = document.querySelector("#response_0")
  firstField.focus()
  firstField.select();
  firstField.classList.add("focus-field");
  const elements = document.querySelectorAll(".letter");

  focusedField()
  elements.forEach((element) => {

    element.addEventListener("click", (event) => {
      let focused = document.querySelector(".focus-field");
      focused.value = focused.value + element.innerText;
      focused.focus();
      focused.select();
    })

  });

}

const focusedField = () => {
  // select all fields
  const fields = document.querySelectorAll(".response")
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

export { disgustingjs };
