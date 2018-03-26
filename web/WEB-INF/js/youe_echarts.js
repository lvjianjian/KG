//param
var force = {
    repulsion: 700,
    edgeLength: 70,
    gravity: 0.7,
    layoutAnimation: true
}

var subject = {
    symbol: 'circle',
    symbolSize: 80,
    draggable: false,
    color: 'RGB(225,79,56)',
    fontSize: 16,
    fontWeight: 'bolder', //normal ,bold,bolder,lighter
    fontFamily: 'Microsoft YaHei', //'serif' , 'monospace', 'Arial', 'Courier New', 'Microsoft YaHei', ...
    opacity: 1
}

var predicate = {
    symbol: 'roundRect',
    symbolSize: [70, 35],
    draggable: false,
    color: 'RGB(231,175,74)',
    fontSize: 12,
    fontWeight: 'bold', //normal ,bold,bolder,lighter
    fontFamily: 'sans-serif', //'serif' , 'monospace', 'Arial', 'Courier New', 'Microsoft YaHei', ...
    opacity: 1
}


var object = {
    symbol: 'circle',
    symbolSize: 40,
    draggable: true,
    color: 'RGB(243,203,189)',
    fontSize: 13,
    fontWeight: 'bold', //normal ,bold,bolder,lighter
    fontFamily: 'Arial', //'serif' , 'monospace', 'Arial', 'Courier New', 'Microsoft YaHei', ...
    opacity: 1
}

var edgeStyle = {
    opacity: 0.8,
    color: "#000000",
    width: 1.5,
    curveness: 0.05,
    type: "dotted"
}

var WEB_ROOT_PATH = getRootPath_web();

//去除所有a标签
function replace_a_tag(str) {
    return str.replace(/<a>/g, "").replace(/<\/a>/g, "")
}

//过长主语拆成2行
function object_name_split_into_two(str) {
    if (str.length <= 10) return str
    newstr = str.substr(0, str.length / 2) + "\n" + str.substr(str.length / 2, str.length)
    return newstr;
}

var node_index_to_node_index = {}
var node_index_to_edge_index = {}
var predicate_show = []
var myChart = null
var originOption = null

//深度拷贝
var cloneObj = function (obj) {
    var newObj = {};
    if (obj instanceof Array) {
        newObj = [];
    }
    for (var key in obj) {
        var val = obj[key];
        //newObj[key] = typeof val === 'object' ? arguments.callee(val) : val; //arguments.callee 在哪一个函数中运行，它就代表哪个函数, 一般用在匿名函数中。
        newObj[key] = typeof val === 'object' ? cloneObj(val) : val;
    }
    return newObj;
};

//过长字符缩减
function echarts_text_turncate_for_object(name) {
    return echarts.format.truncateText(name, 300, object.fontSize + ' ' + object.fontFamily, '…');
}


