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
    <!-- 侧边功能导航栏 -->
    <link href="<%=path%>/libs/css/dashboard.css" rel="stylesheet">
</head>
<body>
<!-- 页面主体 -->
<div class="container-fluid">
    <!-- 页面主体栅格布局 -->
    <div class="row">
        <!-- 主体内容 -->
        <div class="col-md-9 col-md-offset-3 main">
            <h2 class="sub-header">访客信息扫描</h2><br/>

            <div class="row">
                <div class="col-sm-5">
                    <table class="table table-hover table-bordered">
                        <tr>
                            <th>姓&nbsp;&nbsp;名:</th>
                            <td id="name"></td>
                        </tr>
                        <tr>
                            <th>性&nbsp;&nbsp;别:</th>
                            <td id="sex"></td>
                        </tr>
                        <tr>
                            <th>籍&nbsp;&nbsp;贯:</th>
                            <td id="location"></td>
                        </tr>
                        <tr>
                            <th>证件号码:</th>
                            <td id="id"></td>
                        </tr>
                    </table>
                </div>
                <div class="col-sm-2 col-sm-offset-1">
                    <img class="img-rounded pull-right" style="max-height: 150px;"
                         src="<%=path%>/img/photo.jpg">
                </div>
            </div>
            <div class="row">
                <div class="col-sm-5">
                    <button class="btn btn-primary" onclick="scanCard();">读取证件信息</button>
                </div>
            </div>
            <br/>

            <h2 class="sub-header">办事业务选择</h2><br/>

            <div class="form-group">
                <div class="col-sm-3">
                    <select name="business" id="business" class="form-control" onchange="getStaffOpts();">
                        <option value="-1">选择办事业务</option>
                    </select>
                </div>
                <div class="col-sm-3">
                    <select name="staff" id="staff" class="form-control">
                        <option value="-1">选择办事人员</option>
                    </select>
                </div>
                <div class="col-sm-3">
                    <button class="btn btn-info" onclick="scanCard();">预览打印信息</button>
                </div>
            </div>
        </div>
        <!-- 主体内容 结束 -->
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
<!-- javascript functions -->
<script type="text/javascript">

    var $business = $("#business");
    var $staff = $("#staff");

    $(function () {
        getDepartOpts();
    });

    function getDepartOpts() {

        $.post("<%=path%>/depart/getDepartOpts.do", function (result) {
            if (result.status == "success") {
                var data = result.data;
                console.log(data);
                var html;
                for (var i = 0; i < data.length; i++) {
                    html += "<option value='" + data[i].code + "'>" + data[i].name + "</option>";
                }
                $business.append(html);
            }
        })
    }

    function scanCard() {
        $.post("<%=path%>/visitor/scanInfo.do",
                {
                    "id": "410103199206111111",
                    "name": "付康",
                    "sex": "男",
                    "location": "河南郑州"
                },
                function (result) {
                    console.log(result);
                    if (result.status == "success") {
                        alert("scan card success!");
                        $("#id").html(result.id);
                        $("#name").html(result.name);
                        $("#sex").html(result.sex);
                        $("#location").html(result.location);
                    } else {
                        alert("scan card failed!");
                    }
                }, "json");
    }

    function getStaffOpts() {

        var code = $business.val();
        $.post("<%=path%>/depart/getStaffOpts.do?code=" + code, function (result) {
            if (result.status == "success") {
                var data = result.data;
                console.log(data);
                var html;
                for (var i = 0; i < data.length; i++) {
                    html += "<option value='" + data[i].id + "'>" + data[i].name + "</option>";
                }
                $staff.html(html);
            }
        })
    }
</script>
</body>
</html>