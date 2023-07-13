// JavaScript code to generate and update the charts

// Chart 1: Thống kê số bài post trong từng tháng
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
        url: "../../getPostStatistics",
        method: "GET",
        dataType: "json",
        success: function (data) {
            updateChartData(data);
        },
        error: function (xhr, status, error) {
            console.log("Error:", error);
        }
    });
}

// Function to update data and labels 
function updateChartData(data) {
    var labels = []; // Mảng nhãn cho biểu đồ
    var postCounts = []; // Mảng dữ liệu số bài post

    // Duyệt qua từng đối tượng PostStatistics trong danh sách data
    for (var i = 0; i < data.length; i++) {
        var postStat = data[i];
        labels.push(postStat.month); // Thêm giá trị tháng vào mảng nhãn
        postCounts.push(postStat.postNumber); // Thêm giá trị số bài post vào mảng dữ liệu
    }

    // Cập nhật dữ liệu và nhãn cho biểu đồ
    postChartData.labels = labels;
    postChartData.datasets[0].data = postCounts;

    // Cập nhật biểu đồ
    chart1.update();
}

