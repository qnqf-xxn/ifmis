if(!Ext.lt.pmkpi){
	Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.deptperfindex){
	Ext.lt.pmkpi.deptperfindex = {};
}
var serviceid;
var _mainguid;
var _saveAgency;
var _menuid;
var _viewtype;
var _deldatas = new Array();
Ext.lt.pmkpi.deptperfindex = function(config, service){
	var
		_tablecode,//表名
		_defquery,//表配置过滤条件
		_orderby,//表排序sql
		_busguid,//审核定义
		_modelguid//指标模板guid
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
			datatable1.setDatas(rs.data1);
			datatable2.setDatas(rs.data2);
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
		if (!datatable1.checkAll()) return false;//先校验
		if (!datatable2.checkAll()) return false;//先校验
		var params = {};
		params.data1 = datatable1.getRecordSet().toArray();
		params.data2 = datatable2.getRecordSet().toArray();
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

	$(function () {
		cmp.query();
	})

	Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
		var cols = obj.cols;
		var key = obj.table.key;
		if(!Ext.lt.isArray(cols))
			cols = [cols];
		for(var i=0; i<cols.length; i++){
			var col = cols[i];

			if(col["colcode"]=="cz"){
				col.fn = function(l,c,data,col){
					var html = "";
					html += "&nbsp;&nbsp;&nbsp;&nbsp;<a herf='#' title = '新增' style='color:#468ac9;cursor:pointer;' onclick=\"addTableRow('"+data["findex"]+"','"+data["sindex"]+"','"+data["guid"]+"','"+data["keywork"]+"');\">新增</a>"
					if(data["name"] && data["name"] != ""){
						html += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a herf='#' title = '修改' style='color:#468ac9;cursor:pointer' onclick=\"updateTableRow('"+data["guid"]+"','"+data["keywork"]+"');\">修改</a>";
						html += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a herf='#' title = '删除' style='color:#468ac9;cursor:pointer' onclick=\"delTableRow('"+data["guid"]+"','"+data["keywork"]+"');\">删除</a>";
					}
					return html;
				}
			}
			if(key == "/pmkpi/projapplyjs/dept/perfindex1"){
				if(col["colcode"] == "findex"){
					var findex = "";
					var subfindex = "";
					col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
						if(j==2){
							var tabledata1 = datatable1.getRecordSet().toArray();
							var statnum = 0;
							if(i==statnum){
								findex = Ext.lt.cloneobj(rs["findex"]);
							}
							if(findex == rs["findex"]){
								style ='style="border-bottom-style:none;text-align:center;position:relative;padding-top:5px;';
							} else {
								style ='style="border-top-width:1px;text-align:center;border-top-color:#cccccc;border-bottom-style:none;';
							}
							findex = Ext.lt.cloneobj(rs["findex"]);
							if(i == tabledata1.length-1){
								style =style +'border-bottom-style:solid;"';
							} else {
								style =style + '"';
							}
						}
						return style;
					}
					col.fn = function(i,c,rs,value){ //行的显示样式.
						if(rs["findex"]){
							subfindex = Ext.lt.cloneobj(rs["findex"]);
							var seq = showMidleName1(subfindex,"findex");
							if(i==seq){
								return value;
							}
							return "";
						}
					}
				}

				if(col["colcode"] == "sindex"){
					var sindex = "";
					var subsindex = "";
					col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
						if(j==3){
							var tabledata1 = datatable1.getRecordSet().toArray();
							var statnum = 0;
							if(i==statnum){
								sindex = Ext.lt.cloneobj(rs["sindex"]);
							}
							if(sindex == rs["sindex"]){
								style ='style="border-bottom-style:none;text-align:center;position:relative;padding-top:5px;';
							} else {
								style ='style="border-top-width:1px;text-align:center;border-top-color:#cccccc;border-bottom-style:none;';
							}
							sindex = Ext.lt.cloneobj(rs["sindex"]);
							if(i == tabledata1.length-1){
								style =style +'border-bottom-style:solid;"';
							} else {
								style =style + '"';
							}
						}
						return style;
					}
					col.fn = function(i,c,rs,value){ //行的显示样式.
						if(rs["sindex"]){
							subsindex = Ext.lt.cloneobj(rs["sindex"]);
							var seq = showMidleName1(subsindex,"sindex");
							if(i==seq){
								return value;
							}
							return "";
						}
					}
				}
			}
			if(key == "/pmkpi/projapplyjs/dept/perfindex2"){
				if(col["colcode"] == "findex"){
					var findex = "";
					var subfindex = "";
					col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
						if(j==2){
							var tabledata2 = datatable2.getRecordSet().toArray();
							var statnum = 0;
							if(i==statnum){
								findex = Ext.lt.cloneobj(rs["findex"]);
							}
							if(findex == rs["findex"]){
								style ='style="border-bottom-style:none;text-align:center;position:relative;padding-top:5px;';
							} else {
								style ='style="border-top-width:1px;text-align:center;border-top-color:#cccccc;border-bottom-style:none;';
							}
							findex = Ext.lt.cloneobj(rs["findex"]);
							if(i == tabledata2.length-1){
								style =style +'border-bottom-style:solid;"';
							} else {
								style =style + '"';
							}
						}
						return style;
					}
					col.fn = function(i,c,rs,value){ //行的显示样式.
						if(rs["findex"]){
							subfindex = Ext.lt.cloneobj(rs["findex"]);
							var seq = showMidleName2(subfindex,"findex");
							if(i==seq){
								return value;
							}
							return "";
						}
					}
				}

				if(col["colcode"] == "sindex"){
					var sindex = "";
					var subsindex = "";
					col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
						if(j==3){
							var tabledata2 = datatable2.getRecordSet().toArray();
							var statnum = 0;
							if(i==statnum){
								sindex = Ext.lt.cloneobj(rs["sindex"]);
							}
							if(sindex == rs["sindex"]){
								style ='style="border-bottom-style:none;text-align:center;position:relative;padding-top:5px;';
							} else {
								style ='style="border-top-width:1px;text-align:center;border-top-color:#cccccc;border-bottom-style:none;';
							}
							sindex = Ext.lt.cloneobj(rs["sindex"]);
							if(i == tabledata2.length-1){
								style =style +'border-bottom-style:solid;"';
							} else {
								style =style + '"';
							}
						}
						return style;
					}
					col.fn = function(i,c,rs,value){ //行的显示样式.
						if(rs["sindex"]){
							subsindex = Ext.lt.cloneobj(rs["sindex"]);
							var seq = showMidleName2(subsindex,"sindex");
							if(i==seq){
								return value;
							}
							return "";
						}
					}
				}

				if(col["colcode"] == "keywork"){
					var keywork = "";
					var subkeywork = "";
					col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
						if(j==4){
							var tabledata2 = datatable2.getRecordSet().toArray();
							var statnum = 0;
							if(i==statnum){
								keywork = Ext.lt.cloneobj(rs["keywork"]);
							}
							if(keywork == rs["keywork"]){
								style ='style="border-bottom-style:none;text-align:center;position:relative;padding-top:5px;';
							} else {
								style ='style="border-top-width:1px;text-align:center;border-top-color:#cccccc;border-bottom-style:none;';
							}
							keywork = Ext.lt.cloneobj(rs["keywork"]);
							if(i == tabledata2.length-1){
								style =style +'border-bottom-style:solid;"';
							} else {
								style =style + '"';
							}
						}
						return style;
					}
					col.fn = function(i,c,rs,value){ //行的显示样式.
						if(rs["keywork"]){
							subkeywork = Ext.lt.cloneobj(rs["keywork"]);
							var seq = showMidleName2(subkeywork,"keywork");
							if(i==seq){
								return value;
							}
							return "";
						}
					}
				}

				if(col["colcode"] == "projects"){
					var projects = "";
					var subprojects = "";
					col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
						if(j==5){
							var tabledata2 = datatable2.getRecordSet().toArray();
							var statnum = 0;
							if(i==statnum){
								projects = Ext.lt.cloneobj(rs["projects"]);
							}
							if(projects == rs["projects"]){
								style ='style="border-bottom-style:none;text-align:center;position:relative;padding-top:5px;';
							} else {
								style ='style="border-top-width:1px;text-align:center;border-top-color:#cccccc;border-bottom-style:none;';
							}
							projects = Ext.lt.cloneobj(rs["projects"]);
							if(i == tabledata2.length-1){
								style =style +'border-bottom-style:solid;"';
							} else {
								style =style + '"';
							}
						}
						return style;
					}
					col.fn = function(i,c,rs,value){ //行的显示样式.
						if(rs["projects"]){
							subprojects = Ext.lt.cloneobj(rs["projects"]);
							var seq = showMidleName2(subprojects,"projects");
							if(i==seq){
								return value;
							}
							return "";
						}
					}
				}
			}

			if(col["colcode"] == "halfindexval"){
				col.fn = function(l,c,data,col){
					if(data.computesign != "6"){
						if(data.score){
							score = data.score;
						}
						return data.halfindexval + (data.meterunit!=undefined ? data.meterunit : "");
					}else{
						return data.halfindexval;
					}
				}
			}

			if(col["colcode"] == "indexval"){
				col.fn = function(l,c,data,col){
					if(data.computesign != "6"){
						if(data.score){
							score = data.score;
						}
						return data.indexval + (data.meterunit!=undefined ? data.meterunit : "");
					}else{
						return data.indexval;
					}
				}
			}

		}
	});


	return cmp;
}

