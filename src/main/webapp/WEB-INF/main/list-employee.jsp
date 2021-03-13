<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>


<!-- Mirrored from www.gzsxt.cn/theme/hplus/table_basic.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:20:01 GMT -->
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>绿地中央广场综合物业办公系统 - 基础表格</title>
    <meta name="keywords" content="综合办公系统">
    <meta name="description" content="综合办公系统">

    <link rel="shortcut icon" href="favicon.ico">
    <link href="${pageContext.request.contextPath}/css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/animate.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.min862f.css?v=4.1.0" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/plugins/select/bootstrap-select.min.css" rel="stylesheet">

</head>

<body class="gray-bg">
<div class="wrapper2 wrapper-content2 animated fadeInRight">
    <div class="ibox float-e-margins">
        <div class="ibox-content">
            <div class="row">
                <div class="col-sm-3 col-sm-offset-2 text-right">
                    <h3><small>搜索条件:</small></h3>
                </div>
                <div class="col-sm-2">
                    <select name="typeid" class="selectpicker form-control">
                        <option value="0">选择类型</option>
                        <option value="1">部门名称</option>
                        <option value="2">员工姓名</option>
                    </select>
                </div>

                <div class="col-sm-3">
                    <div class="input-group">
                        <input type="text" name="search" placeholder="请输入关键词" class="input-sm form-control">
                        <span class="input-group-btn">
                                        <button type="button" onclick="empPage(1,5)" class="btn btn-sm btn-primary"><i
                                                class="fa fa-search"></i>搜索</button>
                                    </span>
                    </div>
                </div>
                <div class="col-sm-2 text-right">
                    <a href="${pageContext.request.contextPath}/emp/forward/save-employee"
                       class="btn btn-sm btn-primary" type="button"><i
                            class="fa fa-plus-circle"></i> 添加员工</a>
                </div>
            </div>
            <div class="hr-line-dashed2"></div>
            <div class="table-responsive">
                <table class="table table-striped list-table">
                    <thead>
                    <tr>
                        <th>选择</th>
                        <th>序号</th>
                        <th>姓名</th>
                        <th>部门</th>
                        <th>性别</th>
                        <th>联系电话</th>
                        <th>入职时间</th>
                        <th>备注</th>
                        <th class="text-center">操作</th>
                    </tr>
                    </thead>
                    <tbody id="addTr">

                    </tbody>
                </table>
            </div>

            <div class="row">
                <div class="col-sm-5">
                    <button class="btn btn-sm btn-primary" type="button"><i class="fa fa-check-square-o"></i> 全选
                    </button>
                    <button class="btn btn-sm btn-primary" type="button"><i class="fa fa-square-o"></i> 反选</button>
                    <button class="btn btn-sm btn-primary" type="button"><i class="fa fa-times-circle-o"></i> 删除
                    </button>
                    <button id="demo1" class="btn btn-sm btn-primary" type="button"><i class="fa fa-table"></i> 导出Excel
                    </button>
                </div>
                <div id="addPage" class="col-sm-7 text-right">
                </div>
            </div>

        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/jquery.min.js?v=2.1.4"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js?v=3.3.6"></script>
<script src="${pageContext.request.contextPath}/js/plugins/select/bootstrap-select.min.js"></script>
<script src="${pageContext.request.contextPath}/js/plugins/sweetalert/sweetalert.min.js"></script>
<script>
    $(function () {
        empPage(1, 5);
    });

    function empPage(pageNum, pageSize) {
        let typeid = $("select[name='typeid'] option:selected").val();
        let search = $("input[name='search']").val();
        $.getJSON("${pageContext.request.contextPath}/emp/page",
            {"pageNum": pageNum, "pageSize": pageSize, "typeid": typeid, "search": search},
            function (data) {
                $("#addTr").empty();
                $("#addPage").empty();
                $.each(data.list, function (index, item) {
                    let tr = '<tr>\n' +
                        '<td><input type="checkbox" value="' + item.eid + '"></td>\n' +
                        '<td>' + (index + 1) + '</td>\n' +
                        '<td>' + item.ename + '</td>\n' +
                        '<td>' + item.dept.dname + '</td>\n' +
                        '<td>' + item.esex + '</td>\n' +
                        '<td>' + item.telephone + '</td>\n' +
                        '<td>' + item.hiredate + '</td>\n' +
                        '<td>' + item.remark + '</td>\n' +
                        '<td class="text-right">\n' +
                        '\t<a href="${pageContext.request.contextPath}/emp/toEdit?eid=' + item.eid + '" class="btn btn-primary btn-xs"><i class="fa fa-edit"></i>编辑</a>\n' +
                        '\t<button class="btn btn-danger btn-xs btndel"><i class="fa fa-close"></i>删除</button>\n' +
                        '</td>\n' +
                        '</tr>';
                    $("#addTr").append(tr);
                })
                let page = '<span>共有' + data.pages + '页,当前是第' + data.pageNum + '页</span>\n' +
                    '<a href="javaScript:empPage(1,5)">首页</a>\n' +
                    '<a href="javaScript:empPage(' + (data.pageNUm == 1 ? data.pageNum - 1 : 1) + ',5)">上一页</a>\n' +
                    '<a href="javaScript:empPage(' + (data.pageNUm == data.pages ? data.pageNum + 1 : data.pages) + ',5)">下一页</a>\n' +
                    '<a href="javaScript:empPage(' + data.pages + ',5)">尾页</a>';
                $("#addPage").append(page);
            })
    }

</script>

</body>


</html>
    