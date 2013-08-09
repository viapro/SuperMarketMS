<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.viapro.sm.bean.User"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>供应商</title>
<link type="text/css" rel="stylesheet" href="css/style.css">

</head>

<body>

<div class="menu">
 <form method="post" action="ProviderList.do?currentPage=1">
  <!-- <input name="flag" value="search" type="hidden"/> -->
	供应商名称：
	<input name="providerName" class="input-text" type="text" value="${providerName}"/> &nbsp;&nbsp;&nbsp;&nbsp;
	供应商描述：
	<input name="providerDesc" class="input-text" type="text" value="${providerDesc}"/>&nbsp;&nbsp;&nbsp;&nbsp;
  <input type="submit" value="组合查询"/>
 </form>
</div>

<div class="main">

  <div class="optitle clearfix">
  <!-- 这里折行会无法正确取值 -->
	<em><input value="添加数据" name="button" class="input-button" onclick="location.href='./GotoProviderEditPage.do?isAdd=true&currentPage=${page.currentPage}&providerName=${providerName}&providerDesc=${providerDesc}'" type="button"/></em>
	<div class="title">供应商管理&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; <font color="grey" size="3">${message }</font></div>
  </div>

<div class="content">
<table class="list">
  <tbody>
  <tr>
	<td width="70" height="29"><div class="STYLE1" align="center">编号</div></td>
	<td width="80"><div class="STYLE1" align="center">供应商名称</div></td>
	<td width="100"><div class="STYLE1" align="center">供应商描述</div></td>
	<td width="100"><div class="STYLE1" align="center">联系人</div></td>
	<td width="150"><div class="STYLE1" align="center">电话</div></td>
	<td width="150"><div class="STYLE1" align="center">地址</div></td>
  </tr>
<c:forEach items="${page.list}" var="provider">
  <tr>
	<td height="23"><span class="STYLE1">${provider.id}</span></td>
	<td><span class="STYLE1"><a href="./GotoProviderEditPage.do?isEdit=true&provider_to_edit_id=${provider.id}
	&currentPage=${page.currentPage}&providerName=${providerName}&providerDesc=${providerDesc}"
			onclick="doit('mod',1)">${provider.proName }</a></span></td>
	<td><span class="STYLE1">${provider.proDesc} </span></td>
	<td><span class="STYLE1">${provider.contact }</span></td>
	<td><span class="STYLE1">${provider.tel }</span></td>
	<td><span class="STYLE1">${provider.address }</span></td>
  </tr>
</c:forEach>  
  </tbody>
</table>
</div>

<div>
   	当前第${page.currentPage}页&nbsp;&nbsp;&nbsp;&nbsp;
   	<c:if test="${page.currentPage>1}">
   	<a href="./ProviderList.do?currentPage=${page.currentPage-1}&providerName=${providerName}&providerDesc=${providerDesc}">上一页</a>
   	</c:if>
   	
   	<c:forEach varStatus="status" begin="${page.startPage}" end="${page.endPage}">
   		[<a href="./ProviderList.do?currentPage=${status.index}&providerName=${providerName}&providerDesc=${providerDesc}">${status.index}</a>]
	</c:forEach>
   	
   	<c:if test="${page.currentPage<page.pageCount }">
   	<a href="./ProviderList.do?currentPage=${page.currentPage+1 }&providerName=${providerName}&providerDesc=${providerDesc}">下一页</a>
   	</c:if>
   	&nbsp;&nbsp;&nbsp;&nbsp;共${page.pageCount}页，共${page.rowCount}条记录
</div>

</div>
</body>
</html>