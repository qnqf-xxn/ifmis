if(!Ext.lt.pmkpi)
	Ext.lt.pmkpi = {};

var serviceid;
Ext.lt.pmkpi.aisupportauditexe = function(config, service){
	var cmp = {};
	var common = Ext.lt.pmkpi.perfcommon(config, service);
	var _tablecode,
		_tabfilter,//页签查询条件
		_tabcode,//页签编码
		_agency,
		_agency_name,
		_defquery,
		_typequery,
		_menuid = config.menuid,
		_apicode = config.apicode,
		_scrWidth = document.body.clientWidth,
		_scrHeight = document.body.clientHeight;
	serviceid = service;
	var isfirst = true;

	$(function (){
		common.initDatatable();
		if(isfirst){
			Ext.lt.pmkpi.query();
		}
		isfirst = false;
	})

	Ext.lt.message.hook("queryform", "doquery",function(obj){
		Ext.lt.pmkpi.query();
	});

	Ext.lt.message.hook("perfcommon", "tablequery",function(){
		Ext.lt.pmkpi.query();
	});

	Ext.lt.message.hook("left", "click",function(obj){
		var treeNode = obj.node.data;
		if(treeNode){
			_agency = treeNode.guid;
			_agency_name = treeNode.name;
			Ext.lt.pmkpi.isleaf = treeNode.isleaf;
		} else {
			_agency = "treeroot";
			Ext.lt.pmkpi.isleaf = '0';
		}
		Ext.lt.pmkpi.query();
	});

    /**
	 * 查询
     */
	Ext.lt.pmkpi.query = function(){
		if(!_agency){
			_agency = "treeroot";
			Ext.lt.pmkpi.isleaf = 0;
		}
		var params = {};
		Ext.lt.ui.loadingShow();
		params.agency = _agency;
		params.isleaf = Ext.lt.pmkpi.isleaf + "";
		params.tablecode = _tablecode;
		if (_defquery) {
			params.tablesql = _typequery ? _defquery + " and " + _typequery : _defquery;
		} else {
			params.tablesql = _typequery || "";
		}
		params.tabcode = _tabcode;
		params.tabfilter = _tabfilter;
		params.queryConfig = queryform.getQueryParam();
		params.querySql = queryform.getQuerySQL();
		params.menuid = _menuid;
		params.api_code = _apicode;
		params.beanid = "pmkpi.aisupportaudit.AISupportAuditExeBOTX";
		Ext.lt.bus.exportBeanid = params.beanid;
		datatable.queryData(params,function(){
			Ext.lt.ui.loadingClose();
		});
	}

	/**
	 * 提交批量审核任务
	 */
	cmp.batchAudit = function(obj){
		var datas = datatable.getSelected();
		if (datas.length <= 0) {
			Ext.lt.ui.alert("请选择要【" + obj["name"] + "】的数据！");
			return;
		}
		var apicode = _apicode;
		if(_tabcode == "done"){
			Ext.lt.ui.confirm("已经存在智能审核结果，是否重新生成?",{icon:"warn"},function(ret){
				if(ret){
					cmp.doAudit(apicode,datas);
				}
			});
		}else{
			cmp.doAudit(apicode,datas);
		}
	}
	cmp.doAudit = function(apicode,datas){
		var params={};
		params.apicode = apicode;
		params.datas =  datas;
		Ext.lt.RCP.call(serviceid, "batchAudit", params, function(rs){
			if (rs && rs.success == true) {
				Ext.lt.ui.alert('提交批量审核任务成功！',function(){
					Ext.lt.pmkpi.query();
				});
			} else {
				if (rs && rs.msg) {
					Ext.lt.ui.alert(rs.msg,function(){
						Ext.lt.ui.loadingClose();
					});
				} else {
					Ext.lt.ui.alert('提交批量审核任务失败！',function(){
						Ext.lt.ui.loadingClose();
					});
				}
			}
			Ext.lt.ui.loadingClose();
		}, function(){
			Ext.lt.ui.alert('提交批量审核任务失败！',function(){
			});
			Ext.lt.ui.loadingClose();
		});
	}


	/**
	 * 清空审核结果
	 */
	cmp.clearAudit = function(obj){
		var datas = datatable.getSelected();
		if (datas.length <= 0) {
			Ext.lt.ui.alert("请选择要【" + obj["name"] + "】的数据！");
			return;
		}
		Ext.lt.ui.confirm("是否确认清空所选数据的审核结果?",{icon:"warn"},function(ret){
			if(ret){
				var params={};
				params.datas = datas;
				params.apicode = _apicode;
				Ext.lt.RCP.call(serviceid, "clearAudit", params, function(rs){
					if (rs && rs.success == true) {
						Ext.lt.ui.alert('清空审核结果成功！',function(){
							Ext.lt.pmkpi.query();
						});
					} else {
						if (rs && rs.msg) {
							Ext.lt.ui.alert(rs.msg,function(){
								Ext.lt.ui.loadingClose();
							});
						} else {
							Ext.lt.ui.alert('清空审核结果失败！',function(){
								Ext.lt.ui.loadingClose();
							});
						}
					}
					Ext.lt.ui.loadingClose();
				}, function(){
					Ext.lt.ui.alert('清空审核结果失败！',function(){
					});
					Ext.lt.ui.loadingClose();
				});
			}
		});
	}

	/**
	 * 查看审核结果
	 */
	cmp.showAuditDetail = function (obj){
		var apicode = _apicode;
		var datas = datatable.getSelected();
		var url = "/pmkpi/common/aisupportauditdetail.page";
		var params = {};
		params.isloadtaskdata = "1";
		// {apicode:"PMKPI_AISUPPORTAUDITDETAIL"}
		if (apicode == "PMKPI_AISUPPORTAUDITDETAIL"){
			var data;
			if (datas.length != 1) {
				Ext.lt.ui.alert("请选择一条要【" + obj["name"] + "】的数据！");
				return;
			}else{
				data = datas[0];
			}
			params.pro_code = data.pro_code;
			url = "/pmkpi/common/aisupportauditdetail.page";

		}else if (apicode == "PMKPI_AIPREPERFAUDIT"){
			var data;
			if (datas.length != 1) {
				Ext.lt.ui.alert("请选择一条要【" + obj["name"] + "】的数据！");
				return;
			}else{
				data = datas[0];
			}
			params.pro_code = data.pro_code;
			url = "/pmkpi/common/aipreperfaudit.page";

		}else if (apicode == "PMKPI_AISUPPORTAUDIT"){
			if (datas.length <= 0) {
				Ext.lt.ui.alert("请选择要【" + obj["name"] + "】的数据！");
				return;
			}
			url = "/pmkpi/common/aisupportaudit.page";
		}
		url = Ext.lt.pmkpi.genPageUrl(url, params);
		Ext.lt.ui.openModalWindow(url, _scrWidth * 0.9, _scrHeight * 0.9, "智能辅助审核结果查看");
	}

	/**
	 * 查看项目年度绩效详情
	 */
	cmp.showProDetail = function (obj){
		var datas = datatable.getSelected();
		var data;
		if (datas.length != 1) {
			Ext.lt.ui.alert("请选择一条要【" + obj["name"] + "】的数据！");
			return;
		}else{
			data = datas[0];
		}
		var url = "/pmkpi/yearprogram/query/edit.page";
		var params = {};
		params.mainguid = data.guid;
		params.agency = data.agency_code;
		params.pro_code = data.pro_code;
		params.projectkind = data.projectkind;//项目类型
		params.viewtype = "query";
		url = Ext.lt.pmkpi.genPageUrl(url, params);
		Ext.lt.ui.openModalWindow(url, _scrWidth * 0.9, _scrHeight * 0.9, "项目绩效目标查看");
	}

	/**
	 * 删除失败任务
	 */
	cmp.clearError = function(obj){
		var datas = datatable.getSelected();
		if (datas.length <= 0) {
			Ext.lt.ui.alert("请选择要【" + obj["name"] + "】的数据！");
			return;
		}
		Ext.lt.ui.confirm("是否确认删除所选数据的审核执行记录?",{icon:"warn"},function(ret) {
			if (ret) {
				var params={};
				params.datas = datas;
				params.apicode = _apicode;
				Ext.lt.RCP.call(serviceid, "clearError", params, function(rs){
					if (rs && rs.success == true) {
						Ext.lt.ui.alert(obj["name"]+'成功！',function(){
							Ext.lt.pmkpi.query();
						});
					} else {
						if (rs && rs.msg) {
							Ext.lt.ui.alert(rs.msg,function(){
								Ext.lt.ui.loadingClose();
							});
						} else {
							Ext.lt.ui.alert(obj["name"]+'失败！',function(){
								Ext.lt.ui.loadingClose();
							});
						}
					}
					Ext.lt.ui.loadingClose();
				}, function(){
					Ext.lt.ui.alert(obj["name"]+'失败！',function(){
					});
					Ext.lt.ui.loadingClose();
				});
			}
		});
	}

	/**
	 * 切换页签方法
	 */
	cmp.clickTabpage = function(obj){
		common.changTooltoolbuttontStatus(0, obj.hidebtns);
		_tabcode = obj.code;
		if (!isfirst) {
			Ext.lt.pmkpi.query();
		}
	}

	Ext.lt.message.hook("datatable", "drawed",function(obj){
		var uiconfig = obj.uiconfig;
		//表配置
		_tablecode = uiconfig.tablecode;
		_defquery = uiconfig.defquery;
		if (uiconfig.config) {
			var uitable_configs=eval('('+uiconfig.config+')');
			if(uitable_configs){
				_typequery = uitable_configs[_apicode];
			}
		}

	});

	return cmp;
}
