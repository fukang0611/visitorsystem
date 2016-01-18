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
<!-- 身份证读取器插件/打印插件 -->
<OBJECT CLASSID="CLSID:10946843-7507-44FE-ACE8-2B3483D179B7"
        id="CVR_IDCard" name="CVR_IDCard" width="0" height="0">
</OBJECT>
<OBJECT CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"
        id="WebBrowser" name="WebBrowser" width=0 height=0>
</OBJECT>
<OBJECT CLASSID="CLSID:B43D3361-D075-4BE2-87FE-057188254255"
        id="jatoolsPrinter" codebase="jatoolsPrinter.cab#version=8,6,0,0" width=0 height=0>
</OBJECT>
<!-- 页面主体 -->
<div class="container-fluid">
    <!-- 页面主体栅格布局 -->
    <div class="row">
        <!-- 主体内容 -->
        <div class="col-md-9 col-md-offset-3 main">
            <h2 class="sub-header">访客信息扫描</h2><br/>
            <!-- 身份证信息表格及读取按钮 -->
            <div class="row">
                <div class="col-sm-8">
                    <table class="table table-hover table-bordered">
                        <tr>
                            <th class="text-center" style="width: 20%">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名:
                            </th>
                            <td id="name"></td>
                        </tr>
                        <tr>
                            <th class="text-center">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别:</th>
                            <td id="sex"></td>
                        </tr>
                        <tr>
                            <th class="text-center">证件号码:</th>
                            <td id="id"></td>
                        </tr>
                        <tr>
                            <th class="text-center">地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;址:</th>
                            <td id="location"></td>
                        </tr>
                    </table>
                </div>
                <div class="col-sm-2">
                    <img id="photo" src="<%=path%>/img/photo/photo_default.png" class="img-rounded pull-right"
                         style="max-height: 150px;">
                </div>
            </div>
            <div class="row">
                <div class="col-sm-5">
                    <button class="btn btn-primary" onclick="readCard();">读取证件信息</button>
                </div>
            </div>
            <br/>

            <h2 class="sub-header">办事业务选择</h2><br/>
            <!-- 办事业务信息及打印预览按钮 -->
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
                    <table id="preview_area" class="table table-bordered table-hover">
                        <tr>
                            <th class="text-center" width="15%">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</th>
                            <td id="preview_name" width="35%"></td>
                            <th class="text-center" width="15%">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</th>
                            <td id="preview_sex" width="35%"></td>
                        </tr>
                        <tr>
                            <th class="text-center">证件号码</th>
                            <td id="preview_id"></td>
                            <th class="text-center">来访时间</th>
                            <td id="preview_time"></td>
                        </tr>
                        <tr>
                            <th class="text-center">待办业务</th>
                            <td id="preview_business"></td>
                            <th class="text-center">办事部门</th>
                            <td id="preview_depart"></td>
                        </tr>
                        <tr>
                            <th class="text-center">办事人员</th>
                            <td id="preview_staff"></td>
                            <th class="text-center">办公电话</th>
                            <td id="preview_officeTel"></td>
                        </tr>
                        <tr>
                            <th class="text-center">地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;址</th>
                            <td colspan="3" id="preview_location"></td>
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
    <!-- 打印预览模态框 结束 -->
    <!-- 实际打印区域 -->
    <div id="page1" style="width: 80mm;height: 50mm;">
        <table id="print_area" class="table table-hover hidden">
            <tr>
                <th class="text-center" width="15%">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</th>
                <td id="print_name" width="35%"></td>
            </tr>
            <tr>
                <th class="text-center">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</th>
                <td id="print_sex"></td>
            </tr>
            <tr>
                <th class="text-center">证件号码</th>
                <td id="print_id"></td>
            </tr>
            <tr>
                <th class="text-center">地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;址</th>
                <td id="print_location"></td>
            </tr>
            <tr>
                <th class="text-center">来访时间</th>
                <td id="print_time"></td>
            </tr>
            <tr>
                <th class="text-center">待办业务</th>
                <td id="print_business"></td>
            </tr>
            <tr>
                <th class="text-center">办事部门</th>
                <td id="print_depart"></td>
            </tr>
            <tr>
                <th class="text-center">办事人员</th>
                <td id="print_staff"></td>
            </tr>
            <tr>
                <th class="text-center">办公电话</th>
                <td id="print_officeTel"></td>
            </tr>
        </table>
    </div>
    <!-- 实际打印区域 结束 -->
