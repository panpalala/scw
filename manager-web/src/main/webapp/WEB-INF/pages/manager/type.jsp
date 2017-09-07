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

input[type=checkbox] {
	width: 18px;
	height: 18px;
}
</style>
</head>

<body>
	<%
		pageContext.setAttribute("barInfo", "分类管理");
	%>
	<%@include file="/WEB-INF/includes/manager_navigate_bar.jsp"%>
	<div class="container-fluid">
		<div class="row">
			<%@include file="/WEB-INF/includes/user_menu.jsp"%>
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="glyphicon glyphicon-th"></i> 数据矩阵
						</h3>
					</div>
					<div class="panel-body">
						<div class="table-responsive">
							<table class="table  table-bordered">
								<thead>
									<tr>
										<th>名称</th>
										<c:forEach items="${types }" var="type">
											<c:choose>
												<c:when test="${type == 1 }">
													<th>商业公司</th>
												</c:when>
												<c:when test="${type == 2 }">
													<th>个体工商户</th>
												</c:when>
												<c:when test="${type == 3 }">
													<th>个人经营</th>
												</c:when>
												<c:when test="${type == 4 }">
													<th>政府及非营利组织</th>
												</c:when>
											</c:choose>
										</c:forEach>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${certs }" var="cert">
										<tr>
											<td>${cert.name }</td>
											<c:forEach items="${types }" var="type">
												<td><input c_id="${cert.id }" t_id="${type }" class="cert_type_checkbox" type="checkbox"></td>
											</c:forEach>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@include file="/WEB-INF/includes/commons_js.jsp"%>
	<script type="text/javascript">
		//点击角色维护后，权限管理菜单打开，并显示红色字体
		$(function() {
			$("a[href='${App_path}/category/manager']").parents("ul:hidden")
					.show();
			$("a[href='${App_path}/category/manager']").css("color", "red");
		});
		
		$(function(){
			//页面加载完成，查询所有账户拥有的资质，然后页面回显
			$.get("${App_path}/typecert/json",function(data){
				$.each(data,function(){
					$("tbody .cert_type_checkbox[c_id='" + this.certid + "'][t_id='" + this.accttype + "']").prop("checked",true);
				});
			});
			
			//为所有的复选框绑定单击事件
			$("tbody .cert_type_checkbox").click(function(){
				//判断被点击的单选框是否是选中状态，选中为保存，未选中为删除
				var action = $(this).prop("checked");
				if(action){
					$.get("${App_path}/save/accountCerts",{accttype:$(this).attr("t_id"),certid:$(this).attr("c_id")})
					 .done(function(data){
						layer.msg(data.msg);
					 }).fail(function(e){
						 layer.msg("网络异常");
					 });
				}else{
					$.get("${App_path}/delete/accountCerts",{accttype:$(this).attr("t_id"),certid:$(this).attr("c_id")})
					 .done(function(data){
						layer.msg(data.msg);
					 }).fail(function(e){
						layer.msg("网络异常");
					 });
				}
			});
		});
	</script>
</body>
</html>
