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
            <!-- 实体搜索 -->
            <div class="row">
                <section class="col-lg-12 ">
                    <div class="box box-solid box-danger">
                        <div class="box-header">
                            <div class="box-tools pull-right">
                                <form class="input-group" action="${pageContext.request.contextPath}/view/search"
                                      method="get">
                                    <input name="mention" type="text" class="form-control" placeholder="Search for...">
                                    <span class="input-group-btn">
                                        <input class="btn btn-default bg-gray" type="submit" value="Search"/>
                                    </span>
                                </form>
                            </div>
                        </div>
                    </div>
                </section>
            </div><!-- ./实体搜索 -->
            <div id="search-result">

                <ul id="result-tab" class="nav nav-tabs">
                    <li :class="{active:isThisKg('bdbaike')}"><a v-on:click="sameAs(entityName, 'bdbaike')" data-toggle="tab">百度百科</a></li>
                    <li :class="{active:isThisKg('zhwiki')}"><a v-on:click="sameAs(entityName, 'zhwiki')" data-toggle="tab">维基百科</a></li>
                    <li :class="{active:isThisKg('hdbaike')}"><a v-on:click="sameAs(entityName, 'hdbaike')" data-toggle="tab">互动百科</a></li>
                </ul>

                <div id="result-tab-content" class="tab-content">
                    <div class="row">

                        <section class="col-lg-12">

                            <!-- Graph -->
                            <div class="panel panel-default">
                                <div id="graph" class="panel-body" style="width:100%; height: 50px">
                                </div>
                            </div>

                            <!-- Information -->
                            <div :class="['box', 'box-solid', 'box-primary', {hidden: isHidden(information)}]">
                                <div class="box-header">
                                    <h3 class="box-title">Information</h3>
                                    <div class="box-tools pull-right">
                                        <button class="btn btn-primary btn-sm" data-widget="collapse"><span
                                                class="glyphicon glyphicon-minus"></span></button>
                                    </div>
                                </div>
                                <div class="box-body">
                                    <p class="well" v-for="i in information">
                                        <span v-html="i"></span>
                                        </span>
                                </div><!-- /.box-body -->
                            </div><!-- /.box  Information -->

                            <!-- Info box -->
                            <div :class="['box', 'box-solid', 'box-info', {hidden: isHidden(infoboxes)}]">
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
                                        <tr class='row' v-for="(key,value) in infoboxes">
                                            <td style='width: 30%' v-html="value"></td>
                                            <td style='width: 70%'><span style="margin: 5px" v-for="k in key"
                                                                         v-html="k"> </span></td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div><!-- /.box-body -->
                            </div><!-- /.infobox -->

                            <!-- DBpedia Type -->
                            <div :class="['box', 'box-solid', 'box-success', {hidden: isHidden(types)}]">
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
                                        <tr class='row' v-for="type in types">
                                            <td style='width: 30%'>
                                                <a href='https://www.w3.org/1999/02/22-rdf-syntax-ns#type'>rdf:type</a>
                                            </td>

                                            <td style='width: 70%'>
                                                <a v-on:click="redirect(type)">http://dbpedia.org/ontology/{{type}}</a>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div><!-- /.box-body -->
                            </div><!-- /.DBpedia Type -->

                            <!-- Baidu Baike Tag -->
                            <div :class="['box', 'box-solid', 'box-warning', {hidden: isHidden(tags)}]">
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
                                        <tr class='row' v-for="tag in tags">
                                            <td style='width: 30%'> 标签</td>
                                            <td style='width: 70%'>{{tag}}</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div><!-- /.box-body -->
                            </div><!-- /.box -->

                            <!-- Category -->
                            <div :class="['box', 'box-solid', 'box-warning', {hidden: isHidden(categories)}]">
                                <div class="box-header">
                                    <h3 class="box-title">Category</h3>
                                    <div class="box-tools pull-right">
                                        <button class="btn btn-warning btn-sm" data-widget="collapse"><span
                                                class="glyphicon glyphicon-minus"></span></button>
                                    </div>
                                </div>
                                <div class="box-body">
                                    <table class="table table-striped text-center">
                                        <tbody>
                                        <tr class='row' v-for="category in categories">
                                            <td style='width: 30%'> Category</td>
                                            <td style='width: 70%'>{{category}}</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div><!-- /.box-body -->
                            </div><!-- /.box -->
                        </section>
                    </div>
                </div>


            </div>
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
<!-- Vue开发环境版本，包含了用帮助的命令行警告 -->
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<!-- app.js -->

<script src="${pageContext.request.contextPath}/js/app.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/search.js"></script>
<script src="${pageContext.request.contextPath}/js/echarts.js"></script>
<script src="${pageContext.request.contextPath}/js/youe_echarts.js"></script>
<script>

    const result = new Vue({
        el: "#search-result",
        data: {
            mention: '${param.mention}',
            entityName: '${param.entity}',
            kgBase: '${param.kg_base}',
            allInfo: JSON.parse("{}")
            // sameAs: "",
        },
        computed: {
            information: function () {
                return this.allInfo["DESC"]
            },
            types: function () {
                return this.allInfo["TYPE"]
            },
            categories: function () {
                return this.allInfo["CATEGORY"]
            },
            tags: function () {
                return this.allInfo["TAG"]
            },
            infoboxes: function () {
                const ib = new Map();
                const illegalKey = new Set(["DESC", "TAG", "TYPE", "CATEGORY_ZH", "CATEGORY"]);
                $.each(this.allInfo, function (key, value) {
                    if (!illegalKey.has(key)) {
                        ib[key] = value;
                    }
                })
                return ib;
            }

        },
        methods: {
            isThisKg: function (kg_name) {
                return this.kgBase === kg_name
            },
            isHidden: function (item) {
                return getLength(item) <= 0;
            },
            sameAs: function (entityName, kg_base) {
                window.location.href='${pageContext.request.contextPath}/view/search?mention='+this.mention+'&entity='+entityName+'&kg_base='+kg_base;
            }
        },
        watch: {
            infoboxes: function () {
                var myChart = echarts.init(document.getElementById('graph'))
                draw_kg(result.entityName, result.infoboxes, myChart, kg_option_1, document.getElementById('graph')),
                    window.onresize = function () {
                        myChart.resize();
                    };
            }
        }
    });

    $.ajax({
        url: "${pageContext.request.contextPath}/search/info.do",
        type: "GET",
        data: {
            entity: result.entityName,
            kg_base: result.kgBase
        },
        dataType: "json",
        beforeSend: function () {
            console.log('发送前')
        },
        success: function (data) {
            result.allInfo = data
            console.log(data)
        },
        error: function (xhr, textStatus) {
            console.log('错误')
            console.log(xhr)
            console.log(textStatus)
        },
        complete: function () {
            console.log('结束')
        }
    })

    function getLength(map) {
        var size = 0;
        $.each(map, function (key, value) {
            size += 1;
        })
        return size;
    }
</script>
</body>

</html>     