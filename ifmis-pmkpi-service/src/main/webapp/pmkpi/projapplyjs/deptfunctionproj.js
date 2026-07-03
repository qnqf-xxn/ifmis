if(!Ext.lt.pmkpi){
	Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.deptfunctionproj){
	Ext.lt.pmkpi.deptfunctionproj = {};
}
var serviceid;
var _mainguid;
var _saveAgency;
var _menuid;
var _viewtype;
Ext.lt.pmkpi.deptfunctionproj = function(config, service){
	var
		_tablecode,//表名
		_defquery,//表配置过滤条件
		_orderby,//表排序sql
		_busguid,//审核定义
		_modelguid,//指标模板guid
		_deldatas//删除数据集合
	;
	var cmp = {};
	serviceid = service;
	_mainguid = config.mainguid;
	_tablecode = config.tablecode;
	_saveAgency = config.saveAgency;
	_viewtype = config.viewtype,
		_querytype = config.querytype,
		_bustype = config.bustype,
		_scrWidth =document.body.clientWidth;
	_scrHeight =document.body.clientHeight;
	/**
	 *
	 */
	Ext.lt.message.hook("busdatatable", "drawed",function (obj) {
		var config = obj.config;
		_tablecode = obj.uiconfig.tablecode;
		_defquery = obj.uiconfig.defquery;
		_orderby = obj.uiconfig.orderby;
		//审核定义guid，perf_t_busauditdefine表budguid
		_busguid = config.busguid;
		_modelguid = config.modelguid;
	});

	cmp.query = function(){
		var params = {};
		params.tablesql = _defquery;
		params.orderby = _orderby;
		params.queryConfig = queryform.getQueryParam();
		params.querySql = queryform.getQuerySQL();
		params.tablecode = _tablecode;
		params.mainguid = _mainguid;
		params.modelguid = _modelguid;
		params.bustype = _bustype;
		params.agency = _saveAgency;
		params.viewtype = _viewtype;
		params.querytype = _querytype;
		params.menuid = _menuid;
		Ext.lt.ui.loadingShow();
		Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
			datatable.setDatas(rs.data);
			setTimeout(function(){
				// amtTotal(datatable);
			},100);
			Ext.lt.ui.loadingClose();
		},function(){
			Ext.lt.ui.loadingClose();
			Ext.lt.ui.alert('查询失败！',function(){
			});
		});
	}

	cmp.save = function(){
		var selecteddata = datatable.getSelected();
		if(selecteddata.length < 1){
			Ext.lt.ui.alert("请选择项目！",function(){});
			return;
		}
		var params = {};
		params.datas = selecteddata.toArray();
		params.tablecode = parent.parent._tablecode;
		params.busguid = _busguid;
		params.mainguid = _mainguid;
		Ext.lt.RCP.call(serviceid , "save", params, function(rs){
			Ext.lt.ui.loadingClose();
			Ext.lt.ui.alert('选择项目保存成功！',function(){
				Ext.lt.ui.closeModalWindow();
				window.parent.Ext.lt.pmkpi.query();
			});
		},function(){
			Ext.lt.ui.loadingClose();
			Ext.lt.ui.alert('选择项目保存失败！',function(){
			});
		});
	}

	$(function () {
		cmp.query();
	})

	Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
		var cols = obj.cols;
		if(!Ext.lt.isArray(cols))
			cols = [cols];
		for(var i=0; i<cols.length; i++){
			var col = cols[i];


		}
	});


	return cmp;
}
