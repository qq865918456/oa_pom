<%--
  Created by IntelliJ IDEA.
  User: xwfha
  Date: 2018/9/7
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <base href="${pageContext.request.contextPath}/"/>
    <title>表格图形</title>
    <script src="resources/echarts/echarts.simple.min.js"></script>
    <link rel="stylesheet" href="resources/css/reset.css" type="text/css"
          media="screen"/>
    <!-- Main Stylesheet -->
    <link rel="stylesheet" href="resources/css/style.css" type="text/css" media="screen"/>

    <link rel="stylesheet" href="resources/css/invalid.css" type="text/css" media="screen"/>

    <script type="text/javascript" src="resources/scripts/jquery-1.8.3.min.js"></script>
    <!-- jQuery Configuration -->
    <script type="text/javascript" src="resources/scripts/simpla.jquery.configuration.js"></script>
</head>
<body>
<div id="main-content">
    <div class="content-box">
        <div  class="content-box-content" id="main" style="width: 600px;height:400px;"></div>
    </div>
</div>

<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));

    // 指定图表的配置项和数据
    var option = {
        title: {
            text: 'ECharts 入门示例'
        },
        tooltip: {},
        legend: {
            data:['销量'],
        },
        xAxis: {
            data: ['男','女' ]
        },
        yAxis: {},
        series: [{
            name: '销量',
            type: 'bar',
            data: [${men},${women}]
        }]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
</script>
</body>

</html>
