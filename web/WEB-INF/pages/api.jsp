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
                <li><a href="${pageContext.request.contextPath}/view/search">Search</a></li>
                <li class="active"><a href="${pageContext.request.contextPath}/view/api">API</a></li>
                <li><a href="${pageContext.request.contextPath}/view/contributors">Contributors</a></li>
            </ul>
        </section>
        <!-- /.sidebar -->
    </aside>

    <!-- Right side column. Contains the navbar and content of the page -->
    <aside class="right-side">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>API调用</h1>
        </section>

        <!-- Main content -->
        <section class="content">
            1.获取同义词列表 (mention -> entity) <br>
            输入名称(mention)返回对应实体(entity)的列表。<br>

            请求方式(名称：mention_name):<br>

            http://ada.suda.edu.cn/KG/search/query.do?mention=mention_name<br>

            返回格式:<br>
            [entity_name1, entity_name2]<br>
            附加说明: 如果没有同义词, 返回空的列表, 即[]. <br>

            mention_name举例:<br>

            苹果<br>
            苏大<br>
            苏州大学<br>
            番茄<br>
            西红柿<br>



            2.获取实体 (entity -> knowledge) <br>
            输入实体(entity)返回JSON格式的全部知识。 <br>
            请求方式(实体：entity_name):<br>
            http://ada.suda.edu.cn/KG/search/info.do?entity=entity_name <br>
            返回格式:<br>
            {<br>
                predicate1: object1,<br>
                predicate2: object2,<br>
                predicate3: [object3_1, object3_2]<br>
            }<br>
            附加说明: 若谓语只对应一个宾语，则返回谓语和对应宾语；若谓语对应多个并于，则返回谓语和对应的宾语列表 。 如果没有对应实体, 返回空的字典, 即{}. <br>

            entity_name举例:<br>

            苏州大学<br>
            复旦大学<br>
            苹果（蔷薇科苹果属果树）<br>
            苹果公司<br>

            3. 获取属性值(entity&attribute -> value)<br>
            给定实体(entity)和属性(attribute)返回其对应属性值(value)。<br>


            请求方式（实体：entity_name、属性：attribute_name）:<br>
            http://ada.suda.edu.cn/KG/search/attr.do?entity=entity_name&attribute=attribute_name <br>

            返回格式：<br>
            [value1,value2] <br>
            附加说明: 如果没有对应实体或者没有对应的属性名(谓语名), 返回空的列表, 即[]. <br>



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
</body>

</html>     