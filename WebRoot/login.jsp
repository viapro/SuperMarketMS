<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>系统登录 - 超市账单管理系统</title>
<link type="text/css" rel="stylesheet" href="<%=basePath %>css/style.css" />
<script type="text/javascript">
function $(id) {
	return document.getElementById(id);
}
function checkUserName() {
	$("userNameFeedback").innerHTML = $("userName").value ? '': ' 用户名不能为空';
	return !($("userNameFeedback").innerHTML);
}
function checkPassWord() {
	reg = /^\w{4,}$/;
	$("passWordFeedback").innerHTML = $("passWord").value ? (reg.test($("passWord").value) ? '' : ' 密码为不少于4位的有效字符') : '密码不能为空';
	return !($("passWordFeedback").innerHTML);
}
function clearFeedback(obj) {
	if ($(obj.name + 'Feedback').innerHTML)	$(obj.name + 'Feedback').innerHTML = "";
}
function doLogin() {
	if (checkUserName()&checkPassWord()) {
 		with ($("form0")) {
			submit();
		}
	}
}
function clearAll(){
	$("userName").value="";
	$("passWord").value="";
	$("userNameFeedback").innerHTML="";
	$("passWordFeedback").innerHTML="";
	$("servletFeedback").innerHTML="";
}
</script>
</head>
<body class="blue-style">
<div id="login">
<div class="icon"></div>
<div class="login-box">
  <form method="post" id="form0" action="Login.do">
   <dl>
	<dt>用户名：</dt>
	<dd>
		<input type="text" name="userName" id="userName" value="${userName }" 
		onfocus="clearFeedback(this)" onblur="checkUserName()" class="input-text" /> 
		<font color="pink" size="3"><span id="userNameFeedback" ></span></font>
	</dd>
	<dt>密 码：</dt>
	<dd>
		<input type="password" name="passWord" id="passWord"
		onfocus="clearFeedback(this)" onblur="checkPassWord()" class="input-text" /> 
		<font color="pink" size="3"><span id="passWordFeedback"></span></font>
	</dd>
   </dl>
   <div class="buttons">
	<input type="button" name="button" onclick="doLogin()" value="登录系统" class="input-button" /> 
	<input type="reset" name="reset" onclick="clearAll()" value="重　　填" class="input-button" />
   </div>
   <span id="servletFeedback"><font color="red" size="3">${message }</font></span>
  </form>
</div>
</div>
</body>
</html>

