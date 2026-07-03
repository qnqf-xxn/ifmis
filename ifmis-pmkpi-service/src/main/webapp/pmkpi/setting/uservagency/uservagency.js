if (Ext.lt.uatemplate == null) {
	Ext.lt.uatemplate = {};
}
Ext.lt.uatemplate.AllotTemplate = function(config) {
	var tpl = Ext.lt.uatemplate;
	var _cmp = {};
	_cmp.draw = function(el) {
		//菜单头
		/*var headerdiv=document.getElementById('headerdiv');
		header.draw(headerdiv);*/
		//保存按钮
		var buttondiv=document.getElementById('buttondiv');
		toolbutton.draw(buttondiv);
		//隐藏同步配置的单位树
		$("#copymenudiv").hide();
		$("#同步").hide();
		$("#tip").hide();

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
	// 树div
	$("#leftmenudiv").height(bodyHeight-10);
	$("#lefttreediv").height(bodyHeight-20);
	$("#menudiv").height(bodyHeight-98);
	$("#drdiv").height(bodyHeight-98);

	$("#rightbody").width(bodyWidth-410);
	$("#drdiv").width(bodyWidth - 950);


	$("#copymenudiv2").height(bodyHeight-98);
	$("#copymenudiv").height(bodyHeight-10);
	$("#copymenudiv2").width(bodyWidth - 950);


//	$("leftbody").height(bodyHeight-60);
//	$("rightbody_div").height(bodyHeight-560);
});
//页面加载完成后初始化组件（左侧角色树，系统菜单树，数据权限列表）
$(function(){
	//初始化左侧角色树
	caruletypeChange();
})

