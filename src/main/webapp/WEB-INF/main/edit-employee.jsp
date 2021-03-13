<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>


<!-- Mirrored from www.gzsxt.cn/theme/hplus/table_basic.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:20:01 GMT -->
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>绿地中央广场综合物业办公系统 - 基础表格</title>
    <meta name="keywords" content="绿地中央广场综合物业办公系统">
    <meta name="description" content="绿地中央广场综合物业办公系统">

    <link rel="shortcut icon" href="favicon.ico">
    <link href="${pageContext.request.contextPath}/css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/animate.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.min862f.css?v=4.1.0" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/plugins/select/bootstrap-select.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer.css"/>
    <link href="${pageContext.request.contextPath}/css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
</head>

<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">

    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>档案管理<small>>修改档案</small></h5>
                </div>
                <div class="ibox-content">
                    <form id="form2" action="${pageContext.request.contextPath}/emp/edit" class="form-horizontal">
                        <input type="hidden" name="eid" value="${map.emp.eid}">
                        <div class="row">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">姓名</label>
                                <div class="col-sm-3">
                                    <input name="ename" type="text" value="${map.emp.ename}"
                                           class="form-control input-sm">
                                </div>
                                <label class="col-sm-2 col-sm-offset-1 control-label">用户名</label>
                                <div class="col-sm-3">
                                    <input name="username " type="text" value="${map.emp.username}"
                                           class="form-control input-sm">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">密码</label>
                                <div class="col-sm-3">
                                    <input name="password" type="password" value="********"
                                           class="form-control input-sm">
                                </div>
                                <label class="col-sm-2 col-sm-offset-1 control-label">性别</label>
                                <div class="col-sm-3">
                                    <select name="esex" class="selectpicker form-control">
                                        <option value="男" ${map.emp.esex eq '男' ? 'selected':''}>男</option>
                                        <option value="女" ${map.emp.esex eq '女' ? 'selected':''}>女</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">身份证号码</label>
                                <div class="col-sm-3">
                                    <input name="pnum" type="text" value="${map.emp.pnum}"
                                           class="form-control input-sm">
                                </div>
                                <label class="col-sm-2 col-sm-offset-1 control-label">联系电话</label>
                                <div class="col-sm-3">
                                    <input name="telephone" type="text" value="${map.emp.telephone}"
                                           class="form-control input-sm">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <label class="col-sm-2 control-label">部门</label>
                            <div class="col-sm-3">
                                <select name="dfk" class="form-control">
                                    <c:forEach items="${map.depts}" var="dept">
                                        <option value="${dept.deptno}" ${dept.deptno == map.emp.dfk ? 'selected' : ''}>${dept.dname}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 col-sm-offset-1 control-label">入职时间</label>
                                <div class="col-sm-3">
                                    <!--时间控件的id都不能改-->
                                    <input name="hiredate" id="start" type="text"
                                           class="laydate-icon form-control layer-date"
                                           value="<fmt:formatDate value="${map.emp.hiredate}" pattern="yyyy-MM-dd"/>">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">年龄</label>
                                    <div class="col-sm-3">
                                        <input name="eage" type="text" value="${map.emp.eage}"
                                               class="form-control input-sm">
                                    </div>
                                    <label class="col-sm-2 col-sm-offset-1 control-label">角色</label>
                                    <div class="col-sm-3" id="roleid">
                                        <c:forEach items="${map.roles}" var="role">
                                            <input type="checkbox" name="roleids" value="${role.roleid}"
                                            <c:forEach items="${map.rs}" var="ro">
                                            <c:if test="${ro.roleid eq role.roleid}">
                                                   checked
                                            </c:if>
                                            </c:forEach>
                                            >${role.rolename}
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">备注</label>
                                <div class="col-sm-9">
                                    <textarea name="remark" class="form-control">${map.emp.remark}</textarea>
                                </div>

                            </div>
                        </div>

                        <div class="row">
                            <div class="hr-line-dashed"></div>
                        </div>

                        <div class="row">
                            <div class="form-group">
                                <div class="col-sm-3 col-sm-offset-3 text-right">
                                    <button type="button" onclick="add()" class="btn btn-primary"><i
                                            class="fa fa-save"></i> 保存内容
                                    </button>
                                </div>
                                <div class="col-sm-3">
                                    <a href="list-employee.jsp" class="btn btn-white"><i class="fa fa-reply"></i> 返回</a>
                                </div>
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
<script src="${pageContext.request.contextPath}/js/plugins/sweetalert/sweetalert.min.js"></script>
<script src="${pageContext.request.contextPath}/js/plugins/select/bootstrap-select.min.js"></script>
<script src="${pageContext.request.contextPath}/js/plugins/layer/laydate/laydate.js"></script>

<script>
    function add() {
        if ($("input[name='roleids']:checked").length == 0) {
            swal("错误", "用户至少要选择一个角色", "error");
            return;
        }
        $.getJSON($("#form2").attr("action"), $("#form2").serialize(), function (data) {
            if (data.status == 200) {
                swal("成功！", data.msg, "success");
                setTimeout(function () {
                    location = "${pageContext.request.contextPath}/emp/forward/list-employee";
                }, 2000);
            } else {
                swal("失败!", data.msg, "error");
            }
        })
    }
</script>
</body>


</html>

