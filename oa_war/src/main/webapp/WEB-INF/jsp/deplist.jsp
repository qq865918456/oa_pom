<%--
  Created by IntelliJ IDEA.
  User: xwfha
  Date: 2018/8/29
  Time: 15:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <base href="${pageContext.request.contextPath}/"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>部门管理</title>
    <!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
    <!-- Reset Stylesheet -->
    <link rel="stylesheet" href="resources/css/reset.css" type="text/css"
          media="screen"/>
    <!-- Main Stylesheet -->
    <link rel="stylesheet" href="resources/css/style.css" type="text/css"
          media="screen"/>
    <link rel="stylesheet" href="resources/css/invalid.css" type="text/css" media="screen"/>

    <!--                       Javascripts                       -->
    <!-- jQuery -->
    <script type="text/javascript" src="resources/scripts/jquery-1.8.3.min.js"></script>
    <!-- jQuery Configuration -->
    <script type="text/javascript" src="resources/scripts/simpla.jquery.configuration.js"></script>
    <!-- 引入dialog的js -->
    <link rel="stylesheet" href="//apps.bdimg.com/libs/jqueryui/1.10.4/css/jquery-ui.min.css">
    <script type="text/javascript" src="resources/widget/dialog/jquery-ui-1.9.2.custom.min.js"></script>
    <!-- 时间控件 -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/widget/My97DatePicker/WdatePicker.js"></script>
    <!-- ztree树形结构 -->
    <link rel="stylesheet" href="resources/widget/zTree/zTreeStyle/zTreeStyle.css">
    <script type="text/javascript" src="resources/widget/zTree/jquery.ztree.all.min.js"></script>
    <script type="text/javascript">
        function openDialog(){
            $("#dialog_div").dialog({
                title:"新增部门",
                width:600,
                height:500,
                modal:true
            });
        }

        function query_deps_ajax() {
            $.ajax({
               url:"${pageContext.request.contextPath}/dep/queryDep",
                success:function (data) {
                    var settings = {
                        data:{
                            key:{
                                name:"dname"
                            },
                            simpleData:{
                                enable:true,//启用简单json模式
                                pIdKey:"pid"
                            }
                        },
                        view:{
                            showIcon:false//隐藏图标
                        },
                        callback:{
                            onClick:function(event, treeId, treeNode){
                                //ztree点击事件 treeNode - 代表当前被点击的节点json对象
                                $("#select_pdep_id").html(treeNode.dname);
                                $("#pid").val(treeNode.id);
                                //关闭弹出框
                                $("#ztree_dialog").dialog("close");
                            }
                        }
                    };
                    var zNodes = data;
                    var ele = $("#ztree");

                    //初始化ztree
                    var ztreeObject = $.fn.zTree.init(ele, settings, zNodes);
                    ztreeObject.expandAll(true);

                    //弹出dialog
                    $("#ztree_dialog").dialog({
                        title:"选择父部门",
                        width:300,
                        height:200,
                        modal:false
                    });
                },
                dataType:"json"
            });
        }
    </script>



</head>
<body>
<div id="main-content">
    <div class="content-box">
        <!-- End .content-box-header -->
        <div class="content-box-content">
            <div class="tab-content default-tab" id="tab1">
                <h1>部门管理</h1>
                <table>
                    <thead>
                    <tr>
                        <th><input class="check-all" type="checkbox"/></th>
                        <th>编号</th>
                        <th>部门名称</th>
                        <th>所属父部门</th>
                        <th>部门描述</th>
                        <th>创建时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <%--表格中间内容--%>
                    <tbody>
                    <c:forEach items="${deps}" var="dep">
                        <tr>
                            <td><input type="checkbox"/></td>
                            <td>${dep.id}</td>
                            <td>${dep.dname}</td>
                            <td>${dep.parent.dname!=null?dep.parent.dname:'无'}</td>
                            <td>${dep.dinfo}</td>
                            <td><fmt:formatDate value="${dep.createtime}" pattern="yyyy-MM-dd" /></td>
                            <td>
                                <!-- Icons --> <a href="#" title="Edit">
                                <img src="resources/images/icons/pencil.png" alt="Edit"/></a>
                                <a href="${pageContext.request.contextPath}/dep/delete/${dep.id}" title="Delete"><img src="resources/images/icons/cross.png" alt="Delete"/></a>
                                <a href="#" title="Edit Meta"><img src="resources/images/icons/hammer_screwdriver.png" alt="Edit Meta"/></a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                    <%--表格尾部--%>
                    <tfoot>
                    <tr>
                        <td colspan="6">
                            <div class="bulk-actions align-left">
                                <a class="mybutton" onclick="openDialog();">新增部门</a>
                            </div>
                            <%--<div class="pagination">
                                <a href="#" title="First Page">&laquo; First</a>
                                <a href="#" title="Previous Page">&laquo;Previous</a>
                                <a href="#" class="number" title="1">1</a>
                                <a href="#" class="number" title="2">2</a>
                                <a href="#" class="number current" title="3">3</a>
                                <a href="#" class="number" title="4">4</a>
                                <a href="#" title="Next Page">Next &raquo;</a>
                                <a href="#" title="Last Page">Last &raquo;</a>
                            </div>--%> <!-- End .pagination -->

                            <%--分页导航--%>
                            <%@ include file="page.jsp"%>
                            <div class="clear"></div>
                        </td>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
        <!-- End .content-box-content -->
    </div>
</div>
<!-- End #main-content -->

<div id="dialog_div" style="display: none">
    <form action="${pageContext.request.contextPath}/dep/insert" method="post">
        <fieldset>
            <!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
            <p>
                <label>部门名称</label>
                <input class="text-input small-input" type="text" id="dname_id" name="dname" />
            </p>
            <p>
                <label>选择父部门</label>
                <button id="select_pdep_id" class="mybutton" type="button" onclick="query_deps_ajax();">无</button>
                <input type="hidden" id="pid" name="pid" value="-1"/>
            </p>
            <p>
                <label>部门描述</label>
                <textarea class="text-input textarea wysiwyg" id="dinfo_id" name="dinfo" cols="79" rows="15"></textarea>
            </p>
            <p>
                <label>成立时间</label>
                <input class="text-input small-input Wdate" type="text" id="createtime_id" name="createtime" onclick="WdatePicker()"/>
            </p>
            <p>
                <input class="mybutton" type="submit" value="提交" />
            </p>
        </fieldset>
        <div class="clear"></div>
        <!-- End .clear -->
    </form>
</div>

<!-- 树形结构的弹出框 -->
<div id="ztree_dialog" style="display: none;">
    <div id="ztree" class="ztree"></div>
</div>
</body>
</html>
