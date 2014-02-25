function start(k,prefix,subfix,imgnum,id){ //程序主体部分
	var obj=document.getElementById(id); //若图像标记的ID号改变，请修改括号中的字符串值。
	if (document.all)
	{
		if (obj.filters.item(0).Transition==23) // 这部分语句是用于改变切换样式，在23种样式中循环。
		{
			obj.filters.item(0).Transition=1;
		}
		else
		{
			obj.filters.item(0).transition += 1;
		}
		obj.filters.item(0).Apply();
	}
	if (k<imgnum)
	{
		k += 1; //这部分语句用于改变图像标记的src的图片地址（既含路径的文件名）。
	}
	else
	{
		k=1;
	}
	obj.src = prefix+k+subfix;
	if (document.all)
	{
		obj.filters.item(0).Play();
	}
	setTimeout("start("+k+",'"+prefix+"','"+subfix+"',"+imgnum+",'"+id+"');",3000); //每三秒钟刷新一次。
} 

function preloadImage(prefix,subfix,imgnum){ 
	var i = 1;
	var imgs = [];
	for (;i<=imgnum;i+=1)
	{
		imgs[i-1] = new Image();
		imgs[i-1].src = prefix+i+subfix;
	}
} 