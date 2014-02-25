var days = [];
days[0] = 31;
days[1] = 28;
days[2] = 31;
days[3] = 30;
days[4] = 31;
days[5] = 30;
days[6] = 31;
days[7] = 31;
days[8] = 30;
days[9] = 31;
days[10] = 30;
days[11] = 31;

function isLeapYear(year)
{
	return year%4==0&&year%100!=0||year%400==0;
}

function updateDay(year,month,dom_day)
{
	var day = dom_day.value;
	var size = days[month-1];
	if (isLeapYear(year)&&month==2)
	{
		size += 1;
	}
	
	while (dom_day.childNodes.length>0)
	{
		dom_day.removeChild(dom_day.childNodes[0]);
	}
	
	var i=1;
	for (;i<=size;i+=1)
	{
		var option = document.createElement("option");
		option.value = i;
		if (day==i)
		{
			option.selected = true;
		}
		option.appendChild(document.createTextNode(i));
		dom_day.appendChild(option);
	}
}
