<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="UTF-8">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<%@include file="/WEB-INF/includes/commons_css.jsp" %>
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	table tbody tr:nth-child(odd){background:#F4F4F4;}
	table tbody td:nth-child(even){color:#C00;}
	</style>
  </head>

  <body>
  	<!-- 引入后台页面的导航条 -->
  	<%
  		pageContext.setAttribute("barInfo", "用户维护");
  	%>
	<%@include file="/WEB-INF/includes/manager_navigate_bar.jsp" %>
	
    <div class="container-fluid">
      <div class="row">
		<!-- 引入控制面板菜单 -->
		<%@include file="/WEB-INF/includes/user_menu.jsp" %>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
			<div class="panel panel-default">
			  <div class="panel-heading">
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
			  </div>
			  <div class="panel-body">
			<form class="form-inline" role="form" style="float:left;">
			  <div class="form-group has-feedback">
			    <div class="input-group">
			      <div class="input-group-addon">查 条件</div>
			      <input id="condition" class="form-control has-success" type="text" placeholder="请输入查询条件">
			    </div>
			  </div>
			  <button type="button" class="btn btn-warning" id="queryUsersByCondition"><i class="glyphicon glyphicon-search" ></i> 查询</button>
			</form>
				<button type="button" class="btn btn-danger" style="float:right;margin-left:10px;" id="deleteBatchBtn"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
				<button type="button" class="btn btn-primary" style="float:right;" id="addUserBtn" ><i class="glyphicon glyphicon-plus"></i> 新增</button>
			<br>
			 <hr style="clear:both;">
          <div class="table-responsive">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30" >ID</th>
				  <th width="30" ><input id="checkboxheader" type="checkbox"></th>
                  <th >账号</th>
                  <th >名称</th>
                  <th >邮箱地址</th>
                  <th width="100" >操作</th>
                </tr>
              </thead>
              <tbody>
               	<!-- 数据要显示的位置 -->
              </tbody>
			  <tfoot>
			  	 <tr >
 		   			<td colspan="6" align="center">
 						<ul class="pagination">
						  	<!-- 分页条显示的位置 -->
 						</ul>
 					</td>
 				 </tr>	
			  </tfoot>
            </table>
          </div>
			  </div>
			</div>
        </div>
      </div>
    </div>
	<!-- 设置模态框，用于增加和更改元素时，为用户提供的输入框 -->
	<!-- 用户信息新增和修改Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header" align="center">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">新增用户</h4>
	      </div>
	      <div class="modal-body">
			<form id="userForm" method="post" role="form" class="form-signin" action="${App_path }/addUser">
			  <div class="form-group">
				<label for="exampleInputPassword1">登陆账号</label>
				<input type="text" class="form-control" id="loginacct_in" name="loginacct" placeholder="请输入登陆账号">
			  </div>
			  <div class="form-group">
				<label for="exampleInputPassword1">用户名称</label>
				<input type="text" class="form-control" id="username_in" name="username" placeholder="请输入用户名称">
			  </div>
			  <div class="form-group">
				<label for="exampleInputEmail1">邮箱地址</label>
				<input type="email" class="form-control" id="email_in" name="email" placeholder="请输入邮箱地址">
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
			  <button id="resetBtn" type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
	          <button id="saveBtn" type="button" class="btn btn-primary"><i class="glyphicon glyphicon-ok"></i> 保存</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- 用户分配权限用的模态框modal -->
	<div class="modal fade" id="assignRoleModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header" align="center">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">分配角色</h4>
	      </div>
	      <div class="modal-body" align="center">
			<form id="roleForm" role="form" class="form-inline">
			  <div class="form-group">
				<label for="exampleInputPassword1">未分配角色列表</label><br>
				<select id="noAssignRoles" class="form-control" multiple size="10" style="width:200px;overflow-y:auto;">
					<!-- 未分配的角色 -->
                </select>
			  </div>
			  <div class="form-group">
                 <ul>
                     <li id="addroles" class="btn btn-default glyphicon glyphicon-chevron-right"></li>
                     <br>
                     <li id="delroles" class="btn btn-default glyphicon glyphicon-chevron-left" style="margin-top:20px;"></li>
                 </ul>
			  </div>
			  <div class="form-group" style="margin-left:40px;">
				<label for="exampleInputPassword1">已分配角色列表</label><br>
				<select id="userRoles" class="form-control" multiple size="10" style="width:200px;overflow-y:auto;">
                    <!-- 已分配角色 -->
                </select>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	      </div>
	    </div>
	  </div>
	</div>
	
	
   <%@include file="/WEB-INF/includes/commons_js.jsp" %>
        <script type="text/javascript">
        	//定义一个全局变量，用来保存加载器的索引值
        	var index;
            //在main.jsp页面点击子菜单，去user.jsp页面，让父菜单展开，被点击的子菜单以红色显示
            $(function(){
	            $("a[href='${App_path}/user/maintain']").parents("ul:hidden").show();
	            $("a[href='${App_path}/user/maintain']").css("color","red");
            }); 
            
            //发送ajax请求从服务器拿数据，并将数据显示在页面
            $(function(){
            	getAllUsers(1);
            });
            
			//发送异步请求，它执行的过程不影响后面的方法执行，不必等待异步请求完成
            function getAllUsers(pageNum){
            	//获取数据加载的索引
            	index = layer.load();
            	$.ajax({
            		url:"${App_path}/user/json",
            		data:"pageNum=" + pageNum,
            		dataType:"json",
            		success:function(data){
            			//处理返回的数据
            			buildData(data);
            			//数据加载完成按索引关闭
            			layer.close(index);
            		}
            	});
            }
			
			//按条件查询
			$(function(){
				$("#queryUsersByCondition").click(function(){
					//点击查询，发送ajax请求
					$.post("${App_path}/queryByCondition",{condition:$("#condition").val()}).done(function(users){
						//查出符合条件的数据，用此方法构建内容和分页条
						buildData(users);
						//为查询页面显示的分页条重新绑定事件
						$(".pagination").on("click","li",function(){
							//让能点击按钮发送请求
							 if(!$(this).hasClass("disabled")){
								 //弹出加载效果
								 index = layer.load();
								 $.get("${App_path}/queryByCondition",{pageNum:$(this).attr("num"),condition:$("#condition").val()}).done(function(data){
									 //为此时的分页条内容发送ajax请求
									 buildData(data);
									 //关闭加载效果
									 layer.close(index);
								 });
							 }
				         });
					});
				});
			});
			
			
			
            
            //分别构建出数据行和分页条
            function buildData(data){
            	buildTr(data);
            	buildPages(data);
            }
            
            function buildTr(data){
            	//将tbody里面的所有数据，包括标签都清空，避免每次翻页后数据总是在页面填充
            	$("tbody").empty();
            	$.each(data.list,function(){
            		//创建行标签
            		var tr = $("<tr></tr>");
            		//创建容纳行尾操作按钮的格子td
            		var btnTd = $("<td></td>");
            		btnTd.append(" <button type='button' uid='" + this.id + "' id='assignRole' class='btn btn-success btn-xs'><i class=' glyphicon glyphicon-check'></i></button>")
            			 .append(" ")
            		     .append("<button type='button' uid='" + this.id + "' id='updateUserBtn' class='btn btn-primary btn-xs'><i class=' glyphicon glyphicon-pencil'></i></button>")
            		     .append(" ")
            		     .append("<button type='button' username='" + this.username + "' uid='" + this.id + "' id='deleteUserBtn' class='btn btn-danger btn-xs'><i class=' glyphicon glyphicon-remove'></i></button>");
            		tr.append("<td>" + this.id + "</td>")
            		  .append(" <td><input uid='" + this.id + "' type='checkbox'></td>")
            		  .append("<td>" + this.loginacct + "</td>")
            		  .append("<td>" + this.username + "</td>")
            		  .append("<td>" + this.email + "</td>")
            		  .append(btnTd);
            		$("tbody").append(tr);
            	});
            }
            

            //为分页条内容绑定单击事件，由于分页条是页面加载时后加进去的，在源代码中找不到被点击的选项，所以应该用on来绑定
            $(".pagination").on("click","li",function(){
            	//判断当前被电击的li标签是否存在disabled属性，不存在属性才发请求，预防禁用后还可以点击的问题
            	if(!$(this).hasClass("disabled")){
            		$("#checkboxheader").prop("checked",false);
	            	getAllUsers($(this).attr("num"));
            	}
            });
            
            
            $(function(){
	            //为新增按钮绑定单击事件，用来触发模态框
            	$("#addUserBtn").click(function(){
            		//弹出模态框前重置表单数据
            		$("#userForm")[0].reset();
            		//显示重置按钮
            		$("#resetBtn").show();
            		$("#myModalLabel").text("新增用户");
            		//给保存按钮加一个属性，用来标识它是新增的保存
            		$("#saveBtn").attr("action","add");
            		//让登录帐号恢复可点击属性
            		$("#loginacct_in").prop("disabled",false);
            		$("#myModal").modal({
            			backdrop:false,
            			show:true
            		});
            	});
	            
	            function showRoles(userId){
	            	//在弹出分配角色框之前，先将清空模态框
	            	$("#noAssignRoles").empty();
	            	$("#userRoles").empty();
	            	$.get("${App_path}/showRolesOfUser",{uid:userId})
	            	 .done(function(data){
	            		 //将用户id保存到增加/删除角色的按钮上
	            		 $("#addroles").attr("userid",userId);
	            		 $("#delroles").attr("userid",userId);
	            		 $.each(data.allRoles,function(){
	            			 $("#noAssignRoles").append("<option roleid='" + this.id + "'>" + this.name + "</option>");
	            		 });
	            		 $.each(data.userRoles,function(){
	            			$("#userRoles").append("<option roleid='" + this.id + "'>" + this.name + "</option>");
	            			//从所有角色中删除用户已经选择的角色就是用户未选中的
	            			$("#noAssignRoles option[roleid='" + this.id + "']").remove();
	            		 });
	            		 //两次循环效率太低，所以没有上面的方法效率高
// 	            		 $.each(data.allRoles,function(){
// 							var role = this;
// 							$("#userRoles option").each(function(){
// 								//role为javabean对象，this为dom对象，要取得属性值得包装成jquery对象
// 								if(role.id != $(this).attr("roleid")){
// 						            $("#noAssignRoles").append("<option roleid='" + role.id + "'>" + role.name + "</option>");
// 								}
// 							});
// 	            		 });
	            	 }).fail(function(e){
	            		 layer.msg("网络异常，请联系管理员");
	            	 });
	            	$("#assignRoleModal").modal({
	            		backdrop:"static",
	            		show:true
	            	});
	            }
	            
	            //分配角色按钮
	            $("tbody").on("click","#assignRole",function(){
	            	var userId = $(this).attr("uid");
	            	//发请求获取要显示的角色信息
	            	 showRoles(userId);
	            });
	            
	            $("#addroles").click(function(){
	            	var roleids = "";
	            	var selectedRoles = $("#noAssignRoles :selected");
	            	selectedRoles.each(function(){
	            		roleids += $(this).attr("roleid") + ",";
	            	});
	            	$.post("${App_path}/addroles",{userid:$(this).attr("userid"),rids:roleids})
	            	 .done(function(data){
	            		 selectedRoles.appendTo($("#userRoles"));
	            		 layer.msg("添加成功");
	            	 }).fail(function(e){
	            	 });
	            });
	            
	            $("#delroles").click(function(){
	            	var roleids = "";
	            	var selectedRoles = $("#userRoles :selected");
	            	selectedRoles.each(function(){
	            		roleids += $(this).attr("roleid") + ",";
	            	});
	            	$.post("${App_path}/delroles",{userid:$(this).attr("userid"),rids:roleids})
	            	 .done(function(data){
	            		 selectedRoles.appendTo($("#noAssignRoles"));
	            		 layer.msg("删除成功");
	            	 }).fail(function(e){
	            	 });
	            });
	            
	            //为修改按钮绑定单击事件,用on来绑定事件，必须先找到一个页面已经存在的元素，然后在on中的第二个参数传入未来加进去的标签，为其绑定事件
	            $("tbody").on("click","#updateUserBtn",function(){
	            	$("#resetBtn").css("display","none");
	            	//给保存按钮加一个属性，用来标识它是修改的保存
	            	$("#saveBtn").attr("action","update");
	            	$("#myModalLabel").text("修改用户");
	            	//带着用户的id值去数据库查询用户信息用于回显,另外一种办法是在页面直接拿值过来，但是麻烦，列表顺序变动会影响找值
	            	$.post("${App_path}/getUserbyId",{id:$(this).attr("uid")},function(data){
	            		//点击修改，弹出模态框回显数据，并且改变登录帐号不可修改
	            		//设置输入框的值用val
	            		$("#loginacct_in").val(data.loginacct);
	            		//设置原生属性值要用prop
	            		$("#loginacct_in").prop("disabled",true);
// 	            		$("#loginacct_in").addClass("disabled");这里addClass不起作用
	            		$("#username_in").val(data.username);
	            		$("#email_in").val(data.email);
	            		//给保存按钮加上用户id，让其能知道修改那一个的信息
	            		$("#saveBtn").attr("uid",data.id);
	            	});
	            	
	            	$("#myModal").modal({
            			backdrop:false,
            			show:true
            		});
	            });
	            
	            //单个删除，为其绑定单击事件，因为此按钮也是构造加入其中的，所以绑定事件需要用jquery的on方法
	            $("tbody").on("click","#deleteUserBtn",function(){
	            	//保存用户id用于发送请求时做参数
	            	var uid = $(this).attr("uid");
	            	index = layer.confirm("确认删除 【" + $(this).attr("username") + "】 吗？",{btn:["确定","取消"]},
	            							function(){
	            								layer.close(index);
								            	$.get("${App_path}/deleteUser",{id:uid}).done(function(data){
								            		layer.msg(data.msg);
								            		//删除完成，提示信息，刷新当前页面
								            		getAllUsers($("li.active").attr("num"));
								            	}).fail(function(e){
								            		layer.msg(e + "网络异常，请检查网络");
								            	});
	            							},
	            							function(){
	            								layer.close(index);
	            							});
	            });
	            
	       
	            //全选全不选效果
	            $("#checkboxheader").click(function(){
	            	$("tbody :checkbox").prop("checked",$(this).prop("checked"));
	            });
	            //基本选择器，:前面没有空格，有空格是找后代的
	            $("tbody").on("click",":checkbox",function(){
	            	$("#checkboxheader").prop("checked",
	            								$("tbody :checkbox").length == $("tbody :checkbox:checked").length
	            							  );
	            });
	            
	            //批量删除
	            $("#deleteBatchBtn").click(function(){
	            	index = layer.confirm("确认删除这" + $("tbody :checkbox:checked").length + "位用户吗？",function(){
	            							layer.close(index);
						            		var args = "";
							            	$.each($("tbody :checkbox:checked"),function(){
							            		args += $(this).attr("uid") + ",";
							            	});
							            	$.post("${App_path}/deleteBatchUsers",{ids:args}).done(function(data){
							            		layer.msg(data.msg);
							            		getAllUsers($("li.active").attr("num"));
							            	}).fail(function(e){
							            		layer.msg(e + "网络异常，请检查网络");
							            	});
						            	},
						            	function(){
						            		layer.close(index);
						            	});
	            	
	            });
            });
            
            
         
            $(function(){
            	//重置数据
            	$("#resetBtn").click(function(){
	            	$("#userForm")[0].reset();
            	});
            	//为保存按钮绑定单击事件，触发ajax请求携带数据到服务器，serialize()及将表单的所有参数序列化，  //拼成字符串，done/fail是成功或失败的回调函数
            	$("#saveBtn").click(function(){
            		if($(this).attr("action") == "add"){
	            		$.post("${App_path}/addUser",$("#userForm").serialize()).done(function(data){
	            			if(data.code == 1){
	            				//保存弹出框的索引值，便于用户点击完成后关闭弹出框
	            				//弹出框的四个参数，1为确认参数，2为按钮显示的信息34都是依次对应按钮的回调函数
	            				index = layer.confirm(data.msg + ",是否继续新增用户？", {btn:["是","否"]},
	            								function(){
	            									$("#userForm")[0].reset();
	            									layer.close(index);
	            								},
	            								function(){
	            									$("#myModal").modal("hide");
	            									getAllUsers(1111111);
	            								});
	            				
	            			}
	            			if(data.code == 0){
	            				layer.msg(data.msg + ",请联系管理员！");
	            			} 
	            		});
            		}
            		if($(this).attr("action") == "update"){
            			$.post("${App_path}/updateUser",$("#userForm").serialize() + "&id=" + $(this).attr("uid")).done(function(data){
							layer.msg(data.msg);
							//保存完成刷新到当前页
							getAllUsers($("li.active").attr("num"));
	            			$("#myModal").modal("hide");
	            		});
            		}
            	});
            });
        </script>
  </body>
</html>
