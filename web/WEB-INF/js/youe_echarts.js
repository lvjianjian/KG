//param
var force = {
    repulsion: 500,
    edgeLength: 60
}

var subject = {
    symbol: 'circle',
    symbolSize: 100,
    draggable: false,
    color: 'RGB(225,79,56)',
    fontSize: 18,
    fontWeight: 'bolder', //normal ,bold,bolder,lighter
    fontFamily: 'Microsoft YaHei', //'serif' , 'monospace', 'Arial', 'Courier New', 'Microsoft YaHei', ...

}

var predicate = {
    symbol: 'roundRect',
    symbolSize: [60,30],
    draggable: true,
    color: 'RGB(231,175,74)',
    fontSize: 10,
    fontWeight: 'bold', //normal ,bold,bolder,lighter
    fontFamily: 'sans-serif', //'serif' , 'monospace', 'Arial', 'Courier New', 'Microsoft YaHei', ...

}


var object = {
    symbol: 'circle',
    symbolSize: 40,
    draggable: true,
    color: 'RGB(243,203,189)',
    fontSize: 13,
    fontWeight: 'bold', //normal ,bold,bolder,lighter
    fontFamily: 'sans-serif', //'serif' , 'monospace', 'Arial', 'Courier New', 'Microsoft YaHei', ...

}


//去除所有a标签
function replace_a_tag(str) {
    return str.replace(/<a>/g, "").replace(/<\/a>/g, "")
}

//画kg图 谓语也用节点表示
function kg_option_1(entity, data) {
    data_nodes = []
    data_links = []
    entity = entity
    var id = 0;
    data_nodes.push({
        id: id++,
        name: entity,
        draggable: subject.draggable,
        symbolSize: subject.symbolSize,
        symbol: subject.symbol,
        category: 0
    })

    $.each(data, function (p, o) {
        p = replace_a_tag(p)
        if (p === "TYPE" || p === "TAG"
            || p === "DESC" || p === "CATEGORY_ZH")
            return

        var pid = id
        data_nodes.push({
            id: id,
            name: p,
            draggable: predicate.draggable,
            symbolSize: predicate.symbolSize,
            symbol: predicate.symbol,
            category: 1
        })

        data_links.push({
            source: 0,
            target: id++,
        })

        if ($.type(o) === "string") {//string
            o = replace_a_tag(o)


            data_nodes.push({
                id: id,
                name: o,
                draggable: object.draggable,
                symbolSize: object.symbolSize,
                symbol: object.symbol,
                category: 2
            })


            data_links.push({
                source: pid,
                target: id++,
            })

        } else {//array
            $.each(o, function (index, subo) {
                subo = replace_a_tag(subo)
                data_nodes.push({
                    id: id,
                    name: subo,
                    draggable: object.draggable,
                    symbolSize: object.symbolSize,
                    symbol: object.symbol,
                    category: 2
                })
                data_links.push({
                    source: pid,
                    target: id++,
                })
            })
        }
    });

    var option = {
        backgroundColor: new echarts.graphic.RadialGradient(0.3, 0.3, 0.8, [{
            offset: 0,
            color: '#f7f8fa'
        }, {
            offset: 1,
            color: '#cdd0d5'
        }]),
        title: {
            text: "test",
            top: "top",
            left: "center"
        },
        tooltip: {
            show:false
            // formatter: function (name) {
            //     return echarts.format.truncateText(name, 40, '14px Microsoft Yahei', '…');
            // },
        },
        // legend: {
        //     x: "center",
        //     data: ["subject", "predicate", 'object']
        // },
        // legend: [{
        //     formatter: function(name) {
        //         return echarts.format.truncateText(name, 40, '14px Microsoft Yahei', '…');
        //     },
        //     tooltip: {
        //         show: true
        //     },
        //     selectedMode: 'false',
        //     bottom: 20,
        //     data: ['刘备2239', '诸葛亮1892', '曹操979', '关羽948', '张飞408', '赵云393', '孙权390', '吕布384', '周瑜328', '魏延327']
        // }],
        toolbox: {
            show: false,
            feature: {
                dataView: {
                    show: true,
                    readOnly: true
                },
                restore: {
                    show: true
                },
                saveAsImage: {
                    show: true
                }
            }
        },
        animationDuration: 1,
        animationEasingUpdate: 1,
        series: [{
            name: 'test',
            type: 'graph',
            layout: 'force',

            force: {
                repulsion: force.repulsion,
                edgeLength: force.edgeLength
            },
            categories: [
                {
                    name: '主语',
                    itemStyle: {
                        color: subject.color
                    },
                    label: {
                        fontSize: subject.fontSize,
                        fontFamily: subject.fontFamily,
                        fontWeight: subject.fontWeight
                    }
                },
                {
                    name: '谓语',
                    itemStyle: {
                        color: predicate.color
                    },
                    label: {
                        fontSize: predicate.fontSize,
                        fontFamily: predicate.fontFamily,
                        fontWeight: predicate.fontWeight
                    }
                },
                {
                    name: '宾语',
                    itemStyle: {
                        color: object.color
                    },
                    label: {
                        fontSize: predicate.fontSize,
                        fontFamily: predicate.fontFamily,
                        fontWeight: predicate.fontWeight
                    }
                }
            ],
            data: data_nodes,
            links: data_links,
            focusNodeAdjacency: true,
            roam: true,
            label: {
                formatter: function (obj) {
                    return obj.name
                    // return echarts.format.truncateText(obj.name, 100, '14px Microsoft Yahei', '…');
                },
                show: true,
                color:"#000000"
                // position: 'center',

            },
            edgeSymbol: ['', ''],
            edgeLabel: {
                show: false,
                color: 'blue',
                // formatter: function (x) {
                //     return x.data.name;
                // }
                // formatter:'{c}'
            },
            lineStyle: {
                color:"#000000",
                // color: {
                //     type: 'linear',
                //     x: 0,
                //     y: 0,
                //     x2: 0,
                //     y2: 1,
                //     colorStops: [{
                //         offset: 0, color: 'red' // 0% 处的颜色
                //     }, {
                //         offset: 1, color: 'blue' // 100% 处的颜色
                //     }],
                //     globalCoord: false // 缺省为 false
                // },
                opacity: 0.8,
                width: 1.5,
                curveness: 0.05,
                type: "dotted"
            },
            emphasis:{
                label:{
                    show:false
                },
                edgeLabel:{
                    show:false
                }
            },
            textStyle:{
                color:'#000000'
            }
        }]
    };

    return option
}


