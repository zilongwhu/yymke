function toggleChild(folder)
{
	var node = folder.previousSibling;
	if (node.title=="fold")
	{
		if (node.src.indexOf("middle")>0)
		{
			node.src = "images/tree/tree_plusmiddle.gif";
		}
		else
		{
			node.src = "images/tree/tree_plusbottom.gif";
		}
		node.title = "unfold";
		folder.className = "folder_close";
		folder.nextSibling.style.display = "none";
	}
	else
	{
		if (node.src.indexOf("middle")>0)
		{
			node.src = "images/tree/tree_minusmiddle.gif";
		}
		else
		{
			node.src = "images/tree/tree_minusbottom.gif";
		}
		node.title = "fold";
		folder.className = "folder_open";
		folder.nextSibling.style.display = "";
	}
	fix_ie_overflow_bug();
}

function toggleChildByLink(id)
{
	toggleChild($(id));
}

function toggleChildByImg(evt)
{
	toggleChild(evt.element().nextSibling);
}