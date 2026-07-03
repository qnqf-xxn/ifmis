if(!Ext.lt.pmkpi){
	Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.deptfunction){
	Ext.lt.pmkpi.deptfunction = {};
}
var serviceid;
var _mainguid;
var _saveAgency;
var _menuid;
var _viewtype;
Ext.lt.pmkpi.deptfunction = function(config, service){
	var
		_tablecode,//表名
		_defquery,//表配置过滤条件
		_orderby,//表排序sql
		_busguid,//审核定义
		_modelguid,//指标模板guid
		_deldatas = new Array()//删除数据集合
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

	Ext.lt.pmkpi.query = function(){
		var params = {};
		params.tablesql = _defquery;
		params.orderby = _orderby;
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
		if (!datatable.checkAll()) return false;//先校验
		var params = {};
		params.datas = datatable.getRecordSet().toArray();
		params.updatas = datatable.getUpdataData();
		params.deldatas = _deldatas;
		params.tablecode = _tablecode;
		params.busguid = _busguid;
		params.mainguid = _mainguid;
		Ext.lt.ui.loadingShow();
		var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
		Ext.lt.ui.loadingClose();
		cmp.query();
		return rs;
	}
	/**
	 * 新增部门职能
	 */
	cmp.addfunction =function() {
		var data = {};
		var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
		data.guid = newguid;
		data.rowtype = "add";
		data.mainguid = _mainguid;
		data.key_work = "";
		data.dept_function = "";
		Ext.lt.pmkpi.isadd = true;
		datatable.getRecordSet().addData(data,999);
	}
	/**
	 * 删除
	 */
	cmp.delrow =function() {
		var selecteddata = datatable.getSelected();
		if(selecteddata.length < 1){
			Ext.lt.ui.alert("请选择要删除的数据！",function(){});
			return;
		}
		Ext.lt.ui.confirm("是否确定删除选定数据？",{icon:"warn"},function(ret){
			if(ret){
				for(var i=0;i<selecteddata.length;i++){
					var parent_sel_rows = datatable.getRecordset().query({guid:selecteddata[i].guid});
					var parent_sel_obj = parent_sel_rows[0];
					var _sortid = parent_sel_obj._sortid;
					datatable.getRecordset().delRow(_sortid);
				}
				_deldatas.push.apply(_deldatas,selecteddata.toArray());
			}
		});
	}
	/**
	 * 新增重点工作
	 */
	cmp.addwork =function() {
		var selecteddata = datatable.getSelected();
		if(selecteddata.length != 1){
			Ext.lt.ui.alert("请选择一条部门职能！",function(){});
			return;
		}
		var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
		var data = {};
		data.guid = newguid;
		data.rowtype = "add";
		data.mainguid = _mainguid;
		data.key_work = "";
		data.dept_function = selecteddata[0].dept_function;
		Ext.lt.pmkpi.isadd = true;

		var parent_sel_rows = datatable.getRecordset().query({guid:selecteddata[0].guid});
		var parent_sel_obj = parent_sel_rows[0];
		var _sortid = parent_sel_obj._sortid;
		datatable.getRecordSet().addData(data,_sortid);
		datatable.reflash(_sortid);
	}
	/**
	 * 选择对应项目
	 */
	cmp.addproject = function(){
		var selecteddata = datatable.getSelected();
		if(selecteddata.length != 1){
			Ext.lt.ui.alert("请选择一条重点工作！",function(){});
			return;
		}
		var url = '/pmkpi/projapplyjs/dept/perffunctionproj.page';
		var params = {};
		params.key_work = selecteddata[0].key_work;
		params.saveAgency = _mainguid;
		params.mainguid = selecteddata[0].guid;
		url = Ext.lt.pmkpi.genPageUrl(url, params);
		height = _scrHeight*0.8;
		width = _scrWidth*0.8;
		indexwindow = Ext.lt.ui.openModalWindow(url,width,height,"选择项目");
	}
	/**
	 * 清空对应项目
	 */
	cmp.clearproject = function(){
		var selecteddata = datatable.getSelected();
		if(selecteddata.length != 1){
			Ext.lt.ui.alert("请选择一条重点工作！",function(){});
			return;
		}
		Ext.lt.ui.confirm("是否确定选定数据清空对应项目？",{icon:"warn"},function(ret){
			if(ret){
				var params = {};
				params.guid = selecteddata[0].guid;
				params.tablecode = _tablecode;
				Ext.lt.ui.loadingShow();
				var rs = Ext.lt.RCP.asyncall(serviceid , "clearproject", params);
				Ext.lt.ui.loadingClose();
				cmp.query();
			}
		});
	}


	$(function () {
		Ext.lt.pmkpi.query();
	})

	Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
		var cols = obj.cols;
		if(!Ext.lt.isArray(cols))
			cols = [cols];
		for(var i=0; i<cols.length; i++){
			var col = cols[i];

			if(col["colcode"] == "dept_function"){
				var findex = "";
				var subfindex = "";
				col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
					if(j==2){
						var tabledata = datatable.getRecordSet().toArray();
						var statnum = 0;
						if(i==statnum){
							findex = Ext.lt.cloneobj(rs["dept_function"]);
						}
						if(findex == rs["dept_function"]){
							style ='style="border-bottom-style:none;text-align:center;position:relative;padding-top:5px;';
						} else {
							style ='style="border-top-width:1px;text-align:center;border-top-color:#cccccc;border-bottom-style:none;';
						}
						if("" == rs["dept_function"]){
							style =style +'background-color: rgb(237, 255, 245);';
						}
						findex = Ext.lt.cloneobj(rs["dept_function"]);
						if(i == tabledata.length-1){
							style =style +'border-bottom-style:solid;"';
						} else {
							style =style + '"';
						}
						if(datatable.uiconfig.totaltag ==1 && i==0){ //有权重的合计
							style ='style="border-bottom-style:none;text-align:center;position:relative;padding-top:5px;"';
						}
					}
					return style;
				}
				col.fn = function(i,c,rs,value){ //行的显示样式.
					if(rs["dept_function"]){
						subfindex = Ext.lt.cloneobj(rs["dept_function"]);
						var seq = showMidleName(subfindex,"dept_function");
						if(i==seq){
							return value;
						}
						return "";
					}
				}

				col.oneditstart = function (table, el, l, c, d) {
					if(d.dept_function!=""){
						return false;
					}
				}
			}

		}
	});


	return cmp;
}

showMidleName = function(val,col){
	var tabledata = datatable.getRecordSet().toArray();
	var a = -1,b=-1;
	var atemp = {};
	for ( var i = 0; i < tabledata.length; i++) {
		atemp = tabledata[i];
		if(val == atemp[col]){
			a = atemp["_sortid"]; //首次出现值
			break;
		}
	}
	var btemp = {};
	for ( var i = tabledata.length-1; i >-1; i--) {
		btemp = tabledata[i];
		if(val == btemp[col]){
			b = btemp["_sortid"]; //结束出现值
			break;
		}
	}
	return parseInt((b-a)/2)+a;
}
