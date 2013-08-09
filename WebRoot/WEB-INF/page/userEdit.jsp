<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.viapro.sm.bean.User"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>编辑用户</title>
<link type="text/css" rel="stylesheet" href="<%=basePath %>css/style.css"/>

<script type="text/javascript">
var password = '';
var newPassword = '';
function $(id) {
	return document.getElementById(id);
}
function showEditIdAlert() {
	$("idFeedback").innerHTML=" 编号为唯一标记识别，不能被修改！";
	$("id").setAttribute('class', 'redbox');
}
function checkAddUserId() {
	reg = /^\d{1,9}$/;
	$("idFeedback").innerHTML = $("id").value ? (reg.test($("id").value) ? '' : ' 用户编号必须为1-9位数字，请重新填写') : ' 用户编号不能为空';
	if($("idFeedback").innerHTML)  $("id").setAttribute('class', 'redbox');
	return !($("idFeedback").innerHTML);
}
function checkUsername() {
	reg = /^.{2,50}$/;
	$("usernameFeedback").innerHTML = $("username").value ? (reg.test($("username").value) ? '' : ' 用户名必须为2-50位字符，请重新填写') : ' 用户名不能为空';
	if($("usernameFeedback").innerHTML) $("username").setAttribute('class', 'redbox');
	return !($("usernameFeedback").innerHTML);
}
function checkPassword() {
	reg = /^\w{4,}$/;
	$("passwordFeedback").innerHTML = $("password").value ? (reg.test($("password").value) ? '' : '密码不能少于4位') : '密码不能为空';
	if($("passwordFeedback").innerHTML) $("password").setAttribute('class', 'redbox');
	else password = $("password").value;
	return !($("passwordFeedback").innerHTML);
}
function checkPassword1() {
	$("password1Feedback").innerHTML = ($("password1").value==password) ? '' : '两次密码不一致';
	if($("passwordFeedback").innerHTML) $("password").setAttribute('class', 'redbox');
	return !($("password1Feedback").innerHTML);
}
function checkOldPassword() {
	$("oldPasswordFeedback").innerHTML = $("oldPassword").value ? '' : '密码不能为空';
	if($("oldPasswordFeedback").innerHTML) $("oldPassword").setAttribute('class', 'redbox');
	return !($("oldPasswordFeedback").innerHTML);
}
function checkNewPassword() {
	reg = /^\w{4,}$/;
	$("newPasswordFeedback").innerHTML = $("newPassword").value ? (reg.test($("newPassword").value) ? '' : '新密码不能少于4位') : '新密码不能为空';
	if($("newPasswordFeedback").innerHTML) $("newPassword").setAttribute('class', 'redbox');
	else newPassword = $("newPassword").value;
	return !($("newPasswordFeedback").innerHTML);
}
function checkNewPasswordConfirm() {
	$("newPasswordConfirmFeedback").innerHTML = ($("newPasswordConfirm").value==newPassword) ? '' : '两次密码不一致';
	if($("newPasswordConfirmFeedback").innerHTML) $("newPasswordConfirm").setAttribute('class', 'redbox');
	return !($("newPasswordConfirmFeedback").innerHTML);
}
function checkGender() {
	$("genderFeedback").innerHTML = $("gender").value ? '' : ' 请选择用户性别';
	return !($("genderFeedback").innerHTML);
}
function checkAge() {
	reg = /^\d{1,3}$/;
	$("ageFeedback").innerHTML = $("age").value ? (reg.test($("age").value ) ? (($("age").value >= 0 && $("age").value <= 150) ? ''
			: "年龄必须在0~150之间")
			: "年龄必须是1~3位数字")
			: "年龄不能为空";
	if($("ageFeedback").innerHTML) $("age").setAttribute('class', 'redbox');
	return !($("ageFeedback").innerHTML);
}
function checkMobile() {
	reg = /^\d{1,15}$/;
	$("mobileFeedback").innerHTML = $("mobile").value ? (reg.test($("mobile").value) ? '' : ' 用户电话必须为1~15位数字，请重新填写') : ' 用户电话不能为空';
	if($("mobileFeedback").innerHTML) $("mobile").setAttribute('class', 'redbox');
	return !($("mobileFeedback").innerHTML);
}
function checkAuth() {
	var auth = document.getElementsByName("auth");
  	if(auth!=null){
      	var i;
      	for(i=0;i<auth.length;i++){
        	if(auth[i].checked){
        		return true;
        	}
        }
		$("authFeedback").innerHTML = ' 请选择用户权限';
    }
	return false;
}
function clearFeedback(obj) {
	if ($(obj.name + 'Feedback').innerHTML)	$(obj.name + 'Feedback').innerHTML = "";
	obj.setAttribute('class', 'text'); 
}
function clearAuthFeedback(obj) {
	if ($(obj.name + 'Feedback').innerHTML)	$(obj.name + 'Feedback').innerHTML = "";
}

