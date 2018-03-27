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
    <link href="${pageContext.request.contextPath}/css/app.css" rel="stylesheet" type="text/css"/>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->

    <style type="text/css">
        /* cytoscape graph */
        #cy {
            width: 1000px;
            height: 500px;
            background-color: #f9f9f9;
        }
    </style>
</head>

<body class="skin-black fixed">
<header class="header">
    <a href="${pageContext.request.contextPath}/view/index" class="logo">
        <img src="${pageContext.request.contextPath}/img/LOGO01.png" style="height: 34px;">
    </a>
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top" role="navigation" style="background-color: RGB(68,68,68);">
        <!-- Sidebar toggle button-->
        <a href="#" class="navbar-btn sidebar-toggle" data-toggle="offcanvas" role="button">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar bg-green"></span>
            <span class="icon-bar bg-green"></span>
            <span class="icon-bar bg-green"></span>
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
                <li><a href="${pageContext.request.contextPath}/view/index">Introduction</a></li>
                <li class="active"><a href="${pageContext.request.contextPath}/view/search">Search</a></li>
                <li><a href="${pageContext.request.contextPath}/view/api">API</a></li>
                <li><a href="${pageContext.request.contextPath}/view/contributors">Contributors</a></li>
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
                    <div class="box box-solid box-danger">
                        <div class="box-header">
                            <%--<h3 class="box-title">实体搜索</h3>--%>
                            <div class="box-tools pull-right">
                                <form class="input-group" action="${pageContext.request.contextPath}/view/search"
                                      method="get">
                                    <input name="mention" type="text" class="form-control" placeholder="Search for...">
                                    <span class="input-group-btn">
                                        <input class="btn btn-default bg-gray" type="submit" value="Search"></input>
                                    </span>
                                </form>
                            </div>
                        </div>

                        <div id="search-result" class="box-body">
                            <p id="entity-list" class="well hidden">
                            </p>
                            <div id="entity-graph" class="panel panel-default" style="width:100%;">
                            </div>
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
                                <tbody>

                                </tbody>
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
                                <tbody>

                                </tbody>
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
                                <tbody>

                                </tbody>
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
<%--<script src="/js/jquery-3.3.1.min.js"></script>--%>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"
        integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
        crossorigin="anonymous"></script>
<!-- app.js -->

<script src="${pageContext.request.contextPath}/js/app.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/search.js"></script>
<script src="${pageContext.request.contextPath}/js/echarts.js"></script>
<script src="${pageContext.request.contextPath}/js/youe_echarts.js"></script>
<script>

    $(function () {
        var mention = '${mention}'
        var entityNames = ${entityNames};
        var entityInfos = ${entityInfos};
        var entity = '${entity}'
        var myChart = echarts.init(document.getElementById('entity-graph'));
        displayInfo(mention, entity, entityInfos, entityNames, myChart,
            document.getElementById('entity-graph'));
        window.onresize = function () {
            myChart.resize();
        };
    });

    /**
     * 多义词列表中，a标签的点击跳转
     */
    $("#entity-list").on('click', 'a', function () {
        var entity = $(this).text()
        var mention = '${mention}'
        $(location).attr('href', '${pageContext.request.contextPath}/view/search?mention=' + mention + '&entity=' + entity);

    })

    /**
     * 多义词列表中，a标签的点击跳转
     */
    $(".box-body").on('hover', 'a', function () {
        var entity = $(this).text()
        var mention = '${mention}'
        $(location).attr('href', '${pageContext.request.contextPath}/view/search?mention=' + mention + '&entity=' + entity);

    })

    /**
     * 其余面板中，a标签的点击跳转
     */
    $(".box-body").on('click', 'a', function () {
        if (typeof($(this).attr("href")) == "undefined") {
            var mention = $(this).text();
            $(location).attr('href', '${pageContext.request.contextPath}/view/search?mention=' + mention);
        }
    })


</script>
</body>

</html>     