//画kg图 谓语也用节点表示
function kg_option_1(entity, data) {
    node_index_to_node_index = {}
    node_index_to_edge_index = {}
    predicate_show = []
    data_nodes = []
    data_links = []
    entity = entity
    var id = 0;
    var link_id = 0;
    //主语节点
    data_nodes.push({
        id: id,
        name: entity,
        draggable: subject.draggable,
        symbolSize: subject.symbolSize,
        symbol: subject.symbol,
        category: 0,
        itemStyle: {
            opacity: subject.opacity,
        },
        showAdjacent: true,
        label: {
            formatter: function (params) {
                return object_name_split_into_two(params.data.name)
            },
            fontSize: subject.fontSize,
            fontFamily: subject.fontFamily,
            fontWeight: subject.fontWeight
        }

    })
    node_index_to_edge_index[id] = []
    node_index_to_node_index[id] = []
    id++


    $.each(data, function (p, o) {
        p = replace_a_tag(p)
        if (p === "TYPE" || p === "TAG"
            || p === "DESC" || p === "CATEGORY_ZH")
            return

        //谓语节点
        var pid = id
        data_nodes.push({
            id: id,
            name: p,
            draggable: predicate.draggable,
            symbolSize: predicate.symbolSize,
            symbol: predicate.symbol,
            category: 1,
            itemStyle: {
                opacity: predicate.opacity
            },
            showAdjacent: false,
            label: {
                fontSize: predicate.fontSize,
                fontFamily: predicate.fontFamily,
                fontWeight: predicate.fontWeight
            },
            // slient:true
            // fixed:false
        })

        node_index_to_node_index[id] = []
        node_index_to_edge_index[id] = []

        data_links.push({
            source: 0,
            target: id,
            id: link_id,
            lineStyle: {
                opacity: edgeStyle.opacity,
            },

        })
        node_index_to_edge_index[0].push(link_id)
        node_index_to_node_index[0].push(id)
        id++
        link_id++

        if ($.type(o) === "string") {//string
            o = replace_a_tag(o)

            //单宾语节点
            data_nodes.push({
                id: id,
                name: o,
                draggable: object.draggable,
                symbolSize: object.symbolSize,
                symbol: object.symbol,
                category: 2,
                itemStyle: {
                    opacity: 0
                },
                label: {
                    fontSize: object.fontSize,
                    fontFamily: object.fontFamily,
                    fontWeight: object.fontWeight
                },
            })

            data_links.push({
                source: pid,
                target: id,
                lineStyle: {
                    opacity: 0
                },
                id: link_id,
            })
            node_index_to_node_index[pid].push(id)
            node_index_to_edge_index[pid].push(link_id)
            id++
            link_id++

        } else {//array
            //多宾语节点
            $.each(o, function (index, subo) {
                subo = replace_a_tag(subo)
                data_nodes.push({
                    id: id,
                    name: subo,
                    draggable: object.draggable,
                    symbolSize: object.symbolSize,
                    symbol: object.symbol,
                    category: 2,
                    itemStyle: {
                        opacity: 0
                    },
                    label: {
                        fontSize: object.fontSize,
                        fontFamily: object.fontFamily,
                        fontWeight: object.fontWeight
                    },

                })
                data_links.push({
                    source: pid,
                    target: id,
                    lineStyle: {
                        opacity: 0
                    },
                    id: link_id
                })
                node_index_to_node_index[pid].push(id)
                node_index_to_edge_index[pid].push(link_id)
                id++
                link_id++
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
                text: entity,
                top: "top",
                left: "center"
            },
            tooltip: {
                show: true,
                formatter: function (params) {
                    // console.log(params)
                    if (params.dataType === "node"
                        && params.data.category === 2
                        && params.data.itemStyle.opacity !== 0) {
                        if (echarts_text_turncate_for_object(params.data.name) !== params.data.name)
                            return params.data.name
                    }
                }
            },
            // geo: {
            //     zoom:0.5
            // },
            // dataZoom: [
            //     {
            //         type: 'inside',
            //         start:0.2
            //     },
            //
            // ],
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
                show: true,
                itemSize: 25,
                right: "5%",
                feature: {
                    myTool1: {
                        show: true,
                        title: '显示',
                        icon: "image://" + WEB_ROOT_PATH + "/img/lookup2.png",
                        onclick: function () {
                            hide_show_all_node(true)
                        }
                    },
                    myTool2: {
                        show: true,
                        title: '还原',
                        icon: "image://" + WEB_ROOT_PATH + "/img/restore.png",
                        onclick: function () {
                            hide_show_all_node(false)
                        }
                    },
                    saveAsImage: {
                        show: true,
                        icon: "image://" + WEB_ROOT_PATH + "/img/download.png",
                    }
                }
            },
            animation:
                false,
            animationDuration:
                1,
            animationEasingUpdate:
                1,
            series:
                [{
                    name: entity,
                    type: 'graph',
                    layout: 'force',
                    // coordinateSystem:"cartesian2d",
                    force: {
                        repulsion: force.repulsion,
                        edgeLength: force.edgeLength,
                        layoutAnimation: force.layoutAnimation,
                        gravity: force.gravity
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
                                color: object.color,
                            },
                            label: {
                                formatter: function (obj) {
                                    // return obj.name
                                    return echarts_text_turncate_for_object(obj.name);
                                },
                                fontSize: predicate.fontSize,
                                fontFamily: predicate.fontFamily,
                                fontWeight: predicate.fontWeight
                            },
                        }
                    ],
                    data: data_nodes,
                    links: data_links,
                    focusNodeAdjacency: true,
                    roam: true,
                    label: {

                        show: true,
                        color: "#000000"
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
                        color: "#000000",
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
                        opacity: edgeStyle.opacity,
                        width: 1.5,
                        curveness: 0.05,
                        type: "dotted",
                        // silent:true
                    },
                    emphasis: {
                        label: {
                            show: false
                        },
                        edgeLabel: {
                            show: false
                        }
                    },
                    textStyle: {
                        color: '#000000'
                    },
                    // width:500,
                    // height:"10px"
                    // left: "20%",
                    // top: "20%",
                    // right: "20%",
                    // bottom: "20%",
                }]
        }
    ;

    return option
}

