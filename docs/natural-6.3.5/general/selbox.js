//
// use this js file by adding:
// <SCRIPT LANGUAGE='JavaScript' SRC='../../general/doku.js'></SCRIPT>
// to your <head>
//
// reload page with given new address from select
//
// call function with:
// <SELECT NAME="menu" onClick="reload(this.form)" SIZE="10">
//
// specify link as value of option
// <option value="3util.htm#Call_Statistics_Utility">Call Statistics Utility</option>
//

function reload(form) {
  window.location.href=form.menu.options[form.menu.selectedIndex].value
}

