if(!Ext.lt.pmkpi){
	Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.evaluate){
	Ext.lt.pmkpi.evaluate = {};
}
var serviceid;
var commoncmp;
Ext.lt.pmkpi.evaluate.preevaluateeditservice = function(config, service){
	commoncmp = Ext.lt.pmkpi.perfcommon(config, service);
	window.parent.Ext.lt.pmkpi.childwindow = window;
	var cmp = {};
	serviceid = service;
	var _mainguid = config.mainguid,
		_procode = config.procode,
		_saveAgency = config.saveAgency,
		_guid = config.guid,
		_prolev = config.prolev,
		_tabData = config.tabData,
		_scrWidth =document.body.clientWidth,
		_scrHeight =document.body.clientHeight,
		_workflow = config.workflow,
		_menuid = config.menuid,
		_viewtype = config.viewtype;//区分是否查询:query是查询，其他可修改
	//根据组件id存放表名
	Ext.lt.pmkpi.isadd = false;
	/**
	 * 基础信息保存
	 */
	cmp.infosave = function (obj){
		var params= {};
		params.isadd = Ext.lt.pmkpi.isadd;
		params.workflow = _workflow;
		commoncmp.savedatas(obj, params);
	}

	/**proreportedit.js
	 * 页签方法
	 */
	cmp.clickTabpage = function(obj){
		if (_viewtype == "query") {
			return;
		}
		commoncmp.tabpageOnclick(obj, _tabData, toolbutton);
	}
	/**
	 * 重画表格
	 */
	Ext.lt.message.hook("busdatatable", "drawed",function (obj) {
		var config = obj.config;
		var componentid = config.id;
		_table_param[componentid] = obj.uiconfig.tablecode;
		_table_param[componentid + "_defquery"] = obj.uiconfig.defquery;
		_table_param[componentid + "_orderby"] = obj.uiconfig.orderby;
		_table_param[componentid + "_busguid"] = config.busguid; //审核定义调用
		_table_param[componentid + "_totaltag"] = obj.uiconfig.totaltag;
		if (_viewtype == "query") {
			config.edit = false;
			config.addrow = false;
		}
	});

	/**
	 * 页面初始化加载，查看的话不显示按钮
	 */
	$(function(){
		if (_viewtype == "query") {
			for (var i=0; i < _tabData.length; i++){
				var tabconfig = eval('(' + _tabData[i].config + ')');
				var id = _tabData[i].componentid;
				commoncmp.tabinitpage(id,tabconfig);
			}
			document.getElementById("tabpage").style.display = "none";
			$("div[compid='toolbutton']").hide();
			document.getElementById("add").style.display = "none";
			document.getElementById("del").style.display = "none";
		}
	});

	/**
	 * 点击表格类型页签处理消息
	 */
	Ext.lt.message.hook("perfcommon", "tableinit",function(obj){
		var params = obj.params;
		params.menuid = _menuid;
		params.mainguid = _mainguid;
		params.prolev = _prolev; //项目级别
		params.uikey = eval(obj.id)["key"];
	});

	/**
	 * 点击编辑区类型处页签理消息
	 */
	Ext.lt.message.hook("perfcommon", "editinit",function(obj){
		var params = obj.params;
		params.mainguid = _mainguid;
		params.saveAgency = _saveAgency;
		params.prolev = _prolev; //项目级别
		params.uikey = eval(obj.id).cfg["key"];
		params.pagetype = eval(obj.id).cfg["pagetype"];
	});

	/**
	 * 点击报表类型处理消息
	 */
	Ext.lt.message.hook("perfcommon", "reportinit",function(obj){
		var params = obj.params;
		params.mainguid = _mainguid;
		params.saveAgency = _saveAgency;
	});

	/**
	 * 点击嵌套页面类型处理消息
	 */
	Ext.lt.message.hook("perfcommon", "iframeinit",function(obj){
		var params = obj.params;
		params.mainguid = _mainguid;
		params.saveAgency = _saveAgency;
		params.guid = _guid;
		params.procode = _procode;
		params.prolev = _prolev; //项目级别
		params.viewtype = _viewtype; //判断是查看还是可操作
		params.isprogramiframe = "false";//是否项目库嵌套
	});

	/**
	 * 保存编辑区之前封装参数
	 */
	Ext.lt.message.hook("perfcommon", "beforeEditsave",function(obj){
		var params = obj.params;
		params.prolev = _prolev; //项目级别
		params.uikey = eval(obj.id).cfg["key"];
		params.pagetype = eval(obj.id).cfg["pagetype"];//区分主编辑区
	});
	/**
	 * 保存表格之前封装参数
	 */
	Ext.lt.message.hook("perfcommon", "beforeTablesave",function(obj){
		var params = obj.params;
		params.prolev = _prolev; //项目级别
		params.uikey = eval(obj.id)["key"];
	});

	/**
	 * 表格查询方法处理.
	 */
	Ext.lt.message.hook("perfcommon", "tablequery",function(obj){
		if (_table_param[obj.componentid + "_totaltag"] == 1) {
			setTimeout(function(){
				commoncmp.amtTotal(eval(obj.componentid));
			},100);
		}
	});

	cmp.close = function () {
		Ext.lt.ui.closeModalWindow();
		window.parent.Ext.lt.pmkpi.query();
	}

	return cmp;
}