//画kg图
function kg_option_2(entity, data) {
    data_nodes = []
    data_links = []
    entity = entity
    var id = 0;
    data_nodes.push({
        id: id,
        name: entity,
        draggable: false,
        symbolSize: 40,
    })
    id += 1

    $.each(data, function (p, o) {
        p = replace_a_tag(p)
        if (p === "TYPE" || p === "TAG"
            || p === "DESC" || p === "CATEGORY_ZH")
            return

        if ($.type(o) === "string") {//string
            o = replace_a_tag(o)
            data_nodes.push({
                id: id,
                name: o,
                draggable: true,
                symbolSize: 20,
                symbol: 'roundRect'
            })

            data_links.push({
                source: 0,
                target: id,
                name: p
            })

            id += 1
        } else {//array
            $.each(o, function (index, subo) {
                subo = replace_a_tag(subo)
                data_nodes.push({
                    id: id,
                    name: subo,
                    draggable: true,
                    symbolSize: 20,
                    symbol: 'roundRect'
                })
                data_links.push({
                    source: 0,
                    target: id,
                    name: p
                })
                id += 1
            })
        }
    });

    var option = {
        backgroundColor: new echarts.graphic.RadialGradient(0.3, 0.3, 0.8, [{
            offset: 0,
            color: '#f7f8fa'
        }, {
            offset: 1,
            color: '#cdd0d5'
        }]),
        title: {
            text: "test",
            top: "top",
            left: "center"
        },
        tooltip: {},
        // legend: [{
        //     formatter: function(name) {
        //         return echarts.format.truncateText(name, 40, '14px Microsoft Yahei', '…');
        //     },
        //     tooltip: {
        //         show: true
        //     },
        //     selectedMode: 'false',
        //     bottom: 20,
        //     data: ['刘备2239', '诸葛亮1892', '曹操979', '关羽948', '张飞408', '赵云393', '孙权390', '吕布384', '周瑜328', '魏延327']
        // }],
        toolbox: {
            show: false,
            feature: {
                dataView: {
                    show: true,
                    readOnly: true
                },
                restore: {
                    show: true
                },
                saveAsImage: {
                    show: true
                }
            }
        },
        animationDuration: 1,
        animationEasingUpdate: 1,
        series: [{
            name: 'test',
            type: 'graph',
            layout: 'force',

            force: {
                repulsion: 250,
                edgeLength: 125
            },
            data: data_nodes,
            links: data_links,
            focusNodeAdjacency: true,
            roam: true,
            label: {
                normal: {
                    show: true,
                    // position: 'center',

                }
            },
            edgeSymbol: ['', 'arrow'],
            edgeLabel: {
                normal: {
                    show: true,
                    color: 'blue',
                    formatter: function (x) {
                        return x.data.name;
                    }
                    // formatter:'{c}'
                }
            },
            lineStyle: {
                normal: {
                    color: 'source',
                    opacity: 0.7,
                    width: 1,
                    curveness: 0.1,
                    type: "solid"
                }
            }
        }]
    };

    return option
}


//画kg图
function draw_kg(entity, data, myChart, option_methon) {
    var option = option_methon(entity, data)
    myChart.setOption(option);
}