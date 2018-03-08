
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
        if(p === "TYPE" || p ==="TAG"
            || p === "DESC" || p ==="CATEGORY_ZH")
            return

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
        name: 'cose'
    });
    layout.run();
}