if(!Ext.lt.pmkpi)
	Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.rectification)
	Ext.lt.pmkpi.rectification = {};


/**
 * 初始化加载.
 */
Ext.lt.pmkpi.rectification.resultopinion = function(config, service) {
	var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
	var _cmp = {};
	var _viewtype = config.viewtype,
		_isedit = config.isedit,
		_bustype = config.bustype,
		_mainguid = config.mainguid,
		_filebustype = config.filebustype,
		_queryYear = config.queryYear,//跨年查询查询年度
		_queryProvince = config.queryProvince,//跨年查询查询区划
		_tablecode,
		_isHUBEI = config.isHUBEI
	;

	//页面加载完成后执行
	$(function() {
		//_viewtype="query"查看状态(审核和查看详情默认不可修改)  _isedit="true"表示从审核进的页面 则不隐藏按钮页面也可编辑
		//_isedit为true 从审核页面进 则可编辑  !="true"则代表从查询页面等进页签  页面不可编辑
		if(_viewtype == "query" || _isedit != "true"){
			deptcmp.editSetdisabled(editform);
			$("div[compid='toolbutton']").hide();
		}
		_tablecode = editform.cfg.table;
		_cmp.query(true);
	});

	/**
	 * 查询
	 */
	_cmp.query = function () {
		var params = {};
		params.bustype = _bustype;
		params.tablecode = _tablecode;
		params.filebustype = _filebustype;
		params.viewtype = _viewtype;
		params.mainguid = _mainguid;
		params.queryYear = _queryYear;
		params.queryProvince = _queryProvince;
		Ext.lt.ui.loadingShow();
		Ext.lt.RCP.call(service, "getResultOpinionDatas", params, function (rs) {
			if(rs.success){
				editform.synchEditformByObj(rs.result);
			}
			Ext.lt.ui.loadingClose();
		}, function () {
			Ext.lt.ui.loadingClose();
			Ext.lt.ui.alert('查询失败！', function () {
			});
		});
	}


	/**
	 * 保存.
	 * @returns {*}
	 */
	_cmp.infosave = function(){
		if (!editform.check()) return false;//先校验
		var editinfo = editform.getEditFormValues();//获取页面上编辑框的值
		if (_isHUBEI) {//湖北保存添加特殊校验
			var finadjustadvice = editinfo.finadjustadvice;
			if ((finadjustadvice == "1" || finadjustadvice == "2") && (!editinfo.finfeedbackamt)) {
				Ext.lt.ui.alert(editform.getCol('finfeedbackamt')._cfg.label + '必填！',function(){});
				return false;
			}
			if ((finadjustadvice == "3" || finadjustadvice == "4") && (!editinfo.finfeedbackremark || editinfo.finfeedbackremark == "")) {
				Ext.lt.ui.alert(editform.getCol('finfeedbackremark')._cfg.label + '必填！',function(){});
				return false;
			}
		}
		var params = {};
		params.datas = editinfo;
		params.bustype = _bustype;
		params.filebustype = _filebustype;
		params.viewtype = _viewtype;
		params.mainguid = _mainguid;
		var rs = Ext.lt.RCP.asyncall(service , "resultOpinionsave", params);
		if (rs && rs.success) {
			Ext.lt.ui.alert("保存成功", {timeout: 1}, function () { });
			_cmp.query();
		}
		return rs;
	}

	return _cmp;
}