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
    <link href="${pageContext.request.contextPath}/css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/animate.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.min862f.css?v=4.1.0" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/plugins/select/bootstrap-select.min.css"
          rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/plugins/zTreeStyle/zTreeStyle.css"/>

</head>

<body class="gray-bg">
<div class="wrapper2 wrapper-content2 animated fadeInRight">
    <div class="row">
        <div class="col-sm-6">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>资源管理</h5>
                </div>
                <div class="ibox-content">
                    <div class="zTreeDemoBackground left" style="font-size: 16px">
                        <ul id="treeDemo" class="ztree"></ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-6">
            <divclass
            ="ibox float-e-margins">
            <div class="ibox-title">
                <h5 id="h5">资源添加</h5>
            </div>
            <div class="ibox-content">
                <form id="form2" action="${pageContext.request.contextPath}/sources/add" class="form-horizontal">

                    <div class="form-group">
                        <label class="col-sm-4 control-label">菜单资源名称：</label>

                        <div class="col-sm-7">
                            <input type="email" name="name" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">父菜单：</label>

                        <div class="col-sm-7">
                            <select name="pid" class="form-control">
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">菜单资源路径：</label>

                        <div class="col-sm-7">
                            <input type="text" name="url" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">备注：</label>
                        <div class="col-sm-7">
                            <textarea class="form-control" name="remark" id="remark"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-8">
                            <button class="btn btn-sm btn-white" type="button" onclick="add()">
                                <i class="fa fa-save"></i> 保存
                            </button>
                            <button class="btn btn-sm btn-white" type="button">
                                <i class="fa fa-undo"></i> 重置
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

</div>

</div>
<script src="${pageContext.request.contextPath}/js/jquery.min.js?v=2.1.4"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js?v=3.3.6"></script>
<script src="${pageContext.request.contextPath}/js/plugins/select/bootstrap-select.min.js"></script>
<script src="${pageContext.request.contextPath}/js/plugins/sweetalert/sweetalert.min.js"></script>
<script src="${pageContext.request.contextPath}/js/plugins/ztree/jquery.ztree.core.min.js"></script>
<script src="${pageContext.request.contextPath}/js/plugins/ztree/jquery.ztree.exedit.js"></script>
<script>
    $(function () {
        $.getJSON("${pageContext.request.contextPath}/sources/superSources", function (data) {
            $.each(data, function (index, item) {
                $("select[name='pid']").append("<option value='" + item.id + "'>" + item.name + "</option>");
            })
        });

        ztree();
    })

    function add() {
        $.post($("#form2").attr("action"), $("#form2").serialize(), function (data) {
            if (data.status == 200) {
                swal("成功！", data.msg, "success");
                setTimeout(function () {
                    location.reload();
                }, 2000);
            } else {
                swal("失败!", data.msg, "error");
            }
        });
    }

    function ztree() {
        let setting = {
            async: {
                enable: true,
                url: "${pageContext.request.contextPath}/sources/ztreeSources",
                autoParam: ["id", "name"]
            },
            view: {
                addHoverDom: function (treeId, treeNode) {
                    let aObj = $("#" + treeNode.tId + "_a");
                    if (treeNode.editNameFlag || $("#bntGroup" + treeNode.tId).length > 0) {
                        return;
                    }
                    let s = '<span id="bntGroup' + treeNode.tId + '">';
                    // 判断是否是二级节点
                    if (treeNode.level == 1) {
                        // 添加修改按钮
                        s += '<span class="button edit" onclick="toedit(' + treeNode.id + ')"></span>';
                        // 添加删除按钮
                        if (treeNode.children.length == 0) {
                            s += '<span class="button remove" onclick="del(' + treeNode.id + ')"></span>';
                        }
                    }
                    // 判断是否是三级节点
                    if (treeNode.level == 2) {
                        // 添加修改按钮
                        s += '<span class="button edit" onclick="toedit(' + treeNode.id + ')"></span>';
                        // 添加删除按钮
                        s += '<span class="button remove" onclick="del(' + treeNode.id + ')"></span>';
                    }
                    s += '</span>';
                    aObj.append(s);
                },
                removeHoverDom: function (treeId, treeNode) {
                    $("#bntGroup" + treeNode.tId).remove();
                }
            }
        };
        $.fn.zTree.init($("#treeDemo"), setting);
    }

    function toedit(sourcesId) {
        $.getJSON("${pageContext.request.contextPath}/sources/toEdit", {"id": sourcesId}, function (data) {
            $("#h5").html("资源修改");
            $("#form2").attr("action", "${pageContext.request.contextPath}/sources/edit");
            $("#form2").append('<input type="hidden" name="id" value="' + sourcesId + '">');
            $("input[name='name']").val(data.name);
            let $select = $("select option");
            for (let i = 0; i < $select.length; i++) {
                if ($($select[i]).val() == data.pid) {
                    $($select[i]).prop("selected", true);
                } else {
                    $($select[i]).removeProp("selected");
                }
            }
            $("input[name='url']").val(data.url);
            $("#remark").html(data.remark);
        })
    }

    function del(sourceId) {
        swal({
            title: "您确定要删除该资源吗？",
            text: "删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("${pageContext.request.contextPath}/sources/del", {"sourcesId": sourceId}, function (data) {
                if (data.status == 200) {
                    swal("成功", data.msg, "success");
                    setTimeout(function () {
                        location.reload();
                    }, 2000);
                } else {
                    swal("失败!", data.msg, "error");
                }
            });
        });
    }
</script>
</body>
</html>
