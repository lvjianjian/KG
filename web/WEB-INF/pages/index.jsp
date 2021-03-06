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
                <li class="active"><a href="${pageContext.request.contextPath}/view/index">Introduction</a></li>
                <li><a href="${pageContext.request.contextPath}/view/search">Search</a></li>
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
            <h1>Introduction</h1>
        </section>

        <!-- Main content -->
        <section class="content">
            <!-- Main row -->
            <div class="row">
                <section class="col-lg-12 ">
                    <!-- 简介 -->
                    <div class="nav-tabs-custom ">
                        <ul class="nav nav-tabs pull-right">
                            <li class="pull-left header">简介</li>
                        </ul>
                        <div class="tab-content no-padding">
                            <div class="tab-pane active">
                                <p class="well">
                                    <b>优易数据研究院</b><br>
                                    优易数据研究院旨在通过大数据产业技术成果转化，聚集高层次大数据技术人才，对大数据理论进行探索，对大数据产业化过程及关键技术进行研究；解决大数据领域关键技术攻关；推动大数据产业理论成果市场化，实现经济效益转化，不断推动国信优易数据产业的高速发展，为国信优易数据及联盟企业、关联企业产业发展提供全方位技术支撑和技术储备。
                                </p>
                            </div>
                        </div>
                    </div><!-- /.简介 -->

                    <!-- 基本信息 -->
                    <div class="nav-tabs-custom ">
                        <ul class="nav nav-tabs pull-right">
                            <li class="pull-left header">基本信息</li>
                        </ul>
                        <div class="tab-content no-padding">
                            <div id="info-graph" class="tab-pane active panel panel-default" style="height: 400px;">

                            </div>
                        </div>
                    </div><!-- /.基本信息 -->

                    <!-- 更新记录 -->
                    <div class="nav-tabs-custom">
                        <ul class="nav nav-tabs pull-right">
                            <li class="pull-left header">更新记录</li>
                        </ul>
                        <div class="tab-content no-padding">
                            <div class="tab-pane active" id="revenue-chart">
                                <!-- Table -->
                                <table class="table table-striped text-center">
                                    <thead>
                                    <tr>
                                        <th>更新日期</th>
                                        <th>更新内容</th>
                                        <th>贡献者</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>2018.03.05</td>
                                        <td>网站构建</td>
                                        <td>吕中剑、郝茂祥</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div><!-- /.更新记录 -->
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
<script src="${pageContext.request.contextPath}/js/app.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/echarts.min.js"></script>

<script>
    $(function () {
        var entitiesStatistics =
        ${entitiesStatistics}
        var triplesStatistics = ${triplesStatistics}
            console.log(entitiesStatistics)
        console.log(triplesStatistics)

        var infoGraph = echarts.init(document.getElementById('info-graph'));
        // 指定图表的配置项和数据
        var option = {
            legend: {},
            tooltip: {
                trigger: "axis"
            },
            xAxis: [
                {
                    gridIndex: 1,
                    data: entitiesStatistics.map(function (item) {
                        return item['data']
                    })
                },
                {
                    gridIndex: 0,
                    data: triplesStatistics.map(function (item) {
                        return item['data']
                    })
                }
            ],
            yAxis: [
                {
                    min: 10000000,
                    splitLine: {
                        show: false
                    },
                    gridIndex: 1
                },
                {
                    min: 120000000,
                    splitLine: {
                        show: false
                    },
                    gridIndex: 0
                }
            ],
            dataZoom: [
                {
                    id: 'dataZoomEntity',
                    type: 'slider',
                    startValue: entitiesStatistics[Math.max(0, entitiesStatistics.length - 30)]['data'],
                    xAxisIndex: 0
                },
                {
                    id: 'dataZoomTriple',
                    type: 'slider',
                    startValue: triplesStatistics[Math.max(0, triplesStatistics.length - 30)]['data'],
                    xAxisIndex: 1
                }
            ],


            grid: [
                {left: '55%'},
                {right: '55%'}
            ],
            // Declare several bar series, each will be mapped
            // to a column of dataset.source by default.
            series: [
                {
                    name: '实体数',
                    type: 'line',
                    data: entitiesStatistics.map(function (item) {
                        return item['count']
                    }),
                    xAxisIndex: 0,
                    yAxisIndex: 0
                },
                {
                    name: '三元组数',
                    type: 'line',
                    data: triplesStatistics.map(function (item) {
                        return item['count']
                    }),
                    xAxisIndex: 1,
                    yAxisIndex: 1
                }
            ]
        };

        window.onresize = infoGraph.resize;
        $("#info-graph").resize(infoGraph.resize);

        // 使用刚指定的配置项和数据显示图表。
        infoGraph.setOption(option);
    })
</script>

</body>

</html>     