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
<div style="width:800px">
<h3>사용자수</h3>
    <canvas id="myChartUser"></canvas>
</div>

<div style="width:800px">
<h3>재방문자수</h3>
    <canvas id="myChartReUser"></canvas>
</div>

<div style="width:800px">
<h3>신규 방문자수</h3>
    <canvas id="myChartNewUser"></canvas>
</div>

<script>
var dateArr = [];
var userArr = [];
var reUserArr = [];
var newUserArr = [];

// 쩔챙쩌짹 ����쩍쨘�짰쨍짝 째징�짰쩔�쨈�쨈�. 
var ctx = document.getElementById("myChartUser").getContext('2d');
var ctx_re = document.getElementById("myChartReUser").getContext('2d');
var ctx_new = document.getElementById("myChartNewUser").getContext('2d');

var chart_value = '${res}'
var chart_obj = JSON.parse(chart_value);
var date_de = chart_value;

console.log(chart_value);

var preDate = ${preDateArr};
var reUserMap = ${reUserMap};
var newUserMap = ${newUserMap};

// 사용자 수
for(var i = 0; i < 50; i++){
	userArr.push(0);
}

for(var i = 0; i < preDate.length; i++){
	for(var j = 0; j < chart_obj.reports[0].data.rows.length; j++){
		if(preDate[i] == chart_obj.reports[0].data.rows[j].dimensions[0]){
			userArr[i] = chart_obj.reports[0].data.rows[j].metrics[0].values[0];
		}
	}
}

// 재방문자 수
for(var i = 0; i < 50; i++){
	reUserArr.push(0);
}


for(var i = 0; i < preDate.length; i++){
	if(reUserMap.hasOwnProperty(preDate[i])){
		reUserArr[i] = reUserMap[preDate[i]];
	}
}
console.log(reUserArr);


//신규방문자 수
for(var i = 0; i < 50; i++){
	newUserArr.push(0);
}

for(var i = 0; i < preDate.length; i++){
	if(newUserMap.hasOwnProperty(preDate[i])){
		newUserArr[i] = newUserMap[preDate[i]];
	}
}
console.log(newUserArr);
	
/*
- Chart쨍짝 쨩첵쩌쨘��쨍챕쩌짯, 
- ctx쨍짝 �쨔쨔첩�째 argument쨌� 쨀�째���째챠, 
- 쨉�쨔첩�째 argument쨌� 짹�쨍짼�쨩 짹�쨍짹쨋짠 ��쩔채�� 쩔채쩌�쨉챕�쨩 쨍챨쨉� 쨀�째���쨈�쨈�. 
*/
var myChartUser = new Chart(ctx, {
    type: 'line',
    data: {
        labels: preDate,
        datasets: [{
            label: 'User',
            data: userArr,
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)'
            ],
            borderColor: [
                'rgba(255,99,132,1)'
            ],
            borderWidth: 1,
            fill: false
        }]
    },
    options: {
        maintainAspectRatio: false, 
        spanGaps: false,
        eleements: {
        	line: {
        		tension: 0.000001
        	}
        },
       scales: {
            yAxes: [{
                stacked: true
            }]
        },
        plugins: {
        	filter: {
        		propagate: false
        	},
        	'samples-filler-analyser': {
        		target: 'chart-analyser'
        	}
        },
        bezierCurve : false
    }
});

var myChartReUser = new Chart(ctx_re, {
    type: 'line',
    data: {
        labels: preDate,
        datasets: [{
            label: 'ReUser',
            data: reUserArr,
            backgroundColor: [
            	'rgba(54, 162, 235, 0.2)'
            ],
            borderColor: [
            	'rgba(54, 162, 235, 1)'
            ],
            borderWidth: 1,
            fill: false
        }]
    },
    options: {
        maintainAspectRatio: false, 
        spanGaps: false,
        eleements: {
        	line: {
        		tension: 0.000001
        	}
        },
       scales: {
            yAxes: [{
                stacked: true
            }]
        },
        plugins: {
        	filter: {
        		propagate: false
        	},
        	'samples-filler-analyser': {
        		target: 'chart-analyser'
        	}
        },
        bezierCurve : false
    }
});


var myChartNewUser = new Chart(ctx_new, {
    type: 'line',
    data: {
        labels: preDate,
        datasets: [{
            label: 'NewUser',
            data: newUserArr,
            backgroundColor: [
            	'rgba(75, 192, 192, 0.2)'
            ],
            borderColor: [
            	'rgba(75, 192, 192, 1)',
            ],
            borderWidth: 1,
            fill: false
        }]
    },
    options: {
        maintainAspectRatio: false, // default value. false�� 째챈쩔챙 �첨��쨉� div�� �짤짹창쩔징 쨍��챌쩌짯 짹�쨌��체.
        spanGaps: false,
        eleements: {
        	line: {
        		tension: 0.000001
        	}
        },
       scales: {
            yAxes: [{
                stacked: true
            }]
        },
        plugins: {
        	filter: {
        		propagate: false
        	},
        	'samples-filler-analyser': {
        		target: 'chart-analyser'
        	}
        },
        bezierCurve : false
    }
});

</script>

<!-- Load the JavaScript API client and Sign-in library. -->
<script src="https://apis.google.com/js/client:platform.js"></script>
</body>
</html>