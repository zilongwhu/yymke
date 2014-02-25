function fix_ie_overflow_bug() {
	// only apply to IE
	if (!/*@cc_on!@*/0) return;
	
	var list = document.getElementById("product_list_div");
	
    if (list.scrollWidth > list.offsetWidth) {
      list.style['paddingBottom'] = '20px';
    }
    else
    {
      list.style['paddingBottom'] = '0px';
    }
    
    if (list.scrollHeight > list.offsetHeight) {
      list.style['paddingRight'] = '20px';
    }
    else
    {
      list.style['paddingRight'] = '0px';
    }
};