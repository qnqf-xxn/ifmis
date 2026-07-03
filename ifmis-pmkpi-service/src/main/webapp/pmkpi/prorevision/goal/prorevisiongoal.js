if(!Ext.lt.pmkpi)
	Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.prorevision)
	Ext.lt.pmkpi.prorevision = {};
/**
 * 初始化加载.
 */
var _curtab;
var tabcomps;
var showtab;
var _isedittotal;
Ext.lt.pmkpi.prorevision.goalservice = function(config, serviceid) {
	var common = Ext.lt.pmkpi.perfcommon(config, serviceid);
	_curtab = "total"; //当前页签.
	var _mainguid = config.mainguid;//主单guid
	var _procode = config.procode;
	var _pro_name = config.pro_name;
	var _proguid = config["proguid"];
	var _viewtype = config["viewtype"]; //修改还是查看
	var _saveAgency = config["saveAgency"]; //项目单位
	_isedittotal = config["isedittotal"]; //总体指标是否可编辑
	var _busguid = config.busguid;//审核定义guid
	showtab = config.showtab; //页签展示
	var tabnum = 0; //页签点击次数
	var _cmp = {};
	tabcomps = config["goaldata"]; //目标数据.
	var tabname = "";
	//页面加载完成后执行
	$(function() {
		//组件配置，service不放到第一位时，组件初始化消息不走问题
		common.initEditForm();
		if (_viewtype == "query" || _isedittotal == '1') {
			editform.setdisabled({kpi_target:true});
		}
		if (showtab == "3"){ //处理年度显示的时候
			_curtab = "year";
		}
		if (tabcomps && tabcomps["#"+_curtab]){
			editform.synchEditformByObj(tabcomps["#"+_curtab]);
		}
		$("textarea[name='kpi_target']").prev().find(".character").text(tabname);
		parent._isQuery = true;
		_cmp.bulidTopHead();
	});

	/**
	 * tabpage转radio
	 */
	_cmp.bulidTopHead = function (){
		var tabpagedatas = tabpage.cfg.data;
		$("#tabpage").hide();
		var topheadHtml = [];
		topheadHtml.push("<div id='tophead' style='display:block;overflow:hidden;font-size:15px;height:45px;'>");
		topheadHtml.push("<div id='topheadcontent' style='width:70%;float:left;padding-top:5px;'>&nbsp;&nbsp;&nbsp;&nbsp;");
		if(tabpagedatas.length == 1){
			var tabdata = tabpagedatas[0];
			topheadHtml.push("<label style='cursor:pointer'><input name='checktab' id='"+tabdata.code+"' value='"+tabdata.name+"' hidebtns='"+tabdata.hidebtns+"' type='radio' checked>&nbsp;"+tabdata.title+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>")
		}else if(tabpagedatas.length > 1){
			for(var i=0;i<tabpagedatas.length;i++) {
				var tabdata = tabpagedatas[i];
				var ischecked = tabdata.classname;
				if(ischecked == "choosed"){
					topheadHtml.push("<label style='cursor:pointer'><input name='checktab' id='"+tabdata.code+"' value='"+tabdata.name+"' hidebtns='"+tabdata.hidebtns+"' type='radio' checked>&nbsp;"+tabdata.title+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>")
				}else{
					topheadHtml.push("<label style='cursor:pointer'><input name='checktab' id='"+tabdata.code+"' value='"+tabdata.name+"' hidebtns='"+tabdata.hidebtns+"' type='radio'>&nbsp;"+tabdata.title+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>")
				}
			}
		}
		topheadHtml.push("</div>");
		topheadHtml.push("</div>");
		$(".bd_main").children().first().before(topheadHtml.join(''));
		$("input[type='radio'][name='checktab']").click(function () {
			_cmp.checktabRadioClick();
		});
	}

	/**
	 * radio点击触发clickTabpage
	 */
	_cmp.checktabRadioClick = function(){
		var checktab = $("input[name='checktab']:checked");
		var checkcode = checktab.attr("id");
		var checkname = checktab.attr("value");
		var hidebtns = checktab.attr("hidebtns");
		var tabobj = {};
		tabobj.code = checkcode;
		tabobj.name = checkname;
		tabobj.hidebtns = hidebtns;
		_cmp.clickTabpage(tabobj);
	}

	/**
	 * 点击页签.
	 */
	_cmp.clickTabpage = function(obj){
		tabname = obj.name;
		if(tabnum != 0 && _curtab != obj.code && showtab != 3){
			var num = 1;
			if (_curtab == "total"){
				num = 0;
			}
			if ((_isedittotal != "1" || _curtab == "year") && _viewtype != "query" && !editform.check()) {
				tabpage.doActiveTab(num);
				return;//先校验
			}
			var goaldata =  editform.getEditFormValues();
			if (obj.code == "year"){
				tabcomps["#total"] =Ext.lt.cloneobj(goaldata);
			} else {
				tabcomps["#year"] =Ext.lt.cloneobj(goaldata);
			}
			goaldata = tabcomps["#"+obj.code];
			if (goaldata) {
				editform.synchEditformByObj(goaldata);
			} else {
				goaldata = {};
				goaldata.kpi_target = "";
				editform.synchEditformByObj(goaldata);
			}
		}
		if (showtab == 1 && tabnum != 0) {
			if (obj.code == "total" && _isedittotal == '1') {
				editform.setdisabled({kpi_target:true});
			} else {
				editform.setdisabled({kpi_target: false});
				if (_viewtype == "query") {
					editform.setdisabled({kpi_target: true});
				}
			}
		}
		_curtab = obj.code;
		tabnum ++;
		$("textarea[name='kpi_target']").prev().find(".character").text(tabname);
		var isshowapplyfinamt = false;
		for (var i = 0; i < editform.cfg.data.length; i++) {
			if(editform.cfg.data[i].colcode == "APPLYFINAMT" && editform.cfg.data[i].isvisiable == "1"){
				isshowapplyfinamt = true;
			}
		}
		if (obj.code == "total") {
			editform.hide(['applyfinamt'],false);
		}else if(isshowapplyfinamt){
			editform.show(['applyfinamt'],false);
		}
	}

	/**
	 * 项目指标保存方法
	 * @param obj
	 */
	_cmp.save = function (obj) {
		if (!editform.check()) return;//先校验
		var tempdata =  editform.getEditFormValues();
		tabcomps["#"+_curtab] =Ext.lt.cloneobj(tempdata);
		if ((showtab == "1" || showtab == "3")) {
			//校验年度目标是否为空
			if (!tabcomps["#year"] || !tabcomps["#year"].kpi_target || tabcomps["#year"].kpi_target == "") {
				Ext.lt.ui.alert("请填写年度绩效目标！",{timeout:1},function(){});
				return;
			}
		}
		//保存之前存放当前最后一次
		var params = {};
		params.proguid = _proguid;
		params.saveAgency = _saveAgency;
		params.busguid = _busguid;
		params.mainguid = _mainguid;
		params.goaldata = tabcomps;
		params.showtab = showtab;
		params.isedittotal = _isedittotal;
		params.procode = _procode;
		params.pro_name = _pro_name;
		Ext.lt.ui.loadingShow();
		var rs = Ext.lt.RCP.asyncall(serviceid, "saveGoal", params);
		Ext.lt.ui.loadingClose();
		if(rs && rs.success){
			//_cmp.init();
		}
		return rs;
	}

	return _cmp;
}