<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%String path = request.getContextPath();%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <!-- Bootstrap框架必需配置 -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>今日来访</title>
    <!-- Bootstrap 样式 -->
    <link href="<%=path%>/libs/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="all">
    <!-- Bootstrap 表格 -->
    <link rel="stylesheet" href="<%=path%>/libs/bootstrap/css/bootstrap-table.min.css">
</head>
<body>
<!-- 页面主体 -->
<div class="container-fluid">
    <!-- 页面主体栅格布局 -->
    <div class="row">
        <!-- 主体内容 -->
        <div class="main">
            <!-- 表格工具栏 -->
            <div id="toolbar" hidden>
                <button id="addDepart" class="btn btn-info">
                    <i class="glyphicon glyphicon-plus"></i> 增加
                </button>
                <button id="removeDepart" class="btn btn-danger">
                    <i class="glyphicon glyphicon-remove"></i> 删除
                </button>
            </div>
            <!-- 表格主体 -->
            <table id="table"
                   data-toolbar="#toolbar"
                   data-search="true"
                   data-show-refresh="true"
                   data-show-toggle="true"
                   data-show-columns="true"
                   data-detail-view="true"
                   data-detail-formatter="detailFormatter"
                   data-pagination="true"
                   data-id-field="id"
                   data-page-list="[10, 25, 50, 100]"
                   data-show-footer="false"
                   data-side-pagination="server"
                   data-url="<%=path%>/record/today.do"
                   data-response-handler="responseHandler">
            </table>
            <!-- 表格主体 结束 -->
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
<!-- Bootstrap 表格 -->
<script src="<%=path%>/libs/bootstrap/js/bootstrap-table.min.js"></script>
<script src="<%=path%>/libs/bootstrap/js/bootstrap-table-zh-CN.min.js"></script>
<!-- javascript functions -->
<script type="text/javascript">

    // 表格操作全局变量
    var $table = $('#table');
    var selections = [];

    // 页面加载完成后执行
    $(function () {
        initTable(); // 初始化表格
    });

    // 初始化表格
    function initTable() {

        // 表格结构
        $table.bootstrapTable({
            height: getHeight(),
            columns: [
                [
                    {
                        title: '序号',
                        field: 'no',
                        align: 'center',
                        valign: 'middle'
                    },
                    {
                        title: '来访人员',
                        field: 'visitorName',
                        align: 'center',
                        valign: 'middle'
                    },
                    {
                        title: '证件号码',
                        field: 'cardNo',
                        align: 'center',
                        valign: 'middle'
                    },
                    {
                        title: '所办业务',
                        field: 'business',
                        align: 'center',
                        valign: 'middle',
                        sortable: true
                    },
                    {
                        title: '办事人员',
                        field: 'staff',
                        align: 'center',
                        valign: 'middle',
                        sortable: true
                    },
                    {
                        title: '来访时间',
                        field: 'visitDate',
                        align: 'center',
                        valign: 'middle'
                    },
                    {
                        title: '反馈意见',
                        field: 'feedback',
                        align: 'center',
                        valign: 'middle'
                    }
                ]
            ]
        });

        // 展开详情
        $table.on('expand-row.bs.table', function (e, index, row, $detail) {
            // 可以异步获取详情,默认会加载当前行数据所有字段
            /* $.get('url', function (res) {
             $detail.html(res.replace(/\n/g, '<br>'));
             });*/
        });

        // 当调整浏览器窗口的大小时，重置表格尺寸
        $(window).resize(function () {
            $table.bootstrapTable('resetView', {
                height: getHeight()
            });
        });
    }

    // 服务器响应处理
    function responseHandler(res) {
        // 遍历返回数据的rows
        $.each(res.rows, function (i, row) {
            // $.inArray( value,array ) 得到value在array中的index,若没有则返回 -1
            // 此处:根据checked数组将已勾选rows的state赋值true,未勾选则false
            // row.state = $.inArray(row.id, selections) !== -1;
            row.visitorName = row.visitor.name;
            row.cardNo = row.visitor.id;
            row.visitDate = row.visitDate.substring(11);
            row.no = i + 1;
        });
        return res;
    }

    // 展开详情
    function detailFormatter(index, row) {
        var html = [];
        $.each(row, function (key, value) {
            html.push('<p><b>' + key + ':</b> ' + value + '</p>');
        });
        return html.join('');
    }

    // 得到高度
    function getHeight() {
//        return $(window).height() - $('h1').outerHeight(true);
        return $(window).height();
    }

</script>
</body>
</html>