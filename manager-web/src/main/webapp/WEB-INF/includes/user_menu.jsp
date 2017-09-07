<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="col-sm-3 col-md-2 sidebar">
	<div class="tree">
		<ul style="padding-left: 0px;" class="list-group">
			<li class="list-group-item tree-closed">
				<a href="${App_path}/main.jsp">
					<i class="glyphicon glyphicon-dashboard"></i> 
					控制面板
				</a>
			</li>
			<c:forEach items="${userMenu }" var="menu">
				<li class="list-group-item tree-closed">
					<span>
						<i class="${menu.icon }"></i> 
							${menu.name }
						<span class="badge" style="float: right">${fn:length(menu.childs) }</span>
					</span>
					<ul style="margin-top: 10px; display: none;"> 
						<c:forEach items="${menu.childs }" var="child">
								<li style="height: 30px;">
									<a href="${App_path}/${child.url}">
										<i class="${child.icon }"></i> 
										${child.name }
									</a>
								</li>
						</c:forEach>
					</ul>
				</li>
			</c:forEach>
		</ul>
	</div>
</div>