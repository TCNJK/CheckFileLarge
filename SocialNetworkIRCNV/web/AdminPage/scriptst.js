// JavaScript code to generate and update the charts

// Chart 1: Thống kê số bài post trong từng tháng

// Function to get data and labels 
window.onload = function () {
//    fetchData();
    setInterval(fetchData, 2000);
//    $.ajax({
//        url: "../getPostStatistics",
//        method: "GET",
//        dataType: "json",
//        success: function (data) {
//            updateChartData(data);
//        },
//        error: function (xhr, status, error) {
//            console.log("Error:", error);
//        }
//    });
};
function fetchData() {
    $.ajax({
        url: "../getPostStatistics",
        method: "GET",
        dataType: "json",
        success: function (data) {
            updatePostChartData(data);
        },
        error: function (xhr, status, error) {
            console.log("Error:", error);
        }
    });
    $.ajax({
        url: "../getUser_Activity_TimeStatistics",
        method: "GET",
        dataType: "json",
        success: function (data) {
            updateUser_Activity_TimeChartData(data);
        },
        error: function (xhr, status, error) {
            console.log("Error:", error);
        }
    });
    $.ajax({
        url: "../getUserCount",
        method: "GET",
        dataType: "json",
        success: function (data) {
            var h2Element = document.getElementById("UserCountINT");
            h2Element.textContent = data;
        },
        error: function (xhr, status, error) {
            console.log("Error:", error);
        }
    });
    $.ajax({
        url: "../getNewUserInMonthSeverlet",
        method: "GET",
        dataType: "json",
        success: function (data) {
            updateNewUserInMonth(data);
        },
        error: function (xhr, status, error) {
            console.log("Error:", error);
        }
    });
}

// Function to update data and labels 
function updatePostChartData(data) {
    var postChartData = {
        labels: [],
        datasets: [{
                label: "Post",
                backgroundColor: "rgba(104, 124, 247, 0.6)",
                borderColor: '#8596fe',
                data: []
            }]
    };
    var ctx1 = document.getElementById("seolinechart1").getContext('2d');
    var chart1 = new Chart(ctx1, {
        // The type of chart we want to create
        type: 'line',
        // The data for our dataset
        data: postChartData,
        // Configuration options go here
        options: {
            legend: {
                display: false
            },
            animation: {
                easing: "easeInOutBack"
            },
            scales: {
                yAxes: [{
                        display: !1,
                        ticks: {
                            fontColor: "rgba(0,0,0,0.5)",
                            fontStyle: "bold",
                            beginAtZero: !0,
                            maxTicksLimit: 5,
                            padding: 0
                        },
                        gridLines: {
                            drawTicks: !1,
                            display: !1
                        }
                    }],
                xAxes: [{
                        display: !1,
                        gridLines: {
                            zeroLineColor: "transparent"
                        },
                        ticks: {
                            padding: 0,
                            fontColor: "rgba(0,0,0,0.5)",
                            fontStyle: "bold"
                        }
                    }]
            },
            elements: {
                line: {
                    tension: 0 // disables bezier curves
                }
            }
        }
    });
    var labels = []; // Mảng nhãn cho biểu đồ
    var postCounts = []; // Mảng dữ liệu số bài post
    var total = 0;
    // Duyệt qua từng đối tượng PostStatistics trong danh sách data
    for (var i = 0; i < data.length; i++) {
        var postStat = data[i];
        labels.push(postStat.month); // Thêm giá trị tháng vào mảng nhãn
        postCounts.push(postStat.postNumber); // Thêm giá trị số bài post vào mảng dữ liệu
        total = total + postStat.postNumber;
    }

    // Cập nhật dữ liệu và nhãn cho biểu đồ
    postChartData.labels = labels;
    postChartData.datasets[0].data = postCounts;

    // Cập nhật biểu đồ
    chart1.update();

    var h2Element = document.getElementById("TotalNumberofPost");

// Thay đổi nội dung của h2
    h2Element.textContent = total;
    
    addChart(labels,postCounts,1, "user-statistics3");

}
function updateUser_Activity_TimeChartData(data) {
    var userActTimeChartData = {
        labels: [],
        datasets: [{
                label: "userActTime",
                backgroundColor: "rgba(96, 241, 205, 0.2)",
                borderColor: '#3de5bb',
                data: []
            }]
    };
    var ctx2 = document.getElementById("seolinechart2").getContext('2d');
    var chart2 = new Chart(ctx2, {
        // The type of chart we want to create
        type: 'line',
        // The data for our dataset
        data: userActTimeChartData,
        // Configuration options go here
        options: {
            legend: {
                display: false
            },
            animation: {
                easing: "easeInOutBack"
            },
            scales: {
                yAxes: [{
                        display: !1,
                        ticks: {
                            fontColor: "rgba(0,0,0,0.5)",
                            fontStyle: "bold",
                            beginAtZero: !0,
                            maxTicksLimit: 5,
                            padding: 0
                        },
                        gridLines: {
                            drawTicks: !1,
                            display: !1
                        }
                    }],
                xAxes: [{
                        display: !1,
                        gridLines: {
                            zeroLineColor: "transparent"
                        },
                        ticks: {
                            padding: 0,
                            fontColor: "rgba(0,0,0,0.5)",
                            fontStyle: "bold"
                        }
                    }]
            },
            elements: {
                line: {
                    tension: 0 // disables bezier curves
                }
            }
        }
    });
    var labels = []; // Mảng nhãn cho biểu đồ
    var Counts = []; // Mảng dữ liệu số bài post
    var total = 0;
    // Duyệt qua từng đối tượng PostStatistics trong danh sách data
    for (var i = 0; i < data.length; i++) {
        var Stat = data[i];
        labels.push(Stat.date); // Thêm giá trị tháng vào mảng nhãn
        Counts.push(Stat.time); // Thêm giá trị số bài post vào mảng dữ liệu
        total = total + Stat.time;
    }

    // Cập nhật dữ liệu và nhãn cho biểu đồ
    userActTimeChartData.labels = labels;
    userActTimeChartData.datasets[0].data = Counts;

    // Cập nhật biểu đồ
    chart2.update();

    var h2Element = document.getElementById("TotalUserActTime");

// Thay đổi nội dung của h2
    h2Element.textContent = Math.round(total*1000/(1000*60))/1000;
    
    
    addChart(labels,Counts,1000*60, "user-statistics2");
}
function updateNewUserInMonth(data) {
    var dataInChart = {
        labels: [],
        datasets: [{
                label: "New user",
                backgroundColor: "rgba(96, 241, 205, 0)",
                borderColor: '#fff',
                data: []
            }]
    };
    var ctx = document.getElementById("seolinechart4").getContext('2d');
    var chart = new Chart(ctx, {
        // The type of chart we want to create
        type: 'line',
        // The data for our dataset
        data: dataInChart,
        // Configuration options go here
        options: {
            legend: {
                display: false
            },
            animation: {
                easing: "easeInOutBack"
            },
            scales: {
                yAxes: [{
                        display: !1,
                        ticks: {
                            fontColor: "rgba(0,0,0,0.5)",
                            fontStyle: "bold",
                            beginAtZero: !0,
                            maxTicksLimit: 5,
                            padding: 0
                        },
                        gridLines: {
                            drawTicks: !1,
                            display: !1
                        }
                    }],
                xAxes: [{
                        display: !1,
                        gridLines: {
                            zeroLineColor: "transparent"
                        },
                        ticks: {
                            padding: 0,
                            fontColor: "rgba(0,0,0,0.5)",
                            fontStyle: "bold"
                        }
                    }]
            },
            elements: {
                line: {
                    tension: 0, // disables bezier curves
                }
            }
        }
    });
    var labels = []; // Mảng nhãn cho biểu đồ
    var Counts = []; // Mảng dữ liệu số bài post
    var total = 0;
    // Duyệt qua từng đối tượng PostStatistics trong danh sách data
    for (var i = 0; i < data.length; i++) {
        var Stat = data[i];
        labels.push(Stat.date); // Thêm giá trị tháng vào mảng nhãn
        Counts.push(Stat.count); // Thêm giá trị số bài post vào mảng dữ liệu
    }

    // Cập nhật dữ liệu và nhãn cho biểu đồ
    dataInChart.labels = labels;
    dataInChart.datasets[0].data = Counts;

    // Cập nhật biểu đồ
    chart.update();

    addChart(labels,Counts,1, "user-statistics");
}


