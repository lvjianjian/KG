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
    <script src="/js/jquery-3.3.1.min.js"></script>
    <script src="/js/cytoscape.min.js"></script>
</head>
<body>
<div id="cy"></div>
</body>
<script>
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
                        }
                },
                {
                    selector: 'edge',
                    css:
                        {
                            'content': 'data(predicate)',
                            'target-arrow-shape': 'triangle'
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
                        'background-color': '#bbb'
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
    }


</script>
</html>