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
Ext.lt.pmkpi.evaluate.preevaluateprogoalservice = function(config, serviceid) {
	var _proguid = config["proguid"];
	var _procode = config["procode"];
	var _viewtype = config["viewtype"]; //修改还是查看
	_saveAgency = config["saveAgency"]; //项目单位
	var ismergeindex = config["ismergeindex"];//指标值是否合并单位符号
	if(_saveAgency == "" || _saveAgency == null){//嵌套页面获取父及页面的单位
		if(parent.editform){
			if(parent.editform.getCol("agencyguid")){
				_saveAgency = parent.editform.getCol("agencyguid").getvalue();
			}
		}
	}
	var _busguid = config.busguid;//审核定义guid
	_prolev = config["prolev"]; //项目等级123级项目
	var _cmp = {};
	var tabcomps = {};
	var iframeurl = config.iframeurl;//嵌套url
	//是否显示指标，1不显示、2显示
	var isshowindex = config.isshowindex;
	var editinfo = config.editinfo;
	var hideIframeHtml = "";
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
		if (isshowindex == "2") {
			if (!indexdatatable.check()) return false;//先校验
			var datas = indexdatatable.getRecordSet().toArray();
			params.datas = datas;
		}
		params.editinfo = editform.getEditFormValues();
		params.isshowindex = isshowindex;
		params.projguid = _proguid;
		params.procode = _procode;
		params.saveAgency = _saveAgency;
		params.busguid = _busguid;
		Ext.lt.ui.loadingShow();
		var rs = Ext.lt.RCP.asyncall(serviceid , "savePrjIndex", params);
		Ext.lt.ui.loadingClose();
		if(rs && rs.success){
			Ext.lt.ui.loadingShow();
			Ext.lt.RCP.call(serviceid, "findIndex", [params], function(data) {
				setTimeout(function(){
				},100);
				Ext.lt.ui.loadingClose();
			})
		}
		return rs;
	}
	return _cmp;
}
