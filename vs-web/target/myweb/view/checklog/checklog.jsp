<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%String path = request.getContextPath();%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <!-- Bootstrap框架必需配置 -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title></title>
    <!-- Bootstrap 样式 -->
    <link href="<%=path%>/libs/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="all">
    <!-- Bootstrap 表单验证 -->
    <link href="<%=path%>/libs/formValidator/bootstrapValidator.css" rel="stylesheet">
    <!-- Bootstrap 表格 -->
    <link rel="stylesheet" href="<%=path%>/libs/bootstrap/css/bootstrap-table.min.css">
    <!-- 侧边功能导航栏 -->
    <link href="<%=path%>/libs/css/dashboard.css" rel="stylesheet">
</head>
<body>
<!-- 页面主体 -->
<div class="container-fluid">
    <!-- 页面主体栅格布局 -->
    <div class="row">
        <!-- 侧边栏 -->
        <div class="col-sm-3 col-md-2 sidebar">
            <ul class="nav nav-sidebar text-center">
                <li id="depart" class="active"><a href="javascript:changeIframe('all');">所有来访</a></li>
                <li id="business"><a href="javascript:changeIframe('visit');">来访统计</a></li>
                <li id="staff"><a href="javascript:changeIframe('feedback');">反馈统计</a></li>
            </ul>
        </div>
        <!-- 侧边栏 结束 -->
        <!-- iframe内容区域 -->
        <div class="col-md-9 col-md-offset-2 main">
            <iframe id="iframe" src="<%=path%>/view/checklog/all.jsp" scrolling="no"
                    frameborder="0" height="528px" width="100%"></iframe>
        </div>
        <!-- iframe内容区域 结束 -->
    </div>
    <!-- 页面主体栅格布局 结束 -->
</div>
<!-- 页面主体 结束 -->
<!-- jquery core -->
<script src="<%=path%>/libs/jquery/jquery-1.11.3.min.js"></script>
<!-- Bootstrap core -->
<script src="<%=path%>/libs/bootstrap/js/bootstrap.min.js"></script>
<!-- Bootstrap 表单验证 -->
<script src="<%=path%>/libs/formValidator/bootstrapValidator.js"></script>
<!-- Bootstrap 表格 -->
<script src="<%=path%>/libs/bootstrap/js/bootstrap-table.min.js"></script>
<script src="<%=path%>/libs/bootstrap/js/bootstrap-table-zh-CN.min.js"></script>
<!-- javascript functions -->
<script type="text/javascript">
    function changeIframe(name) {

        var $iframe = $("#iframe");
        switch (name) {
            case "all":
                $("#all").addClass("active");
                $("#visit,#feedback").removeClass("active");
                $iframe.attr("src", "<%=path%>/view/checklog/all.jsp");
                break;
            case "visit":
                $("#visit").addClass("active");
                $("#all,#feedback").removeClass("active");
                $iframe.attr("src", "<%=path%>/view/checklog/visit.jsp");
                break;
            case "feedback":
                $("#feedback").addClass("active");
                $("#all,#visit").removeClass("active");
                $iframe.attr("src", "<%=path%>/view/checklog/feedback.jsp");
                break;
        }
    }
</script>
</body>
</html>