function doAddUser() {
	if (checkAuth()&checkAddUserId()&checkUsername()&checkPassword()&checkPassword1()&checkGender()&checkAge()&checkMobile()&checkAuth()) {
		if(confirm('符合填写要求，确认提交？')){
			with ($("form1")) {
				action = "UserEdit.do?isAdd=true";
				submit();
			}
		}
	}
}
function doUpdateUser() {
	if (checkUsername()&checkGender()&checkAge()&checkMobile()&checkAuth()) {
		if(confirm('符合要求，确认修改？')){
			with ($("form1")) {
				action = "UserEdit.do?isUpdate=true";
				submit();
			}
		}
	}
}
function doUpdatePassword() {
	if (checkOldPassword()&checkNewPassword()&checkNewPasswordConfirm()) {
		if(confirm('符合要求，确认修改？')){
			with ($("form1")) {
				action = "GotoUserEditPage.do?doModifyPassword=true";
				submit();
			}
		}
	}
}
function doDeleteUser() {
	if(confirm('确定删除该用户？')){
		with ($("form1")) {
			action = "UserEdit.do?isDelete=true";
			submit();
		}
	}
}
</script>

</head>

<body>
<div class="main">
	<div class="optitle clearfix">
		<div class="title">用户管理&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red" size="3">${message }</font></div>
	</div>
<form id="form1" name="form1" method="post">

		<input name="currentPage" value="${currentPage}" type="hidden"/>
		<input name="userName" value="${userName}" type="hidden"/>
		<input name="userGender" value="${userGender}" type="hidden"/>

<div class="content">
	<table class="box">
