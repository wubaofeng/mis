<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>


<!-- Mirrored from www.gzsxt.cn/theme/hplus/table_basic.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:20:01 GMT -->
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>办公系统 - 基础表格</title>
    <meta name="keywords" content="办公系统">
    <meta name="description" content="办公系统">

    <link rel="shortcut icon" href="favicon.ico">
    <link href="${pageContext.request.contextPath}/css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/animate.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.min862f.css?v=4.1.0" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/plugins/select/bootstrap-select.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/plugins/zTreeStyle/zTreeStyle.css" rel="stylesheet">

</head>

<body class="gray-bg">
<div class="wrapper2 wrapper-content2 animated fadeInRight">
    <div class="row">
        <div class="col-sm-5">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>添加角色</h5>
                </div>
                <div class="ibox-content">
                    <form class="form-horizontal" id="form2" action="${pageContext.request.contextPath}/role/add">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">角色名称：</label>
                            <input type="hidden" name="roleid">
                            <input type="hidden" name="sids">
                            <div class="col-sm-8">
                                <input type="text" name="rolename" class="form-control">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">角色描述：</label>

                            <div class="col-sm-8">
                                <input type="text" name="roledis" class="form-control">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">角色权限：</label>

                            <div class="col-sm-8">
                                <ul id="treeDemo" class="ztree"></ul>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">是否启用：</label>
                            <div class="col-sm-8">
                                <div class="switch">
                                    <div>
                                        <input type="radio" id="status1" checked name="status" value="1">是
                                        <input type="radio" id="status2" name="status" value="0">否
                                        <%--<label class="onoffswitch-label" for="status">
                                            <span class="onoffswitch-inner"></span>
                                            <span class="onoffswitch-switch"></span>
                                        </label>--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-3 col-sm-8">
                                <button class="btn btn-sm btn-white" onclick="add()" type="button"><i
                                        class="fa fa-save"></i> 保存
                                </button>
                                <button class="btn btn-sm btn-white" type="button"><i class="fa fa-undo"></i> 重置
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-sm-7">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>角色列表 <small>点击修改信息将显示在左边表单</small></h5>
                </div>
                <div class="ibox-content">
                    <div class="hr-line-dashed2"></div>
                    <div class="row">
                        <div class="table-responsive">
                            <table class="table table-striped list-table">
                                <thead>
                                <tr>
                                    <th>选择</th>
                                    <th>角色名称</th>
                                    <th>角色描述：</th>
                                    <th>是否启用</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody id="addTr">
                                </tbody>
                            </table>
                        </div>
                        <div class="row">
                            <div class="col-sm-5">
                                <button class="btn btn-sm btn-primary" onclick="selectAll(this)" type="button"><i
                                        id="a1" class="fa fa-check-square-o"></i> 全选
                                </button>
                                <button class="btn btn-sm btn-primary" onclick="revSelect(this)" type="button"><i
                                        id="a2" class="fa fa-square-o"></i> 反选
                                </button>
                                <button class="btn btn-sm btn-primary" onclick="delSelected()" type="button"><i
                                        class="fa fa-times-circle-o"></i> 删除
                                </button>
                            </div>
                            <div class="col-sm-7 text-right">
                                <div class="btn-group" id="addPage">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

</div>
<script src="${pageContext.request.contextPath}/js/jquery.min.js?v=2.1.4"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js?v=3.3.6"></script>
<script src="${pageContext.request.contextPath}/js/plugins/select/bootstrap-select.min.js"></script>
<script src="${pageContext.request.contextPath}/js/plugins/sweetalert/sweetalert.min.js"></script>
<script src="${pageContext.request.contextPath}/js/plugins/ztree/jquery.ztree.core.js"></script>
<script src="${pageContext.request.contextPath}/js/plugins/ztree/jquery.ztree.excheck.js"></script>
<script src="${pageContext.request.contextPath}/js/plugins/ztree/jquery.ztree.exedit.js"></script>

