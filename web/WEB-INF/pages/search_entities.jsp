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
                                        <input class="btn btn-default bg-gray" type="submit" value="Search" v-on:click="isNull()"/>
                                    </span>
                                </form>
                            </div>
                        </div>
                    </div>
                </section>
            </div><!-- /.main row -->

            <div id="entity-list" class="row">

                <!-- BaiduBaike -->
                <section :class="[setWidth(),{hidden:isHidden(entities['bdbaike'])}]">
                    <div class="box box-success">
                        <div class="box-header">
                            <h3 class="box-title">百度百科</h3>
                        </div><!-- /.box-header -->
                        <div class="box-body">
                            <ul class="todo-list">
                                <li v-for="entity in entities['bdbaike']">
                                    <!-- todo text -->
                                    <span class="text"><a v-on:click="search(entity, 'bdbaike')">{{entity}}</a></span>
                                </li>
                            </ul>
                        </div><!-- /.box-body -->
                    </div><!-- /.box -->
                </section>

                <section :class="[setWidth(),{hidden:isHidden(entities['zhwiki'])}]">
                    <div class="box box-info">
                        <div class="box-header">
                            <h3 class="box-title">维基百科</h3>
                        </div><!-- /.box-header -->
                        <div class="box-body">
                            <ul class="todo-list">
                                <li v-for="entity in entities['zhwiki']">
                                    <!-- todo text -->
                                    <span class="text"><a v-on:click="search(entity, 'zhwiki')">{{entity}}</a></span>
                                </li>
                            </ul>
                        </div><!-- /.box-body -->
                    </div><!-- /.box -->
                </section>

                <section :class="[setWidth(),{hidden:isHidden(entities['hdbaike'])}]">
                    <div class="box box-warning">
                        <div class="box-header">
                            <h3 class="box-title">互动百科</h3>
                        </div><!-- /.box-header -->
                        <div class="box-body">
                            <ul class="todo-list">
                                <li v-for="entity in entities['hdbaike']">
                                    <!-- todo text -->
                                    <span class="text"><a v-on:click="search(entity, 'hdbaike')">{{entity}}</a></span>
                                </li>
                            </ul>
                        </div><!-- /.box-body -->
                    </div><!-- /.box -->
                </section>

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
<!-- app.js -->

<script src="${pageContext.request.contextPath}/js/app.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/search.js"></script>
<script src="${pageContext.request.contextPath}/js/echarts.js"></script>
<script src="${pageContext.request.contextPath}/js/youe_echarts.js"></script>
<script>

    var entityList = new Vue({
        el: "#entity-list",
        data: {
            mention: '${param.mention}',
            entities: JSON.parse("{}")
        },
        methods: {
            search: function (entity, kg_name) {
                window.location.href='${pageContext.request.contextPath}/view/search?mention='+this.mention+'&entity='+entity+'&kg_base='+kg_name
            },
            isHidden: function (entities) {
                return getLength(entities) === 0;
            },
            getKgNum: function () {
                var kgs = new Array('bdbaike', 'hdbaike', 'zhwiki')
                var num = 0
                for(i in kgs) {
                    if (getLength(this.entities[kgs[i]]) !== 0) num += 1;
                }
                return num;
            },
            setWidth: function () {
                var num = this.getKgNum()
                if (num === 0) return "col-lg-12";
                else return "col-lg-"+ String(12 / num);
            }
        }
    })

    $.ajax({
        url: "${pageContext.request.contextPath}/search/query.do",
        type: "GET",
        data :{
            mention: entityList.mention
        },
        dataType: "json",
        beforeSend:function(){
            console.log('发送前')
        },
        success:function(data){
            entityList.entities = data
            console.log(data)
        },
        error:function(xhr,textStatus){
            console.log('错误')
            console.log(xhr)
            console.log(textStatus)
        },
        complete:function(){
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