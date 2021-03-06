<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>博客管理页面</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/jquery-easyui-1.4.5/themes/default/easyui.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/jquery-easyui-1.4.5/themes/icon.css">
<script src="${pageContext.request.contextPath}/static/jquery-easyui-1.4.5/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/static/jquery-easyui-1.4.5/jquery.easyui.min.js"></script>
<script src="${pageContext.request.contextPath}/static/jquery-easyui-1.4.5/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	function formatTitle(val,row){
		return "<a target='_blank' href='${pageContext.request.contextPath}/blog/articles/"+row.id+".html'>"+val+"</a>";
	}
	
	function formatBlogType(val,row){
		return val.typeName;
	}
	
 	function searchBlog(){
		$('#dg').datagrid('load',{
			'title':$('#s_title').val()
		});
	}
	
	function deleteBlog(){
		var SelectedRows=$('#dg').datagrid('getSelections');
		if(SelectedRows.length==0){
			$.messager.alert('系统提示','请选择要删除的数据!');
			return;
		}
		var strIds=[];
		for(var i=0;i<SelectedRows.length;i++){
			strIds.push(SelectedRows[i].id);
		}
		var ids=strIds.join(",");
		$.messager.confirm('系统提示','您确定要删除这<font color="red">'+SelectedRows.length+'</font>条数据么!',function(r){
			if(r){
				$.post('${pageContext.request.contextPath}/cc/blog/delete.html', {ids:ids}, function(result) {
					if(result.success){
						$.messager.alert('系统提示','数据已成功删除!');
						$('#dg').datagrid('reload');
					}else{
						$.messager.alert('系统提示','数据删除失败!');
					}
				},'JSON');
			}
		});
	}
	
	function openModifyBlogTab(){
		var SelectedRows=$('#dg').datagrid('getSelections');
		if(SelectedRows.length!=1){
			$.messager.alert('系统提示','请选择一条要修改的数据!');
			return;
		}
		var row=SelectedRows[0];
		window.parent.openTab('修改博客','modifyBlog.jsp?id='+row.id,'icon-writeblog');
	} 
</script>
</head>
<body style="margin: 1px;">
<table id="dg" title="博客管理" class="easyui-datagrid" 
  fitColumns="true" pagination="true" rownumbers="true" 
  url="${pageContext.request.contextPath}/cc/blog/list.html" fit="true" toolbar="#tb">
	<thead>
		<tr>
	  		<th field="cb" checkbox="true" align="center"></th>
	  		<th field="id" width="20" align="center">编号</th>
	  		<th field="title" width="200" align="center" formatter="formatTitle">标题</th>
	  		<th field="releaseDate" width="50" align="center">发布日期</th>
	  		<th field="blogType" width="50" align="center" formatter="formatBlogType">博客类型</th> 
  		</tr>
	</thead>
</table>
<div id="tb">
	<div>
		<a href="javascript:openModifyBlogTab()" class="easyui-linkbutton" iconCls="icon-edit" plain='true'>修改</a>
		<a href="javascript:deleteBlog()" class="easyui-linkbutton" iconCls="icon-remove" plain='true'>删除</a>
	</div>
	<div>
		&nbsp;标题:&nbsp;<input id="s_title" size="20" type="text" onkeydown="if(event.keyCode==13) searchBlog()">
		<a href="javascript:searchBlog()" class="easyui-linkbutton" iconCls="icon-search" plain='true'>搜索</a>
	</div>
</div>
</body>
</html>