showMidleName1 = function(val,col){
	var tabledata1 = datatable1.getRecordSet().toArray();
	var a = -1,b=-1;
	var atemp = {};
	for ( var i = 0; i < tabledata1.length; i++) {
		atemp = tabledata1[i];
		if(val == atemp[col]){
			a = atemp["_sortid"]; //首次出现值
			break;
		}
	}
	var btemp = {};
	for ( var i = tabledata1.length-1; i >-1; i--) {
		btemp = tabledata1[i];
		if(val == btemp[col]){
			b = btemp["_sortid"]; //结束出现值
			break;
		}
	}
	return parseInt((b-a)/2)+a;
}

showMidleName2 = function(val,col){
	var tabledata2 = datatable2.getRecordSet().toArray();
	var a = -1,b=-1;
	var atemp = {};
	for ( var i = 0; i < tabledata2.length; i++) {
		atemp = tabledata2[i];
		if(val == atemp[col]){
			a = atemp["_sortid"]; //首次出现值
			break;
		}
	}
	var btemp = {};
	for ( var i = tabledata2.length-1; i >-1; i--) {
		btemp = tabledata2[i];
		if(val == btemp[col]){
			b = btemp["_sortid"]; //结束出现值
			break;
		}
	}
	return parseInt((b-a)/2)+a;
}

