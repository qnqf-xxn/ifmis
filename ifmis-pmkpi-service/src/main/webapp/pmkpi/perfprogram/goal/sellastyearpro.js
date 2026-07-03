if(!Ext.lt.pmkpi)
	Ext.lt.pmkpi = {};
/**
 * 初始化加载.
 */
Ext.lt.pmkpi.sellastyearpro = function(config, serviceid) {
	var common = Ext.lt.pmkpi.perfcommon(config, serviceid);
	var _busguid = config.busguid;
	var _pro_code = config.pro_code;
	var _agency_code = config.agency_code;
	var _type = config.type;
	var _defquery,//列表查询条件
		_orderby,//排序
		_tablecode;//表名
	var _cmp = {};
	var _selpro = config.selpro;
	var height = Math.floor(document.documentElement.clientHeight * 0.9);
	var width =  Math.floor(document.documentElement.clientWidth * 0.9);

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
		var uiconfig = obj.table.uiconfig;
		_tablecode = uiconfig.tablecode;
		_defquery = uiconfig.defquery;
		_orderby = uiconfig.orderby;
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
	})

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
		params.beanid = "pmkpi.perfprogram.goal.SelLastYearProBOTX";
		params.agency_code = _agency_code;
		params.tablecode = _tablecode;
		params.tablesql = _defquery;
		params.orderby = _orderby;
		Ext.lt.ui.loadingShow();
		Ext.lt.bus.exportBeanid = params.beanid;
		datatable.queryData(params,function(){
			if(_selpro.size()>0){ // 存在选中数据做回显
				var alltabledata = datatable.getRecordSet().toArray();
				for (var j = 0; j < alltabledata.length; j++) {
					var order = alltabledata[j]._sortid;
					for (var index = 0; index < _selpro.length; index++) {
						var repData = _selpro[index];
						if (repData.last_pro_code == alltabledata[j].pro_code) {
							var insData = alltabledata[order];
							insData.check = 1;
							datatable.getRecordset().setData({}, order);
							insData._locationposition = order;
							datatable.getRecordset().setData(insData, order);
							_selpro.remove(index);
							break;
						}
					}
				}
			}
			datatable.redraw();
			Ext.lt.ui.loadingClose();
		});
	}

	/**
	 * 确定
	 */
	_cmp.save = function(){
		var selDatas = datatable.getSelected();
		var params = {};
		params.selpros = selDatas;
		params.pro_code = _pro_code;
		params.busguid = _busguid;
		params.ismultipro = true;
		params.procode = _pro_code;
		params.isconfirm = true;
		Ext.lt.ui.loadingShow();
		var rs = Ext.lt.RCP.asyncall(serviceid , "saveData", params);
		Ext.lt.ui.loadingClose();
		if (rs && rs.success) {
			if(_type && _type == "fromgoal"){ //目标来源，返回填充editform
				if(parent.editform){
					parent.editform.synchEditformByObj(rs.data);
				}
				if(parent.yeareditform){
					parent.yeareditform.synchEditformByObj(rs.data);
				}
				parent.Ext.lt.pmkpi.alert("复制成功！",function(){});
				parent.Ext.lt.ui.modalWindow.close();
			}else if (_type && _type == "fromindex"){ //指标来源，返回弹出对应项目的上年指标
				parent.Ext.lt.ui.modalWindow.close();
				var params = {};
				var url = '/pmkpi/program/prjindex/lastyear.page';
				params.fromtype = "tree";//树级填报
				params.procode = _pro_code;
				params.ismultipro = "1";
				url = Ext.lt.pmkpi.genPageUrl(url, params);
				parent.Ext.lt.ui.openModalWindow(url,width,height,"上年指标");
			}
		} else {
			Ext.lt.pmkpi.alert(rs.error,function(){});
		}
		return rs;
	}

	return _cmp;
}