/*
* 响应Company菜单。
*/
function showCompanySubmenus()
{
	$("company_menu_wraper").style.display = "block";
	$("products_menu_wraper").style.display = "none";
	$("nav").style.paddingBottom = "20px";
}

/*
* 响应Products菜单。
*/
function showProductsSubmenus()
{
	$("company_menu_wraper").style.display = "none";
	$("products_menu_wraper").style.display = "block";
	$("nav").style.paddingBottom = "20px";
}

function hideAllSubmenus()
{
	$("company_menu_wraper").style.display = "none";
	$("products_menu_wraper").style.display = "none";
	$("nav").style.paddingBottom = "30px";
}