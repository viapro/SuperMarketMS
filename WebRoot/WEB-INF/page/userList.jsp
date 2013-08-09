<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.viapro.sm.bean.User"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>用户</title>
<link type="text/css" rel="stylesheet" href="css/style.css"></link>
</head>

<body>

<div class="menu">
  <form method="post" action="UserList.do?currentPage=1">
	用户名称：
	<input name="userName" class="input-text" type="text" value="${userName}"/>
	&nbsp;&nbsp;&nbsp;&nbsp; 
	用户性别：
	<select name="userGender">
		<option value="" <c:if test="${empty userGender }"> selected="selected"</c:if>>不选定</option>
		<option value="0" <c:if test="${userGender eq '0' }"> selected="selected"</c:if>>女</option>
		<option value="1" <c:if test="${userGender eq '1' }"> selected="selected"</c:if>>男</option>
	</select>&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="submit" value="组合查询"/>
  </form>
</div>
<div class="main">
<div class="optitle clearfix">
  <em><input value="添加数据" class="input-button" onclick="location.href='./GotoUserEditPage.do?isAdd=true&currentPage=${currentPage}&userName=${userName}&userGender=${userGender}'" type="button"/></em>
  <div class="title">用户管理&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;<font color="grey" size="3">${message }</font></div>
</div>
<div class="content">
  <table class="list">
	<tbody>
	  <tr>
		<td width="70" height="29"><div class="STYLE1" align="center">编号</div></td>
		<td width="80"><div class="STYLE1" align="center">用户名称</div></td>
		<td width="100"><div class="STYLE1" align="center">性别</div></td>
		<td width="100"><div class="STYLE1" align="center">年龄</div></td>
		<td width="150"><div class="STYLE1" align="center">电话</div></td>
		<td width="150"><div class="STYLE1" align="center">地址</div></td>
		<td width="150"><div class="STYLE1" align="center">权限</div></td>
	  </tr>
	  <c:forEach items="${page.list}" var="user">
	  <tr>
		<td height="23"><span class="STYLE1">${user.id}</span></td>
		<td><span class="STYLE1"><a href="./GotoUserEditPage.do?isEdit=true&user_to_edit_id=${user.id}&currentPage=${page.currentPage}&userName=${userName}&userGender=${userGender}"
			onclick="doit('mod',1)">${user.username }</a></span></td>
		<td><span class="STYLE1">${user.gender==0?"女":"男"} </span></td>
		<td><span class="STYLE1">${sessionScope.year-user.yob }</span></td>
		<td><span class="STYLE1">${user.mobile }</span></td>
		<td><span class="STYLE1">${user.address }</span></td>
		<td><span class="STYLE1">${user.privilege==0?"经理":"普通用户"}</span></td>
	  </tr>
	  </c:forEach>
	</tbody>
  </table>
</div>
<div>
   	当前第${page.currentPage}页&nbsp;&nbsp;&nbsp;&nbsp;
   	<c:if test="${page.currentPage>1}">
   	<a href="./UserList.do?currentPage=${page.currentPage-1}&userName=${userName}&userGender=${userGender}">上一页</a>
   	</c:if>
   	
   	<c:forEach varStatus="status" begin="${page.startPage}" end="${page.endPage}">
   		[<a href="./UserList.do?currentPage=${status.index}&userName=${userName}&userGender=${userGender}">${status.index}</a>]
	</c:forEach>
   	
   	<c:if test="${page.currentPage<page.pageCount }">
   	<a href="./UserList.do?currentPage=${page.currentPage+1 }&userName=${userName}&userGender=${userGender}">下一页</a>
   	</c:if>
   	&nbsp;&nbsp;&nbsp;&nbsp;共${page.pageCount}页，共${page.rowCount}条记录
</div>
</div>
</body>
</html>