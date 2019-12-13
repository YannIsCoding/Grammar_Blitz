const disgustingjs = () => {

    const elements = document.querySelectorAll(".letter");
     // var focused = document.querySelector(":focus")
     // var focused = document.autofocus

     // const focused = document.activeElement;
     // console.log(focused)

     // document.addEventListener('mousedown', function(){
     //   var focused = document.activeElement;
     // });

    elements.forEach((element) => {

      element.addEventListener("click", (event) => {
        focusedField()
        let focused = document.querySelector(".focus-field");
        focused.value = focused.value + element.innerText;
        focused.focus();
      })

    });

}

const focusedField = () => {
  // select all fields
  const fields = document.querySelectorAll(".response")
  //find the one focus
  fields.forEach((el) =>{
      console.log('chocolate pizza')
      console.log(el.focus)
      blabal = document.getElementById==

    el.classList.remove("focus-field");
    if (el.focus){
      el.classList.add("focus-field");
    }
  })
}

export { disgustingjs };
