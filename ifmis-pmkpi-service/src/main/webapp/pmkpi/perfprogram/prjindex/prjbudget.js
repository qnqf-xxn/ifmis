if(!Ext.lt.pmkpi) 
	Ext.lt.pmkpi = {};
/**
 * 初始化加载.
 */
Ext.lt.pmkpi.prjbudget = function(config, serviceid) {
	var sindex = config["sindex"];
	var rowguid = config["guid"]; //选择行的guid
	var prolev = config["prolev"]; //项目级别：1 2 3
	var saveAgency = config["saveAgency"]; //项目单位
	var _cmp = {};
	/**
	 * 页面布局完成.
	 */
	Ext.lt.message.hook("layout", "endlayout2",function(){
		var height = $(window).height() - 68;
		var width = $(window).width() ;
        budgettable.resize(width,height);
	});
	
	/**
	 * 页面加载完成
	 */
	$(function() {
		window.parent.indexwindow = window;
	})
	/**
	 * 关闭
	 * @param obj
	 */
	_cmp.closewin = function(obj){
		parent.Ext.lt.ui.modalWindow.close();
	}
	/**
	 * 查询
	 */
	_cmp.query = function(){
		/*var filter = queryform.getQuerySQL();
		//var tablewhere = picktable //获取表格的过滤数据
		var params = {"filer":filter,"sindex":sindex,"prolev":prolev,"saveAgency":saveAgency};
		params.beanid = "pmkpi.prjindex.PrjIndexBO";
		params.pagetype = 'pickindex';
		Ext.lt.ui.loadingShow();
		picktable.queryData(params,function(){
        	Ext.lt.ui.loadingClose();
        });*/
	}
	return _cmp;
}