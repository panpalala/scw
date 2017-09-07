<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
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
      <form class="form-signin" role="form" action="${App_path }/login" method="post">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户登录
        	<br/>&nbsp;&nbsp;<span style="color: red;font-size: 14px">${msg }</span>
        </h2>
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" id="inputSuccess4" 
			 name="loginacct" placeholder="请输入登录账号" value="${TUser.loginacct }" autofocus>
			<span class="glyphicon glyphicon-user form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input type="password" class="form-control" id="inputSuccess4" 
			 name="userpswd" placeholder="请输入登录密码" style="margin-top:10px;">
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<select class="form-control" >
                <option value="user">管理</option>
            </select>
		  </div>
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> 记住我
          </label>
          <br>
          <label>
            忘记密码
          </label>
          <label style="float:right">
            <a href="${App_path}/reg.jsp">我要注册</a>
          </label>
        </div>
        <a id="login_btn" class="btn btn-lg btn-success btn-block" > 登录</a>
      </form>
    </div>
     <%@include  file="/WEB-INF/includes/commons_js.jsp" %>
    <script>
    	$("#login_btn").click(function(){
    		var type = $(":selected").val();
    		//检查是否是管理员登录
    		if(type == "user"){
    			//提交表单
    			$(".form-signin:first").submit();
    		} else {
    			layer.msg("此功能未开通");
    		}
    		return false;
    	}); 
    	
    </script>
  </body>
</html>