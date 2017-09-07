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

<%@include file="/WEB-INF/includes/commons_css.jsp"%>
<style>
.tree li {
	list-style-type: none;
	cursor: pointer;
}

table tbody tr:nth-child(odd) {
	background: #F4F4F4;
}

table tbody td:nth-child(even) {
	color: #C00;
}
</style>
</head>
<body>
	<%
		pageContext.setAttribute("barInfo", "角色维护");
	%>
	<!-- 管理页面导航条 -->
	<%@include file="/WEB-INF/includes/manager_navigate_bar.jsp"%>
	<div class="container-fluid">
		<div class="row">
			<!-- 用户菜单 -->
			<%@include file="/WEB-INF/includes/user_menu.jsp"%>
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="glyphicon glyphicon-th"></i> 数据列表
						</h3>
					</div>
					<div class="panel-body">
						<form class="form-inline" role="form" style="float: left;">
							<div class="form-group has-feedback">
								<div class="input-group">
									<div class="input-group-addon">查询条件</div>
									<input class="form-control has-success" type="text"
										placeholder="请输入查询条件">
								</div>
							</div>
							<button type="button" class="btn btn-warning">
								<i class="glyphicon glyphicon-search"></i> 查询
							</button>
						</form>
						<button id="delBacthRoles" type="button" class="btn btn-danger"
							style="float: right; margin-left: 10px;">
							<i class=" glyphicon glyphicon-remove"></i> 删除
						</button>
						<!-- 为按钮绑定模态框，按钮会以跳转地址优先，绑定不了模态框 -->
						<button id="addRole" type="button" class="btn btn-primary"
							style="float: right;">
							<i class="glyphicon glyphicon-plus"></i> 新增
						</button>
						<br>
						<hr style="clear: both;">
						<div class="table-responsive">
							<table class="table  table-bordered">
								<thead>
									<tr>
										<th width="30">ID</th>
										<th width="30"><input id="check_roles" type="checkbox"></th>
										<th>名称</th>
										<th width="100">操作</th>
									</tr>
								</thead>
								<tbody>
									<!-- 放置角色数据 -->
								</tbody>
								<tfoot>
									<tr>
										<td colspan="4" align="center">
											<ul class="pagination">
												<!-- 分页条 -->
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
	<!-- 模态框，用于添加和修改角色 -->
	<div class="modal fade" id="roleModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header" align="center">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">新增角色</h4>
	      </div>
	      <div id="roleInfo" class="modal-body">
			  <div class="form-group">
				<label for="exampleInputPassword1">格式：XX-角色名&nbsp;例如：PM-项目经理</label><br/>
				<input type="text" class="form-control" id="roleName_in" name="name" placeholder="请输入角色信息">
			  </div>
	      </div>
	      <div class="modal-footer">
	          <button id="saveRoleBtn" type="button" class="btn btn-primary"><i class="glyphicon glyphicon-ok"></i> 保存</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- 模态框，用于为角色分配权限 -->
	<div class="modal fade" id="permitModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header" align="center">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">分配许可</h4>
	      </div>
	      <div id="roleInfo" class="modal-body">
			 <!-- 权限树 -->
			 <ul id="permissionTree" class="ztree"></ul>
	      </div>
	      <div class="modal-footer">
	          <button id="saveRolePermissionBtn" type="button" class="btn btn-primary"><i class="glyphicon glyphicon-ok"></i> 保存</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!--引入js代码  -->
	<%@include file="/WEB-INF/includes/commons_js.jsp" %>
	<script type="text/javascript">
		//声明一个全局变量，用来保存加载的索引
		var index;
		//点击角色维护后，权限管理菜单打开，并显示红色字体
		 $(function(){
	         $("a[href='${App_path}/role/maintain']").parents("ul:hidden").show();
	         $("a[href='${App_path}/role/maintain']").css("color","red");
	     });
			
		 //页面加载完成构建页面要显示的内容
		 $(function(){
			getRoles(1); 
		 });
		 
		 function getRoles(pageNum){
			 index = layer.load();
			 $.ajax({
				 url:"${App_path}/role/json",
				 data:"pageNum=" + pageNum,
				 dataType:"json",
				 success:function(roleData){
					 buildData(roleData);
					 layer.close(index);
				 }
			 });
		 }
		 
		 function buildData(roleData){
		     buildTr(roleData);
			 buildPages(roleData);
		 }
		
		 function buildTr(roleData){
			 //清空原来的数据
			 $("tbody").empty();
			 $.each(roleData.list,function(){
				//构建出行和每格的按钮，这必须为jquery对象
				var tr = $("<tr></tr>");
				var tdBtn = $("<td></td>");
				tdBtn.append("<button rid='" + this.id + "' id='assignPermission' type='button' class='btn btn-success btn-xs'><i class='glyphicon glyphicon-check'></i></button>")
					 .append(" ")
				     .append("<button rid='" + this.id + "' id='modify' type='button' class='btn btn-primary btn-xs'><i class='glyphicon glyphicon-pencil'></i></button>")
					 .append(" ")
				     .append("<button rid='" + this.id + "' id='delete' type='button' class='btn btn-danger btn-xs'><i class='glyphicon glyphicon-remove'></i></button>");
				tr.append("<td>" + this.id + "</td>")
				  .append("<td><input rid='" + this.id + "' type='checkbox'></td>")
				  .append("<td>" + this.name + "</td>")
				  .append(tdBtn);
				//将构建好的行加入到表格中
				$("tbody").append(tr);
			 });
		 }
		 
		 //为分页条的所有有效按钮绑定事件
		 $(".pagination").on("click","li",function(){
			if(!$(this).hasClass("disabled")){
				$("#check_roles").prop("checked",false);
				getRoles($(this).attr("num"));
			} 
		 });
		 
			
		 $("#addRole").click(function(){
			//将模态框的输入框内容清空
			$("#roleName_in").val("");
			$("#saveRoleBtn").attr("action","add");
			$("#roleModal").modal({
				backdrop:"static",
				show:true
			});
		 });
	
		 $("#saveRoleBtn").click(function(){
			var roleName = $("#roleName_in").val();
			if($("#saveRoleBtn").attr("action") == "add"){
				$.get("${App_path}/addRole",{name:roleName}).done(function(data){
					layer.msg(data.msg);
					//保存角色成功后，去最后一页
					getRoles(111111);
				}).fail(function(data){
					layer.msg(data.msg);
				});
			}
			if($("#saveRoleBtn").attr("action") == "modify"){
				$.post("${App_path}/modifyRole",{rid:$(this).attr("rid"),name:$("#roleName_in").val()})
				 .done(function(data){
					getRoles($("li.active").attr("num"));
					layer.msg(data.msg);
				 }).fail(function(data){
					layer.msg(data.msg);
				 });
			}
			//关闭模态框
			$("#roleModal").modal("hide");
		 });
		 
		 //批量删除按钮之全选全不选
		 $("#check_roles").click(function(){
			 $("tbody :checkbox").prop("checked",$(this).prop("checked"));
		 });
		 
		 $("tbody").on("click",":checkbox",function(){
			 $("#check_roles").prop("checked",$("tbody :checkbox:checked").length == $("tbody :checkbox").length);
		 });
		 //批量删除
		 $("#delBacthRoles").click(function(){
			 if($("tbody :checkbox:checked").length == 0){
				 layer.msg("请选择要删除的角色！");
				 return false;
			 }
			index = layer.confirm("确认删除这" + $("tbody :checkbox:checked").length + "个角色吗？", {btn:["确认","再想想吧"]},
								function(){
									layer.close(index);
									var rids = "";
									$("tbody :checkbox:checked").each(function(){
										rids += $(this).attr("rid") + ",";
									});
									$.post("${App_path}/delBatchRoles",{roleIds:rids}).done(function(data){
										layer.msg(data.msg);
										//删除完成去当前页 
										getRoles($("li.active").attr("num"));
									}).fail(function(data){
									});
								}, function(){
									layer.close(index);
								});
			
		 });
		 
		 //单个删除
		 $("tbody").on("click","#delete",function(){
			$.get("${App_path}/delBatchRoles",{roleIds:$(this).attr("rid")+""})
			 .done(function(data){
				layer.msg(data.msg);
				getRoles($("li.active").attr("num"));
			 });		
		 });
		 
		 
		//修改角色信息
		 $("tbody").on("click","#modify",function(){
			 $("#saveRoleBtn").attr("rid",$(this).attr("rid"));
		
			 $("#saveRoleBtn").attr("action","modify");
			 $("#myModalLabel").text("修改角色");
			 $.get("${App_path}/getRoleById",{rid:$(this).attr("rid")}).done(function(data){
				 $("#roleName_in").val(data.name);
			 });
			 $("#roleModal").modal({
				backdrop:"static",
				show:true
			 });
		 });
		 
		 //ztree的配置
		 var setting = {
			//设置节点数据为简单数据模式，idkey为父节点，pidkey为子节点；
			data:{
				simpleData:{
					enable:true,
					idKey: "id",
					pIdKey: "pid"
				},
				//阻止节点的跳转，写一个不存在的属性
		 		key:{
		 			url:"panpala"
		 		}
			},
			//设置节点位置是否显示单选框
		 	check:{
		 		enable:true
		 	},
			//显示节点位置的自定义图标
		 	view:{
		 		//showIcon不写()表示对方法的引用，而不是调用
		 		addDiyDom:showIcon
		 	}
		 };
		 
		//每一个节点显示都会调用这个方法；
			//treeId：当前树的id
			//treeNode：当前的这个节点对象
			function showIcon(treeId, treeNode){
				//console.log("treeId=>"+treeId);
				//console.log(treeNode);
				var tid = treeNode.tId;
				//根据tid找到图标的span即可’
				//清样式
				$("#"+tid+"_ico").attr("style","");
				//$("#"+tid+"_ico").removeClass().addClass(treeNode.icon);
				$("#"+tid+"_ico").removeClass().after("<span class='" + treeNode.icon + "'></span>");
				//$("#"+tid+"_ico").after("<span class='" + treeNode.icon + "'></span>");
			}
		 
		 
		 //声明ztree对象
		 var ztreeObject;
		 //分配许可之弹框显示许可树，并回显用户许可权限
		 $(function(){
			 $.ajax({
				 url:"${App_path}/rolejsons",
				 dataType:"json",
				 success:function(data){
					$.each(data,function(){
						if(this.pid == 0){
							//让满足条件的节点处于展开状态
							this.open = true;
						}
					});
					//初始化树，第一个参数表示要初始化的树，第二个参数表示初始化树需要的配置，第三个参数表示填充树中节点的数据
					ztreeObject = $.fn.zTree.init($("#permissionTree"), setting, data);
				 }
			 });
		 });
		 //点击修改权限按钮，弹出模态框
		 $("tbody").on("click","#assignPermission",function(){
			 //在点击分配权限按钮后，将角色的id保存到保存按钮中，以便保存角色权限使用
			 $("#saveRolePermissionBtn").attr("rid",$(this).attr("rid"));
			 //点击分配权限按钮，先将所有勾选项清空，然后再回显角色拥有的权限
			 ztreeObject.checkAllNodes(false);
			 $.get("${App_path}/currentRolePermissions",{rid:$(this).attr("rid")}).done(function(data){
				 $.each(data,function(){
					 //选中id为指定值的节点
					 var node = ztreeObject.getNodeByParam("id", this.id, null);
					 //第一个参数是需要选中的节点，第二个参数表示选中状态，第三个参数表示是否级联勾选
					 ztreeObject.checkNode(node, true, false);
				 });
			 });
			 $("#permitModal").modal({
				 backdrop:"static",
				 show:true
			 });
		 });
		 
		 //分配权限之保存按钮
		 $("#saveRolePermissionBtn").click(function(){
			var roleid = $(this).attr("rid");
			var permissionIds = "";
			$.each(ztreeObject.getCheckedNodes(true),function(){
				permissionIds += this.id + ",";
			});
			$.post("${App_path}/saveRolePermissions",{rid:roleid,pids:permissionIds}).done(function(data){
				layer.msg(data.msg);
			}).fail(function(data){
				layer.msg(data.msg);
			});
			$("#permitModal").modal("hide");
		 });
		 
	</script>
</body>
</html>