//获取项目url根地址
function getRootPath_web() {
    //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
    var curWwwPath = window.document.location.href;
    //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
    var pathName = window.document.location.pathname;
    var pos = curWwwPath.indexOf(pathName);
    //获取主机地址，如： http://localhost:8083
    var localhostPaht = curWwwPath.substring(0, pos);
    //获取带"/"的项目名，如：/uimcardprj
    var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
    return (localhostPaht + projectName);
}

function selfHeight(size) {
    height = Math.max((100 + Math.sqrt(size) * 88), 350)
    console.log(height)
    return height + "px"
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
function draw_kg(entity, data, mc, option_methon, graph_dom) {
    var option = option_methon(entity, data)
    originOption = option
    graph_dom.style.height = selfHeight(option.series[0].data.length)
    myChart = mc
    myChart.setOption(option)
    myChart.on('click', hide_show_node)
}


//影藏或者显示某个节点
function hide_show_for_node(data, index, node_opacity, edge_opacity, links) {
    var click_node = data[index]
    if (click_node.category === 2) return
    if (click_node.showAdjacent === false) {
        node_opacity = 1
        edge_opacity = 0.8
        click_node.showAdjacent = true
        if (click_node.category !== 0)
            predicate_show.push(index)
    } else {
        click_node.showAdjacent = false
        if (click_node.category !== 0)
            predicate_show.splice($.inArray(index, predicate_show), 1)
    }
    if (click_node.category === 0) {
        $.each(predicate_show, function (i, ind) {
            setOpacity(ind, data, links, edge_opacity, node_opacity)
        })
    }
    setOpacity(index, data, links, edge_opacity, node_opacity)
}

//影藏或者显示某个节点e的周围连接节点
function hide_show_node(e) {
    var graph = myChart.getOption("graph")
    var data = graph.series[0].data
    var links = graph.series[0].links
    var node_opacity = 0
    var edge_opacity = 0
    if (e.dataType === "node") {//点击节点
        var index = e.data.id
        hide_show_for_node(data, index, node_opacity, edge_opacity, links);
    } else if (e.dataType === "edge") {
        var index = e.data.target
        hide_show_for_node(data, index, node_opacity, edge_opacity, links);
    }
    myChart.setOption(graph)
}

//隐藏或者显示所有节点
function hide_show_all_node(showAll) {
    predicate_show = []
    if (showAll) {
        var graph = cloneObj(originOption)
        var data = graph.series[0].data
        var links = graph.series[0].links
        for (i = 0; i < data.length; ++i) {
            if (data[i].category === 1) {
                hide_show_for_node(data, data[i].id, 0, 0, links)
            }
        }
    } else {
        graph = originOption
    }
    myChart.setOption(graph)
}

//设置某个节点的透明度
function setOpacity(index, nodes, links, edge_opacity, node_opacity) {
    $.each(node_index_to_edge_index[index], function (i, edge_index) {
        links[edge_index].lineStyle.opacity = edge_opacity
    })
    $.each(node_index_to_node_index[index], function (i, node_index) {
        nodes[node_index].itemStyle.opacity = node_opacity
    })
}