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
		pageContext.setAttribute("barInfo", "流程管理");
	%>
	<%@include file="/WEB-INF/includes/manager_navigate_bar.jsp"%>
	
	<div class="container-fluid">
		<div class="row">
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

						<button type="button" id="upload" class="btn btn-primary"
							style="float: right;">
							<i class="glyphicon glyphicon-upload"></i> 上传流程定义文件
						</button>
						<br>
						<hr style="clear: both;">
						<div class="table-responsive">
							<table class="table  table-bordered">
								<thead>
									<tr>
										<th width="100">流程定义ID</th>
										<th>流程名称</th>
										<th>流程KEY</th>
										<th>流程分类</th>
										<th>流程版本</th>
										<th width="100">操作</th>
									</tr>
								</thead>
								<tbody>
									
								</tbody>
								<tfoot>
									<tr>
										<td colspan="6" align="center">
											<ul class="pagination">
												
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
	
	<!-- 流程文件上传模态框 -->
	<div class="modal fade" id="processModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header" align="center">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">上传流程文件</h4>
	      </div>
	      <div class="modal-body">
			<form id="activitiForm" enctype="multipart/form-data">
			  <div class="form-group">
				<label>选择流程文件</label>
				<input type="file" class="form-control" id="activitiFile" name="activitiFile">
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
			  <button id="uploadBtn" type="button" class="btn btn-primary"><i class="glyphicon glyphicon-arrow-up"></i> 上传</button>
	          <button id="cancelBtn" type="button" class="btn btn-primary"><i class="glyphicon glyphicon-remove"></i> 取消</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- 显示流程图片的模态框 -->
	<div class="modal fade" id="processImg" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header" align="center">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">流程图预览</h4>
	      </div>
	      <div class="modal-body">
			
	      </div>
	      <div class="modal-footer">
	      </div>
	    </div>
	  </div>
	</div>
	
	<%@include file="/WEB-INF/includes/commons_js.jsp"%>
	<script type="text/javascript">
		$(function() {
			$("a[href='${App_path}/activiti/manager']").parents("ul:hidden")
					.show();
			$("a[href='${App_path}/activiti/manager']").css("color", "red");
		});
		
		//点击上传流程文件，弹出模态框
		$("#upload").click(function(){
			$("#processModal").modal({
				backdrop:"static",
				show:true
			});
		});
		
		//为上传按钮绑定单击事件
		$("#uploadBtn").click(function(){
			//获取上传的文件对象
			var file = $("#activitiFile")[0].files[0];
			//console.log(file.name);
			//匹配文件名以.bpmn结尾的文件的正则表达式
			if(file == null){
				layer.msg("请选择要上传的文件！");
				return;
			}
			var pattern = /(\.bpmn)$/;
			if(pattern.test(file.name)){
				//因为不想让页面跳转，所以不会直接提交表单，来上传文件
				//发送原生的ajax请求，用xmlHttpRequest对象，利用js中的FormData来上传文件
				$.ajax({
					url:"${App_path}/uploadActivitiFile",
					//文件上传用post
					type:"post",
					//上传的数据用FormData包装,也可以创建一个空的FormData对象，利用append方法添加数据
					data:new FormData($("#activitiForm")[0]),
					//不默认处理数据成键值对，保持流的形式
					processData:false,
					//不要设置默认文件内容类型，将enctype="multipart/form-data
					contentType:false,
					success:function(data){
						$("#processModal").modal("hide");
						$("#activitiFile").val("");
						//此时数据已经成功存入数据库，所以+1的页码就是最后一页
						getProcessDefinitions(lastPage);
						layer.msg(data.msg);
					},
					error:function(data){
						layer.msg(data.msg);
					}
				});
			}else{
				layer.msg("请上传后缀为.bpmn的文件");
			}
		});
		
		
		//为取消上传按钮绑定事件
		$("#cancelBtn").click(function(){
			$("#processModal").modal("hide");
		});
		
		//页面加载完成查询信息并分页显示
		$(function(){
			getProcessDefinitions(1);
		});
		
		//查询流程信息，并分页
		function getProcessDefinitions(pageNum){
			$.post("${App_path}/activiti/pds",{pageNum:pageNum},function(data){
// 				console.log(data.msg);
// 				console.log(data.map); 
				buildData(data);
				
			});
		}
		//声明一个变量保存最后一页的页码
		var lastPage;
		//构建数据
		function buildData(data){
			//每次构建数据都将页面清零
			lastPage = 0;
			buildTr(data);
			//调用分页条方法，将目前的总页码和判断的增量加在一起，下回加入新数据翻页时的页码就正确了
			lastPage += buildPages(data.map.pageInfo);
		}
		
		//构建数据行
		function buildTr(data){
			//每次构建都需要将之前的数据清空，防止数据叠加
			$("tbody").empty();
			var pdMapList = data.map.pdList;
			//声明计数器，记录返回的数据个数
			var count = 0;
			$.each(pdMapList,function(){
				//声明行
				var tr = $("<tr></tr>");
				//声明列
				var btnTd = $("<td></td>");
				btnTd.append('<button type="button" pid="' + this.id + '" class="btn btn-success btn-xs checkDetails"><i class=" glyphicon glyphicon-eye-open"></i></button>')
				     .append(" ")
				     .append('<button type="button" pid ="' + this.version + '" class="btn btn-danger btn-xs deleteProcess"><i class=" glyphicon glyphicon-remove"></i></button>');
				tr.append("<td>" + this.id + "</td>")
				  .append("<td>" + this.name + "</td>")
				  .append("<td>" + this.key + "</td>")
				  .append("<td>" + this.category + "</td>")
				  .append("<td>" + this.version + "</td>")
				  .append(btnTd);
				//将构建好的行添加到表格中
				$("tbody").append(tr);
				count += 1;
			});
			//如果返回数据等于pageSize的值，目前是3，给页码+1，这样就可以在加入数据造成新增一页时，继续跳到最后一页
			if(count == 3){
				lastPage += 1;
			}
		}
		
		//为分页条的按钮绑定单击事件
		$(".pagination").on("click","li",function(){
			//只针对能点击的按钮绑定
			if(!$(this).hasClass("disabled")){
				pageNum = $(this).attr("num");
				getProcessDefinitions(pageNum);
			}
		});
		
		//为所有的查看按钮绑定单击事件，弹出模态框显示流程图
		$("tbody").on("click",".checkDetails",function(){
			//每次弹出模态框都将上次显示内容清空
			$("#processImg .modal-body").empty();
			var pid = $(this).attr("pid");
			//获取流程图
			var img = $("<img class='img-responsive img-rounded bg-success' alt='网络异常' src='${App_path}/showProcessImg?pid=" + pid + "'>");
			//将流程图加入模态框
			$("#processImg .modal-body").append(img);
			$("#processImg").modal({
				backdrop:"static",
				show:true
			});
		});
		
		/* //为删除按钮绑定单击事件
		$("tbody").on("click",".deleteProcess",function(){
			$.get("${App_path}/deleteProcess?pid=" + $(this).attr("pid"))
			 .done(function(data){
				 getProcessDefinitions(1);
				 layer.msg("删除成功");
			 }).fail(function(e){
				 layer.msg("网络异常");
			 });
		}); */
	</script>
</body>
</html>
