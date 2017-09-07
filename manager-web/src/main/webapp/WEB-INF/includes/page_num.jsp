<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
    function buildPages(data){
    	//分页条要放的位置
    	var pageBar = $("ul.pagination");
    	//当用户点击某页码时，导航页应该动态显示，必须要清空原来的分页条
    	pageBar.empty();
    	if(data.hasPreviousPage){
        	pageBar.append($("<li num='1'><a>首页</a></li>"));
    	}
    	var prePage = $("<li num='" + data.prePage + "'><a>上一页</a></li>");
    	if(data.hasPreviousPage){
    		prePage.removeClass();
    	}else{
    		prePage.addClass("disabled");
    	}
    	pageBar.append(prePage);
    	
    	//导航页构建
    	$.each(data.navigatepageNums,function(){
    		//声明要加入导航条的页码
    		var li;
    		//判断遍历到的页码是否是当前显示的页码，是就做处理
    		if(this == data.pageNum){
    			li = $("<li class='active' num='" + this +"'><a>"+ this +"<span class='sr-only'>(current)</span></a></li>");
    		}else{
    			li = $("<li num='" + this + "'><a>" + this + "</a></li>");
    		}
    		pageBar.append(li);
    	});
    	
    	var nextPage = $("<li num='" + data.nextPage + "'><a>下一页</a></li>");
    	if(data.hasNextPage){
    		nextPage.removeClass();
    	}else{
    		nextPage.addClass("disabled");
    	}
    	pageBar.append(nextPage);
    	if(data.hasNextPage){
    		pageBar.append($("<li num='" + data.pages + "'><a>末页</a></li>"));
    	}
    	pageBar.append("<li class='disabled' ><span class='disabled'> " + "总共" + data.pages + "页; 共计" + data.total + "记录</span></li>");
    	//返回此时分页后的总页码
    	return data.pages;
    }
</script>
 