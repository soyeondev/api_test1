<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Graph with Chart.js</title>
  <meta charset="utf-8">
  <meta name="google-signin-client_id" content="808706814285-f44ev80ictroiiarr65q4mj299pin69c.apps.googleusercontent.com">
  <meta name="google-signin-scope" content="https://www.googleapis.com/auth/analytics.readonly">
</head>
<body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<h2>��¥�� ������</h2>
<div style="width:800px">
    <canvas id="myChart"></canvas>
</div>

<script>
var dateArr = [];
var userArr = [];

// �켱 ���ؽ�Ʈ�� �����ɴϴ�. 
var ctx = document.getElementById("myChart").getContext('2d');
var chart_value = '${res}'
var chart_obj = JSON.parse(chart_value);
var date_de = chart_value;

console.log(chart_value);

var dateArr = '${dateArr}';
console.log("dateArr",${dateArr[0].date});
console.log("dateArr",${dateArr[0].month});
/*
for(var i = 0; i < chart_obj.reports[0].data.rows.length; i++){
    dateArr.push(chart_obj.reports[0].data.rows[i].dimensions[0]);
}

console.log(dateArr);

for(var i = 0; i < chart_obj.reports[0].data.rows.length; i++){
	userArr.push(chart_obj.reports[0].data.rows[i].metrics[0].values[0]);
}

console.log(userArr);
*/

/*
- Chart�� �����ϸ鼭, 
- ctx�� ù��° argument�� �Ѱ��ְ�, 
- �ι�° argument�� �׸��� �׸��� �ʿ��� ��ҵ��� ��� �Ѱ��ݴϴ�. 
*/
var myChart = new Chart(ctx, {
    type: 'line',
    data: {
        labels: dateArr,
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
        maintainAspectRatio: true, // default value. false�� ��� ���Ե� div�� ũ�⿡ ���缭 �׷���.
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