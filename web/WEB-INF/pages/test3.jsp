<%@ page language="java" pageEncoding="utf-8" import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Learning echarts.js</title>
    <%--<meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>--%>

    <%--<script src="/js/youe_cytoscape.js"></script>--%>
    <script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/echarts.js"></script>
    <script src="${pageContext.request.contextPath}/js/youe_echarts.js"></script>

</head>
<body>
<div id="main" style="width: 100%; height: 500px"></div>
</body>
<script>

    var myChart = echarts.init(document.getElementById('main'));
    draw_kg('${entity}', ${triples},myChart,kg_option_1)



</script>
</html>