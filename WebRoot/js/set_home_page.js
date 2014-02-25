function setHomePage(url)
{
	if (document.all)
	{
		document.body.style.behavior='url(#default#homepage)';
		document.body.setHomePage(url);
	}
	else if (window.sidebar)
	{
		if(window.netscape)
		{
			try
			{
				netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
				var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components. interfaces.nsIPrefBranch);
				prefs.setCharPref('browser.startup.homepage',url);
			}
			catch(e)
			{
				alert("this action was aviod by your browser，if you want to enable，please enter about:config in your address line,and change the value of signed.applets.codebase_principal_support to true");
			}
		}
	}
}