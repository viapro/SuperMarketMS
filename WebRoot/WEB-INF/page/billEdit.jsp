<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.viapro.sm.bean.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link type="text/css" rel="stylesheet" href="css/style.css" />
<script type="text/javascript" >

function $(id) {
	return document.getElementById(id);
}
function showEditIdAlert() {
	$("idFeedback").innerHTML=" 编号为识别身份，不能被修改！";
	$("id").setAttribute('class', 'redbox');
}
function checkAddBillId() {
	reg = /^\d{1,9}$/;
	$("idFeedback").innerHTML = $("id").value ? (reg.test($("id").value) ? '' : ' 账单编号必须为1-9位数字，请重新填写') : ' 账单编号不能为空';
	if($("idFeedback").innerHTML) $("id").setAttribute('class', 'redbox');
	return !($("idFeedback").innerHTML);
}
function checkproduct_name() {
	reg = /^.{3,16}$/;
	$("product_nameFeedback").innerHTML = $("product_name").value ? (reg.test($("product_name").value) ? '' : ' 商品名称必须为3-16位字符，请重新填写') : ' 商品名称不能为空';
	if($("product_nameFeedback").innerHTML) $("product_name").setAttribute('class', 'redbox');
	return !($("product_nameFeedback").innerHTML);
}
function checkAmount() {
	reg = /^\d{1,9}$/;
	$("amountFeedback").innerHTML = $("amount").value ? (reg.test($("amount").value) ? '' : ' 商品数量必须为1~9位数字，请重新填写') : ' 商品数量不能为空';
	if($("amountFeedback").innerHTML) $("amount").setAttribute('class', 'redbox');
	return !($("amountFeedback").innerHTML);
}
function checkMoney() {
	reg = /^\d{1,9}$/;
	$("moneyFeedback").innerHTML = $("money").value ? (reg.test($("money").value) ? '' : ' 交易金额必须为1~9位数字，请重新填写') : ' 交易金额不能为空';
	if($("moneyFeedback").innerHTML) $("money").setAttribute('class', 'redbox');
	return !($("moneyFeedback").innerHTML);
}
function checkPayStatus() {
	$("pay_stateFeedback").innerHTML = $("pay_state").value ? '' : ' 请选择付款状态';
	return !($("pay_stateFeedback").innerHTML);
}
function checkProviderId() {
	$("providerIdFeedback").innerHTML = $("providerId").value ? '' : ' 请选择供应商';
	return !($("providerIdFeedback").innerHTML);
}

function clearFeedback(obj) {
	if ($(obj.name + 'Feedback').innerHTML)	$(obj.name + 'Feedback').innerHTML = "";
	obj.setAttribute('class', 'text'); 
}

function doAddBill() {
	if (checkAddBillId()&checkproduct_name()&checkAmount()&checkMoney()&checkPayStatus()&checkProviderId()) {
		if(confirm('符合填写要求，确认提交？')){
			with ($("form1")) {
				action = "BillEdit.do?isAdd=true";
				submit();
			}
		}
	}
}
function doEditBill() {
	if (checkproduct_name()&checkAmount()&checkMoney()&checkPayStatus()&checkProviderId()) {
		if(confirm('符合要求，确认修改？')){
			with ($("form1")) {
				action = "BillEdit.do?isUpdate=true";
				submit();
			}
		}
	}
}
function doDeleteBill() {
	if(confirm('确定删除该账单？')){
		with ($("form1")) {
			action = "BillEdit.do?isDelete=true";
			submit();
		}
	}
}
</script>
</head>
<body>
<div class="main">
  <div class="optitle clearfix">
	<div class="title">账单管理&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red" size="3">${message}</font></div>
  </div>
  <form id="form1" name="form1" method="post">
  
  		<input name="currentPage" value="${currentPage}" type="hidden"/>
		<input name="productName" value="${productName}" type="hidden"/>
		<input name="payStatus" value="${payStatus}" type="hidden"/>
  
