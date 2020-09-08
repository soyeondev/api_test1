<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<form id="querySubmit" action="/chartjstest" method="POST">
	startDate: <input type="Date" id= "startDate" name="startDate"/></br>
	endDate: <input type="Date" id= "endDate" name="endDate"/></br>
	<input type="button" onclick="button1_click();" value="등록">
</form>
<script type="text/javascript">
	function button1_click(){
		document.getElementById("querySubmit").submit();
	}

</script>
</body>
</html>