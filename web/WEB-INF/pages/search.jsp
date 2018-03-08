<%@ page language="java" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>YoueData</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <!-- Theme style -->
    <link href="/css/app.css" rel="stylesheet" type="text/css"/>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
</head>

<body class="skin-black fixed">
<header class="header">
    <a href="index" class="logo">
        <img src="/img/LOGO01.png" style="height: 34px;">
    </a>
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top" role="navigation" style="background-color: RGB(68,68,68);">
        <!-- Sidebar toggle button-->
        <a href="#" class="navbar-btn sidebar-toggle" data-toggle="offcanvas" role="button">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </a>
    </nav>
</header>

<div class="wrapper row-offcanvas row-offcanvas-left">
    <!-- Left side column. contains the logo and sidebar -->
    <aside class="left-side sidebar-offcanvas">
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">
            <!-- sidebar menu: : style can be found in sidebar.less -->
            <ul class="sidebar-menu">
                <li><a href="index">Introduction</a></li>
                <li class="active"><a href="search">Search</a></li>
                <li><a href="api">API</a></li>
                <li><a href="contributors">Contributors</a></li>
            </ul>
        </section>
        <!-- /.sidebar -->
    </aside>

    <!-- Right side column. Contains the navbar and content of the page -->
    <aside class="right-side">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>Search</h1>
        </section>

        <!-- Main content -->
        <section class="content">
            <!-- Main row -->
            <div class="row">
                <section class="col-lg-12 ">
                    <!-- 实体搜索
                    <div class="nav-tabs-custom">
                        <ul class="nav nav-tabs pull-right">
                            <li class="pull-left header">实体搜索</li>
                            <li class="pull-right row">
                                <div class="form-inline">
                                    <input type="text" name="entity_name" class="form-control input-sm" id="entity_name"
                                           style="width: 150px;" placeholder="Entity">
                                    <button type="button" class="btn btn-sm btn-default" id="entity_search">Search
                                    </button>
                                </div>
                            </li>
                        </ul>
                        <div class="tab-content no-padding">
                            <div id="search-result" class="tab-pane active">

                            </div>
                        </div>
                    </div>--><!-- /.实体搜索 -->
                    <div class="box box-solid box-danger">
                        <div class="box-header">
                            <h3 class="box-title">实体搜索</h3>
                            <div class="box-tools pull-right">
                                <div class="form-inline">
                                    <input type="text" name="entity_name" class="form-control input-sm" id="entity_name"
                                           style="width: 150px;" placeholder="Entity">
                                    <button type="button" class="btn btn-sm btn-default bg-gray" id="entity_search">Search
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div id="search-result" class="box-body">

                        </div><!-- /.box-body -->
                    </div>

                    <!-- Information -->
                    <div id="information" class="box box-solid box-primary hidden">
                        <div class="box-header">
                            <h3 class="box-title">Information</h3>
                            <div class="box-tools pull-right">
                                <button class="btn btn-primary btn-sm" data-widget="collapse"><span
                                        class="glyphicon glyphicon-minus"></span></button>
                            </div>
                        </div>
                        <div class="box-body">
                            <p class="well">
                                .......
                            </p>
                        </div><!-- /.box-body -->
                    </div><!-- /.box  Information -->

                    <!-- Info box -->
                    <div id="infobox" class="box box-solid box-info hidden">
                        <div class="box-header">
                            <h3 class="box-title">InfoBox</h3>
                            <div class="box-tools pull-right">
                                <button class="btn btn-info btn-sm" data-widget="collapse"><span
                                        class="glyphicon glyphicon-minus"></span></button>
                            </div>
                        </div>
                        <div class="box-body">
                            <table class="table table-striped text-center">
                                <tr class="row">
                                    <td style="width: 50%">属性</td>
                                    <td style="width: 50%">值</td>
                                </tr>
                                <tr class="row">
                                    <td style="width: 50%">属性</td>
                                    <td style="width: 50%">值</td>
                                </tr>
                                <tr class="row">
                                    <td style="width: 50%">属性</td>
                                    <td style="width: 50%">值</td>
                                </tr>
                            </table>
                        </div><!-- /.box-body -->
                    </div><!-- /.box -->

                    <!-- DBpedia Type -->
                    <div id="dbpedia-type" class="box box-solid box-success hidden">
                        <div class="box-header">
                            <h3 class="box-title">DBpedia Type</h3>
                            <div class="box-tools pull-right">
                                <button class="btn btn-success btn-sm" data-widget="collapse"><span
                                        class="glyphicon glyphicon-minus"></span></button>
                            </div>
                        </div>
                        <div class="box-body">
                            <table class="table table-striped text-center">
                                <tr class="row">
                                    <td style="width: 50%"><a href="https://www.w3.org/1999/02/22-rdf-syntax-ns#type"
                                                              target="_black">rdf:type</a></td>
                                    <td style="width: 50%"><a href="http://dbpedia.org/ontology/Organisation" target="_black">http://dbpedia.org/ontology/Organisation</a>
                                    </td>
                                </tr>
                                <tr class="row">
                                    <td style="width: 50%"><a href="https://www.w3.org/1999/02/22-rdf-syntax-ns#type"
                                                              target="_black">rdf:type</a></td>
                                    <td style="width: 50%"><a href="http://dbpedia.org/ontology/Organisation" target="_black">http://dbpedia.org/ontology/Organisation</a>
                                    </td>
                                </tr>

                            </table>
                        </div><!-- /.box-body -->
                    </div><!-- /.box -->

                    <!-- Baidu Baike Tag -->
                    <div id="baidu-tag" class="box box-solid box-warning hidden">
                        <div class="box-header">
                            <h3 class="box-title">Baidu Baike Tag</h3>
                            <div class="box-tools pull-right">
                                <button class="btn btn-warning btn-sm" data-widget="collapse"><span
                                        class="glyphicon glyphicon-minus"></span></button>
                            </div>
                        </div>
                        <div class="box-body">
                            <table class="table table-striped text-center">
                                <tr class="row">
                                    <td style="width: 50%">标签</td>
                                    <td style="width: 50%">大学</td>
                                </tr>
                                <tr class="row">
                                    <td style="width: 50%">标签</td>
                                    <td style="width: 50%">教育机构</td>
                                </tr>

                            </table>
                        </div><!-- /.box-body -->
                    </div><!-- /.box -->
                </section>
            </div><!-- /.main row -->

        </section><!-- /.Main content -->
    </aside><!-- /.right-side -->
