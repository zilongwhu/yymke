function addFavorite(url)
{
	try
    {
        window.external.addFavorite(url,'YUEYANG MINGKE ELECTROMAGNET CO.,LTD');
	}
    catch (e)
    {
        try
        {
            window.sidebar.addPanel('YUEYANG MINGKE ELECTROMAGNET CO.,LTD', url, "");
        }
        catch (e)
        {
            alert("fail to add this page to your favorite, please do it yourself with your browser.");
        }
    }
}