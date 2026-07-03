if(!Ext.lt.pmkpi) 
	Ext.lt.pmkpi = {};
/**
 * 初始化加载.
 */
Ext.lt.pmkpi.majorpolicyselpro = function(config, serviceid) {
	var common = Ext.lt.pmkpi.perfcommon(config, serviceid);
	var _defquery,//列表查询条件
		_cfgquerysql,
		_orderby,//排序
		_tablecode;//表名
	var _cmp = {};
	var _menuid = config.menuid;

	/**
	 * 页面加载完成
	 */
	$(function() {
		common.initDatatable();
		_cmp.query();
		window.parent.indexwindow = window;
	})

	/**
	 * 重画表格列.
	 */
	Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
		var cols = obj.cols;
		if(!Ext.lt.isArray(cols))
			cols = [cols];
		for(var i=0; i<cols.length; i++){
			var col = cols[i];
			if (col["name"] != "check") {
				col.style = "background-color:#f2f2f2;";
				col.oneditstart = function (table, e, l, c, d) {
					return false;
				}
			}

		}
	});

	Ext.lt.message.hook("busdatatable", "drawed",function (obj) {
		var uiconfig = obj.uiconfig;
		_tablecode = uiconfig.tablecode;
		_defquery = uiconfig.defquery;
		_orderby = uiconfig.orderby;
		var config =obj.config;
		_cfgquerysql = config.cfgquerysql;
	});

	Ext.lt.message.hook("queryform", "doquery",function(obj){
		_cmp.query();
	});

	/**
	 * 关闭
	 * @param obj
	 */
	_cmp.closewin = function(){
		parent.Ext.lt.ui.modalWindow.close();
	}
	/**
	 * 查询
	 */
	_cmp.query = function(){
		var params = {};
		params.beanid = "pmkpi.transpaypro.TranspayProIndexBOTX";
		params.type = "selectpro";
		params.tablecode = _tablecode;
		params.tablesql = _defquery;
		params.cfgquerysql = _cfgquerysql;
		params.queryConfig = queryform.getQueryParam();
		params.querySql = queryform.getQuerySQL();
		params.menuid = _menuid;
		Ext.lt.ui.loadingShow();
		datatable.queryData(params,function(){
        	Ext.lt.ui.loadingClose();
        });
	}

	/**
	 * 确定
	 */
	_cmp.save = function(){
		var selDatas = datatable.getSelected();
		if (selDatas.size() <= 0) {
			Ext.lt.ui.alert('请选择要新增的项目！', function () {
			});
			return;
		}
		var parentDatas = parent.datatable.getRecordSet().toArray();
		for(var j=0; j<parentDatas.length; j++) {
			for(var i=0; i<selDatas.length; i++) {
				if (selDatas[i].pro_code == parentDatas[j].pro_code) {
					Ext.lt.ui.alert('['+selDatas[i].pro_name+']项目已填报，请不要重复选择！', function () {
					});
					return;
				}
			}
		}
		for(var i=0; i<selDatas.length; i++) {
			var data = selDatas[i];
			// data.guid = getCreateguid(serviceid);
			data.rowtype = "add";
			data.isedit = 1;
			data.ordernum = datatable.getRecordSet().toArray().size+i+1;
			data.finintorgguid = data.bgt_mof_dep_code ? data.bgt_mof_dep_code : data.finintorgguid;
		}
		parent.getdataSource();
		parent.datatable.getRecordSet().addData(selDatas);
		parent.Ext.lt.ui.modalWindow.close();
	}

	return _cmp;
}