<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%String path = request.getContextPath();%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <!-- Bootstrap框架必需配置 -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>访客管理系统--登陆</title>
    <!-- Bootstrap 样式 -->
    <link href="<%=path%>/libs/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap 表单验证 -->
    <link href="<%=path%>/libs/formValidator/bootstrapValidator.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <img class="img-responsive center-block" src="<%=path%>/img/login/banner.jpg">

    <form id="loginForm" style="margin:50px auto;max-width: 300px" method="post"
          action="<%=path%>/user/loginValidate.do">
        <div class="form-group">
            <label class="control-label">帐&nbsp;&nbsp;号:</label>
            <input type="text" class="form-control " name="username" placeholder="请输入帐号" autofocus>
        </div>
        <div class="form-group">
            <label class="control-label">密&nbsp;&nbsp;码:</label>
            <input type="password" class="form-control " name="password" placeholder="请输入密码">
        </div>
        <div class="form-group">
            <button type="submit" class="btn btn-primary btn-block">登&nbsp;&nbsp;陆</button>
        </div>
    </form>
</div>
<!-- jquery core -->
<script src="<%=path%>/libs/jquery/jquery-1.11.3.min.js"></script>
<!-- Bootstrap core -->
<script src="<%=path%>/libs/bootstrap/js/bootstrap.min.js"></script>
<!-- Bootstrap 表单验证 -->
<script src="<%=path%>/libs/formValidator/bootstrapValidator.js"></script>
<!-- javascript functions -->
<script type="text/javascript">
    $(document).ready(function () {
        initValidate();
    });
    function initValidate() {
        $('#loginForm').
                bootstrapValidator({
                    message: '输入信息不合法!',
                    feedbackIcons: {
                        valid: 'glyphicon glyphicon-ok',
                        invalid: 'glyphicon glyphicon-remove',
                        validating: 'glyphicon glyphicon-refresh'
                    },
                    fields: {
                        username: {
                            message: '用户名输入不合法!',
                            validators: {
                                notEmpty: {
                                    message: '用户名不能为空!'
                                }
                            }
                        },
                        password: {
                            validators: {
                                notEmpty: {
                                    message: '密码不允许为空!'
                                }
                            }
                        }
                    }
                })
                .on('success.form.bv', function (e) {
                    e.preventDefault();
                    var $form = $(e.target);
                    var bv = $form.data('bootstrapValidator');
                    $.post($form.attr('action'), $form.serialize(), function (result) {
                        if (result == "success") {
                            window.location.href = "<%=path%>/view/index.jsp";
                        } else {
                            alert("登陆失败!请重试!");
                        }
                    }, 'json');
                });
    }
</script>
</body>
</html>
