<!DOCTYPE html>
<html>
<head>
    <title>Learning Cytoscape.js</title>
    <style type="text/css">
        /* cytoscape graph */
        #cy {
            height: 300px;
            width: 400px;
            background-color: #f9f9f9;
        }
    </style>
    <script src="http://cdn.bootcss.com/jquery/1.11.2/jquery.min.js"></script>
    <script src="http://cdn.bootcss.com/cytoscape/2.3.16/cytoscape.min.js"></script>
    <script>
        $.ajax({
            url: "info.do?entity=复旦大学",
            cache: false
        }).done(function(json) {
                t(json["cytoscape_json"])
            });
        function t(json){
            alert(json)
            cytoscape({
                container: document.getElementById('cy'),
                elements: json,
                layout: { name: 'grid'}
            });
        }
    </script>
</head>
<body>
<div id="cy"></div>
</body>
</html>