<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>访问错误</title>
<link type="text/css" rel="stylesheet" href="<%=basePath %>css/style.css" />
<script type="text/javascript">
/* setTimeout("window.top.location.href='./Logout.do'",3000); */

var i=0;
function toLogout(){
	setTimeout("toLogout()",3000);
	if(i>=1 && i<=10) window.top.location.href="./Logout.do";
	i++;
}

toLogout();
</script>
</head>
<body>
<div class="main">
	<div class="optitle clearfix">
		<div class="title">页面访问错误！&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;<font color="grey" size="4">引起的原因可能有：</font></div>
	</div>
	<form id="form1" name="form1" method="post">
		<div class="content">
			<table class="box">
				<tr>
					<td class="field">1.&nbsp;&nbsp;</td>
					<td>您没有正常登录；</td>
				</tr>
				<tr>
					<td class="field">2.&nbsp;&nbsp;</td>
					<td>您访问了权限之外的页面；</td>
				</tr>
				<tr>
					<td class="field">3.&nbsp;&nbsp;</td>
					<td>您用了非法的方式访问页面。</td>
				</tr>
			</table>
		</div>
		
	<div class="buttons">
		<span>本页将会在3秒后自动跳转到登录页.....</span>
	</div>
	
	</form>
</div>

</body>
</html>