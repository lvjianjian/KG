/**
 * 显示实体的全部信息
 * @param mention   查询参数
 * @param entityInfos   实体内容
 * @param entityNames   多义词列表
 * @param myChart   echart实例
 * @param graph_dom     graph对应的dom实例
 */
function displayInfo(mention,entity, entityInfos, entityNames, myChart, graph_dom) {
    if (!$.isEmptyObject(entityInfos)) {
        //有实体信息，画图，显示实体信息
        $("#entity-graph").css("height", "500px")
        displayPanel(entityInfos);
        draw_kg(entity,entityInfos,myChart,kg_option_1,graph_dom)
        if (entityNames.length > 1) {
            //显示多义词列表
            displayEntityNames(mention, entityNames)
        }
    } else if (entityNames.length > 1) {
        //显示多义词列表
        displayEntityNames(mention, entityNames)
    } else {
        //显示查询信息不存在
        displayNone(mention);
    }
}

/**
 * 显示多义词列表
 */
function displayEntityNames(mention, entityNames) {
    $("#entity-list").removeClass("hidden");
    $("#entity-list").append("<h6> \"<b>" + mention + "</b>\"是个多义词，全部含义如下：</h6>");
    $.each(entityNames, function (index, name) {
        $("#entity-list").append(" <span class='glyphicon glyphicon-chevron-right'><span><a href='#'>" + name + "</a> ");
    })
}

/**
 * 显示实体基本信息框的函数
 * @param entityInfos   实体信息
 */
function displayPanel(entityInfos) {
    var information, infobox, dbpedia_type, baidu_tag;
    $.each(entityInfos, function (key, value) {
        if (key === "DESC") {   //描述信息
            if ($("#information").hasClass("hidden")) {
                $("#information").removeClass("hidden");
            }
            information = value;

        } else if (key === "TYPE") {    // DBpedia Type
            if ($("#dbpedia-type").hasClass("hidden")) {
                $("#dbpedia-type").removeClass("hidden");
            }
            if ($.type(value) === "string") {   //如果只有一个Type
                dbpedia_type = ("<tr class='row'> " +
                    "<td style='width: 50%'> " +
                    "   <a href='https://www.w3.org/1999/02/22-rdf-syntax-ns#type'>rdf:type</a>" +
                    "</td>" +
                    "<td style='width: 50%'>" +
                    "   <a href='http://dbpedia.org/ontology/'" + value + ">http://dbpedia.org/ontology/" + value + "</a>" +
                    "</td></tr>")
            } else {    //有多个Type
                $.each(value, function (i, v) {
                    dbpedia_type += ("<tr class='row'> " +
                        "<td style='width: 50%'> " +
                        "   <a href='https://www.w3.org/1999/02/22-rdf-syntax-ns#type'>rdf:type</a>" +
                        "</td>" +
                        "<td style='width: 50%'>" +
                        "   <a href='http://dbpedia.org/ontology/'" + v + ">http://dbpedia.org/ontology/" + v + "</a>" +
                        "</td></tr>")
                });
            }


        } else if (key === "TAG") { //Baidu Baike Tag
            if ($("#baidu-tag").hasClass("hidden")) {
                $("#baidu-tag").removeClass("hidden");
            }
            if ($.type(value) == "string") {    //只有一个Tag
                baidu_tag += ("<tr class='row'>" +
                    "<td style='width: 50%'> 标签 </td>" +
                    "<td style='width: 50%'> " + value + "</td> </tr>")
            } else {    //有多个Tag
                $.each(value, function (i, v) {
                    baidu_tag += ("<tr class='row'>" +
                        "<td style='width: 50%'> 标签 </td>" +
                        "<td style='width: 50%'> " + v + "</td> </tr>")
                });
            }
        } else if (key === "CATEGORY_ZH") {

        } else {
            if ($("#infobox").hasClass("hidden")) {
                $("#infobox").removeClass("hidden");
            }
            infobox += ("<tr class='row'>" +
                "<td style='width: 50%'>" + key + "</td>" +
                "<td style='width: 50%'>" + value + "</td></tr>");
        }
    });
    $("#information .box-body p").html(information);
    $("#infobox .box-body table tbody").html(infobox);
    $("#dbpedia-type .box-body table tbody").html(dbpedia_type);
    $("#baidu-tag .box-body table tbody").html(baidu_tag);
}

/**
 * 显示查询实体不存在
 * @param mention   查询参数
 */
function displayNone(mention) {
    $("#search-result").html("<p class='well'>您查询的：<b>" + mention + "</b>不存在，请检查！\</p>");
}
