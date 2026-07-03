if(!Ext.lt.pmkpi) 
	Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.evaluate)
	Ext.lt.pmkpi.evaluate = {};
/**
 * 初始化加载.
 */
var _proguid;
var _prolev;
var _saveAgency;
var height;
var width;
Ext.lt.pmkpi.evaluate.preevaluateopinionservice = function(config, serviceid) {
	var _proguid = config["proguid"];
	var _viewtype = config["viewtype"]; //修改还是查看
	var _busguid = config.busguid;//审核定义guid
	var _workflow = config.workflow;
	var _cmp = {};
	var tabcomps = {};
	var editinfo = config.editinfo;
	height = $(window).height()*0.8;
	width = $(window).width()*0.8;
	//页面加载完成后执行
	$(function() {
		editform.synchEditformByObj(editinfo[0]);
		if (_viewtype == "query") {
			$("div[compid='toolbutton']").hide();
		}
		parent._isQuery = true;
	});
	/**
	 * 项目指标保存方法
	 * @param obj
	 */
	_cmp.save = function(obj){
		if (!editform.check()) {
			return false;
		}
		var params = {};
		params.editinfo = editform.getEditFormValues();
		params.projguid = _proguid;
		params.workflow = _workflow;
		Ext.lt.ui.loadingShow();
		var rs = Ext.lt.RCP.asyncall(serviceid , "saveOpinion", params);
		Ext.lt.ui.loadingClose();
		if(rs && rs.success){
			Ext.lt.ui.loadingShow();
			Ext.lt.RCP.call(serviceid, "findOpinion", [params], function(data) {
				setTimeout(function(){
					editform.synchEditformByObj(data);
				},100);
				Ext.lt.ui.loadingClose();
			})
		}
		return rs;
	}
	return _cmp;
}
