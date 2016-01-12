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
            <h2 class="sub-header">手动录入访客信息</h2><br/>

            <div class="col-sm-4">
                <form action="" method="post" class="form-inline">

                    <div class="form-group">
                        <label for="name">姓名</label>
                        <input type="text" class="form-control" name="name" id="name" placeholder="">
                    </div>


                </form>
            </div>
            <div class="col-sm-4">
                <form action="" method="post" class="form-inline">

                    <div class="form-group">
                        <label for="tel">姓名</label>
                        <input type="text" class="form-control" name="tel" id="tel" placeholder="">
                    </div>


                </form>
            </div>

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
                    <button class="btn btn-info" onclick="prePrint();">预览打印信息</button>
                </div>
            </div>
        </div>
        <!-- 主体内容 结束 -->
    </div>
    <!-- 页面主体栅格布局 结束 -->
    <!-- 打印预览模态框 -->
    <div class="modal fade" id="printModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                    <h4 class="modal-title" id="printModalLabel">访客信息打印预览</h4>
                </div>
                <div class="modal-body">
                    <table class="table table-bordered table-hover">
                        <tr>
                            <th class="text-center" width="15%">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</th>
                            <td id="print_name" width="35%">付康</td>
                            <th class="text-center" width="15%">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</th>
                            <td id="print_sex" width="35%">男</td>
                        </tr>
                        <tr>
                            <th class="text-center">证件号码</th>
                            <td id="print_id">410103199011100011</td>
                            <th class="text-center">籍&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;贯</th>
                            <td id="print_location">河南郑州</td>
                        </tr>
                        <tr>
                            <th class="text-center">待办业务</th>
                            <td id="print_business">民行</td>
                            <th class="text-center">办事部门</th>
                            <td id="print_depart">民行科</td>
                        </tr>
                        <tr>
                            <th class="text-center">办事人员</th>
                            <td id="print_staff">王小虎</td>
                            <th class="text-center">办公电话</th>
                            <td id="print_officeTel">2239</td>
                        </tr>
                        <tr>
                            <th class="text-center">来访时间</th>
                            <td colspan="3" id="print_time">2015-12-31 15:33</td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" onclick="doPrint();">确认打印</button>
                </div>
            </div>
        </div>
    </div>
    <!-- 修改员工模态框 结束 -->
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
                var html;
                for (var i = 0; i < data.length; i++) {
                    html += "<option value='" + data[i].code + "'>" + data[i].business + "----" + data[i].name + "</option>";
                }
                $business.append(html);
            }
        })
    }

    function getStaffOpts() {

        var code = $business.val();
        if (code == -1) {
            $staff.html('<option value="-1">选择办事人员</option>');
            return;
        }
        $.post("<%=path%>/depart/getStaffOpts.do?code=" + code, function (result) {
            if (result.status == "success") {
                var data = result.data;
                console.log(data);
                var html = "";
                for (var i = 0; i < data.length; i++) {
                    html += "<option value='" + data[i].id + "'>" + data[i].name + " ( " + data[i].officeTel + " ) " + "</option>";
                }
                $staff.html(html);
            }
        })
    }

    function prePrint() {

        $("#print_name").html($("#name").html());
        $("#print_sex").html($("#sex").html());
        $("#print_id").html($("#id").html());
        $("#print_location").html($("#location").html());

        $("#print_business").html($business.find("option:selected").text().substring(0, 2));
        $("#print_depart").html($business.find("option:selected").text().substring(6));

        var staff_select = $staff.find("option:selected").text();
        $("#print_staff").html(staff_select.substring(0, 3));
        $("#print_officeTel").html($staff.find("option:selected").text().substring(staff_select.indexOf("(") + 1, staff_select.indexOf(")")));

        var d = new Date();
        var datetime = (d.getFullYear() + "-" +
        ("0" + (d.getMonth() + 1)).slice(-2) + "-" +
        ("0" + d.getDate()).slice(-2) + " " +
        ("0" + d.getHours()).slice(-2) + ":" +
        ("0" + d.getMinutes()).slice(-2));
        $("#print_time").html(datetime);

        $('#printModal').modal('show');

    }

    function doPrint() {

        var name = $("#print_name").html();
        var sex = $("#print_sex").html();
        var id = $("#print_id").html();
        var location = $("#print_location").html();
        var business = $("#print_business").html();
        var depart = $("#print_depart").html();
        var staff = $("#print_staff").html();
        var officeTel = $("#print_officeTel").html();
        var printTime = $("#print_time").html();

        $.post("<%=path%>/record/add.do", {
            id: id,
            name: name,
            sex: sex,
            location: location,
            staffID: $staff.val()
        }, function (result) {
            console.log(result);
        }, "json");
    }
</script>
</body>
</html>