<div class="content">
	<table class="box">
	  <tbody>
		<tr>
		  <td class="field">账单编号：</td>
		  <!-- 在input中设置disable会导致servlet取不到! -->
		  <td><input name="id" id="id"
		  <c:choose>
			  <c:when test="${isEdit}">value="${bill_to_edit.id}" readonly="readonly" onfocus="showEditIdAlert()" onblur="clearFeedback(this)" </c:when>
			  <c:otherwise>value="${bill_to_add.id}" onblur="checkAddBillId()" onfocus="clearFeedback(this)" </c:otherwise>
		  </c:choose>
		  class="text" type="text" /><span class="feedback" id="idFeedback" ></span></td>
		</tr>
		<tr>
		  <td class="field">商品名称：</td>
		  <td><input name="product_name"  id="product_name" 
		  value="${isEdit?bill_to_edit.productName:bill_to_add.productName}" onblur="checkproduct_name()" onfocus="clearFeedback(this)" 
		  class="text" type="text" /><span class="feedback" id="product_nameFeedback" ></span></td>
		</tr>
		<tr>
		  <td class="field">商品数量：</td>
		  <td><input name="amount" id="amount" 
		  value="${isEdit?bill_to_edit.amount:bill_to_add.amount}" onblur="checkAmount()" onfocus="clearFeedback(this)" 
		  class="text" type="text" /><span class="feedback" id="amountFeedback" ></span></td>
		</tr>
		<tr>
		  <td class="field">交易金额：</td>
		  <td><input name="money" id="money" 
		  value="${isEdit?bill_to_edit.money:bill_to_add.money}" onblur="checkMoney()" onfocus="clearFeedback(this)" 
		  class="text" type="text" /><span class="feedback" id="moneyFeedback" ></span></td>
		</tr>
		<tr>
		  <td class="field">是否付款：</td>
		  <td>
		    <select name="pay_state" id="pay_state" onblur="checkPayStatus()" onfocus="clearFeedback(this)" >
			  <c:choose>
				<c:when test="${isEdit}">
				  <option value="0" <c:if test="${bill_to_edit.paystate==0 }"> selected="selected"</c:if> >未付款</option>
				  <option value="1" <c:if test="${bill_to_edit.paystate==1 }"> selected="selected"</c:if> >已付款</option>
				</c:when>
				<c:otherwise>
				  <option value="" <c:if test="${empty bill_to_add.paystate}"> selected="selected"</c:if> >请选择</option>
				  <option value="0" <c:if test="${bill_to_add.paystate==0 }"> selected="selected"</c:if> >未付款</option>
				  <option value="1" <c:if test="${bill_to_add.paystate==1 }"> selected="selected"</c:if> >已付款</option>
				</c:otherwise>
			  </c:choose>
			</select>
			<span class="feedback" id="pay_stateFeedback" ></span>
		  </td>
		</tr>
		<tr>
		  <td class="field">供应商编号：</td>
		  <td>
		   <select name="providerId" id="providerId" onblur="checkProviderId()" onfocus="clearFeedback(this)" >
			<c:choose>
		      <c:when test="${isEdit}">
			    <c:set var="provider_id_to_edit" value="${bill_to_edit.providerId }"></c:set>
			    <c:forEach items="${providers}" var="provider">
			      <option value="${provider.id}"<c:if test="${provider.id==provider_id_to_edit}">selected="selected"</c:if>>${provider.id}.${provider.proName}</option>
			    </c:forEach>
		  	  </c:when>
			  <c:otherwise>
			    <c:set var="provider_id_to_add" value="${bill_to_add.providerId}"></c:set>
			    <option value="" <c:if test="${empty bill_to_add.providerId}">selected="selected"</c:if> >请选择</option>
			    <c:forEach items="${providers}" var="provider">
				  <option value="${provider.id}" <c:if test="${provider.id==provider_id_to_add}">selected="selected"</c:if> >${provider.id}.${provider.proName}</option>
			    </c:forEach>
			  </c:otherwise>
			 </c:choose>
		   </select>
		  <span class="feedback" id="providerIdFeedback" ></span>
		  </td>
		</tr>
		  <tr>
			<td class="field">商品描述：</td>
			<td><textarea name="productDesc" id="textarea">${isEdit?bill_to_edit.productDesc:bill_to_add.productDesc}</textarea></td>
		  </tr>
		</tbody>
	</table>
</div>

	<div class="buttons">
	  <c:choose>
	   <c:when test="${isEdit}">
		<input name="button" id="button" onclick="doEditBill()" value="修改" class="input-button" type="button" />
		<input name="button" id="button" onclick="doDeleteBill()" value="删除" class="input-button" type="button" />
	   </c:when>
	   <c:otherwise>
		<input name="button" id="button" onclick="doAddBill()" value="提交" class="input-button" type="button" /> 
	   </c:otherwise>
	  </c:choose>
		<input name="button" id="button" onclick="form1.action='BillList.do';form1.submit()" value="返回" class="input-button" type="button" />
	</div>
	
  </form>
</div>
</body>
</html>
