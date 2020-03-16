<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
function go_submit(){
	var userId = $j('[name=userId]').val();
	var userPw = $j('[name=userPw]').val();
	
	if( userId.trim()=='' ){
		alert('아이디를 입력하세요');
		$j('[name=userId]').focus();
		return;
	}
	if( userPw.trim()=='' ){
		alert('비밀번호를 입력하세요');
		$j('[name=userPw]').focus();
		return;
	}
	$j.ajax({
		type: 'post',
		url : '/loginAction.do',
		data : {
			userId : $j('#userId').val(),
			userPw : $j('#userPw').val()
		},
		success : function(data) {
			if (data) {
				if( ${empty param.name} )
					window.location=document.referrer;
				else
					window.location=document.referrer+'?${param.name}=${param.val}';
			} else {
				alert('아이디나 비밀번호가 일치하지 않습니다!');
				$j('#userId').focus();
				return;
			}
		},
		error : function(req, text) {
			alert(text + ": " + req.status);
		}
	});
}
</script>
<body>
<form name="form" method="post">
<table align="center">
	<tr>
		<td align="left">
			<a href="/board/boardList.do">List</a>
		</td>
	</tr>
	<tr>
		<td>
			<table border ="1"> 
				<tr>
					<td width="120" align="center">
					id
					</td>
					<td width="300">
						<input name="userId" id="userId" type="text" size="17" maxlength="17"/>
					</td>
				</tr>
				<tr>
					<td width="120" align="center">
					pw
					</td>
					<td width="300" style="font-size: 10px;">
						<input name="userPw" id="userPw" type="password" size="17" maxlength="12" />
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<a id="submit" onclick="go_submit()">join</a>
		</td>
	</tr>
</table>
</form>
</body>
</html>