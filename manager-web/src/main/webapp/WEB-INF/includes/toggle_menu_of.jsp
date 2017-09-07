<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
	//点击菜单，菜单的打开与收起
	$(function() {
		$(".list-group-item").click(function() {
			if ($(this).find("ul")) {
				$(this).toggleClass("tree-closed");
				if ($(this).hasClass("tree-closed")) {
					$("ul", this).hide("fast");
				} else {
					$("ul", this).show("fast");
				}
			}
		});
	});
</script>