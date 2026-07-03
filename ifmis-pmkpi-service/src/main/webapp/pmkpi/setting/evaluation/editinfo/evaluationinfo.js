if(!Ext.lt.pmkpi)
	Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.evaluation)
	Ext.lt.pmkpi.evaluation = {};

Ext.lt.pmkpi.evaluation.evaluationinfoservice = function(config, serviceid) {
	var deptcmp = Ext.lt.pmkpi.perfcommon(config, serviceid);
	var _mainguid = config.mainguid;//主单guid
	var _procode = config.procode;
	var _proguid = config.proguid;
	var _viewtype = config["viewtype"]; //修改还是查看
	var _saveAgency = config["saveAgency"]; //项目单位
	var _busguid = config.busguid;//审核定义guid
	var _prolev = config["prolev"]; //项目等级123级项目
	var cmp = {};

	//页面加载完成后执行
	$(function() {
		//组件配置，service不放到第一位时，组件初始化消息不走问题
		deptcmp.initEditForm();
		if (_viewtype == "query") {
			var cols = editform.cfg.data;
			var c = {};
			for (var i=0; i<cols.length; i++) {
				c[cols[i].colcode.toLowerCase()] = true;
			}
			editform.setdisabled(c);//设置不可编辑
		}
		if (Ext.lt.pmkpi.perfcommon.datas != null) {
			editform.synchEditformByObj(Ext.lt.pmkpi.perfcommon.datas);
		}
		cmp.query(true);
	});

	cmp.query = function(isquery){
		var params = {};
		params.mainguid = _mainguid;
		params.proguid = _proguid;
		params.procode = _procode; //项目code
		Ext.lt.ui.loadingShow();
		Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
			editform.synchEditformByObj(rs.data);
			Ext.lt.ui.loadingClose();
			if (isquery) {
				parent._isQuery = true;
			}
		},function(){
			Ext.lt.ui.loadingClose();
			Ext.lt.ui.alert('查询失败！',function(){
			});
		});
	}

	/**
	 * 评估信息保存
	 * @param obj
	 */
	cmp.save = function (obj) {
		if (!editform.check()) return;//先校验
		var tempdata =  editform.getEditFormValues();  //获取编辑框的值
		var params = {};
		params.items = tempdata.items;
		params.result = tempdata.result;
		params.projguid = _proguid;
		params.saveAgency = _saveAgency;
		params.busguid = _busguid;
		params.mainguid = _mainguid;
		params.procode = _procode;
		Ext.lt.ui.loadingShow();
		var rs = Ext.lt.RCP.asyncall(serviceid, "saveDatas", params);
		Ext.lt.ui.loadingClose();
		if(rs && rs.success){
			//_cmp.init();
		}
		return rs;
	}

	/**
	 * 保存编辑区之前封装参数
	 */
	Ext.lt.message.hook("perfcommon", "beforeEditsave",function(obj){
		var params = obj.params;
		params.prolev = _prolev; //项目级别
		params.uikey = eval(obj.id).cfg["key"];
		params.pagetype = eval(obj.id).cfg["pagetype"];//区分主编辑区
	});

	return cmp;
}