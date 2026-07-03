if (Ext.lt.drtemplate == null) {
	Ext.lt.drtemplate = {};
}
Ext.lt.drtemplate.AllotTemplate = function(config) {
	var tpl = Ext.lt.drtemplate;
	var _cmp = {};
	_cmp.draw = function(el) {
		//菜单头
		/*var headerdiv=document.getElementById('headerdiv');
		header.draw(headerdiv);*/
		//保存按钮
		var buttondiv=document.getElementById('buttondiv');
		//数据权限
		var drdiv=document.getElementById('drdiv');

		toolbutton.draw(buttondiv);
		uidatatabledr.draw(drdiv);
	}
	return _cmp;
};
/**
 * 设置表格宽和高
 */
Ext.lt.message.hook('layout', 'endlayout', function() {
	var windowObj = $(window);
	var bodyHeight=windowObj.height();
	var bodyWidth=windowObj.width();
	// 菜单树div
	$("#leftmenudiv").height(bodyHeight-60);
	$("#lefttreediv").height(bodyHeight-40);
	$("#menudiv").height(bodyHeight-80);
	
	// 数据权限列表
	//$("#buttondiv").height(70);
	$("#rightbody").width(bodyWidth-260);
	$("#drdiv").width(bodyWidth - 800);
	uidatatabledr.resize(bodyWidth - 780, bodyHeight - 53);
	
	$("leftbody").height(bodyHeight-60);
	$("rightbody_div").height(bodyHeight-210);
});
//页面加载完成后初始化组件（左侧角色树，系统菜单树，数据权限列表）
$(function(){
	//初始化左侧角色树
	caruletypeChange();
})

