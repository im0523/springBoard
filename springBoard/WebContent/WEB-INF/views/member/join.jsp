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
	var space = /\s/g;
	var reg = /[^a-zA-Z0-9]/g;
	var getCheck= RegExp(/^[a-zA-Z0-9]{6,12}$/);
	var nameCheck = /^[가-힣]{2,4}$/;
//아이디 중복확인
function usable(){
	var userId = $j('[name=userId]').val();
	var space = /\s/g;
	var reg = /[^a-zA-Z0-9]/g;
	if( userId=='' ){ 				
		alert('아이디를 입력하세요');
		$j('[name=userId]').focus();
		return;
	}else if( userId.match(space) ){ 
		alert('공백없이 입력하세요'); 
		$j('[name=userId]').focus();
		return;
	}else if( reg.test(userId) ){    
		alert('영문, 숫자만 입력가능');
		$j('[name=userId]').focus();
		return;
	}else if( userId.length<6 ){ 	
		alert('아이디는 최소 6자 이상'); 
		$j('[name=userId]').focus();
		return;
	}
		$j.ajax({
			type: 'post',
			data: { userId: $j('[name=userId]').val() },
			url: '/id_usable.do',
			dataType: "json",
			success: function(data){
				if( data == true){
					alert('사용가능한 아이디입니다'); 
					$j('#id_usable').val('y');
				}else{
					alert('이미 사용중인 아이디입니다');
					$j('#id_usable').val('n');
				}
			},error: function(req, text){
				alert(text+": " + req.status);
			}
		});
	return data;		
}

//join 버튼 눌렀을 시 처리
function go_submit(){
	if( $j('[name=userId]').val().trim()=='' ){
		alert('아이디를 입력하세요');
		$j('[name=userId]').focus();
		return;
	}
	if( $j('[name=userPw]').val().trim()=='' ){
		alert('비밀번호를 입력하세요');
		$j('[name=userPw]').focus();
		return;
	}
	if( $j('[name=userPwCk]').val().trim()=='' ){
		alert('비밀번호 확인을 입력하세요');
		$j('[name=userPwCk]').focus();
		return;
	}
	if( $j("#userPw").val() != $j("#userPwCk").val() ){
		alert("비밀번호가 서로 다릅니다");
		$j("#userPw").focus();
		return false; 
	}
	if( $j('[name=userName]').val().trim()=='' ){
		alert('이름을 입력하세요');
		$j('[name=userName]').focus();
		return;
	}
	if( $j('[name=userPhone2]').val().trim()=='' ){
		alert('전화번호를 입력하세요');
		$j('[name=userPhone2]').focus();
		return;
	}
	if( $j('[name=userPhone3]').val().trim()=='' ){
		alert('전화번호를 입력하세요');
		$j('[name=userPhone3]').focus();
		return;
	}
	
	//아이디 중복확인 안한경우 유효한지 판단
	if( $j('#id_usable').val()=='n' ){	//값이 '중복확인 안했습니다'인 경우
		alert('아이디 중복확인을 해주세요');
		$('[name=userId]').focus();
		return;
	}
	
	//비밀번호 유효성검사
	var userPw = $j('[name=userPw]').val();
	if( !getCheck.test(userPw) ){
		alert('비밀번호는 영문, 숫자의 6~12글자만 가능합니다');
		$j('[name=userPw]').focus();
		return; 
	}
	
	//전화번호 유효성검사
	var userPhone2 = /^\d{3,4}$/;
	var userPhone3 = /^\d{4}$/;
	if(!userPhone2.test($j("input[name='userPhone2']").val())) {            
        //경고
        alert('전화번호 가운데번호는 3자리 또는 4자리');
		$j('[name=userPhone2]').focus();
        return false;
	}
	if(!userPhone3.test($j("input[name='userPhone3']").val())) {            
        //경고
        alert('전화번호 마지막 자리는 4자리');
		$j('[name=userPhone3]').focus();
        return false;
	}
	
	//postNo 유효성검사
	var postPattern = /^[0-9]{3}-[0-9]{3}$/;
	if ($j('#userAddr1').val() != ''){
		if(!postPattern.test($j('#userAddr1').val())){	//	userPhone3의 value값과 numberCheck의 양식을 체크
    		alert('000-000 형식으로 입력해주세요(숫자만 가능)');
			$j('[name=userAddr1]').focus();
    		return false;
		} 
	}
	var $frm = $j('.memberInsert :input');
	var param = $frm.serialize();
	
	$j.ajax({
	    url : "/board/memberInsert.do",
	    dataType: "json",
	    type: "POST",
	    data : param,
	    success: function(data, textStatus, jqXHR)
	    {
	    	alert('회원가입 성공');
			location.href = "/board/boardList.do?pageNo=1";
	    },
	    error: function (jqXHR, textStatus, errorThrown)
	    {
	    	alert("실패");
	    }
	});
	
	$j('form').submit();
}

