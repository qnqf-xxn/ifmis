if(!Ext.lt.pmkpi)
	Ext.lt.pmkpi = {};
var serviceid
Ext.lt.pmkpi.expdoctempservice = function(config, service){
	var common = Ext.lt.pmkpi.perfcommon(config, service);
	var _cmp = {};
	var _maintablecode = config.maintablecode,
		_mainguid = config.mainguid,
		_pagetype = config.pagetype,
		_tablecode;
	serviceid = service;
	window.parent.Ext.lt.pmkpi.childwindow = window;
	$(function () {
		common.initDatatable();
		editform.synchEditformByObj(config.expdata);
		if (_pagetype == "query") {
			common.editSetdisabled(editform);
		}
		if (_pagetype == "query") {
			$("div[compid='toolbutton']").hide();
			document.getElementById("add").style.display = "none";
			document.getElementById("del").style.display = "none";
		}
	})
	/**
	 * 查询
	 */
	Ext.lt.pmkpi.query = function() {
		Ext.lt.ui.loadingShow();
		var params = {};
		params.tablecode = _tablecode;
		params.mainguid = _mainguid;
		params.beanid = "pmkpi.setting.expdoc.temp.ExpdocTempBOTX";
		Ext.lt.bus.exportBeanid = params.beanid;
		datatable.queryData(params, function () {
			Ext.lt.ui.loadingClose();
		});
	}

	Ext.lt.message.hook("datatable", 'beforesetcols', function(data){
		var cols = data.cols;
		if(!Ext.lt.isArray(cols))
			cols = [cols];
		for(var i=0; i<cols.length; i++){
			var col = cols[i];
			if (_pagetype == 'query' && !config[col.colcode] && col["name"] != "check") {
				col.style = "background-color:#f2f2f2;";
				col.oneditstart = function (table, e, l, c, d) {
					return false;
				}
			}
		}

	});

	/**
	 * 新增
	 */
	Ext.lt.message.hook("addRow", "uidatatable", function(data){
		var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
		var newdata ={};
		newdata.guid = newguid;
		newdata.mainguid = _mainguid;
		newdata.rowtype = 'add';
		datatable.getRecordSet().addData(newdata,999);
	});

	/**
	 * 刪除表格.
	 */
	Ext.lt.message.hook("delRow", "uidatatable", function() {
		var selDatas = datatable.getSelected();
		if (selDatas.size() <= 0) {
			Ext.lt.ui.alert('请选择要删除的数据！', function () {
			});
			return;
		}
		datatable.removeData(selDatas);
	})

	/**
	 * 保存
	 */
	_cmp.save = function () {
		if (!datatable.check()) return false;//先校验
		var params = {};
		var editdatas = editform.getEditFormValues();
		params.editdatas = editdatas;
		params.maintablecode = _maintablecode;
		params.datas = datatable.getRecordSet().toArray();
		params.updatas = datatable.getUpdataData();
		params.deldatas = datatable.getRemoveData();
		params.tablecode = _tablecode;
		params.mainguid = _mainguid;
		Ext.lt.ui.loadingShow();
		var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
		Ext.lt.ui.loadingClose();
		if(rs && rs.success == true){
			Ext.lt.ui.alert(rs.code,function(){
				parent.Ext.lt.pmkpi.query();
				Ext.lt.ui.closeModalWindow();
			});
		}else{
			Ext.lt.ui.alert(rs.code,function(){});
		}
	}

	Ext.lt.message.hook("datatable", 'drawed', function(data){
		var uiconfig = data.uiconfig;
		_tablecode = uiconfig.tablecode;
	});

	$(function (){
		Ext.lt.pmkpi.query();
	})
	return _cmp;
}