</div>
<!-- 页面主体 结束 -->
<!-- jquery core -->
<script src="<%=path%>/libs/jquery/jquery-1.11.3.min.js"></script>
<!-- jquery print-->
<script src="<%=path%>/libs/jquery/jquery.jqprint-0.3.js"></script>
<!-- Bootstrap core -->
<script src="<%=path%>/libs/bootstrap/js/bootstrap.min.js"></script>
<!-- Bootstrap 表单验证 -->
<script src="<%=path%>/libs/formValidator/bootstrapValidator.js"></script>
<!-- javascript functions -->
<script type="text/javascript">

    // 全局变量定义
    var $business = $("#business"); // 业务选择
    var $staff = $("#staff");       // 员工选择

    // 初始化完成后
    $(function () {
        getDepartOpts();// 得到部门数据
    });

    // 得到部门选择列表
    function getDepartOpts() {

        $.post("<%=path%>/depart/getDepartOpts.do", function (result) {
            if (result.status == "success") {
                var data = result.data;
                var html = "";
                for (var i = 0; i < data.length; i++) {
                    html += "<option value='" + data[i].code + "'>" + data[i].business + "----" + data[i].name + "</option>";
                }
                $business.append(html);
            }
        })
    }

    // 得到部门对应员工选择列表
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

    //读取身份证信息
    function readCard() {
        // 读卡器
        var CVR_IDCard = document.getElementById("CVR_IDCard");
        // 读取结果,0为正常,其他为各种错误
        var strReadResult = CVR_IDCard.ReadCard();
        // 若读取正常,则取出所需身份证信息
        if (strReadResult == "0") {
            var $id = CVR_IDCard.CardNo;                  // 身份证号
            var $name = CVR_IDCard.Name;                  // 姓名
            var $sex = CVR_IDCard.Sex;                    // 性别
            var $born = CVR_IDCard.Born;                  // 出生日期
            var $nation = CVR_IDCard.Nation;              // 民族
            var $location = CVR_IDCard.Address;           // 地址
            var $imgCode = CVR_IDCard.Picture;            // 头像照片jpg转换编码(base64)
            var $validateBegin = CVR_IDCard.EffectedDate; // 起始有效期
            var $validateEnd = CVR_IDCard.ExpiredDate;    // 终止有效期
            var $organization = CVR_IDCard.IssuedAt;      // 发证机关
            // 提交服务器处理,并根据返回结果进行处理
            $.post("<%=path%>/visitor/scanInfo.do", {
                id: $id,
                name: $name,
                sex: $sex,
                born: $born,
                nation: $nation,
                location: $location,
                imgCode: $imgCode,
                validateBegin: $validateBegin,
                validateEnd: $validateEnd,
                organization: $organization
            }, function (result) {
                if (result.status == "success") {
                    clearForm();
                    $("#id").html($id);
                    $("#name").html($name);
                    $("#sex").html($sex);
                    $("#location").html($location);
                    $("#photo").attr("src", "<%=path%>/" + result.img); // 显示照片
                }
            }, "json");
        }
        else {
            clearForm();
            alert(strReadResult);
        }
    }

    // 清空表单
    function clearForm() {
        $("#id").html();
        $("#name").html();
        $("#sex").html();
        $("#location").html();
    }

    // 预览打印信息
    function prePrint() {

        // 访客信息
        $("#print_name,#preview_name").html($("#name").html());
        $("#print_sex,#preview_sex").html($("#sex").html());
        $("#print_id,#preview_id").html($("#id").html());
        $("#print_location,#preview_location").html($("#location").html());
        // 业务信息
        $("#print_business,#preview_business").html($business.find("option:selected").text().substring(0, 2));
        $("#print_depart,#preview_depart").html($business.find("option:selected").text().substring(6));
        // 办事人员信息
        var staff_select = $staff.find("option:selected").text();
        $("#print_staff,#preview_staff").html(staff_select.substring(0, 3));
        $("#print_officeTel,#preview_officeTel").html($staff.find("option:selected").text().substring(staff_select.indexOf("(") + 1, staff_select.indexOf(")")));
        // 日期信息
        var d = new Date();
        var datetime = (d.getFullYear() + "-" +
        ("0" + (d.getMonth() + 1)).slice(-2) + "-" +
        ("0" + d.getDate()).slice(-2) + " " +
        ("0" + d.getHours()).slice(-2) + ":" +
        ("0" + d.getMinutes()).slice(-2));
        $("#print_time,#preview_time").html(datetime);
        // 显示模态框
        $('#printModal').modal('show');
    }

    // 执行打印操作,同时增加来访记录
    function doPrint() {

        // 将打印区域的隐藏类去掉
        $("#print_area").removeClass('hidden');

        <!--jqprint 插件打印-->
        //pagesetup_null();
        //$("#print_area").jqprint({operaSupport: false});

        <!--jatoolsPrint 打印-->
        doJatoolsPrint();

        // 将打印区域再次增加隐藏类
        //$("#print_area").addClass('hidden');

        // 增加来访记录
        $.post("<%=path%>/record/add.do", {
            id: $("#print_id").html(),
            staffID: $staff.val()
        }, function (result) {
            console.log(result);
        }, "json");
    }

    // jatoolsPrinter 打印插件
    function doJatoolsPrint() {
        myDoc = {
            documents: document,
            copyrights: '杰创软件拥有版权  www.jatools.com' // 版权声明,必须
        };
        //jatoolsPrinter.print(myDoc, false); // 直接打印，不弹出打印机设置对话框
        jatoolsPrinter.printPreview(myDoc); // 打印预览
    }

    //设置网页打印的页眉页脚边距为空
    function pagesetup_null() {
        var hkey_key;
        var hkey_root = "HKEY_CURRENT_USER";
        var hkey_path = "\\software\\Microsoft\\Internet Explorer\\PageSetup\\";
        try {
            var RegWsh = new ActiveXObject("WScript.Shell");
            hkey_key = "header";
            RegWsh.RegWrite(hkey_root + hkey_path + hkey_key, "");
            hkey_key = "footer";
            RegWsh.RegWrite(hkey_root + hkey_path + hkey_key, "");
            /*hkey_key = "margin_left";
             RegWsh.RegWrite(hkey_root + hkey_path + hkey_key, "0.0");
             hkey_key = "margin_right";
             RegWsh.RegWrite(hkey_root + hkey_path + hkey_key, "0.0");
             hkey_key = "margin_top";
             RegWsh.RegWrite(hkey_root + hkey_path + hkey_key, "0.0");
             hkey_key = "margin_bottom";
             RegWsh.RegWrite(hkey_root + hkey_path + hkey_key, "0.0");*/
        } catch (e) {
            alert(e);
        }
    }

</script>
</body>
</html>