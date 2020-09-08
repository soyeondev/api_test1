<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Graph with Chart.js</title>
  <meta charset="utf-8">
  <meta name="google-signin-client_id" content="808706814285-f44ev80ictroiiarr65q4mj299pin69c.apps.googleusercontent.com">
  <meta name="google-signin-scope" content="https://www.googleapis.com/auth/analytics.readonly">
</head>
<body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<h2>사용자수</h2>
<div style="width:800px">
    <canvas id="myChart"></canvas>
</div>

<script>
var dateArr = [];
var userArr = [];


// 쩔챙쩌짹 ����쩍쨘�짰쨍짝 째징�짰쩔�쨈�쨈�. 
var ctx = document.getElementById("myChart").getContext('2d');
var chart_value = '${res}'
var chart_obj = JSON.parse(chart_value);
var date_de = chart_value;
var preDate = ${preDateArr};
console.log(chart_value);

for(var i = 0; i < 100; i++){
	userArr.push(0);
}

for(var i = 0; i < preDate.length; i++){
	for(var j = 0; j < chart_obj.reports[0].data.rows.length; j++){
		if(preDate[i] == chart_obj.reports[0].data.rows[j].dimensions[0]){
			//console.log(chart_obj.reports[0].data.rows[i].dimensions[0]);
			userArr[i] = chart_obj.reports[0].data.rows[j].metrics[0].values[0];
		}
	}
}


/* for(var i = 0; i < preDate.length; i++)
	if(preDate[i] == 0) */
	
/*
- Chart쨍짝 쨩첵쩌쨘��쨍챕쩌짯, 
- ctx쨍짝 �쨔쨔첩�째 argument쨌� 쨀�째���째챠, 
- 쨉�쨔첩�째 argument쨌� 짹�쨍짼�쨩 짹�쨍짹쨋짠 ��쩔채�� 쩔채쩌�쨉챕�쨩 쨍챨쨉� 쨀�째���쨈�쨈�. 
*/
var myChart = new Chart(ctx, {
    type: 'line',
    data: {
        labels: preDate,
        datasets: [{
            label: 'User',
            data: userArr,
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                'rgba(255,99,132,1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        maintainAspectRatio: true, // default value. false�� 째챈쩔챙 �첨��쨉� div�� �짤짹창쩔징 쨍��챌쩌짯 짹�쨌��체.
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:true
                }
            }]
        }
    }
});
</script>

<!-- Load the JavaScript API client and Sign-in library. -->
<script src="https://apis.google.com/js/client:platform.js"></script>
</body>
</html>