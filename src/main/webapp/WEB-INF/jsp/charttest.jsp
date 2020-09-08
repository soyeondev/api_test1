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
<div style="width:800px">
    <canvas id="myChart"></canvas>
</div>

<script>
var dateArr = [];
var userArr = [];

// 우선 컨텍스트를 가져옵니다. 
var ctx = document.getElementById("myChart").getContext('2d');
var chart_value = '${res}'
var chart_obj = JSON.parse(chart_value);
var date_de = chart_value;

console.log(chart_value);

for(var i = 0; i < chart_obj.reports[0].data.rows.length; i++){
    dateArr.push(chart_obj.reports[0].data.rows[i].dimensions[0]);
}

console.log(dateArr);

for(var i = 0; i < chart_obj.reports[0].data.rows.length; i++){
	userArr.push(chart_obj.reports[0].data.rows[i].metrics[0].values[0]);
}

console.log(userArr);


/*
- Chart를 생성하면서, 
- ctx를 첫번째 argument로 넘겨주고, 
- 두번째 argument로 그림을 그릴때 필요한 요소들을 모두 넘겨줍니다. 
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
        maintainAspectRatio: true, // default value. false일 경우 포함된 div의 크기에 맞춰서 그려짐.
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:true
                }
            }]
        }
    }
});

// Replace with your view ID.
var VIEW_ID_CARE = '199244727';

// Query the API and print the results to the page.
function queryReportsCare() {
  gapi.client.request({
    path: '/v4/reports:batchGet',
    root: 'https://analyticsreporting.googleapis.com/',
    method: 'POST',
    body: {
      reportRequests: [
        {
          viewId: VIEW_ID_CARE,
          dateRanges: [
            {
              startDate: '7daysAgo',
              endDate: 'today'
            }
          ],
          metrics: [
            {
              expression: 'ga:users'
            }
          ],
          dimensions: [
          	{
	          name: 'ga:date'
          	}
           ]
        }
      ]
    }
  }).then(displayResultsCare, console.error.bind(console));
}

function displayResultsCare(response) {
	    var formattedJson = JSON.stringify(response.result, null, 2);
	    
	    var arr = []; 
	    arr = response.result.reports[0].data.rows;
	 
	    for(var i = 0; i < arr.length; i++){
	    	
	    	/* console.log(arr[i].dimensions[0]);
	    	dateArr.push(arr[i].dimensions[0]);
	    	userArr.push(arr[i].dimensions[0]) */
	    }
	    
	    var preNewVisitor = response.result.reports[0].data.rows[0].metrics.values();
	    var preReVisitor = response.result.reports[0].data.rows[1].metrics.values();
	    
	    
	    var newVisitor = 0;
	    var reVisitor = 0;
	    
	    for(var value of preNewVisitor) {
	    	newVisitor = value.values[0];
	    }
	    
	    for(var value of preReVisitor) {
	    	reVisitor = value.values[0];
	    }
		
	    var percent = reVisitor / (newVisitor+reVisitor)*100;
	    
	    document.getElementById('query-output').value = formattedJson;
	    document.getElementById('new_user_care').value = newVisitor;
	    document.getElementById('return_user_care').value = reVisitor;
	    document.getElementById('percent_care').value = percent;
}

<!-- 에필써모 view method-->

// Replace with your view ID.
var VIEW_ID_THERMO = '129913980';

// Query the API and print the results to the page.
function queryReportsThermo() {
  gapi.client.request({
    path: '/v4/reports:batchGet',
    root: 'https://analyticsreporting.googleapis.com/',
    method: 'POST',
    body: {
      reportRequests: [
        {
          viewId: VIEW_ID_THERMO,
          dateRanges: [
            {
              startDate: '7daysAgo',
              endDate: 'today'
            }
          ],
          metrics: [
            {
              expression: 'ga:users'
            }
          ],
          dimensions: [
          	{
	            	name: 'ga:date'
          	}
           ]
        }
      ]
    }
  }).then(displayResultsThermo, console.error.bind(console));
}

function displayResultsThermo(response) {
	    var formattedJson = JSON.stringify(response.result, null, 2);
	    
	    document.getElementById('query-output_thermo').value = formattedJson;
	    
		console.log(response.result.reports[0].data.totals[0].values[0]);

		var preNewVisitor = response.result.reports[0].data.totals[0].values[0];
	    var preReVisitor = response.result.reports[0].data.totals[0].values[0];

	    var newVisitor = response.result.reports[0].data.totals[0].values[0];
	    var reVisitor = response.result.reports[0].data.totals[0].values[0];
	    
	    var percent = reVisitor / (newVisitor+reVisitor)*100;
	    
	    document.getElementById('new_user_thermo').value = newVisitor;
	    document.getElementById('return_user_thermo').value = reVisitor;
	    document.getElementById('percent_thermo').value = percent;
}

</script>

<!-- The Sign-in button. This will run `queryReports()` on success. -->
<p class="g-signin2" data-onsuccess="queryReportsCare"></p>
<p class="g-signin2" data-onsuccess="queryReportsThermo"></p>

<div>
	<!-- The API response will be printed here. -->
	<textarea cols="80" rows="20" id="query-output"></textarea><br>
	New Visitor: <input id="new_user_care"/>
	Returning Visitor: <input id="return_user_care"/>
	percent: <input id="percent_care"/>
</div>

<div>
	<textarea cols="80" rows="20" id="query-output_thermo"></textarea><br>
	New Visitor: <input id="new_user_thermo"/>
	Returning Visitor: <input id="return_user_thermo"/>
	percent: <input id="percent_thermo"/>
</div>

<!-- Load the JavaScript API client and Sign-in library. -->
<script src="https://apis.google.com/js/client:platform.js"></script>

</body>
</html>