function addChart(labels,Counts,mod, id) {
    var dataChart;
    var chart = AmCharts.makeChart(id, {
        "type": "serial",
        "theme": "light",
        "marginRight": 0,
        "marginLeft": 40,
        "autoMarginOffset": 20,
        "dataDateFormat": "YYYY-MM-DD",
        "valueAxes": [{
                "id": "v1",
                "axisAlpha": 0,
                "position": "left",
                "ignoreAxisWidth": true
            }],
        "balloon": {
            "borderThickness": 1,
            "shadowAlpha": 0
        },
        "graphs": [{
                "id": "g1",
                "balloon": {
                    "drop": true,
                    "adjustBorderColor": false,
                    "color": "#ffffff",
                    "type": "smoothedLine"
                },
                "fillAlphas": 0.2,
                "bullet": "round",
                "bulletBorderAlpha": 1,
                "bulletColor": "#FFFFFF",
                "bulletSize": 5,
                "hideBulletsCount": 50,
                "lineThickness": 2,
                "title": "red line",
                "useLineColorForBulletBorder": true,
                "valueField": "value",
                "balloonText": "<span style='font-size:18px;'>[[value]]</span>"
            }],
        "chartCursor": {
            "valueLineEnabled": true,
            "valueLineBalloonEnabled": true,
            "cursorAlpha": 0,
            "zoomable": false,
            "valueZoomable": true,
            "valueLineAlpha": 0.5
        },
        "valueScrollbar": {
            "autoGridCount": true,
            "color": "#5E72F3",
            "scrollbarHeight": 30
        },
        "categoryField": "date",
        "categoryAxis": {
            "parseDates": true,
            "dashLength": 1,
            "minorGridEnabled": true
        },
        "export": {
            "enabled": false
        },
        "dataProvider": []
    });
    var newData = [];
    for (var i = 0; i < labels.length; i++) {
        var dateParts = labels[i].split('/');
        var year = '20' + dateParts[1]; // Lấy năm từ phần tử thứ 2 trong mảng dateParts
        var month = dateParts[0]; // Lấy tháng từ phần tử thứ 1 trong mảng dateParts

        // Xây dựng chuỗi ngày có định dạng YYYY-MM-DD
        var formattedDate = year + '-' + month.padStart(2, '0') + '-01';

        var item = {
            "date": formattedDate,
            "value": Math.round(Counts[i]*10/mod)/10
        };
        newData.push(item);
    }
    chart.dataProvider = newData;
// Cập nhật biểu đồ
    chart.validateData();
}






