<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%String path = request.getContextPath();%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <!-- Bootstrap框架必需配置 -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>员工管理</title>
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
                <button id="addStaff" class="btn btn-info">
                    <i class="glyphicon glyphicon-plus"></i> 新增员工
                </button>
                <button id="removeStaff" class="btn btn-danger" disabled>
                    <i class="glyphicon glyphicon-remove"></i> 删除员工
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
                   data-url="<%=path%>/staff/staffList.do"
                   data-response-handler="responseHandler">
            </table>
            <!-- 表格主体 结束 -->
            <!-- 新增员工模态框 -->
            <div class="modal fade" id="addStaffModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">新增员工信息</h4>
                        </div>
                        <div class="modal-body">
                            <form class="form-horizontal" id="addform" action="<%=path%>/staff/addStaff.do">
                                <div class="form-group">
                                    <label for="add_name" class="col-sm-2 control-label">员工姓名</label>

                                    <div class="col-sm-10">
                                        <input id="add_name" name="name" type="text" class="form-control"
                                               placeholder="员工姓名">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="add_sex" class="col-sm-2 control-label">员工性别</label>

                                    <div class="col-sm-10">
                                        <input id="add_sex" name="sex" type="text" class="form-control"
                                               placeholder="员工性别">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="add_officeTel" class="col-sm-2 control-label">办公电话</label>

                                    <div class="col-sm-10">
                                        <input id="add_officeTel" name="officeTel" type="text" class="form-control"
                                               placeholder="办公电话">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="add_mobileTel" class="col-sm-2 control-label">手机号码</label>

                                    <div class="col-sm-10">
                                        <input id="add_mobileTel" name="mobileTel" type="text" class="form-control"
                                               placeholder="手机号码">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="add_sortOrder" class="col-sm-2 control-label">员工序号</label>

                                    <div class="col-sm-10">
                                        <input id="add_sortOrder" name="sortOrder" type="text" class="form-control"
                                               placeholder="员工序号">
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="button" class="btn btn-primary" onclick="addStaff();">确认</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 新增员工模态框 结束 -->
            <!-- 修改员工模态框 -->
            <div class="modal fade" id="editStaffModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                            <h4 class="modal-title" id="editModalLabel">编辑员工信息</h4>
                        </div>
                        <div class="modal-body">
                            <form class="form-horizontal" id="editform" action="<%=path%>/staff/doEditStaff.do">
                                <input id="id" name="id" type="hidden"/>

                                <div class="form-group">
                                    <label for="edit_name" class="col-sm-2 control-label">员工姓名</label>

                                    <div class="col-sm-10">
                                        <input id="edit_name" name="name" type="text" class="form-control"
                                               placeholder="员工姓名">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="edit_sex" class="col-sm-2 control-label">员工性别</label>

                                    <div class="col-sm-10">
                                        <input id="edit_sex" name="sex" type="text" class="form-control"
                                               placeholder="员工性别">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="edit_officeTel" class="col-sm-2 control-label">办公电话</label>

                                    <div class="col-sm-10">
                                        <input id="edit_officeTel" name="officeTel" type="text" class="form-control"
                                               placeholder="办公电话">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="edit_mobileTel" class="col-sm-2 control-label">手机号码</label>

                                    <div class="col-sm-10">
                                        <input id="edit_mobileTel" name="mobileTel" type="text" class="form-control"
                                               placeholder="手机号码">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="edit_sortOrder" class="col-sm-2 control-label">员工序号</label>

                                    <div class="col-sm-10">
                                        <input id="edit_sortOrder" name="sortOrder" type="text" class="form-control"
                                               placeholder="员工序号">
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="button" class="btn btn-primary" onclick="doEditStaff();">确认</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 新增员工模态框 结束 -->
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
    var $remove = $('#removeStaff');
    var $add = $('#addStaff');
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
                        title: '员工姓名',
                        field: 'name',
                        align: 'center',
                        valign: 'middle',
                        sortable: true
                    },
                    {
                        title: '员工性别',
                        field: 'sex',
                        align: 'center',
                        valign: 'middle',
                        sortable: true
                    },
                    {
                        title: '办公电话',
                        field: 'officeTel',
                        align: 'center',
                        valign: 'middle'
                    },
                    {
                        title: '手机号码',
                        field: 'mobileTel',
                        align: 'center',
                        valign: 'middle',
                        sortable: true
                    },
                    {
                        title: '员工序号',
                        field: 'sortOrder',
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
            delStaff();
        });

        // 新增部门
        $add.click(function () {
            $('#addStaffModal').modal('show');
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
            '<a class="like" href="javascript:editStaff(\'' + row.id + '\')" title="修改信息">',
            '<i class="glyphicon glyphicon-pencil"></i>',
            '</a>&nbsp;&nbsp;',
            '<a class="remove" href="javascript:delStaff(\'' + row.id + '\')" title="删除人员">',
            '<i class="glyphicon glyphicon-remove"></i>',
            '</a>'
        ].join('');
    }

    // 删除部门
    function delStaff(id) {
        var ids = id ? id : getIdSelections();
        $.post("<%=path%>/staff/delStaffByIds.do?ids=" + ids, function (result) {
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
    function editStaff(id) {
        $.post("<%=path%>/staff/editStaff.do?id=" + id, function (result) {
            if (result.status == "success") {
                var data = result.data;
                $("#id").val(data.id);
                $("#edit_name").val(data.name);
                $("#edit_sex").val(data.sex);
                $("#edit_officeTel").val(data.officeTel);
                $("#edit_mobileTel").val(data.mobileTel);
                $("#edit_sortOrder").val(data.sortOrder);
                $('#editStaffModal').modal('show');
            }
        })
    }

    // 保存编辑
    function doEditStaff() {
        var $editform = $("#editform");
        $.post($editform.attr("action"), $editform.serialize(), function (result) {
            $('#editStaffModal').modal('hide');
            history.go(0);
        })
    }

    // 新增部门
    function addStaff() {
        var $addform = $("#addform");
        $.post($addform.attr("action"), $addform.serialize(), function (result) {
            $('#addStaffModal').modal('hide');
            history.go(0);
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