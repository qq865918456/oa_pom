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

        function openDialog() {
            $("#dialog_div").dialog({
               title:"新增权限",
                width:600,
                height:500,
                modal:true
            });
        }

        function select_fresc_resc() {
            //查询出所有权限
            //dialog弹出权限
            $.get("${pageContext.request.contextPath}/resc/queryall",function (data) {
                debugger
                var settings = {
                    //设置数据展示的区域  key为显示的内容
                    //simpleDate为id和pid的模式
                    data:{
                      key:{
                          name:"rname"
                      },
                        simpleData: {
                            enable: true,   //启用简单json模式
                            pIdKey: "pid"
                        }
                    },
                    view:{
                        showIcon:false
                    },
                    callback:{
                        //回调内容  首先是点击事件
                        onClick:function (event,treeId,treeNode) {
                            //ztree点击事件 treeNode - 代表当前被点击的节点json对象
                            //将按钮的内容修改为当前选中的权限内容
                            $("#select_fresc_id").html(treeNode.rname);
                            //将选择权限的id设置到隐藏域之中
                            $("#pid_id").val(treeNode.id);
                            //关闭弹出框
                            $("#ztree_dialog_div").dialog("close");
                        },
                        beforeClick:function (treeId,treeNode) {
                            if(treeNode.rstate == 1){
                                $("#rstate_id").html("二级权限");
                                $("#rstate_id_hidden").val(2);
                            } else if(treeNode.rstate == 2){
                                $("#rstate_id").html("三级权限");
                                $("#rstate_id_hidden").val(3);
                            } else if(treeNode.rstate == 3){
                                alert("三级权限下不能再有子权限！！！");
                                return false;
                            }
                            return true;
                            
                        }
                    }
                };
                var zNodes = data;
                var ele = $("#ztree");

                //初始化ztree
                var ztreeObject = $.fn.zTree.init(ele, settings, zNodes);
                ztreeObject.expandAll(true);    //expandFlag = true 表示 展开 全部节点

                //弹出框
                $("#ztree_dialog_div").dialog({
                    title:"选择父权限",
                    width:300,
                    height:200,
                    modal:false
                });
            },"json")
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
                        <th>父权限id</th>
                        <th>权限名称</th>
                        <th>权限路径</th>
                        <th>权限描述</th>
                        <th>权限状态</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <%--表格中间内容--%>
                    <tbody>
                    <c:forEach items="${rescs}" var="resc">
                        <tr>
                            <td><input type="checkbox"/></td>
                            <td>${resc.id}</td>
                            <td>${resc.pid}</td>
                            <td>${resc.rname}</td>
                            <td>${resc.rpath}</td>
                            <td>${resc.rdesc}</td>
                            <td>${resc.rstate}</td>
                            <td>
                                <!-- Icons --> <a href="#" title="Edit">
                                <img src="resources/images/icons/pencil.png" alt="Edit"/></a>
                                <a href="#" title="Delete"><img src="resources/images/icons/cross.png" alt="Delete"/></a>
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
                                <a class="mybutton" onclick="openDialog();">新增权限</a>
                            </div>
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
    <form action="${pageContext.request.contextPath}/resc/insert" method="post">
        <fieldset>
            <!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
            <p>
                <label>权限名称</label>
                <input class="text-input small-input" type="text" id="resc_id" name="rname" />
            </p>
            <p>
                <label>选择父权限</label>
                <button type="button" id="select_fresc_id" class="mybutton" onclick="select_fresc_resc();">无</button>
                <input type="hidden" id="pid_id" name="pid" value="-1">
            </p>
            <p>
                <label>权限路径</label>
                <input class="text-input small-input" type="text" id="rpath_id" name="rpath" />
            </p>
            <p>
                <label>权限描述</label>
                <textarea rows="12" cols="60" class="text-input textarea wysiwyg" id="rdesc_id"
                          name="rdesc"></textarea>
            </p>
            <p>
                <label>权限类型</label>
                <span id="rstate_id">一级权限</span>
                <input id="rstate_id_hidden" type="hidden" name="rstate" value="1"/>
            </p>

            <p>
                <input class="mybutton" type="submit" value="提交" />
            </p>
        </fieldset>
    </form>
</div>

    <div id="ztree_dialog_div" style="display: none">
        <div id="ztree"></div>
    </div>
</body>
</html>
