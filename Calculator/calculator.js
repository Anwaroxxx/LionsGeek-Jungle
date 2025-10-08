 const display_elem = document.getElementById("display_elem");

 function display(value)
 {
    display_elem.value += value;
 }
 function clearDisplay()
 {
    display_elem.value = "";
 }
 function calculate()
 {
    try
    {
        display_elem.value = eval(display_elem.value);
    }
    catch(error)
    {
        display_elem.value = "error"
    }
 }