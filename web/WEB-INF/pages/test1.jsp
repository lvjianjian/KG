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

    <link rel="stylesheet" type="text/css" href="/css/cytoscape.js-panzoom.css">
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css">

    <script src="/js/jquery-3.3.1.min.js"></script>
    <script src="/js/cytoscape.min.js"></script>
    <script src="/js/cytoscape-panzoom.js"></script>

</head>
<body>
<div id="cy"></div>
</body>
<script>
    // var cytoscape = require('cytoscape');
    // var panzoom = require('cytoscape-panzoom');
    //
    // panzoom( cytoscape );
    var entity = "纽约（南拳妈妈演唱歌曲）"
    $.get("info.do", {entity: entity},
        function (data) {
            draw_kg(data)
        }, "json");

    function replace_a_tag(str) {
        return str.replace(/<a>/g, "").replace(/<\/a>/g, "")
    }

    function draw_kg(data) {
        var cy = cytoscape({
            container: document.getElementById('cy'),
            style: [
                {
                    selector: 'node',
                    css:
                        {
                            'background-color': '#6FB1FC',
                            'content': 'data(id)',
                            'text-valign': 'center',
                            'text-halign': 'center',
                            'padding-top': '10px',
                        }
                },
                {
                    selector: 'edge',
                    css:
                        {
                            'content': 'data(predicate)',
                            'target-arrow-shape': 'triangle',
                            'target-arrow-color': '#f2f08c',
                            'line-color': '#f2f08c',
                            'curve-style':'bezier',
                            'arrow-scale':1.5,
                            // 'target-distance-from-node':10
                        }
                },
                {
                    selector: '$node > node',
                    css: {
                        'padding-top': '10px',
                        'padding-left': '10px',
                        'padding-bottom': '10px',
                        'padding-right': '10px',
                        'text-valign': 'top',
                        'text-halign': 'center',
                        'background-color': '#bbb',
                        // 'opacity':0.5,
                    }
                },
            ],
            charset: 'UTF-8',
            layout: {name: 'concentric'}
        });

        cy.add({group: "nodes", data: {id: entity}})
        $.each(data, function (p, o) {
            p = replace_a_tag(p)
            if ($.type(o) === "string") {//string
                o = replace_a_tag(o)
                cy.add({group: "nodes", data: {id: o}})
                cy.add({group: "edges", data: {source: entity, target: o, predicate: p}})
            } else {//array
                cy.add({group: "nodes", data: {id: p}})
                cy.add({group: "edges", data: {source: entity, target: p, predicate: p}})
                $.each(o, function (index, subo) {
                    subo = replace_a_tag(subo)
                    cy.add({group: "nodes", data: {id: subo, parent: p}})
                })
            }
        });
        var layout = cy.layout({
            name: 'circle'
        });
        layout.run();
        var defaults = {
            zoomFactor: 0.05, // zoom factor per zoom tick
            zoomDelay: 45, // how many ms between zoom ticks
            minZoom: 0.1, // min zoom level
            maxZoom: 10, // max zoom level
            fitPadding: 50, // padding when fitting
            panSpeed: 10, // how many ms in between pan ticks
            panDistance: 10, // max pan distance per tick
            panDragAreaSize: 75, // the length of the pan drag box in which the vector for panning is calculated (bigger = finer control of pan speed and direction)
            panMinPercentSpeed: 0.25, // the slowest speed we can pan by (as a percent of panSpeed)
            panInactiveArea: 8, // radius of inactive area in pan drag box
            panIndicatorMinOpacity: 0.5, // min opacity of pan indicator (the draggable nib); scales from this to 1.0
            zoomOnly: false, // a minimal version of the ui only with zooming (useful on systems with bad mousewheel resolution)
            fitSelector: undefined, // selector of elements to fit
            animateOnFit: function () { // whether to animate on fit
                return false;
            }
        }
        cy.panzoom(defaults);

    }


</script>
</html>