<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>编辑供应商</title>
<link type="text/css" rel="stylesheet" href="css/style.css" />

<script type="text/javascript" >
function $(id) {
	return document.getElementById(id);
}
function showEditIdAlert() {
	$("idFeedback").innerHTML=" 编号为唯一标记识别，不能被修改！";
	$("id").setAttribute('class', 'redbox');
}
function checkAddProviderId() {
	reg = /^\d{1,9}$/;
	$("idFeedback").innerHTML = $("id").value ? (reg.test($("id").value) ? '' : ' 供应商编号必须为1-9位数字，请重新填写') : ' 供应商编号不能为空';
	if($("idFeedback").innerHTML) $("id").setAttribute('class', 'redbox');
	return !($("idFeedback").innerHTML);
}
function checkProName() {
	reg = /^.{2,50}$/;
	$("proNameFeedback").innerHTML = $("proName").value ? (reg.test($("proName").value) ? '' : ' 供应商名称必须为2-50位字符，请重新填写') : ' 供应商名称不能为空';
	if($("proNameFeedback").innerHTML) $("proName").setAttribute('class', 'redbox');
	return !($("proNameFeedback").innerHTML);
}
function checkContact() {
	reg = /^.{2,50}$/;
	$("contactFeedback").innerHTML = $("contact").value ? (reg.test($("contact").value) ? '' : ' 供应商联系方式需要为2-50位字符，请重新填写') : ' 供应商联系方式不能为空';
	if($("contactFeedback").innerHTML) $("contact").setAttribute('class', 'redbox');
	return !($("contactFeedback").innerHTML);
}
function checkTel() {
	reg = /^\d{1,15}$/;
	$("telFeedback").innerHTML = $("tel").value ? (reg.test($("tel").value) ? '' : ' 电话必须为1~15位数字，请重新填写') : ' 供应商电话不能为空';
	if($("telFeedback").innerHTML) $("tel").setAttribute('class', 'redbox');
	return !($("telFeedback").innerHTML);
}
function checkFax() {
	reg = /^\d{1,15}$/;
	$("faxFeedback").innerHTML = $("fax").value ? (reg.test($("fax").value) ? '' : ' 传真必须为1~15位数字，请重新填写') : ' 供应商传真不能为空';
	if($("faxFeedback").innerHTML) $("fax").setAttribute('class', 'redbox');
	return !($("faxFeedback").innerHTML);
}
function checkAddress() {
	reg = /^.{2,50}$/;
	$("addressFeedback").innerHTML = $("address").value ? (reg.test($("address").value) ? '' : ' 供应商地址需要为2-50位字符，请重新填写') : ' 供应商地址不能为空';
	if($("addressFeedback").innerHTML) $("address").setAttribute('class', 'redbox');
	return !($("addressFeedback").innerHTML);
}

function checkProDesc() {
	reg = /^.{2,500}$/;
	$("proDescFeedback").innerHTML = $("proDesc").value ? (reg.test($("proDesc").value) ? '' : ' 供应商描述需要为2-500个字符，请重新填写') : ' 供应商描述不能为空';
	if($("proDescFeedback").innerHTML) $("proDesc").setAttribute('class', 'redbox');
	return !($("proDescFeedback").innerHTML);
}

function clearFeedback(obj) {
	if ($(obj.name + 'Feedback').innerHTML)	$(obj.name + 'Feedback').innerHTML = "";
	obj.setAttribute('class', 'text'); 
}

function doAddProvider() {
	if (checkAddProviderId()&checkProName()&checkContact()&checkTel()&checkFax()&checkAddress()&checkProDesc()) {
		if(confirm('符合填写要求，确认提交？')){
			with ($("form1")) {
				action = "ProviderEdit.do?isAdd=true";
				submit();
			}
		}
	}
}
function doUpdateProvider() {
	if (checkProName()&checkContact()&checkTel()&checkFax()&checkAddress()&checkProDesc()) {
		if(confirm('符合要求，确认修改？')){
			with ($("form1")) {
				action = "ProviderEdit.do?isUpdate=true";
/* 				action = "ProviderEdit.do?isUpdate=true&currentPage=${currentPage}&providerName=${providerName}&providerDesc=${providerDesc}"; */
				submit();
			}
		}
	}
}
function doDeleteProvider() {
	if(confirm('确定删除该供应商？')){
		with ($("form1")) {
			action = "ProviderEdit.do?isDelete=true";
			submit();
		}
	}
}
</script>
</head>
<body>
<div class="main">
	<div class="optitle clearfix">
		<div class="title">供应商管理&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; <font color="grey" size="3">${message }</font></div>
	</div>
	