addTableRow = function(findex,sindex,guid,keywork){
	var datatable =datatable1;
	var isfunction = 0;
	if(keywork!="undefined" && keywork!=""){
		datatable =datatable2;
		isfunction = 1;
	}
	var delrows = datatable.getRecordset().query({guid:guid});
	if (delrows && delrows.length>0) {
		var delobj = delrows[0];
		var _sortid = delobj._sortid;
		if(!delobj.name || delobj.name == ""){
			updateTableRow(guid,keywork);
		}else{
			var formobj = {};
			formobj["mainguid"] =_mainguid;
			formobj["findex"] = delobj["findex"];
			formobj["sindex"] = delobj["sindex"];
			formobj["isfunction"] = isfunction;
			if(isfunction == 1){
				formobj["keywork"] = delobj["keywork"];
				formobj["projects"] = delobj["projects"];
			}
			var uuid = createUUID().replace(/-/g, '');
			formobj["guid"] = uuid;
			datatable.getRecordSet().addData(formobj,_sortid);
			updateTableRow(uuid,keywork);
		}
	}
}

updateTableRow = function(guid,keywork){
	var url = '/pmkpi/projapplyjs/dept/perfindexedit.page';
	var params = {};
	params.guid = guid;
	params.datatable = (keywork!="undefined" && keywork!="") ? "datatable2" : "datatable1";
	url = Ext.lt.pmkpi.genPageUrl(url, params);
	height = _scrHeight*0.8;
	width = _scrWidth*0.5;
	indexwindow = Ext.lt.ui.openModalWindow(url,width,height,"编辑指标");
}

delTableRow = function(guid,keywork){
	Ext.lt.ui.confirm("确认要删除选中指标？",{icon:"warn"},function(ret){
		if(ret){
			var datatable =datatable1;
			if(keywork!="undefined" && keywork!=""){
				datatable =datatable2;
			}
			var delrows = datatable.getRecordset().query({guid:guid});
			if (delrows && delrows.length>0) {
				var delobj = delrows[0];
				var _sortid = delobj._sortid;
				//判断二级下是否还有没有保留一条空的二级
				var delrow = datatable.getRecordset().query({guid:guid});
				if(delrow.length == 1){
					var formobj = {};
					formobj["mainguid"] =_mainguid;
					formobj["findex"] = delobj["findex"];
					formobj["sindex"] = delobj["sindex"];
					var uuid = createUUID().replace(/-/g, '');
					formobj["guid"] = uuid;
					datatable.getRecordSet().addData(formobj,_sortid);
				}
				datatable.getRecordset().delRow(_sortid);
				_deldatas.push.apply(_deldatas,delrows.toArray());
			}
		}
	})
}