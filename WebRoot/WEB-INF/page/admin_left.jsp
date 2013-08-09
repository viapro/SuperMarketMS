<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.viapro.sm.bean.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link type="text/css" rel="stylesheet" href="css/style.css" />
<script type="text/javascript">
function doLogout(){
	if(confirm("确定退出？")) window.top.location.href="./Logout.do";
}
</script>
</head>
<body class="frame-bd" id="frame-bd">
<ul class="left-menu">
	<li><a href="./BillList.do" target="mainFrame"><img src="images/btn_bill.gif" /></a></li>
	<c:if test="${sessionScope.user.privilege==0}">
	<li><a href="./ProviderList.do" target="mainFrame"><img src="images/btn_suppliers.gif" /></a></li>
	<li><a href="./UserList.do" target="mainFrame"><img src="images/btn_users.gif" /></a></li>
	</c:if>
	<li><a onclick="doLogout()" ><img src="images/btn_exit.gif" /></a></li>
</ul>
</body>
</html>
