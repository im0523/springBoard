<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>boardWrite</title>
</head>
<script type="text/javascript">
$j(document).ready(function(){
	
	$j("#submit").on("click",function(){
		var $frm = $j('.boardWrite :input');
		var param = $frm.serialize();
		
		$j.ajax({
		    url : "/board/boardWriteAction.do",
		    dataType: "json",
		    type: "POST",
		    data : param,
		    success: function(data, textStatus, jqXHR)
		    {
				alert("작성완료");
				
				alert("메세지:"+data.success);
				
				location.href = "/board/boardList.do?pageNo=1";
		    },
		    error: function (jqXHR, textStatus, errorThrown)
		    {
		    	alert("실패");
		    }
		});
	});

	
	var cnt = 1;
	$j('#add_btn').on("click",function(){
		$j(".table").append('<table border ="1" class="table'+ cnt +'" >'
				+ '<tr>'
				+ '<td width="120" align="center">'
				+ 'Type'
				+ '</td>'
				+ '<td width="300">'
					+ '<select name="list[' + cnt + '].boardType">'
						+ '<c:forEach var="list" items="${codeName }">'
							+ '<option value="${list.codeName }">${list.codeName }</option>'
						+ '</c:forEach>'
					+ '</select>'
				+ '</td>'
				+ '<td id="del_btn" onclick="delete_btn(this)">추가사항 삭제</td>'
			+ '</tr>'
			+ '<tr>'
				+ '<td width="120" align="center">'
				+ 'Title'
				+ '</td>'
				+ '<td width="400" colspan="2">'
				+ '<input name="list[' + cnt + '].boardTitle" type="text" size="53" value="${board.boardTitle}">' 
				+ '</td>'
			+ '</tr>'
			+ '<tr>'
				+ '<td height="300" align="center">'
				+ 'Comment'
				+ '</td>'
				+ '<td valign="top" colspan="2">'
				+ '<textarea name="list[' + cnt + '].boardComment"  rows="20" cols="55">${board.boardComment}</textarea>'
				+ '</td>'
			+ '</tr>'
			+ '<tr>'
			+ '<td align="center">'
			+ 'Writer'
			+ '</td>'
			+ '<td colspan="2">'
			+ '<input name="list['+ cnt +'].creator" type="hidden" value="${login_info.userId }"/>'
				+ '${login_info.userName }'
			+ '</td>'
		+ '</tr>'
		+ '</table>'
		);
		cnt++;
	});
	
});

function delete_btn(o){
	$j(o).parent().parent().parent().remove();
}
// commit test..
</script>
<body>
<form class="boardWrite">
	<table align="center" class="table">
		<tr>
			<td align="right">
			<input id="add_btn" type="button" value="추가">
			<input id="submit" type="button" value="작성">
			</td>
		</tr>
		<tr>
			<td>
				<table border ="1" >
					<tr>
						<td width="120" align="center">
						Type
						</td>
						<td width="400">
							<select name="list[0].boardType">
								<c:forEach var="list" items="${codeName }">
									<option value="${list.codeName }">${list.codeName }</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						Title
						</td>
						<td width="400" colspan="2">
						<input name="list[0].boardTitle" type="text" size="53" value="${board.boardTitle}"> 
						</td>
					</tr>
					<tr>
						<td height="300" align="center">
						Comment
						</td>
						<td valign="top" colspan="2">
						<textarea name="list[0].boardComment"  rows="20" cols="55">${board.boardComment}</textarea>
						</td>
					</tr>
					<tr>
						<td align="center">
						Writer
						</td>
						<td colspan="2">
						<input name="list[0].creator" type="hidden" value="${login_info.userId }"/>
							${login_info.userName }
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
				<a href="/board/boardList.do">List</a>
			</td>
		</tr>
	</table>
</form>	
</body>
</html>