if(!Ext.lt.pmkpi) 
	Ext.lt.pmkpi = {};

if(!Ext.lt.pmkpi.adjust)
	Ext.lt.pmkpi.adjust = {};

/**
 * 初始化加载.
 */
Ext.lt.pmkpi.adjust.goalservice = function(config, serviceid) {
	var commcmp = Ext.lt.pmkpi.perfcommon(config, serviceid);

	var _cmp = {};
	var _proguid = config.proguid;
	var _mainguid = config.mainguid; //项目单位
	var _busguid = config.busguid;//审核定义guid
	var _bustype = config.bustype;//业务类型
	var _prolev = config.prolev; //项目等级123级项目
	var _procode = config.procode;//项目编码
	var _viewtype = config.viewtype;
	var _saveAgency = config.saveAgency;
	var _queryYear = config.queryYear;//跨年查询查询年度
	var _queryProvince = config.queryProvince;//跨年查询查询区划
	var _pro_name = decodeURIComponent(config.pro_name);

	//页面加载完成后执行
	$(function() {
		try {
			if (_viewtype == "query") {
				$("div[compid='toolbutton']").hide();
			}
		} catch (e) {
		}
		_cmp.query(true);
	});

	_cmp.query = function (isquery){
		var params = {};
		params.proguid = _proguid;
		params.mainguid = _mainguid;
		params.tablecode = editform.cfg.tablecode;
		params.bustype = _bustype;
		params.procode = _procode;
		params.queryYear = _queryYear;//跨年查询查询年度
		params.queryProvince = _queryProvince;//跨年查询查询区划
		Ext.lt.RCP.call(serviceid , "queryGoal", params, function(data) {
			if (_viewtype == "query") {
				commcmp.editSetdisabled(editform);
			}
			editform.synchEditformByObj(data);
			Ext.lt.ui.loadingClose();
			if (isquery) {
				parent._isQuery = true;
			}
		}, function() {
			Ext.lt.ui.loadingClose();
			Ext.lt.ui.alert('查询失败！',function(){
			});
		});
	}

	/**
	 * 保存方法
	 * @param obj
	 */
	_cmp.save = function(obj){
		if (!editform.check()) {
			return false;
		}
		var data = editform.getEditFormValues();
		if (data.kpi_target) {
			data.kpi_target = data.kpi_target.trim();//调整后绩效目标，去处空格
			data.kpi_target = convertStr(data.kpi_target);
		}
		if (data.adjustndgoal) {
			data.adjustndgoal = data.adjustndgoal.trim();//调整后绩效目标，去处空格
			data.adjustndgoal = convertStr(data.adjustndgoal);
		}
		if (!commcmp.checkSpaceValue(data,null,"editform")) return;//校验空格
		if ((!data.adjustndgoal && !data.kpi_target) || (data.adjustndgoal == "" && (data.kpi_target == "" || data.kpi_target == "无目标"))) {
			alert("请填写目标！");
			return false;
		}
		var params = {};
		params.editinfo = data;
		params.proguid = _proguid;
		params.mainguid = _mainguid;
		params.busguid = _busguid;
		params.saveAgency = _saveAgency;
		params.tablecode = editform.cfg.tablecode;
		params.procode = _procode;
		params.bustype = _bustype;
		params.pro_name = _pro_name;
		params.queryYear = _queryYear;//跨年查询查询年度
		params.queryProvince = _queryProvince;//跨年查询查询区划
		Ext.lt.ui.loadingShow();
		var rs = Ext.lt.RCP.asyncall(serviceid , "saveGoal", params);
		Ext.lt.ui.loadingClose();
		if(rs && rs.success){
			_cmp.query();
		}
		return rs;
	}

	/**
	 * 复制上年绩效目标
	 */
	_cmp.lastyeargoal = function(obj){
		Ext.lt.ui.confirm("是否复制上年绩效目标到调整后年度绩效目标？",{icon:"warn"},function(ret){
			if(ret){
				var params = {};
				params.procode = _procode;
				params.proguid = _proguid;
				params.mainguid = _mainguid;
				params.queryYear = _queryYear;//跨年查询查询年度
				params.queryProvince = _queryProvince;//跨年查询查询区划
				var rs = Ext.lt.RCP.asyncall(serviceid, "copyGoal", params);
				if(rs && rs.success){
					editform.synchEditformByObj(rs.data);
					Ext.lt.ui.alert("复制成功!",function(){});
				} else {
					Ext.lt.ui.alert("该项目上年绩效目标值不存在!",function(){});
				}
			}
		});
	}

	return _cmp;
}