function idCheck(){
	$j('#id_usable').val('n');
}

function isSame(){
	var pw = document.getElementById('userPw').value;
	var pwch = document.getElementById('userPwCk').value;
	if(document.getElementById('userPw').value!='' && document.getElementById('userPwCk').value!=''){
		if(document.getElementById('userPw').value == document.getElementById('userPwCk').value){
			document.getElementById('same').innerHTML='비밀번호가 일치합니다';
			document.getElementById('same').style.fontSize='x-small';
			document.getElementById('same').style.color='blue';
		}else{
			document.getElementById('same').innerHTML='비밀번호가 일치하지 않습니다';
			document.getElementById('same').style.fontSize='x-small';
			document.getElementById('same').style.color='red';
		}
	}
}

//postNo 정규식
function postNo(obj){
	var number = obj.value.replace(/[^0-9]/g, "");
	var phone = "";
	
	if(number.length < 4) {
        return number;
    } else if(number.length < 7) {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3);
    }
	obj.value = phone;
}
</script>
<body>
<% request.setCharacterEncoding("UTF-8"); %>
<form action="/board/memberInsert.do" class="memberInsert" method="post" accept-charset="UTF-8">
<input type="hidden" id="id_usable" value="n"/>
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
						<input name="userId" id="userId" type="text" size="13" maxlength="17" onkeyup="idCheck(); this.value=this.value.replace(/[^a-zA-Z0-9]/g,'');"/>
						<input type="button" value="중복확인" onclick="usable()"/>
					</td>
				</tr>
				<tr>
					<td width="120" align="center">
					pw
					</td>
					<td width="300" style="font-size: 10px;">
						<input name="userPw" id="userPw" type="password" size="15" maxlength="12" onkeyup="isSame()"/>
						영문 대/소문자 숫자만 가능
					</td>
				</tr>
				<tr>
					<td width="120" align="center">
					pw check
					</td>
					<td width="300">
						<input name="userPwCk" id="userPwCk" type="password" size="15" maxlength="12" onkeyup="isSame()"/>&nbsp;
						<span id="same"></span>
					</td>
				</tr>
				<tr>
					<td width="120" align="center">
					name
					</td>
					<td width="300">
						<input name="userName" type="text" maxlength="4" size="17" onkeyup="this.value=this.value.replace(/[^가-힣]{2,4}/g,'');"/> 
					</td>
				</tr>
				<tr>
					<td width="120" align="center">
					phone
					</td>
					<td width="300">
						<select id="phone" id="userPhone1" name="userPhone1">
								<c:forEach var="code" items="${codeList}">
										<option value="${code.codeId}">${code.codeName}</option>
								</c:forEach>
						</select> -
						<input name="userPhone2" type="text" size="1" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/> -
						<input name="userPhone3" type="text" size="1" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/> 
					</td>
				</tr>
				<tr>
					<td width="120" align="center">
					postNo
					</td>
					<td width="300">
						<input name="userAddr1" id="userAddr1" class="phoneNumber" type="text" size="17" maxlength="7"
								onkeyup="this.value=this.value.replace(/[^0-9]/g,''); postNo(this);"/>
					</td>
				</tr>
				<tr>
					<td width="120" align="center">
					address
					</td>
					<td width="300">
						<input name="userAddr2" type="text" size="17" maxlength="50"/> 
					</td>
				</tr>
				<tr>
					<td width="120" align="center">
					company
					</td>
					<td width="300">
						<input name="userCompany" type="text" size="17" maxlength="30"/> 
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