if(!Ext.lt.pmkpi){
	Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.deptracetask){
	Ext.lt.pmkpi.deptracetask = {};
}
if(!Ext.lt.pmkpi.deptracetask.depterport){
	Ext.lt.pmkpi.deptracetask.depterport = {};
}

Ext.lt.pmkpi.deptracetask.depterportservice = function(config, service){
	var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
	window.parent.Ext.lt.pmkpi.childwindow = window;
	var cmp = {};
	var serviceid = service;
		_mainguid = config.mainguid,
		_agency = config.agency,
		_scrWidth =document.body.clientWidth,
		_scrHeight =document.body.clientHeight,
		_workflow = config.workflow,
		_tabData = config.tabData,
		_menuid = config.menuid,
		_uikey = config.uikey,
		_tokenid = config.tokenid,
		_selectyear = config.selectyear,
		_appid = config.appid,
		_flg = config.flg,
		//根据组件id存放表名
		_table_param = {};

	/**
	 * 基础信息保存
	 */
	cmp.infosave = function (obj){
		var params= {};
		params.isadd = Ext.lt.pmkpi.isadd;
		params.workflow = _workflow;
		deptcmp.savedatas(obj, params);
	}

	/**
	 * 页签方法
	 */
	cmp.clickTabpage = function(obj){
		deptcmp.tabpageOnclick(obj, _tabData, toolbutton);
	}

	Ext.lt.message.hook("addRow", "uidatatable", function(editdatatable){
		var config = editdatatable.config;
		var componentid = config.id;
		if(_onclickid == componentid){
			var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
			var newdata ={};
			newdata.guid = newguid;
			newdata.mainguid = _mainguid;
			newdata.rowtype = "add";
			newdata.findex = _table_param[_onclickid + "_findex"];
			eval(_onclickid).getRecordSet().addData(newdata,1);
		}
	});

	Ext.lt.message.hook("delRow", "uidatatable", function(editdatatable){
		var config = editdatatable.config;
		var componentid = config.id;
		if(_onclickid == componentid){
			var selDatas = eval(_onclickid).getSelected();
			if (selDatas.size() <= 0) {
				Ext.lt.ui.alert('请选择要删除的数据！',function(){
				});
				return;
			}
			Ext.lt.ui.confirm('是否删除已选择数据？',null,function(is){
				if(is){
					// var datas = eval(_onclickid).getRecordSet().toArray();
					eval(_onclickid).removeData(selDatas);
				}
			})
		}
	});
	/**
	 *
	 */
	Ext.lt.message.hook("busdatatable", "drawed",function (obj) {
		var config = obj.config;
		var componentid = config.id;
		_table_param[componentid] = obj.uiconfig.tablecode;
		_table_param[componentid + "_defquery"] = obj.uiconfig.defquery;
		_table_param[componentid + "_orderby"] = obj.uiconfig.orderby;
		_table_param[componentid + "_pagetype"] = config.pagetype;
		_table_param[componentid + "_indextable"] = config.indextable;
		_table_param[componentid + "_deltables"] = config.deltables;
		_table_param[componentid + "_delcols"] = config.delcols;
		_table_param[componentid + "_findex"] = config.findex;
		if (_flg == "query") {
			config.edit = false;
			config.addrow = false;
		}
	});

	Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
		var cols = obj.cols;
		if(!Ext.lt.isArray(cols))
			cols = [cols];
		for(var i=0; i<cols.length; i++){
			var col = cols[i];
			if(col["colcode"]=="obligate1"){
				if (_flg != "query"){
					col.style = " text-align:center;";
					col.fn = function(l,c,data,col){
						var html = "";
						if(data.levelno == "2"){
							html = '<a title = "新增" style="color:#468ac9;cursor:pointer;">新增</a>';
						}else if(data.levelno == "3"){
							html = '<a title = "删除" style="color:#468ac9;cursor:pointer;">删除</a>';
						}
						return html;
					}
					col.onclick = function(td, el, l, c, d) {
						var levelno = d.levelno;
						if (levelno == "2"){
							var url = "/pmkpi/deptracetask/report/addperfindex.page";
							var params = {};
							params.name = d.name;
							params.findex = d.findex;
							params.sindex = d.guid;
							url = Ext.lt.pmkpi.genPageUrl(url, params);
							Ext.lt.ui.openModalWindow(url,_scrWidth - 200, _scrHeight - 100,"部门绩效目标申报");
						} else if (levelno == "3"){
							Ext.lt.ui.confirm("你确定删除选定的数据？",{icon:"warn"},function(ret){
								if(ret){
									eval(_onclickid).removeData(d);
								}
							});
						}
					};
				}
			}

			if(col["colcode"]=="indexval"){
				if (_flg != "query"){
					col.fn = function(l,c,data,col){
						if(data.levelno == "3"){
							if(data.computesign == "6"){
								var indexvalue = !data.indexval? "" : data.indexval;
								return "<font style=\"margin-left:10px;\">" + indexvalue+"</font>";
							} else {
								var computesignstr ="";
								var computesign_source = [{guid:"1",code:"1",name:"≥"},{guid:"2",code:"2",name:">"},{guid:"3",code:"3",name:"="},{guid:"4",code:"4",name:"<"},{guid:"5",code:"5",name:"≤"},{guid:"6",code:"6",name:"定性"}]
								for(var i =0; i<computesign_source.size() ; i++){
									if(data.computesign == computesign_source[i].guid){
										computesignstr = computesign_source[i].name;
									}
								}
								var unit = "";
								if(data.meterunit){
									unit = data.meterunit;
								}
								var returnstr = !data.indexval ? computesignstr + unit :computesignstr + data.indexval + unit;
								return "<font style=\"margin-left:10px;\">"+returnstr+"</font>";
							}
						}
					}
					col.oneditstart = function (table, el, l, c, d) {
						if(d.levelno != "3"){
							return false;
						}
						el.innerText =  d.indexval!=undefined ? d.indexval : '';
						table.getCol(c).mapping = null;
						table.nowtype="input";
						table.getCol(c).format = "";
						// return;
					}
					col.oneditend = function (table, el, l, c, d) {
						if(d.computesign && d.computesign != '6'){
							if(!checkReferencepole(d.indexval)){
								d.indexval = '';
								return false;
							}
						}
					}
				}

			}

			if(col["colcode"]=="obligate2"){
				if (_flg != "query"){
					col.style = " text-align:center;";
					col.fn = function(l,c,data,col){
						var html = '<a title = "删除" style="color:#468ac9;cursor:pointer;">删除</a>';
						return html;
					}
					col.onclick = function(td, el, l, c, d) {
						Ext.lt.ui.confirm("你确定删除选定的数据？",{icon:"warn"},function(ret){
							if(ret){
								eval(_onclickid).removeData(d);
							}
						});
					};
				}
			}
		}
	});

	Ext.lt.pmkpi.addrow = function(data){
		var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
		data.guid = newguid;
		data.rowtype = "add";
		data.mainguid = _mainguid;
		data.sindex = data.sindex;
		data.findex = data.findex;
		data.superid = data.sindex;
		data.levelno = 3;
		data.isleaf = 1;
		Ext.lt.pmkpi.isadd = true;
		eval(_onclickid).getRecordSet().addData(data,999);
	}

	$(function(){
		if (_flg == "query") {
			for (var i=0; i < _tabData.length; i++){
				var tabconfig = eval('(' + _tabData[i].config + ')');
				var id = _tabData[i].componentid;
				deptcmp.tabinitpage(id,tabconfig);
			}
			document.getElementById("tabpage").style.display = "none";
			$("div[compid='toolbutton']").hide();
			document.getElementById("add").style.display = "none";
			document.getElementById("del").style.display = "none";
		}
	})

	/**
	 * 点击表格类型页签处理消息
	 */
	Ext.lt.message.hook("perfcommon", "tableinit",function(obj){
		var params = obj.params;
		params.menuid = _menuid;
		params.mainguid = _mainguid;
	});

	/**
	 * 点击表单类型处页签理消息
	 */
	Ext.lt.message.hook("perfcommon", "editinit",function(obj){
		var params = obj.params;
		params.mainguid = _mainguid;
		params.agency = _agency;
	});

	/**
	 * 点击报表类型处理消息
	 */
	Ext.lt.message.hook("perfcommon", "reportinit",function(obj){

	});

	/**
	 * 点击嵌套页面类型处理消息
	 */
	Ext.lt.message.hook("perfcommon", "iframeinit",function(obj){

	});

	cmp.close = function () {
		Ext.lt.ui.closeModalWindow();
		window.parent.Ext.lt.pmkpi.query();
	}
	return cmp;
}

