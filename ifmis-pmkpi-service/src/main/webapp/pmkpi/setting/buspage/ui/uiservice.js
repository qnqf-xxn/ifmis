if(!Ext.lt.pmkpi)
	Ext.lt.pmkpi = {};

var serviceid
Ext.lt.pmkpi.uiservice = function(config, service){
	var common = Ext.lt.pmkpi.perfcommon(config, service);
	var _cmp = {};
	var _pageurl = config.pageurl,
		_uikey = config.uikey,
		_cols = config.cols,
		_checktabsource = config.checktabsource,
		_tablecode = config.tablecode,
		_scrWidth =document.body.clientWidth,
		_scrHeight =document.body.clientHeight;
	serviceid = service;

	$(function (){
		common.initDatatable();
		Ext.lt.pmkpi.query();
	})

	/**
	 * 查询
	 */
	Ext.lt.pmkpi.query = function() {
		Ext.lt.ui.loadingShow();
		if(_pageurl == "/pmkpi/set/uidatatablecols/edit"){
			var editparams = {};
			editparams.tablecode = 'busfw_t_uitable';
			editparams.uikey = _uikey;
			var editfromdata = Ext.lt.RCP.asyncall(serviceid , "getUIData", editparams);
			editform.synchEditform(editfromdata[0]);
		}
		var dsparams = {};
		dsparams.tablecode = _tablecode;
		dsparams.cols = _cols;
		var _datasource = Ext.lt.RCP.asyncall(service , "getDataSource", dsparams);
		var params = {}
		params.tablecode = _tablecode;
		params.uikey = _uikey;
		common.setColDatasource(_datasource,datatable);
		params.beanid = "pmkpi.setting.buspage.ui.UiBO";
		Ext.lt.bus.exportBeanid = params.beanid;
		datatable.queryData(params, function () {
			Ext.lt.ui.loadingClose();
		});
	}

	/**
	 * 新增
	 */
	Ext.lt.message.hook("addRow", "uidatatable", function(data){
		var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
		var datas = datatable.getRecordSet().toArray();
		var newdata ={};
		newdata.guid = newguid;
		newdata.tablecode = datas[0]['tablecode'];
		newdata.appid = 'pmkpi';
		newdata.key = _uikey;
		newdata.rowtype = 'add';
		newdata.config = '{}';
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
		if(_pageurl == "/pmkpi/set/uidatatablecols/edit"){
			var editdatas = editform.getEditFormValues();
			params.editdatas = editdatas;
		}
		params.datas = datatable.getRecordSet().toArray();
		params.updatas = datatable.getUpdataData();
		params.deldatas = datatable.getRemoveData();
		params.tablecode = _tablecode;
		Ext.lt.ui.loadingShow();
		var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
		Ext.lt.ui.loadingClose();
		if(rs && rs.success == true){
			Ext.lt.ui.alert(rs.code,function(){
				Ext.lt.pmkpi.query();
			});
		}else{
			Ext.lt.ui.alert(rs.code,function(){});
		}
	}

	Ext.lt.message.hook("datatable", 'beforesetcols', function(data){
		var cols = data.cols;
		if (!Ext.lt.isArray(cols)) cols = [cols];
		for(var i=0; i<cols.length; i++) {
			var col = cols[i];
			if(col["colcode"] == "ischecktab"){
				col.fn = function (l, c, data, col) {
					var ischecktab = data.ischecktab;
					if (!ischecktab && !data.checktable) {
						return;
					}
					if (ischecktab && ischecktab == '2') {
						return "2-否";
					} else {
						return "1-是";
					}
				}
				col.oneditstart = function (table, el, l, c, d) {
					table.getCol(c).format = "#code-#name";
					Ext.lt.pmkpi.doMapper(_checktabsource, table.getCol(c));
				}
			}
		}
	});

	_cmp.queryexpdoc = function () {
		var datas = datatable.getSelected();
		if (datas.length != 1) {
			Ext.lt.ui.alert("请选择一条数据进行查看！", function () {
			});
			return;
		}
		if (datas[0].config) {
			var cnf = eval('(' + datas[0].config + ')')
			if (cnf.tempatecode && cnf.tempatecode != "") {
				var params = {};
				params.tempatecode = cnf.tempatecode;
				params.pagetype = "query";
				var url = "/pmkpi/setting/expdoctemp.page";
				url = Ext.lt.pmkpi.genPageUrl(url, params);
				parent.Ext.lt.ui.openModalWindow(url,_scrWidth, _scrHeight,"查看模板");
			} else {
				Ext.lt.ui.alert("未添加导出报告配置！", function () {
				});
			}
		} else {
			Ext.lt.ui.alert("未添加导出报告配置！", function () {
			});
		}
	}
	return _cmp;
}