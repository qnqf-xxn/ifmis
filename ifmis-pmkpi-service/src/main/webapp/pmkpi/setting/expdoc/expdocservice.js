if(!Ext.lt.pmkpi)
	Ext.lt.pmkpi = {};

Ext.lt.pmkpi.expdocservice = function(config, service){
	var perfcommon = Ext.lt.pmkpi.perfcommon(config, service);
	var cmp = {};
	var serviceid = service,
		_tablecode,
		_scrWidth =document.body.clientWidth,
		_scrHeight =document.body.clientHeight;

	Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
		var uiconfig = obj.table.uiconfig;
		_tablecode = uiconfig.tablecode;
	});

	Ext.lt.pmkpi.query = function(){
		cmp.query();
	}

	cmp.query = function (){
		var params = {};
		params.tablecoe = _tablecode;
		params.queryConfig = queryform.getQueryParam();
		params.querySql = queryform.getQuerySQL();
		params.beanid = "pmkpi.setting.expdoc.ExpdocBOTX";
		Ext.lt.bus.exportBeanid = params.beanid;
		datatable.queryData(params, function () {
			Ext.lt.ui.loadingClose();
		});
	}
	cmp.add = function (){
		var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
		var newdata ={};
		newdata.mainguid = newguid;
		newdata.pagetype = "add";
		newdata.maintablecode = _tablecode;
		var url = "/pmkpi/setting/expdoctemp.page";
		url = Ext.lt.pmkpi.genPageUrl(url, newdata);
		Ext.lt.ui.openModalWindow(url,_scrWidth * 0.8, _scrHeight * 0.8,"新增模板");
	}

	cmp.mod = function (){
		var data = datatable.getSelected();
		if(data.length != 1){
			Ext.lt.ui.alert("请选择一条要修改的数据！",function(){});
			return;
		}
		var params = {};
		params.maintablecode = _tablecode;
		params.mainguid = data[0].guid;
		params.pagetype = "mod";
		var url = "/pmkpi/setting/expdoctemp.page";
		url = Ext.lt.pmkpi.genPageUrl(url, params);
		Ext.lt.ui.openModalWindow(url,_scrWidth * 0.8, _scrHeight * 0.8,"修改模板");
	}

	cmp.del = function (){
		var data = datatable.getSelected();
		Ext.lt.ui.confirm('是否删除已选中数据？',null,function(is){
			if(is){
				Ext.lt.ui.loadingShow();
				var params = {};
				params.datas = data
				params.tablecode = _tablecode;
				Ext.lt.RCP.call(service , "del", params, function(rs){
					Ext.lt.ui.loadingClose();
					if (rs.flg=="1") {
						Ext.lt.ui.alert('删除成功！',function(){
							cmp.query();
						});
					}
				},function(){
					Ext.lt.ui.loadingClose();
					Ext.lt.ui.alert('删除失败！',function(){
					});
				});
			}
		})
	}
	Ext.lt.message.hook("queryform", "doquery",function(obj){
		cmp.query();
	});

	$(function () {
		perfcommon.initDatatable();
		cmp.query();
	})
	return cmp;
}
