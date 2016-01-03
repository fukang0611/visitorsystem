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
            <div id="toolbar">
                <button id="addDepart" class="btn btn-info">
                    <i class="glyphicon glyphicon-plus"></i> 新增部门
                </button>
                <button id="removeDepart" class="btn btn-danger" disabled>
                    <i class="glyphicon glyphicon-remove"></i> 删除部门
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
                   data-url="<%=path%>/depart/departList.do"
                   data-response-handler="responseHandler">
            </table>
            <!-- 表格主体 结束 -->
            <!-- 新增部门模态框 -->
            <div class="modal fade" id="addDepartModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">新增部门信息</h4>
                        </div>
                        <div class="modal-body">
                            <form class="form-horizontal" id="addform" action="<%=path%>/depart/addDepart.do">
                                <div class="form-group">
                                    <label for="code" class="col-sm-2 control-label">部门代码</label>

                                    <div class="col-sm-10">
                                        <input id="code" name="code" type="text" class="form-control"
                                               placeholder="部门代码">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="name" class="col-sm-2 control-label">部门名称</label>

                                    <div class="col-sm-10">
                                        <input id="name" name="name" type="text" class="form-control"
                                               placeholder="部门名称">
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="button" class="btn btn-primary" onclick="addDepart();">确认</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 新增部门模态框 结束 -->
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
    var $remove = $('#removeDepart');
    var $add = $('#addDepart');
    var selections = [];

    // 页面加载完成后执行
    $(function () {
        initTable(); // 初始化表格
    });

    // 初始化表格
    function initTable() {

        // 表格结构
        $table.bootstrapTable({
            // 常规属性在html标签中设置
            height: getHeight(),
            columns: [
                [
                    {
                        field: 'state',
                        checkbox: true,
                        align: 'center',
                        valign: 'middle'
                    },
                    {
                        title: '部门代码',
                        field: 'code',
                        align: 'center',
                        valign: 'middle',
                        sortable: true
                    },
                    {
                        title: '部门名称',
                        field: 'name',
                        align: 'center',
                        valign: 'middle',
                        sortable: true
                    },
                    {
                        field: 'operate',
                        title: '操作',
                        align: 'center',
                        formatter: operateFormatter
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

        // 有勾选数据时删除按钮可用
        $table.on('check.bs.table uncheck.bs.table check-all.bs.table uncheck-all.bs.table', function () {
            $remove.prop('disabled', !$table.bootstrapTable('getSelections').length);
            selections = getIdSelections();
        });

        // 批量删除部门
        $remove.click(function () {
            delDepart();
        });

        // 新增部门
        $add.click(function () {
            $('#addDepartModal').modal('show');
        });

        // 当调整浏览器窗口的大小时，重置表格尺寸
        $(window).resize(function () {
            $table.bootstrapTable('resetView', {
                height: getHeight()
            });
        });
    }

    // 得到勾选ids
    function getIdSelections() {
        return $.map($table.bootstrapTable('getSelections'), function (row) {
            return row.id;
        });
    }

    // 服务器响应处理
    function responseHandler(res) {
        // 遍历返回数据的rows
        $.each(res.rows, function (i, row) {
            // $.inArray( value,array ) 得到value在array中的index,若没有则返回 -1
            // 此处:根据checked数组将已勾选rows的state赋值true,未勾选则false
            row.state = $.inArray(row.id, selections) !== -1;
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

    // 操作列按钮
    function operateFormatter(value, row, index) {
        return [
            '<a class="like" href="javascript:editDepart(\'' + row.id + '\')" title="修改信息">',
            '<i class="glyphicon glyphicon-pencil"></i>',
            '</a>&nbsp;&nbsp;',
            '<a class="remove" href="javascript:delDepart(\'' + row.id + '\')" title="删除部门">',
            '<i class="glyphicon glyphicon-remove"></i>',
            '</a>'
        ].join('');
    }

    // 删除部门
    function delDepart(id) {
        var ids = id ? id : getIdSelections();
        $.post("<%=path%>/depart/delDepartByIds.do?ids=" + ids, function (result) {
            if (result == "success") {
                $table.bootstrapTable('remove', {
                    field: 'id',
                    values: ids
                });
                $remove.prop('disabled', true);
            } else {
                alert(result);
            }
        }, "json");
    }

    // 编辑部门
    function editDepart(id) {
        $.post("<%=path%>/depart/editDepart.do?id=" + id, function () {

        })
    }

    // 新增部门
    function addDepart() {
        var $addform = $("#addform");
        $.post($addform.attr("action"), $addform.serialize(), function (result) {
            $("#table").refresh();
            $('#addDepartModal').modal('hide');
        })
    }

    // 得到高度
    function getHeight() {
//        return $(window).height() - $('h1').outerHeight(true);
        return $(window).height();
    }

</script>
</body>
</html>