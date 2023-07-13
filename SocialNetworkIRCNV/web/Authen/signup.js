
var pass = document.getElementById("pass");


var repeat = document.getElementById("repeat");
var user = document.getElementById("user");
var mail = document.getElementById("mail");

myInput.onfocus = function () {
    document.getElementById("message").style.display = "block";
};

repeat.onblur = function () {
    if(repeat.value!==pass.value)
        document.getElementById("id").innerHTML= "Repeat pass didn't match pass";
};

myInput.onblur = function () {
    document.getElementById("message").style.display = "none";
};


function validateForm() {
  
if(pass.value!==repeat.value){
   document.getElementById("mess").innerHTML = "Repeat pass didn't match pass";
  return false;
  }
  return true;
}
// When the user starts to type something inside the password field


