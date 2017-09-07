<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="UTF-8">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
	<%@include file="/WEB-INF/includes/commons_css.jsp" %>
	<link rel="stylesheet" href="${App_path}/css/login.css">
	<style>
		.error{
			color: red;
		}
	</style>
  </head>
  <body>
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <div><a class="navbar-brand" href="${App_path}/index.jsp" style="font-size:32px;">尚筹网-创意产品众筹平台</a></div>
        </div>
      </div>
    </nav>

    <div class="container">

      <form class="form-signin" role="form" action="${App_path }/regist" method="post">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户注册
        	 <br/>&nbsp;&nbsp;<span style="color: red;font-size: 14px">${msg }</span>
        </h2>
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" id="loginacct" placeholder="请输入登录账号" 
			name="loginacct" autofocus>
			<span class="glyphicon glyphicon-user form-control-feedback"></span>
			<span class="error"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" id="userpswd" placeholder="请输入登录密码" style="margin-top:10px;"
			name="userpswd">
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
			<span class="error"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" id="email" placeholder="请输入邮箱地址" style="margin-top:10px;"
			name="email">
			<span class="glyphicon glyphicon glyphicon-envelope form-control-feedback"></span>
			<span class="error"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<select class="form-control" >
                <option>会员</option>
                <option>管理</option>
            </select>
		  </div>
        <div class="checkbox">
          <label>
            忘记密码
          </label>
          <label style="float:right">
            <a href="${App_path}/login.jsp">我有账号</a>
          </label>
        </div>
        <a id="regist_btn" class="btn btn-lg btn-success btn-block" > 注册</a>
      </form>
    </div>
    <%@include  file="/WEB-INF/includes/commons_js.jsp" %>
  </body>
  
  <script type="text/javascript">
  	$.validator.setDefaults({
  		showErrors:function(map,list){
  			$(".form-group").removeClass("has-error");
  			$("span.error").text("");
  			$.each(list,function(){
  				//$(this.element).parent(".form-group").removeClass("has-error");
  				$(this.element).nextAll("span.error").text(this.message);
  				$(this.element).parent(".form-group").addClass("has-error");
  			});
  		}
  	});
  
  	$(".form-signin:first").validate({
  		rules:{
  			loginacct:{
  				required: true,
  				maxlength: 18,
  				minlength: 5
  			},
  			userpswd:{
  				required: true,
  				maxlength: 18,
  				minlength: 5
  			},
  			email:{
  				required: true,
  				email: true
  			}
  		},
  		messages:{
  			loginacct:{
  				required: "帐号必须填写！",
  				maxlength: "帐号长度应不大于18位！",
  				minlength: "帐号长度应不小于5位！"
  			},
  			userpswd:{
  				required: "密码必须填写！",
  				maxlength: "密码长度应不大于18位！",
  				minlength: "帐号长度应不小于5位！"
  			},
  			email:{
  				required: "邮箱必须填写！",
  				email: "邮箱格式不合法，请重新输入！"
  			}
  		}
  	});
  
  	$("#regist_btn").click(function(){
  		var type = $(":selected").val();
  		if(type == "管理") {
  			$(".form-signin:first").submit();
  		} else {
  			layer.msg("未开通此功能");
  		}
  		return false;
  	});
  </script>
</html>