<c:choose>
	<c:when test="${isEdit||isAdd}">
		<tr>
			<td class="field">用户编号：</td>
			<td><input type="text" name="id" id="id"
			  <c:choose>
				  <c:when test="${isEdit}">value="${user_to_edit.id}" readonly="readonly" onfocus="showEditIdAlert()" onblur="clearFeedback(this)" </c:when>
				  <c:otherwise>value="${user_to_add.id}" onblur="checkAddUserId()" onfocus="clearFeedback(this)" <</c:otherwise>
			  </c:choose>
			 class="text" /> <span class="feedback" id="idFeedback" ></span></td>
		</tr>
		<tr>
			<td class="field">用户名称：</td>
			<td><input name="username" id="username" 
			value="${isEdit?user_to_edit.username:user_to_add.username}" onblur="checkUsername()" onfocus="clearFeedback(this)" 
			class="text" type="text" /><span class="feedback" id="usernameFeedback" ></span></td>
		</tr>
		
		<c:if test="${isAdd }">
			<tr>
				<td class="field">用户密码：</td>
				<td><input name="password" id="password" value="" onblur="checkPassword()" onfocus="clearFeedback(this)" 
				class="text" type="password" /> 
				<span class="feedback" id="passwordFeedback" ></span></td>
			</tr>
			<tr>
				<td class="field">确认密码：</td>
				<td><input type="password" name="password1" id="password1" value="" onblur="checkPassword1()" onfocus="clearFeedback(this)" class="text"/> 
				<span class="feedback" id="password1Feedback" ></span></td>
			</tr>
		</c:if>

		<tr>
		   <td class="field">用户性别：</td>
		   <td>
			<select name="gender" id="gender" onblur="checkGender()" onfocus="clearFeedback(this)">
   			  <c:choose>
				<c:when test="${isEdit}">
				  <option value="0" <c:if test="${user_to_edit.gender==0 }"> selected="selected"</c:if>>女</option>
				  <option value="1" <c:if test="${user_to_edit.gender==1 }"> selected="selected"</c:if>>男</option>
				</c:when>
				<c:otherwise>
				  <option value="" <c:if test="${empty user_to_add.gender}"> selected="selected"</c:if> >请选择</option>
				  <option value="0" <c:if test="${user_to_add.gender==0 }"> selected="selected"</c:if> >女</option>
				  <option value="1" <c:if test="${user_to_add.gender==1 }"> selected="selected"</c:if> >男</option>
				</c:otherwise>
			  </c:choose>
					</select>
					<span class="feedback" id="genderFeedback" ></span>
			</td>
		    </tr>
		<tr>
			<td class="field">用户年龄：</td>
			<td><input type="text" name="age" id="age" onblur="checkAge()" onfocus="clearFeedback(this)"
				<c:if test="${!empty user_to_edit||!empty user_to_add }">value="${isEdit?sessionScope.year-user_to_edit.yob:sessionScope.year-user_to_add.yob}"</c:if>
			 class="text"/><span class="feedback" id="ageFeedback" ></span></td>
		</tr>
		<tr>
			<td class="field">用户电话：</td>
			<td><input type="text" name="mobile" id="mobile" onblur="checkMobile()" onfocus="clearFeedback(this)"
			value="${isEdit?user_to_edit.mobile:user_to_add.mobile}" class="text" /> 
			<span class="feedback" id="mobileFeedback" ></span></td>
		</tr>
		<tr>
			<td class="field">用户地址：</td>
			<td><textarea name="address" id="textarea" class="text" cols="45" rows="5">${isEdit?user_to_edit.address:user_to_add.address}</textarea></td>
		</tr>
		<tr>
			<td class="field">用户权限：</td>
			<td>
		  	  <c:choose>
				<c:when test="${isEdit}">
				  <input type="radio" name="auth" id="auth" value="0" <c:if test="${user_to_edit.privilege==0 }"> checked="checked" </c:if>/>经理
				  <input type="radio" name="auth" id="auth" value="1" <c:if test="${user_to_edit.privilege==1 }"> checked="checked" </c:if>/>普通用户
				</c:when>
				<c:otherwise>
				  <input type="radio" name="auth" id="auth" value="0" onclick="clearAuthFeedback(this)" <c:if test="${user_to_add.privilege==0 }"> checked="checked" </c:if>/>经理
				  <input type="radio" name="auth" id="auth" value="1" onclick="clearAuthFeedback(this)" <c:if test="${user_to_add.privilege==1 }"> checked="checked" </c:if>/>普通用户
				</c:otherwise>
			  </c:choose>
			  <span class="feedback" id="authFeedback" ></span>
			</td>
		</tr>
	</c:when>
	<c:otherwise>
		<tr>
			<td class="field">旧的密码：</td>
			<td><input type="password" name="oldPassword" id="oldPassword" onblur="checkOldPassword()" onfocus="clearFeedback(this)" 
			class="text" /><span class="feedback" id="oldPasswordFeedback" ></span></td>
		</tr>
		<tr>
			<td class="field">新的密码：</td>
			<td><input type="password" name="newPassword" id="newPassword" onblur="checkNewPassword()" onfocus="clearFeedback(this)" 
			class="text" /><span class="feedback" id="newPasswordFeedback" ></span></td>
		</tr>
		<tr>
			<td class="field">确认密码：</td>
			<td><input type="password" name="newPasswordConfirm" id="newPasswordConfirm" value="" onblur="checkNewPasswordConfirm()" onfocus="clearFeedback(this)" class="text"/> 
			<span class="feedback" id="newPasswordConfirmFeedback" ></span></td>
		</tr>
		<input type="hidden" name="user_to_edit_id" value="${user_to_edit_id}" />
	</c:otherwise>
</c:choose>				
	</table>
</div>
	
<div class="buttons">
  <c:choose>
  
   <c:when test="${isEdit}">
	<input name="button" id="button" onclick="doUpdateUser()" value="修改" class="input-button" type="button" />
	  <c:if test="${sessionScope.user.id ne user_to_edit.id }">
		<input name="button" id="button" onclick="doDeleteUser()" value="删除" class="input-button" type="button" />
	  </c:if>
      <%-- <c:if test="${sessionScope.user.id eq user_to_edit.id }"> --%>
		<input name="button" id="button" onclick="form1.action='GotoUserEditPage.do?isModifyPassword=true&user_to_edit_id=${user_to_edit_id }';form1.submit()" value="修改密码" class="input-button" type="button" />
      <%-- </c:if> --%>
   	  <input name="button" id="button" onclick="form1.action='UserList.do';form1.submit()" value="返回" class="input-button" type="button" />
   </c:when>
   
   <c:when test="${isAdd }">
	<input name="button" id="button" onclick="doAddUser()" value="数据提交" class="input-button" type="button" /> 
	<input name="button" id="button" onclick="form1.action='UserList.do';form1.submit()" value="返回" class="input-button" type="button" />
   </c:when>
   
   <c:otherwise>
		<input name="button" id="button" onclick="doUpdatePassword()" value="修改密码" class="input-button" type="button" /> 
  		<input name="button" id="button" onclick="form1.action='GotoUserEditPage.do?isEdit=true';form1.submit()" value="返回" class="input-button" type="button" />
   </c:otherwise>
   
  </c:choose>
</div>
</form>
</div>

</body>
</html>
