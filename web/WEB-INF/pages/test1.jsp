<%@ page language="java" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Learning Cytoscape.js</title>
    <%--<meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>--%>
    <style type="text/css">
        /* cytoscape graph */
        #cy {
            width: 100%;
            height: 100%;
            position: absolute;
            left: 0;
            top: 0;
            z-index: 999;
            background-color: #f9f9f9;
        }
    </style>

    <%--<script src="/js/youe_cytoscape.js"></script>--%>
    <script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
    <script src="/js/cytoscape.js"></script>
    <script src="/js/youe_cytoscape.js"></script>


</head>
<body>
<div id="cy"></div>
</body>
<script>
    // var cytoscape = require('cytoscape');
    // var panzoom = require('cytoscape-panzoom');
    //
    // panzoom( cytoscape );
    var entity = "凯蒂·普莱斯"
    $.get("info.do", {entity: entity},
        function (data) {
            draw_kg(entity, data)
        }, "json");




</script>
</html>