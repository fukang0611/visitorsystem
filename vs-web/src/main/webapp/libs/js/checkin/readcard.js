var $business = $("#business"); // 业务选择
var $staff = $("#staff");       // 员工选择

// 初始化完成后
$(function () {
    getDepartOpts($path);// 得到部门数据
});

// 得到部门选择列表
function getDepartOpts() {

    $.post($path + "/depart/getDepartOpts.do", function (result) {
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
    $.post($path + "/depart/getStaffOpts.do?code=" + code, function (result) {
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
        $.post($path + "/visitor/scanInfo.do", {
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
                $("#photo").attr("src", $path + "/" + result.img); // 显示照片
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
    $.post($path + "/record/add.do", {
        id: $("#print_id").html(),
        staffID: $staff.val()
    }, function (result) {
        if(result=="success"){
            $("#print_area").addClass('hidden');
            $('#printModal').modal('hide');
            alert("打印成功！");
            clearForm();
        }
    }, "json");
}

// jatoolsPrinter 打印插件
function doJatoolsPrint() {
    myDoc = {
        //settings:{paperName:'70×50'},
        documents: document,
        copyrights: '杰创软件拥有版权  www.jatools.com' // 版权声明,必须
    };
    jatoolsPrinter.print(myDoc, false); // 直接打印,不弹出打印机设置对话框
    //jatoolsPrinter.print(myDoc, true);
    //jatoolsPrinter.printPreview(myDoc);   // 打印预览,调试阶段使用该模式,确保无误后使用直接打印模式
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