</div><!-- ./wrapper -->

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"
        integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
        crossorigin="anonymous"></script>
<!-- app.js -->
<script src="/js/app.js" type="text/javascript"></script>

<script>
    function hidden_info() {
        $("#search-result").empty();

        if (!$("#information").hasClass("hidden")) {
            $("#information").addClass("hidden");
        }
        if (!$("#infobox").hasClass("hidden")) {
            $("#infobox").addClass("hidden");
        }
        if (!$("#dbpedia-type").hasClass("hidden")) {
            $("#dbpedia-type").addClass("hidden");
        }
        if (!$("#baidu-tag").hasClass("hidden")) {
            $("#baidu-tag").addClass("hidden");
        }
    }

    $("#entity_search").click(function () {
        hidden_info();
        var mention = $("#entity_name").val();
        ment_search(mention);
    });

    /**
     * mention查询
     * @param mention
     */
    function ment_search(mention) {
        $.get("/search/query.do", {mention: mention},
            function (ment_list) {
                var len = ment_list.length;
                alert(len);
                var content;    //查询结果展示内容
                if (len === 0) {    //查询不存在
                    content = "<p class='well'>您查询的：<b>" + mention + "</b>不存在，请检查！"

                } else if (len === 1) { //长度为1，说明只有一个实体，直接查询实体
                    entity_search(ment_list[0]);
                } else {
                    content = "<table class=\"table table-striped text-center\">";
                    $.each(ment_list, function (i, m) {
                        content += ("<tr class=\"row\"> <td><a>" + m + "</a></td></tr>")
                    });
                    content += "</table>";

                }
                $("#search-result").html(content);
            }, "json");
    }

    /**
     * 实体查询
     * @param entity
     */
    function entity_search(entity) {
        $.get("/search/info.do", {entity: entity},
            function (entity_info) {
                var information, infobox, dbpedia_type, baidu_tag;
                $.each(entity_info, function (key, value) {
                    // alert(key + ":" + value);
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
            }, "json");
    }

    $(".box-body").on('click', 'a', function () {
        if(typeof($(this).attr("href"))=="undefined") {
            hidden_info();
            var mention = $(this).text();
            $("#entity_name").val(mention);
            ment_search(mention);
        }

    })
</script>
</body>

</html>     