<script>
    $(function () {
        toPage(1, 3);
        showAllSources();
    });

    function toPage(pageNum, pageSize) {
        $.getJSON("${pageContext.request.contextPath}/role/page",
            {"pageNum": pageNum, "pageSize": pageSize},
            function (data) {
                $("#addTr").empty();
                $("#addPage").empty();
                $.each(data.list, function (index, item) {
                    let $tr = '<tr>\n' +
                        '<td><input type="checkbox" name="ids" value="' + item.roleid + '" checked=""></td>\n' +
                        '<td>' + item.rolename + '</td>\n' +
                        '<td>' + item.roledis + '</td>\n' +
                        '<td>' + (item.status == 1 ? "是" : "否") + '</td>\n' +
                        '<td>\n' +
                        '<a href="javaScript:toedit(' + item.roleid + ')"><i class="glyphicon glyphicon-edit  text-navy"></i></a>\n' +
                        '<a href="javaScript:del(' + item.roleid + ')" class="btndel"><i class="glyphicon glyphicon-remove text-navy"></i></a>\n' +
                        '</td>\n' +
                        '</tr>';
                    $("#addTr").append($tr);
                });
                let $page = '<span>共有' + data.pages + '页,当前是第' + data.pageNum + '页</span>\n' +
                    '<a href="javaScript:toPage(1,3)">首页</a>\n' +
                    '<a href="javaScript:toPage(' + (data.pageNum != 1 ? data.pageNum - 1 : 1) + ',3)">上一页</a>\n' +
                    '<a href="javaScript:toPage(' + (data.pageNum != data.pages ? data.pageNum + 1 : data.pages) + ',3)">下一页</a>\n' +
                    '<a href="javaScript:toPage(' + data.pages + ',3)">尾页</a>';
                $("#addPage").append($page);
            });
    }

    function showAllSources() {
        let setting = {
            check: {
                enable: true
            },
            async: {
                enable: true,
                url: "${pageContext.request.contextPath}/sources/ztreeSources",
                autoParam: ["id", "name"]
            }
        }
        $.fn.zTree.init($("#treeDemo"), setting);
    }

    function add() {
        let treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        let nodes = treeObj.getCheckedNodes(true);
        if (nodes.length == 0) {
            swal("错误", "至少要为角色分配一个资源", "error");
            return;
        }
        let ids = new Array();
        for (let i = 0; i < nodes.length; i++) {
            ids[i] = nodes[i].id;
        }
        $("input[name='sids']").val(ids);
        $.getJSON($("#form2").attr("action"), $("#form2").serialize(), function (data) {
            if (data.status == 200) {
                swal("成功！", data.msg, "success");
                setTimeout(function () {
                    location.reload();
                }, 2000);
            } else {
                swal("失败!", data.msg, "error");
            }
        })
    }

    function toedit(roleid) {
        $.getJSON("${pageContext.request.contextPath}/role/toEdit", {"roleid": roleid}, function (data) {
            $("#form2").attr("action", "${pageContext.request.contextPath}/role/edit");
            $("input[name='roleid']").val(data.role.roleid);
            $("input[name='rolename']").val(data.role.rolename);
            $("input[name='roledis']").val(data.role.roledis);
            $("#treeDemo").empty();
            let setting = {
                check: {
                    enable: true
                },
                async: {
                    enable: true,
                    url: "${pageContext.request.contextPath}/sources/ztreeSources",
                    autoParam: ["id", "name"]
                },
                callback: {
                    onAsyncSuccess: function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
                        let treeObj = $.fn.zTree.getZTreeObj("treeDemo");
                        $.each(data.sources, function (index, item) {
                            let node = treeObj.getNodeByParam("id", item.id, null);
                            treeObj.checkNode(node, true);
                        })
                    }
                }
            }
            $.fn.zTree.init($("#treeDemo"), setting);
            if (data.role.status == 0) {
                $("#status1").removeProp("checked");
                $("#status2").prop("checked", "checked");
            } else {
                $("#status2").removeProp("checked");
                $("#status1").prop("checked", "checked");
            }
        })
    }

    function del(id) {
        swal({
            title: "您确定要删除该角色吗？",
            text: "删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.getJSON("${pageContext.request.contextPath}/role/del", {"roleid": id}, function (data) {
                if (data.status == 200) {
                    swal("成功", data.msg, "success");
                    setTimeout(function () {
                        location.reload();
                    }, 2000);
                } else {
                    swal("失败", data.msg, "error");
                }
            })
        });
    }

    function selectAll(iNode) {
        if ($("#a1").attr("class") == "fa fa-check-square-o") {
            $("#a1").removeClass();
            $("#a1").addClass("fa fa-square-o");
            $("input[name='ids']").prop("checked", false);
        } else {
            $("#a1").removeClass();
            $("#a1").addClass("fa fa-check-square-o");
            $("input[name='ids']").prop("checked", true);
        }
    }

    function revSelect(iNode) {
        let nodes = $("input[name='ids']");
        for (let i = 0; i < nodes.length; i++) {
            nodes[i].checked = !nodes[i].checked;
        }
    }

    function delSelected() {
        let nodes = $("input[name='ids']:checked");
        if (nodes.length == 0) {
            swal("必须选中至少一个!");
        } else {
            swal({
                title: "您确定要删除这些角色吗？",
                text: "删除后将无法恢复，请谨慎操作！",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "删除",
                closeOnConfirm: false
            }, function () {
                let ids = new Array();
                for (let i = 0; i < nodes.length; i++) {
                    ids[i] = $(nodes[i]).val();
                }
                $.getJSON("${pageContext.request.contextPath}/role/delList", {"ids": ids.join()}, function (data) {
                    if (data.status == 200) {
                        swal("成功", data.msg, "success");
                        setTimeout(function () {
                            location.reload();
                        }, 2000);
                    } else {
                        swal("失败", data.msg, "error");
                    }
                })
            });
        }
    }
</script>

</body>


</html>
    
