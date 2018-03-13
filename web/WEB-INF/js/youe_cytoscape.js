//去除所有a标签
function replace_a_tag(str) {
    return str.replace(/<a>/g, "").replace(/<\/a>/g, "")
}

//画kg图
function draw_kg(entity, data) {
    var cy = cytoscape({
        container: document.getElementById('cy'),
        style: [
            {
                selector: 'node',
                css:
                    {
                        'background-color': '#6FB1FC',
                        'content': 'data(name)',
                        'text-valign': 'center',
                        'text-halign': 'center',
                        'padding-top': '10px',
                        'width': '30px',
                        'height': '30px'
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
                        'curve-style': 'bezier',
                        'arrow-scale': 1.5,
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
    });

    var id = 0;
    cy.add({group: "nodes", data: {id: id, name: entity}})
    id += 1
    $.each(data, function (p, o) {
        p = replace_a_tag(p)
        if (p === "TYPE" || p === "TAG"
            || p === "DESC" || p === "CATEGORY_ZH")
            return

        if ($.type(o) === "string") {//string
            o = replace_a_tag(o)
            cy.add({group: "nodes", data: {id: id, name: o}})
            cy.add({group: "edges", data: {source: 0, target: id, predicate: p}})
            id += 1
        } else {//array
            cy.add({group: "nodes", data: {id: id, name: p}})
            cy.add({group: "edges", data: {source: 0, target: id, predicate: p}})
            var pid = id
            id += 1
            $.each(o, function (index, subo) {
                subo = replace_a_tag(subo)
                cy.add({group: "nodes", data: {id: id, name: subo, parent: pid}})
                id += 1
            })
        }
    });
    var layout = cy.layout({
        name: 'concentric'

    });
    layout.run();


}