<%@ page language="java" pageEncoding="utf-8" import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Learning echarts.js</title>
    <%--<meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>--%>

    <%--<script src="/js/youe_cytoscape.js"></script>--%>
    <script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/echarts.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/youe_echarts.js"></script>

</head>
<body>
<div id="main" style="width: 1000px;height:800px;"></div>
</body>
<script>
    var myChart = echarts.init(document.getElementById('main'));
    var option = kg_option('${entity}', ${triples})
    myChart.setOption(option);


</script>
</html>