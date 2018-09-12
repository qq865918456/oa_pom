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

    <!-- webuploader的上传控件 -->
    <link rel="stylesheet" href="resources/widget/webuploader/webuploader.css">
    <script type="text/javascript" src="resources/widget/webuploader/webuploader.min.js"></script>
    <script type="text/javascript">
        function openDialog(){
            //弹出添加职工的弹出框
                //清空弹出框的内容
                $("#hiddenid").val("");

                //处理照片
                $("#header").attr("src", "resources/images/icons/header.jpg");

                //职工姓名
                $("#name_id").val("");

                //邮箱
                $("#email_id").val("");

                //密码
                $("#password_id").val("");

                //性别
                $("input[name='sex'][value='1']").attr("checked","checked");

                //电话
                $("#phone_id").val("");
                //所属部门
                //<input type="button" value="xx"/>
                //<button>xxxxx</button>
                $("#select_dep_id").html("无");
                $("#did").val("");
                //个人简介
                $("#einfo_id").val("");
                //通过js将时间进行转换
                //生日
                $("#birthday_id").val("");
                //入职时间
                $("#entrytime_id").val("");

            $("#dialog_div").dialog({
                title:"新增员工",
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
                                $("#did").val(treeNode.id);
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

        function query_emps(eid) {
            $.get("${pageContext.request.contextPath}/emp/queryById",{eid:eid},function (data) {

                $("#hiddenid").val(data.id);//id

                //处理照片
                if(data.image != null && data.image != ""){
                    $("#header").attr("src", "${pageContext.request.contextPath}/img/getImg?path=" + data.image);
                    $("#image").val(data.image);
                } else {
                    $("#header").attr("src", "resources/images/icons/header.jpg")
                }

                //职工姓名
                $("#name_id").val(data.name);

                //邮箱
                $("#email_id").val(data.email);

                //密码
                $("#password_id").val(data.password);

                //性别
                $("input[name='sex'][value='" + data.sex + "']").attr("checked","checked");

                //电话
                $("#phone_id").val(data.phone);

                //所属部门
                //<input type="button" value="xx"/>
                //<button>xxxxx</button>
                $("#select_dep_id").html(data.did);
                $("#did").val(data.did);


                //个人简介
                $("#einfo_id").val(data.einfo);


                //通过js将时间进行转换
                var birthday = new Date(data.birthday);
                //生日
                $("#birthday_id").val(birthday.getFullYear() + "-" + (birthday.getMonth() + 1) + "-" + birthday.getDate());

                //入职时间
                var entrytime = new Date(data.entrytime);
                $("#entrytime_id").val(entrytime.getFullYear() + "-" + (entrytime.getMonth() + 1) + "-" + entrytime.getDate());

                //弹出dialog
                $("#dialog_div").dialog({
                    title:"修改职工",
                    width:600,
                    height:500,
                    modal:true
                });
            },"json");
        }

        function open_roles_dialog(eid) {

            $("#myeid").val(eid);

            $.get("${pageContext.request.contextPath}/role/queryall",{eid:eid},function (data) {
                var html = "<ul>";
                for (var i = 0; i < data.length; i++) {
                    html += "<li>";
                    if(data[i].isHave){
                        html += "<input type='checkbox' name='rid' value='"+data[i].id+"' checked />"
                    }else{
                        html += "<input type='checkbox' name='rid' value='"+data[i].id+"'/>";
                    }
                    html += data[i].rolename;
                    html += "</li>";
                }
                html += "</ul>";

                $("#role_list").html(html);

                $("#role_list2").dialog({
                    title:"选择角色",
                    width:300,
                    height:200,
                    modal:true
                })

            },"json");


        }

    </script>



</head>
<body>
<div id="main-content">
    <div class="content-box">
        <!-- End .content-box-header -->
        <div class="content-box-content">
            <div class="tab-content default-tab" id="tab1">
                <h1>员工管理</h1>
                <table>
                    <thead>
                    <tr>
                        <th><input class="check-all" type="checkbox"/></th>
                        <th>编号</th>
                        <th>姓名</th>
                        <th>照片</th>
                        <th>性别</th>
                        <th>所属部门</th>
                        <th>生日</th>
                        <th>入职时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <%--表格中间内容--%>
                    <tbody>
                    <c:forEach items="${emps}" var="emp">
                        <tr>
                            <td><input type="checkbox"/></td>
                            <td>${emp.id}</td>
                            <td>${emp.name}</td>
                            <th>
                                <c:if test="${emp.image == null}">
                                    <img src="resources/images/icons/header.jpg" width="100">
                                </c:if>
                                <c:if test="${emp.image != null}">
                                    <img src="${pageContext.request.contextPath}/img/getImg?path=${emp.image}" width="100" height="90">
                                </c:if>
                            </th>
                            <td>${emp.sex == 1 ? '男':'女'}</td>
                            <td>${emp.did}</td>
                            <td><fmt:formatDate value="${emp.birthday}" pattern="yyyy-MM-dd" /></td>
                            <td><fmt:formatDate value="${emp.entrytime}" pattern="yyyy-MM-dd" /></td>
                            <td>
                                <!-- Icons -->
                                <a title="Edit" onclick="query_emps(${emp.id});">
                                <img src="resources/images/icons/pencil.png" alt="Edit"/></a>
                                <a href="#" title="Delete"><img src="resources/images/icons/cross.png" alt="Delete"/></a>
                                <a onclick="open_roles_dialog(${emp.id});" title="Edit Meta"><img src="resources/images/icons/hammer_screwdriver.png" alt="Edit Meta"/></a>
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
    <form action="${pageContext.request.contextPath}/emp/insert" method="post">
        <fieldset>
            <!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
            <input type="hidden" id="hiddenid" name="id" value="" />
            <p>
                <label>照片</label>

                <img id="header" src="resources/images/icons/header.jpg" width="100"/>
                <input type="hidden" id="image" name="image" value=""/>

            <div id="filePicker">选择图片</div>
            </p>
            <p>
                <label>员工名称</label>
                <input class="text-input small-input" type="text" id="name_id" name="name" />
            </p>
            <p>
                <label>邮箱</label>
                <input class="text-input small-input" type="text" id="email_id" name="email" />
            </p>
            <p>
                <label>密码</label>
                <input class="text-input small-input" type="text" id="password_id" name="password" />
            </p>
            <p>
                <label>性别</label>
                <input class="text-input small-input" type="radio" name="sex" value="1" checked/>男 <br />
                <input class="text-input small-input" type="radio"  name="sex" value="0" checked/>女 <br />
            </p>
            <p>
                <label>电话</label>
                <input class="text-input small-input" type="text" id="phone_id" name="phone" />
            </p>
            <p>
                <label>选择部门</label>
                <button id="select_pdep_id" class="mybutton" type="button" onclick="query_deps_ajax();">无</button>
                <input type="hidden" id="did" name="did" value="-1"/>
            </p>
            <p>
                <label>个人简介</label>
                <textarea class="text-input textarea wysiwyg" id="einfo_id" name="einfo" cols="79" rows="15"></textarea>
            </p>
            <p>
                <label>生日</label>
                <input class="text-input small-input Wdate" type="text" id="birthday_id" name="birthday" onclick="WdatePicker()"/>
            </p>
            <p>
                <label>入职时间</label>
                <input class="text-input small-input Wdate" type="text" id="entrytime_id" name="entrytime" onclick="WdatePicker()"/>
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

<%--通过员工id查询到对应角色的div--%>
<div id="role_list2" style="display: none;">
    <form action="${pageContext.request.contextPath}/role/selectroles" method="post">
        <%--职工id的隐藏域--%>
        <input type="hidden" name="eid"  id="myeid" value="" />
        <div id="role_list"></div>
        <button class="mybutton" type="submit">提交</button>
    </form>
</div>

<script type="text/javascript">
    uploader = WebUploader.create({
        // 选完文件后，是否自动上传。
        auto: true,
        // swf文件路径
        swf: '${pageContext.request.contextPath}/resources/widget/webuploader/Uploader.swf',
        // 文件接收服务端。
        server: '${pageContext.request.contextPath}/img/upload',
        // 选择文件的按钮。可选。
        // 内部根据当前运行是创建，可能是input元素，也可能是flash.
        pick: '#filePicker'
    });

    //处理上传文件的缩略图
    uploader.on('fileQueued', function(file){
        //生成缩略图，并且显示到指定的位置
        //显示头像的控件
        var img = $("#header");

        // 创建缩略图
        // 如果为非图片文件，可以不用调用此方法。
        // thumbnailWidth x thumbnailHeight 为 100 x 100
        uploader.makeThumb( file, function( error, src ) {
            if ( error ) {
                return;
            }

            img.attr( 'src', src );
        }, 100, 100 );
    });

    //图片上传成功之后的回调
    uploader.on('uploadSuccess', function(file, response){
        $("#image").val(response.fileuploader);
    });

    uploader.on('error', function(type){
        //文件上传失败！！！！
    });

</script>

</body>
</html>
