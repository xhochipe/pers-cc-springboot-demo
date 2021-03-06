<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>叶晨个人博客后台管理系统</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/jquery-easyui-1.4.5/themes/icon.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/jquery-easyui-1.4.5/themes/default/easyui.css">
<script src="${pageContext.request.contextPath}/static/jquery-easyui-1.4.5/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/static/jquery-easyui-1.4.5/jquery.easyui.min.js"></script>
<script src="${pageContext.request.contextPath}/static/jquery-easyui-1.4.5/locale/easyui-lang-zh_CN.js"></script>
<link rel="Shortcut Icon" type="image/x-icon" href="${pageContext.request.contextPath }/static/images/favicon.ico" />
<script type="text/javascript">
	var url;

	function openTab(text,url,iconCls){
		if($('#tabs').tabs('exists',text)){
			$('#tabs').tabs('select',text);
		}else{
			var content = "<iframe frameborder=0 scrollong='auto' style='width:100%;height:100%' src='/cc/"+url+"'></iframe>";
			$('#tabs').tabs('add',{
				title:text,
				iconCls:iconCls,
				closable:true,
				content:content
			});
		}
	}
	
	function openPasswordModifyDialog(){
		$('#dlg').dialog('open').dialog('setTitle','修改密码').dialog('center');
		url='${pageContext.request.contextPath}/cc/blogger/modifyPassword.html';
	}
	
	function modifyPassword(){
		$('#fm').form('submit',{
			url:url,
			onSubmit:function(){
				return $(this).form('validate');
				var newPasword= $('#newPassword').val();
				var newPasword1= $('#newPassword1').val();
				if(!(this).form('validate')){
					return false;
				}
				if(newPasword!=newPasword1){
					$.messager.alert('系统提示','两次密码输入不一致！请重新输入!');
					return false;
				}
				return true;
			},
			success: function(result){
				var result=eval('('+result+')');
				if(result.success){
					$.messager.alert('系统提示','密码修改成功，下次登录生效!');
					resertValue();
					$('#dlg').dialog('close');
					$('#dg').datagrid('reload');
				}else{
					$.messager.alert('系统提示','密码修改失败!');
					return;
				}
			}
		});
	}
	
	
	function resertValue(){
		$('#newPassword').val('');
		$('#newPassword1').val('');
	}
	
	function closeModifyPasswordDialog(){
		$('#dlg').dialog('close');
		resertValue();
	}
	
	function refreshSystem(){
		$.post('${pageContext.request.contextPath}/cc/system/refreshSystem.html', function(result) {
			if(result.success){
				$.messager.alert('系统提示','刷新系统缓存成功！');
			}else{
				$.messager.alert('系统提示','刷新系统缓存失败！');
			}
		},'JSON');
	}
	
	function logout(){
		$.messager.confirm('系统提示','您确定要退出系统么？',function(r){
			if(r){
				window.location.href="${pageContext.request.contextPath}/cc/blogger/logout.html";
			}
		});
	}
</script>

</head>
<body class="easyui-layout">
<div region="north" style="height: 78px;background-color: #E0ECFF">
	<table style="padding: 5px" width="100%">
		<tr>
			<td width="50%">
				<img alt="logo" src="/static/images/logo.png">
			</td>
			<td valign="bottom" align="right" width="50%">
				<font size="3">&nbsp;&nbsp;<strong>欢迎：</strong>${currentUser.userName }</font>
			</td>
		</tr>
	</table>
</div>
<div region="center">
	<div class="easyui-tabs" fit="true" border="false" id="tabs">
		<div title="首页" data-options="iconCls:'icon-home'">
			<div align="center" style="padding-top: 100px"><font color="red" size="10">欢迎使用</font></div>
		</div>
	</div>
</div>
<div region="west" style="width: 200px" title="导航菜单" split="true" >
	<div class="easyui-accordion" data-options="fit:true,border:false">
		<div title="常用操作" data-options="selected:true,iconCls:'icon-item'" style="padding: 10px">
			<a href="javascript:openTab('写博客','writeBlog.jsp','icon-writeblog')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-writeblog'" style="width: 150px">写博客</a>
			<a href="javascript:openTab('评论审核','commentReview.jsp','icon-review')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-review'" style="width: 150px">评论审核</a>
		</div>
		<div title="博客管理"  data-options="iconCls:'icon-bkgl'" style="padding:10px;">
			<a href="javascript:openTab('写博客','writeBlog.jsp','icon-writeblog')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-writeblog'" style="width: 150px;">写博客</a>
			<a href="javascript:openTab('博客信息管理','blogManage.jsp','icon-bkgl')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-bkgl'" style="width: 150px;">博客信息管理</a>
		</div>
		<div title="博客类别管理" data-options="iconCls:'icon-bklb'" style="padding:10px">
			<a href="javascript:openTab('博客类别信息管理','blogTypeManage.jsp','icon-bklb')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-bklb'" style="width: 150px;">博客类别信息管理</a>
		</div>
		<div title="评论管理"  data-options="iconCls:'icon-plgl'" style="padding:10px">
			<a href="javascript:openTab('评论审核','commentReview.jsp','icon-review')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-review'" style="width: 150px">评论审核</a>
			<a href="javascript:openTab('评论信息管理','commentManage.jsp','icon-plgl')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-plgl'" style="width: 150px;">评论信息管理</a>
		</div>
		<div title="个人信息管理"  data-options="iconCls:'icon-grxx'" style="padding:10px">
			<a href="javascript:openTab('修改个人信息','modifyInfo.jsp','icon-grxxxg')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-grxxxg'" style="width: 150px;">修改个人信息</a>
		</div>
		<div title="系统管理"  data-options="iconCls:'icon-system'" style="padding:10px">
		    <a href="javascript:openTab('友情链接管理','linkManage.jsp','icon-link')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-link'" style="width: 150px">友情链接管理</a>
			<a href="javascript:openPasswordModifyDialog()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-modifyPassword'" style="width: 150px;">修改密码</a>
			<a href="javascript:refreshSystem()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-refresh'" style="width: 150px;">刷新系统缓存</a>
			<a href="javascript:logout()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-exit'" style="width: 150px;">安全退出</a>
		</div>
	</div>
</div>
<div region="south" style="height: 25px;padding: 5px" align="center">
	Copyright © 2012-2016 牛逼的晨晨 抄袭峰哥所有
</div>

<div id="dlg" class="easyui-dialog" style="width: 400px;height: 200px;padding: 10px 20px;" closed="true" buttons="#dlg-buttons">
	<form id="fm" method="post">
		<table cellspacing="8px">
			<tr>
				<td>用户名：</td>
				<td>
					<input type="text" id="userName" name="userName" value="${currentUser.userName }" readonly="readonly" class="easyui-validatebox" required="true" >
				</td>
			</tr>
			<tr>
				<td>新密码：</td>
				<td>
					<input type="password" class="easyui-validatebox" id="newPassword" name="newPassword" required="true" style="width: 200px;">
				</td>
			</tr>
			<tr>
				<td>确认新密码：</td>
				<td>
					<input type="password" class="easyui-validatebox" id="newPassword1" name="newPassword1" required="true" style="width: 200px;">
				</td>
			</tr>
		</table>
	</form>
</div>
<div id="dlg-buttons">
	<a href="javascript:modifyPassword()" class="easyui-linkbutton" iconCls="icon-ok" >保存</a>
	<a href="javascript:closeModifyPasswordDialog()" class="easyui-linkbutton" iconCls="icon-no" >关闭</a>
</div>





</body>
</html>