if (Ext.lt.ui == null) {
	Ext.lt.ui = {};
}
Ext.lt.ui.template = function(config) {
	var tpl = Ext.lt.uatemplate;
	var _cmp = {};
	_cmp.draw = function(el) {
		//菜单头
		/*var headerdiv = document.getElementById('headerdiv');
		header.draw(headerdiv);*/
		//保存按钮
		var buttondiv = document.getElementById('buttondiv');
		toolbutton.draw(buttondiv);
		//列表
		var datatablediv = document.getElementById('datatablediv');
		datatable.draw(datatablediv);
	}
	return _cmp;
};
/**
 * 设置表格宽和高
 */
Ext.lt.message.hook('layout', 'endlayout', function() {
	var windowObj = $(window);
	var bodyWidth=windowObj.width();
	var bodyHeight=windowObj.height();

	$("#rightbody_div").width(bodyWidth-750);
	$("#datatablediv").width(bodyWidth-750);
	datatable.resize(bodyWidth - 750, bodyHeight - 73);
});

