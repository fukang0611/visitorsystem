<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%String path = request.getContextPath();%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <!-- Bootstrap框架必需配置 -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>访客管理系统</title>
    <!-- Bootstrap 样式 -->
    <link href="<%=path%>/libs/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="all">
    <!-- Bootstrap 表单验证 -->
    <link href="<%=path%>/libs/formValidator/bootstrapValidator.css" rel="stylesheet">
    <!-- 自定义样式 -->
    <link href="<%=path%>/libs/css/index.css" rel="stylesheet"/>
</head>
<body>
<!-- 顶部固定导航 -->
<nav class="navbar navbar-default navbar-fixed-top navbar-inverse">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="javascript:switchFunc('checkin');">访客管理系统</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li id="checkin" class="active"><a href="javascript:switchFunc('checkin');">访客登记</a></li>
                <li id="checklog"><a href="javascript:switchFunc('checklog');">来访记录</a></li>
                <li id="infomanage"><a href="javascript:switchFunc('infomanage');">信息维护</a></li>
                <%--<li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                       aria-expanded="false">Dropdown <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">Action</a></li>
                        <li><a href="#">Another action</a></li>
                        <li><a href="#">Something else here</a></li>
                        <li class="divider"></li>
                        <li class="dropdown-header">Nav header</li>
                        <li><a href="#">Separated link</a></li>
                        <li><a href="#">One more separated link</a></li>
                    </ul>
                </li>--%>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#">当前用户 : ${user.displayName}</a></li>
                <li><a href="javascript:logout();">用户登出</a></li>
            </ul>
        </div>
    </div>
</nav>
<!-- 主体内容 -->
<div class="content">
    <iframe id="icontent" width="100%" height="100%"></iframe>
</div>
<!-- jquery core -->
<script src="<%=path%>/libs/jquery/jquery-1.11.3.min.js"></script>
<!-- Bootstrap core -->
<script src="<%=path%>/libs/bootstrap/js/bootstrap.min.js"></script>
<!-- Bootstrap 表单验证 -->
<script src="<%=path%>/libs/formValidator/bootstrapValidator.js"></script>
<!-- javascript functions -->
<script type="text/javascript">
    /*文档初始化完成*/
    $(document).ready(function () {
        /*默认进入访客登记模块*/
        switchFunc('checkin');
    })
    /*切换功能模块*/
    function switchFunc(type) {
        switch (type) {
            case "checkin":
                $("#checklog,#infomanage").removeClass("active");
                $("#checkin").addClass("active");
                $("#icontent").attr("src", "<%=path%>/view/checkin/checkin.jsp");
                break;
            case "checklog":
                $("#checkin,#infomanage").removeClass("active");
                $("#checklog").addClass("active");
                $("#icontent").attr("src", "<%=path%>/view/checklog/checklog.jsp");
                break;
            case "infomanage":
                $("#checkin,#checklog").removeClass("active");
                $("#infomanage").addClass("active");
                $("#icontent").attr("src", "<%=path%>/view/infomanage/infomanage.jsp");
                break;
        }
    }

    function logout() {
        $.get("<%=path%>/user/toLoginPage.do", function (result) {
            if (result == "success") {
                window.parent.location.href = "<%=path%>/view/login.jsp";
            }
        });
    }
</script>
</body>
</html>