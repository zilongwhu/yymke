function reload_auth_img()
{
  	$("auth_img").src = "/auth_image?r="+Math.random();
}
  	
function callback(status)
{
  if (status==0)
  {
  	$("username_f").className = "feedback";
  	$("password_f").className = "feedback";
  	window.location.href = "online/index.jsp";
  }
  else if (status==1)
  {
  	$("username_f").className = "feedback_wrong";
  	$("password_f").className = "feedback";
  }
  else if (status==2)
  {
  	$("username_f").className = "feedback";
  	$("password_f").className = "feedback_wrong";
  }
  else
  {
  	alert("对不起，登录出错！");
  }
}

function validate_code()
{
  var code = getInputValue("auth_code");
  if (code.length!=4)
  {
  	$("auth_code_f").className = "feedback_wrong";
  }
  else
  {
  	new Ajax.Request("../auth_code",{
  		parameters: 'code='+code,
  		onSuccess: function(response)
  		{
  			var obj = response.responseJSON;
  			if (obj.valid)
  			{
			 	$("auth_code_f").className = "feedback_right";
  			}
  			else
  			{
				$("auth_code_f").className = "feedback_wrong";
  			}
  		}
  	});
  }
}
  	
function validate_code2()
{
  var code = getInputValue("auth_code");
  if (code.length>=4)
  {
  	validate_code();
  }
  else
  {
	$("auth_code_f").className = "feedback";
  }
}

function check_valid(evt)
{
	if (getInputValue("username").length==0||$("username_f").className=="feedback_wrong")
	{
		Event.stop(evt);
		alert("用户名输入有误！");
		$("username").focus();
	}
	else if(getInputValue("password").length==0||$("password_f").className=="feedback_wrong")
	{
		Event.stop(evt);
		alert("密码输入有误！");
		$("password").focus();
	}
	else if($("auth_code_f").className!="feedback_right")
	{
		Event.stop(evt);
		alert("验证码输入有误！");
		$("auth_code").focus();
	}
}