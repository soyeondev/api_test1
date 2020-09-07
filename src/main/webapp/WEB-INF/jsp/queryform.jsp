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
	dimensions: <input type="text" name="demen"/></br>
	metrics: <input type="text" name="metr"/></br>
	startDate: <input type="Date" id= "startDate"/></br>
	endDate: <input type="Date" id= "endDate"/></br>
	<input type="hidden" id="postStartDate" name="startDate"/></br>
	<input type="hidden" id="postEndDate" name="endDate"/></br>
	<input type="button" onclick="button1_click();" value="등록">
</form>
<script type="text/javascript">
	function button1_click(){
		var startD = document.getElementById("startDate").value;
		var yr = startD.substring(0, 4);
		var month = startD.substring(5, 7);
		var day = startD.substring(8, 10);
		document.getElementById("postStartDate").value = yr+month+day;
		
		console.log(yr+month+day);
		
		var endD = document.getElementById("endDate").value;
		var yr = endD.substring(0, 4);
		var month = endD.substring(5, 7);
		var day = endD.substring(8, 10);
		var endDateStr = yr+month+day;
		document.getElementById("postEndDate").value = yr+month+day;
		
		console.log(yr+month+day);
		
		document.getElementById("querySubmit").submit();
	}

</script>
</body>
</html>