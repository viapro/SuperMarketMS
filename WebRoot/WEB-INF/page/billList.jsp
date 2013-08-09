<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.viapro.sm.bean.Bill" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>账单</title>
<link type="text/css" rel="stylesheet" href="css/style.css" />
</head>

<body>

<div class="menu">
  <form method="post" action="BillList.do?currentPage=1">
	商品名称： 
	<input type="text" name="productName" value="${productName }" class="input-text" />&nbsp;&nbsp;&nbsp;&nbsp;
	是否付款：
	<select name="payStatus">
		<option value="" <c:if test="${empty payStatus }"> selected="selected"</c:if>>不选定</option>
		<option value="0" <c:if test="${payStatus eq '0' }"> selected="selected"</c:if>>未付款</option>
		<option value="1" <c:if test="${payStatus eq '1' }"> selected="selected"</c:if>>已付款</option>
	</select>&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="组合查询"/>
  </form>
</div>

<div class="main">
  <div class="optitle clearfix">
	<em><input type="button" name="button" value="添加数据" class="input-button" onclick="location.href='./GotoBillEditPage.do?isAdd=true&currentPage=${currentPage}&productName=${productName}&payStatus=${payStatus}'" /></em>
    <div class="title">账单管理&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;<font color="grey" size="3">${message }</font></div>
  </div>
<div class="content">
<table class="list">
  <tbody>
   <tr>
	<td width="70" height="29"><div class="STYLE1" align="center">编号</div></td>
	<td width="80"><div class="STYLE1" align="center">商品名称</div></td>
	<td width="100"><div class="STYLE1" align="center">商品数量</div></td>
	<td width="100"><div class="STYLE1" align="center">交易金额</div></td>
	<td width="150"><div class="STYLE1" align="center">是否付款</div></td>
	<td width="150"><div class="STYLE1" align="center">供应商名称</div></td>
	<td width="150"><div class="STYLE1" align="center">商品描述</div></td>
	<td width="150"><div class="STYLE1" align="center">账单时间</div></td>
   </tr>
<c:forEach items="${page.list}" var="bill">
<tr>
	<td height="23"><span class="STYLE1">${bill.id}</span></td>
	<td>
	  <span class="STYLE1">
		<a href="./GotoBillEditPage.do?bill_to_edit_id=${bill.id}&isEdit=true
		&currentPage=${page.currentPage}&productName=${productName }
		&payStatus=${payStatus }">${bill.productName }</a>
	  </span>
	</td>
	<td><span class="STYLE1">${bill.amount }</span></td>
	<td><span class="STYLE1">${bill.money }</span></td>
	<td>
	 <span class="STYLE1">
	  <c:if test="${bill.paystate==0 }">未付款</c:if>
	  <c:if test="${bill.paystate==1 }">已付款</c:if>
	 </span>
	</td>
	<td>
	 <span class="STYLE1">
	  <c:set var="bill_provider_id" value="${bill.providerId }"></c:set>
	  <c:forEach items="${providers }" var="provider">
	    <c:if test="${provider.id==bill_provider_id }">${provider.proName }</c:if>
	  </c:forEach>
	 </span>
	</td>
	<td><span class="STYLE1">${bill.productDesc }</span></td>
	<td><span class="STYLE1">${bill.billDate }</span></td>
</tr>
</c:forEach>
</tbody>
</table>
</div>


<div>
   	当前第${page.currentPage}页&nbsp;&nbsp;&nbsp;&nbsp;
   	<c:if test="${page.currentPage>1}">
   	<a href="./BillList.do?currentPage=${page.currentPage-1}&productName=${productName }&payStatus=${payStatus }">上一页</a>
   	</c:if>
   	
   	<c:forEach varStatus="status" begin="${page.startPage}" end="${page.endPage}">
   		[<a href="./BillList.do?currentPage=${status.index}&productName=${productName }&payStatus=${payStatus }">${status.index}</a>]
	</c:forEach>
   	
   	<c:if test="${page.currentPage<page.pageCount }">
   	<a href="./BillList.do?currentPage=${page.currentPage+1 }&productName=${productName }&payStatus=${payStatus }">下一页</a>
   	</c:if>
   	&nbsp;&nbsp;&nbsp;&nbsp;共${page.pageCount}页，共${page.rowCount}条记录
</div>
  
</div>
</body>
</html>
