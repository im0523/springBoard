<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>list</title>
</head>
<script type="text/javascript">
$j(document).ready(function(){
	//체크박스 전체선택 및 전체해제
	$j('#all').click(function(){
		if( $j('#all').is(':checked')){
			$j('.typeCk').prop('checked', true);
		}else{
			$j('.typeCk').prop('checked', false);
		}
	});
	
	//체크박스 하나라도 해제되어 있을 시 전체선택 체크박스도 해제
	$j('.typeCk').click(function(){
		if( $j('input[name="codeId"]:checked').length == 4 ){
			$j('#all').prop('checked', true);
		}else {
			$j('#all').prop('checked', false);
		}
	})

	//조회버튼 눌렀을 때 처리
	$j('#btnSearch').click(function(){
		 var count = 0;
		 var obj = document.getElementsByClassName("typeCk");
			 for (var i=0 ; i < obj.length ; i++) {
			 	if( obj[i].checked == true ){count++;}
			 }
		 if( count == 0) {
			 alert('조회할 항목을 선택하세요');
			 return false;
		 }else{
			 $j('#list').submit();
		 }
	});
});
</script>
<body>	
<form action="" id="list">
<table  align="center">
	<tr>
		<c:choose>
			<c:when test="${login_info.userId ne vo.userId }">
				<td align="left">
					${login_info.userName }
				</td>
			</c:when>
			<c:otherwise>
				<td align="left">
					<a href="/board/login.do">login</a>
					<a href="/board/join.do">join</a>
					${login_info }
				</td>
			</c:otherwise>
			</c:choose>
		<td align="right">
			total : ${totalCnt}
		</td>
	</tr>
	<tr>
		<td>
			<table id="boardTable" border = "1">
				<tr>
					<td width="80" align="center">
						Type
					</td>
					<td width="40" align="center">
						No
					</td>
					<td width="300" align="center">
						Title
					</td>
				</tr>
				<c:forEach items="${boardList}" var="list">
					<tr>
						<td align="center">
							${list.codeName}
						</td>
						<td>
							${list.boardNum}
						</td>
						<td>
							<a href = "/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
						</td>
					</tr>	
				</c:forEach>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<a href ="/board/boardWrite.do">글쓰기</a>
			<c:if test="${!empty login_info.userId }">
				<a href ="/logout.do">로그아웃</a>
			</c:if>
		</td>
	</tr>
	<tr>
		<td>
			<input type="checkbox" id="all" class="typeCk">전체
			<c:forEach var="code" items="${codeName}" varStatus="status">
				<input type="checkbox" class="typeCk" name="codeId" value="${code.codeId}">${code.codeName}</>
			</c:forEach>
			<input type="button" value="조회" id="btnSearch"/>
		</td>
	</tr>
</table>
</form>
</body>
</html>