<form id="form1" name="form1" method="post">
	
		<input name="currentPage" value="${currentPage}" type="hidden"/>
		<input name="providerName" value="${providerName}" type="hidden"/>
		<input name="providerDesc" value="${providerDesc}" type="hidden"/>
		
<div class="content">
	<table class="box">

	<tbody>
	<tr>
		<td class="field">供应商编号：</td>
		<td><input name="id" id="id" 
		  <c:choose>
			<c:when test="${isEdit}">value="${provider_to_edit.id}" readonly="readonly" onfocus="showEditIdAlert()" onblur="clearFeedback(this)" </c:when>
			<c:otherwise>value="${provider_to_add.id}" onblur="checkAddProviderId()" onfocus="clearFeedback(this)" </c:otherwise>
		  </c:choose>					
		 class="text" type="text"/><span class="feedback" id="idFeedback" ></span></td>
	</tr>
	
	<tr>
		<td class="field">供应商名称：</td>
		<td><input name="proName" id="proName" 
		value="${isEdit?provider_to_edit.proName:provider_to_add.proName}" onblur="checkProName()" onfocus="clearFeedback(this)" 
		class="text" type="text"/><span class="feedback" id="proNameFeedback" ></span></td>
	</tr>
	<tr>
		<td class="field">供应商联系：</td>
		<td><input name="contact" id="contact" 
		value="${isEdit?provider_to_edit.contact:provider_to_add.contact}" onblur="checkContact()" onfocus="clearFeedback(this)" 
		class="text" type="text"/><span class="feedback" id="contactFeedback" ></span></td>
	</tr>
	<tr>
		<td class="field">供应商电话：</td>
		<td><input name="tel" id="tel" 
		value="${isEdit?provider_to_edit.tel:provider_to_add.tel}" onblur="checkTel()" onfocus="clearFeedback(this)" 
		class="text" type="text"/><span class="feedback" id="telFeedback" ></span></td>
	</tr>
	<tr>
		<td class="field">供应商传真：</td>
		<td><input name="fax" id="fax" onblur="checkFax()" onfocus="clearFeedback(this)" 
		value="${isEdit?provider_to_edit.fax:provider_to_add.fax}"  
		class="text" type="text"/><span class="feedback" id="faxFeedback" ></span></td>
	</tr>
	<tr>
		<td class="field">供应商地址：</td>
		<td><input name="address" id="address" onblur="checkAddress()" onfocus="clearFeedback(this)" 
		value="${isEdit?provider_to_edit.address:provider_to_add.address}"  
		class="text" type="text"/><span class="feedback" id="addressFeedback" ></span></td>
	</tr>
	<tr>
		<td class="field">供应商描述：</td>
		<td><textarea name="proDesc" id="proDesc" cols="45" rows="5"  onblur="checkProDesc()" onfocus="clearFeedback(this)" >${isEdit?provider_to_edit.proDesc:provider_to_add.proDesc}</textarea><span class="feedback" id="proDescFeedback" ></span></td>
	</tr>
	</tbody>
</table>
</div>

	<div class="buttons">
	  <c:choose>
	   <c:when test="${isEdit}">
		<input name="button" id="button" onclick="doUpdateProvider()" value="修改" class="input-button" type="button" />
		<input name="button" id="button" onclick="doDeleteProvider()" value="删除" class="input-button" type="button" />
	   </c:when>
	   <c:otherwise>
		<input name="button" id="button" onclick="doAddProvider()" value="提交" class="input-button" type="button" /> 
	   </c:otherwise>
	  </c:choose>
<%-- 	<input name="button" id="button" onclick="location.href='ProviderList.do?'" value="返回" class="input-button" type="button" />
		<input name="button" id="button" onclick="location.href='ProviderList.do?currentPage=${currentPage}&providerName=${providerName}&providerDesc=${providerDesc}'" value="返回" class="input-button" type="button" />--%>
		<input name="button" id="button" onclick="form1.action='ProviderList.do';form1.submit()" value="返回" class="input-button" type="button" />
	</div>
</form>

</div>
</body>
</html>
