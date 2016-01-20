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
            <h2 class="sub-header">访客信息扫描</h2><br>
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
            <br>

            <h2 class="sub-header">办事业务选择</h2><br>
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
    <!-- 打印预览区域 -->
    <div class="modal fade" id="printModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                    <h4 class="modal-title" id="printModalLabel">访客信息打印预览</h4>
                </div>
                <div class="modal-body">
                    <%--<div id="page1" style="width: 70mm;height: 50mm">
                        <table id="preview_area" class="table table-hover" style="font-size: .3cm;">
                            &lt;%&ndash;<tr style="padding-left: .5cm">&ndash;%&gt;
                            <tr>
                                <th class="text-center" width="15%" style="padding: 0;margin-left: .5cm">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</th>
                                <td id="preview_name" width="85%" style="padding: 0;padding-left:.5cm"></td>
                            </tr>
                            &lt;%&ndash;<tr style="padding-left: .5cm">&ndash;%&gt;
                            <tr>
                                <th class="text-center" style="padding: 0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</th>
                                <td id="preview_sex" style="padding: 0;padding-left:.5cm"></td>
                            </tr>
                            &lt;%&ndash;<tr style="padding-left: .5cm">&ndash;%&gt;
                            <tr>
                                <th class="text-center" style="padding: 0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;证件号码</th>
                                <td id="preview_id" style="padding: 0;padding-left:.5cm"></td>
                            </tr>
                            &lt;%&ndash;<tr>
                                <th class="text-center" style="padding: 0">地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;址</th>
                                <td id="preview_location" style="padding: 0"></td>
                            </tr>&ndash;%&gt;
                            &lt;%&ndash;<tr style="padding-left: .5cm">&ndash;%&gt;
                            <tr>
                                <th class="text-center" style="padding: 0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;来访时间</th>
                                <td id="preview_time" style="padding: 0;padding-left:.5cm"></td>
                            </tr>
                            &lt;%&ndash;<tr style="padding-left: .5cm">&ndash;%&gt;
                            <tr>
                                <th class="text-center" style="padding: 0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;待办业务</th>
                                <td id="preview_business" style="padding: 0;padding-left:.5cm"></td>
                            </tr>
                            &lt;%&ndash;<tr style="padding-left: .5cm">&ndash;%&gt;
                            <tr>
                                <th class="text-center" style="padding: 0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;办事部门</th>
                                <td id="preview_depart" style="padding: 0;padding-left:.5cm"></td>
                            </tr>
                            &lt;%&ndash;<tr style="padding-left: .5cm">&ndash;%&gt;
                            <tr>
                                <th class="text-center" style="padding: 0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;办事人员</th>
                                <td id="preview_staff" style="padding: 0;padding-left:.5cm"></td>
                            </tr>
                            &lt;%&ndash;<tr style="padding-left: .5cm">&ndash;%&gt;
                            <tr>
                                <th class="text-center" style="padding: 0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;办公电话</th>
                                <td id="preview_officeTel" style="padding: 0;padding-left:.5cm"></td>
                            </tr>
                            &lt;%&ndash;<tr>
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
                            </tr>&ndash;%&gt;
                        </table>
                    </div>--%><!--此方法用于打印-->
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
                    <%--此方法可以预览，不可以打印，偏大--%>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" onclick="doPrint();">确认打印</button>
                </div>
            </div>
        </div>
    </div>
    <!-- 打印预览区域 结束 -->
    <!-- 实际打印区域 -->
    <div id="print_area" class="hidden">
        <div id="page1" style="width: 70mm;height: 50mm">
            <table class="table table-hover" style="font-size: .3cm;">
                <%--<tr style="padding-left: .5cm">--%>
                <tr>
                    <th class="text-center" width="15%" style="padding: 0;margin-left: .5cm">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</th>
                    <td id="print_name" width="85%" style="padding: 0;padding-left:.5cm"></td>
                </tr>
                <%--<tr style="padding-left: .5cm">--%>
                <tr>
                    <th class="text-center" style="padding: 0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</th>
                    <td id="print_sex" style="padding: 0;padding-left:.5cm"></td>
                </tr>
                <%--<tr style="padding-left: .5cm">--%>
                <tr>
                    <th class="text-center" style="padding: 0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;证件号码</th>
                    <td id="print_id" style="padding: 0;padding-left:.5cm"></td>
                </tr>
                <%--<tr>
                    <th class="text-center" style="padding: 0">地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;址</th>
                    <td id="preview_location" style="padding: 0"></td>
                </tr>--%>
                <%--<tr style="padding-left: .5cm">--%>
                <tr>
                    <th class="text-center" style="padding: 0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;来访时间</th>
                    <td id="print_time" style="padding: 0;padding-left:.5cm"></td>
                </tr>
                <%--<tr style="padding-left: .5cm">--%>
                <tr>
                    <th class="text-center" style="padding: 0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;待办业务</th>
                    <td id="print_business" style="padding: 0;padding-left:.5cm"></td>
                </tr>
                <%--<tr style="padding-left: .5cm">--%>
                <tr>
                    <th class="text-center" style="padding: 0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;办事部门</th>
                    <td id="print_depart" style="padding: 0;padding-left:.5cm"></td>
                </tr>
                <%--<tr style="padding-left: .5cm">--%>
                <tr>
                    <th class="text-center" style="padding: 0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;办事人员</th>
                    <td id="print_staff" style="padding: 0;padding-left:.5cm"></td>
                </tr>
                <%--<tr style="padding-left: .5cm">--%>
                <tr>
                    <th class="text-center" style="padding: 0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;办公电话</th>
                    <td id="print_officeTel" style="padding: 0;padding-left:.5cm"></td>
                </tr>
                <%--<tr>
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
                </tr>--%>
            </table>
        </div>
        <!--此方法用于打印-->
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
<script src="<%=path%>/libs/js/checkin/readcard.js"></script>
<!-- get path variable , so that the js file can use it in ajax. -->
<script type="text/javascript">
    var $path = '<%=path%>';
</script>
</body>
</html>