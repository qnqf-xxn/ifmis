if(!Ext.lt.pmkpi){
	Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.perfdp){
	Ext.lt.pmkpi.perfdp = {};
}
var serviceid;
var deptcmp;
Ext.lt.pmkpi.perfdp.editservice = function(config, service){
	deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
	window.parent.Ext.lt.pmkpi.childwindow = window;
	var cmp = {};
 	serviceid = service;
 	var _mainguid = config.mainguid,
	_proid = config["pro_id"]; //嵌入传入项目的GUID
	_saveAgency = config.saveAgency,
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
		deptcmp.savedatas(obj, params);
	}

	/**
	 * 页签方法
	 */
	cmp.clickTabpage = function(obj){
		deptcmp.tabpageOnclick(obj, _tabData, toolbutton);
	}
    /**
     * 页面初始化加载，查看的话不显示按钮
     */
	$(function(){
		if (_viewtype == "query") {
			try{
				$("div[compid='toolbutton']").hide();
			}catch (e){
				document.getElementsByClassName("winfooter")[0].style.display = "none";
			}
		}
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
	 * 点击嵌套页面类型处理消息
	 */
	Ext.lt.message.hook("perfcommon", "iframeinit",function(obj){
		var params = obj.params;
		params.mainguid = _mainguid;
        params.pro_id =
		params.saveAgency = _saveAgency;
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
	cmp.close = function () {
		Ext.lt.ui.closeModalWindow();
		window.parent.Ext.lt.pmkpi.query();
	}

	return cmp;
}