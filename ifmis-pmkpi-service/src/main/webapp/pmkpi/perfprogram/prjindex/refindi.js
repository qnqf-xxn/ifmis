if(!Ext.lt.pmkpi)
	Ext.lt.pmkpi = {};
/**
 * 初始化加载.
 */
Ext.lt.pmkpi.refindiservice = function(config, serviceid) {
	var _cmp = {};
	var currentNode; //树选中
	var tabcode; //页签选中
	var tabconfig = {}; //页签配置的{}；
	var tabfilter = ""; //页签过滤条件,用于赛选过滤指标的单位或者财政；还是案例的共性还是部门权限
	var _saveAgency = config.saveAgency;//单位id
	var _menuid =config.menuid;
	var _prolev = config.prolev;//项目级次
	var _fromtype = config["fromtype"]; //来源树级表格还是合并表格
	var i = 0;
	var _tableid ='';//父级树
	var onclicktab;//选中的页签
	var _signs = config["signs"]; //计算符号
	var showtab = config.showtab;//1总+年 2总 3年
	var proguid = config.proguid;//项目guid
	var isfirst = true;
	var isadjust = config.isadjust;//是否调整
	isZJ = config["isZJ"];//标识是否是浙江（1.浙江）
	var isHuBei = config["isHuBei"];//标识是否是湖北（1.湖北）
	var isSX = config["isSX"];//标识是否是山西（1.山西）
	var fundguid = config["fundguid"];
	var indmap = config["indmap"];//指标层次分类
	var sxflag = "";//山西查询标识(省级指标，市级指标，县级指标)
	var tabconf;//页签配置
	// /**
	//  * 页面布局完成.
	//  */
	Ext.lt.message.hook("layout", "endlayout2",function(){
		if (isfirst) {
			var height = $(".bd_main").height();
			var width = $("#recomtable").width();
			recomtable.resize(width,height);
			tab.doActiveTab(0);
			isfirst = false;
			if ("tree" == _fromtype){
				_tableid = "datatable";
			} else {
				_tableid = "indexdatatable";
			}
			/**
			 * 添加按钮,查询区位移
			 */
			if (isGreyStyle()) {
				$('.layui-tab-title').append("<button title='取消' onclick=\"closewin();\" type=\"button\" style=\"float:right;margin:0 6px 0 6px;background: rgb(255, 255, 255);" +
					"border: 1px solid rgb(220, 223, 230);color: rgb(89, 136, 255);line-height: normal;height: 33px;border-radius: 4px !important;\" " +
					"class=\"layui-btn btn-black\">取消</button>");
				$('.layui-tab-title').append("<button title='确定' onclick=\"addindex();\" type=\"button\" style=\"float:right;margin:0 6px 0 6px;background-color:#3472ef;line-height: normal;height: 33px;border-radius: 4px !important;\" " +
					"class=\"layui-btn btn-black\">确定</button>");
				if(isZJ == 1) {
					$('.layui-tab-title').append("<button title='新增指标' onclick=\"add();\" type=\"button\" style=\"float:right;margin:0 6px 0 6px;background-color:#3472ef;line-height: normal;height: 33px;border-radius: 4px !important;\" " +
						"class=\"layui-btn btn-black\">新增指标</button>");
				}
			}else{
				$('.layui-tab-title').append("<button title='取消' onclick=\"closewin();\" type=\"button\" style=\"float:right;margin:0 10px 0 10px;background-color:#3472ef;line-height: normal;height: 33px;\" class=\"layui-btn btn-black\">取消</button>");
				$('.layui-tab-title').append("<button title='确定' onclick=\"addindex();\" type=\"button\" style=\"float:right;margin:0 10px 0 10px;background-color:#3472ef;line-height: normal;height: 33px;\" class=\"layui-btn btn-black\">确定</button>");
				if(isZJ == 1) {
					$('.layui-tab-title').append("<button title='新增指标' onclick=\"add();\" type=\"button\" style=\"float:right;margin:0 10px 0 10px;background-color:#3472ef;line-height: normal;height: 33px;\" class=\"layui-btn btn-black\">新增指标</button>");
				}
			}
			/*if(isSX ==1){
				$('.layui-tab-title').append("<button title='县级指标' onclick=\"countyindex();\" type=\"button\" style=\"float:right;margin:0 10px 0 15px;background-color:#3472ef\" class=\"layui-btn btn-black\">县级指标</button>");
				$('.layui-tab-title').append("<button title='市级指标' onclick=\"cityindex();\" type=\"button\" style=\"float:right;margin:0 10px 0 15px;background-color:#3472ef\" class=\"layui-btn btn-black\">市级指标</button>");
				$('.layui-tab-title').append("<button title='省级指标' onclick=\"provinceindex();\" type=\"button\" style=\"float:right;margin:0 10px 0 15px;background-color:#3472ef\" class=\"layui-btn btn-black\">省级指标</button>");

			}*/
			$("#queryform").css("top",0);
		}
	});

	// $(function () {
	// 	if (tabcode == "case") {
	// 		document.getElementById("editform").style.display = "block";
	// 	} else {
	// 		document.getElementById("editform").style.display = "none";
	// 	}
	// })

	/**
	 * 点击触发.
	 */
	Ext.lt.message.hook("left","click",function(datas){
		/*if(!datas.node["data"]){
			return;
		}*/
		currentNode = datas.node.data;
		querytabledata();
	});
	/**
	 * 页签选中.
	 */
	_cmp.clicktab = function(obj){
		tabconf = obj;
		var code = obj.code;
		if (onclicktab  == code && isSX != 1) {
			return;
		}
		tabcode = obj["code"];
		tabfilter = obj["filter"]; //页签过滤条件
		tabconfig = obj["config"];
		onclicktab = code;
		var params = {};
		params.tabcode = tabcode;
		params.tabfilter = tabfilter;
		params.saveAgency = _saveAgency;
		params.sxflag = sxflag;
		params.menuid = _menuid;
		Ext.lt.RCP.call(serviceid, "finTreeData", params, function(result) {
			if (tabcode == "case") {
				lefttree.cfg.outformart = "#name";
				lefttree.cfg.trees[0].cfg.outformart = "#name";
			} else {
				lefttree.cfg.outformart = "#code-#name";
				lefttree.cfg.trees[0].cfg.outformart = "#code-#name";
			}
			lefttree.setRecordset(result.datalist,0);
			recomtable.setDatas([]);
			Ext.lt.ui.loadingClose();
		},function(data){
			alert("查询失败!")
			Ext.lt.ui.loadingClose();
		})
	}
	/**
	 * 重新画表格.
	 */
	_cmp.refdrawtable1 = function(){
		var oldcols = recomtable.getColumns();
		recomtable.columns.checkbox.style = "text-align:center";
		var columns = [recomtable.columns.seq, recomtable.columns.checkbox];
		var arr = eval("("+tabconfig+")");
		if(!arr){
			recomtable.setCols(oldcols);
			recomtable.redraw();
			return;
		}
		var tbarr = arr["tb"];//tabpage表配置的字段
		if(oldcols && tbarr){
			$.each(oldcols, function(i, item){
				$.each(tbarr, function(m, tbitem){
					if(item["colcode"] == tbitem){//相同的添加到表字段
						columns.push(item);
					}
				})
			})
		}else{
			columns = oldcols;
		}
		recomtable.setCols(columns);
		recomtable.redraw();
	}
	/**
	 * 查询.
	 */
	Ext.lt.message.hook("queryform", "doquery",function(obj){
		var filter = obj.queryform.getQuerySQL();
		querytabledata(filter);
	});
	/**
	 * 关闭
	 * @param obj
	 */
	closewin = function(obj){
		parent.Ext.lt.ui.modalWindow.close();
	}
	/**
	 * 选中
	 */
	addindex = function(){
		var selRecords = recomtable.getSelected();
		if(selRecords.size()<=0 && tabcode != "index"){
			var warntal = "模板";
			if(tabcode == "case"){
				warntal ="案例";
			}
			Ext.lt.ui.confirm("确认将整个"+warntal+"应用项目？",{icon:"warn"},function(ret){
				if(ret){
					var alldata = recomtable.getRecordset().toArray();
					//for赋值新的guid.
					var selMap = {};
					var tempobj = {};
					var sindex = "";
					var name = "";
					var indflag = 0;
					for(var i=0;i<alldata.length;i++){
						tempobj = alldata[i];
						tempobj["tindex"] = tempobj["guid"];
						var uuid = createUUID().replace(/-/g, '');
						tempobj["guid"] = uuid;
						sindex = tempobj["sindex"];
						name = tempobj["name"];
						tempobj.superid = tempobj["sindex"];
						tempobj.levelno = 3;
						tempobj.isleaf = 1;
						tempobj._isleaf = 1;
						tempobj.rowtype = "add";
						tempobj.obligate1 = "删除";
						tempobj.kpi_evalsid = "1";
						tempobj.isfixed = "";
						tempobj.isfromparent = "0";
						tempobj.isapply = "1";
						if (parent._curtab == "total") {
							tempobj.yearflag = "1";
						} else if (parent._curtab == "year") {
							tempobj.yearflag = "0";
						}
						if (isadjust == "true") {
							tempobj.status = "3";
						}
						tempobj.is_add = "2";
						/*if(isZJ == 1) {
							// 浙江 预算编制 年度绩效指标与项目测算
							if(fundguid){
								var parent_sel_rows = parent.eval(_tableid).getRecordset().query({fundguid:fundguid});
								var tempfund = parent_sel_rows[0];
								tempobj.xmlx = tempfund.xmlx;
								tempobj.xmlb = tempfund.xmlb;
								tempobj.xmmxnr = tempfund.xmmxnr;
								tempobj.bzy = tempfund.bzy;
								tempobj.bzjs = tempfund.bzjs;
								tempobj.jldw1 = tempfund.jldw1;
								tempobj.sl1 = tempfund.sl1;
								tempobj.jldw2 = tempfund.jldw2;
								tempobj.sl2 = tempfund.sl2;
								tempobj.zjlywy = tempfund.zjlywy;
								tempobj.procode = tempfund.procode;
								tempobj.fundguid = fundguid;
								// 此处指标guid为空 代表改项目明细测算下无指标
								if(!tempfund.guid){
									indflag = 1;
								}
							}
						}*/
						if(name && name != ""){ //存在三级指标的才保存替换
							if(!selMap[sindex]){
								selMap[sindex] = [];
							}
							if(isSX == 1) {
								if (tempobj.computesign == "6" || tempobj.computesign == "9" || tempobj.computesign == "10") {
									tempobj.explain = tempobj.indexvalue;
								} else {
									var computesignstr = "";
									for (var a = 0; a < _signs.size(); a++) {
										if (tempobj.computesign == _signs[a].guid) {
											computesignstr = _signs[a].name;
										}
									}
									var zqunit = "";
									if (tempobj.meterunit) {
										zqunit = tempobj.meterunit;
									}
									tempobj.explain = !tempobj.indexvalue ? computesignstr + '***' + zqunit : computesignstr + ' ' + tempobj.indexvalue + ' ' + zqunit;
								}
							}
							tempobj.indexvalue = ""; //指标值清空
							tempobj.kpi_val = "";
							selMap[sindex].push(tempobj);
						}
					}
					//指标符号翻译
					var zbxs_source = [];
					for(var i=0; i<_signs.length; i++){
						var temparr = [];
						temparr.push(_signs[i]["guid"]);
						temparr.push(_signs[i]["code"]);
						temparr.push(_signs[i]["name"]);
						zbxs_source.push(temparr);
					}
					if (isadjust == "true") {
						parent.getdataSource();
					}
					parent.eval(_tableid).addMapperDatas("computesign",zbxs_source);
					if (parent.eval(_tableid).getCol("isapply") && parent.eval(_tableid).getCol("isapply")["isvisiable"] == 1){
						var isapply_source = [];
						var _isapply = [{guid: "2", code: 2, name: "否"}, {guid: "1", code: 1, name: "是"}];
						for (var i = 0; i < _isapply.length; i++) {
							var temparr = [];
							temparr.push(_isapply[i]["guid"]);
							temparr.push(_isapply[i]["code"]);
							temparr.push(_isapply[i]["name"]);
							isapply_source.push(temparr);
						}
						parent.eval(_tableid).addMapperDatas("isapply", isapply_source);
					}
					if(isZJ == 1){
						//是否新增
						var isadd_source = [];
						var _isadd = [{guid:"2",code:2,name:"否"},{guid:"1",code:1,name:"是"}];
						for(var i=0; i<_isadd.length; i++){
							var temparr = [];
							temparr.push(_isadd[i]["guid"]);
							temparr.push(_isadd[i]["code"]);
							temparr.push(_isadd[i]["name"]);
							isadd_source.push(temparr);
						}
						parent.eval(_tableid).addMapperDatas("is_add",isadd_source);
						if(fundguid){
							// 指标层次分类
							var ind_source = [];
							for(var i=0; i<indmap.length; i++){
								var temparr = [];
								temparr.push(indmap[i]["guid"]);
								temparr.push(indmap[i]["code"]);
								temparr.push(indmap[i]["name"]);
								ind_source.push(temparr);
							}
							parent.eval(_tableid).addMapperDatas("findex",ind_source);
							parent.eval(_tableid).addMapperDatas("sindex",ind_source);
						}

					}
					var parent_sel_rows;
					var parent_sel_obj;
					var _sortid;
					// 浙江 特殊业务处理（项目测速与绩效指标）
					if(fundguid){
						parent_sel_rows = parent.eval(_tableid).getRecordset().query({fundguid:fundguid});
						parent_sel_obj = parent_sel_rows[parent_sel_rows.length -1];
						_sortid = parent_sel_obj._sortid;
						if(indflag == 1){
							parent.eval(_tableid).getRecordSet().delRow(_sortid);
						}
					}
					for ( var key in selMap) {
						if(!fundguid){
							parent_sel_rows = parent.eval(_tableid).getRecordset().query({guid:key});
						}
						if (parent_sel_rows.length > 0 ) {
							parent_sel_obj = parent_sel_rows[parent_sel_rows.length -1];
							_sortid = parent_sel_obj._sortid;
							// 浙江 特殊业务处理（项目测速与绩效指标）
							if(fundguid){
								parent.eval(_tableid).getRecordSet().addData(selMap[key],_sortid - 1);
							}else {
								parent.eval(_tableid).getRecordSet().addData(selMap[key],_sortid + parent.eval(_tableid).getRecordset().toArray().length);
							}
							if((!parent_sel_obj["name"] || parent_sel_obj["name"] =="") && "tree" != _fromtype){
								parent.eval(_tableid).getRecordset().delRow(_sortid);
							}
						}
					}
					parent.Ext.lt.ui.modalWindow.close();
				}
			})
		} else{
			var selMap = {};
			var tempobj = {};
			var sindex = "";
			var name = "";
			var indflag = 0;
			for(var i=0;i<selRecords.length;i++){
				tempobj = selRecords[i];
				tempobj["tindex"] = tempobj["guid"];
				var uuid = createUUID().replace(/-/g, '');
				tempobj["guid"] = uuid;
				sindex = tempobj["sindex"];
				name = tempobj["name"];
				tempobj.superid = tempobj["sindex"];
				tempobj.levelno = 3;
				tempobj.isleaf = 1;
				tempobj._isleaf = 1;
				tempobj.rowtype = "add";
				tempobj.obligate1 = "删除";
				tempobj.isfixed = "";
				tempobj.isfromparent = "0";
				tempobj.isapply = "1";
				if (parent._curtab == "total") {
					tempobj.yearflag = "1";
				} else if (parent._curtab == "year") {
					tempobj.yearflag = "0";
				}
				if(isHuBei == 1) {
					//参考值
					tempobj.targetvalue = tempobj.kpi_val;
				}
				tempobj.kpi_evalsid = "1";
				if (isadjust == "true") {
					tempobj.status = "3";
				}
				tempobj.is_add = "2";
				/*if(isZJ == 1) {
					// 浙江 预算编制 年度绩效指标与项目测算
					if(fundguid){
						var parent_sel_rows = parent.eval(_tableid).getRecordset().query({fundguid:fundguid});
						var tempfund = parent_sel_rows[0];
						tempobj.xmlx = tempfund.xmlx;
						tempobj.xmlb = tempfund.xmlb;
						tempobj.xmmxnr = tempfund.xmmxnr;
						tempobj.bzy = tempfund.bzy;
						tempobj.bzjs = tempfund.bzjs;
						tempobj.jldw1 = tempfund.jldw1;
						tempobj.sl1 = tempfund.sl1;
						tempobj.jldw2 = tempfund.jldw2;
						tempobj.sl2 = tempfund.sl2;
						tempobj.zjlywy = tempfund.zjlywy;
						tempobj.procode = tempfund.procode;
						tempobj.fundguid = fundguid;
						// 此处指标guid为空 代表改项目明细测算下无指标
						if(!tempfund.guid){
							indflag = 1;
						}
					}
				}*/
				if(name && name != ""){ //存在三级指标的才保存替换
					if(!selMap[sindex]){
						selMap[sindex] = [];
					}
					if(isSX == 1) {
						if (tempobj.computesign == "6" || tempobj.computesign == "9" || tempobj.computesign == "10") {
							tempobj.explain = tempobj.indexvalue;
						} else {
							var computesignstr = "";
							for (var a = 0; a < _signs.size(); a++) {
								if (tempobj.computesign == _signs[a].guid) {
									computesignstr = _signs[a].name;
								}
							}
							var zqunit = "";
							if (tempobj.meterunit) {
								zqunit = tempobj.meterunit;
							}
							tempobj.explain = !tempobj.indexvalue ? computesignstr + '***' + zqunit : computesignstr + ' ' + tempobj.indexvalue + ' ' + zqunit;
						}
					}
					// tempobj.explain = computesignstr + tempobj.indexvalue +tempobj.meterunit
					tempobj.indexvalue = ""; //指标值清空
					tempobj.kpi_val = "";
					selMap[sindex].push(tempobj);
				}
			}
			//指标符号翻译
			var zbxs_source = [];
			for(var i=0; i<_signs.length; i++){
				var temparr = [];
				temparr.push(_signs[i]["guid"]);
				temparr.push(_signs[i]["code"]);
				temparr.push(_signs[i]["name"]);
				zbxs_source.push(temparr);
			}
			if (isadjust == "true") {
				parent.getdataSource();
			}
			parent.eval(_tableid).addMapperDatas("computesign",zbxs_source);
			if (parent.eval(_tableid).getCol("isapply") && parent.eval(_tableid).getCol("isapply")["isvisiable"] == 1){
				var isapply_source = [];
				var _isapply = [{guid: "2", code: 2, name: "否"}, {guid: "1", code: 1, name: "是"}];
				for (var i = 0; i < _isapply.length; i++) {
					var temparr = [];
					temparr.push(_isapply[i]["guid"]);
					temparr.push(_isapply[i]["code"]);
					temparr.push(_isapply[i]["name"]);
					isapply_source.push(temparr);
				}
				parent.eval(_tableid).addMapperDatas("isapply", isapply_source);
			}
			if(isZJ == 1){
				//是否新增
				var isadd_source = [];
				var _isadd = [{guid:"0",code:0,name:"否"},{guid:"1",code:1,name:"是"}];
				for(var i=0; i<_isadd.length; i++){
					var temparr = [];
					temparr.push(_isadd[i]["guid"]);
					temparr.push(_isadd[i]["code"]);
					temparr.push(_isadd[i]["name"]);
					isadd_source.push(temparr);
				}
				parent.eval(_tableid).addMapperDatas("is_add",isadd_source);
				if(fundguid){
					// 指标层次分类
					var ind_source = [];
					for(var i=0; i<indmap.length; i++){
						var temparr = [];
						temparr.push(indmap[i]["guid"]);
						temparr.push(indmap[i]["code"]);
						temparr.push(indmap[i]["name"]);
						ind_source.push(temparr);
					}
					parent.eval(_tableid).addMapperDatas("findex",ind_source);
					parent.eval(_tableid).addMapperDatas("sindex",ind_source);
				}
			}
			var parent_sel_rows;
			var parent_sel_obj;
			var _sortid;
			// 浙江 特殊业务处理（项目测速与绩效指标）
			if(fundguid){
				parent_sel_rows = parent.eval(_tableid).getRecordset().query({fundguid:fundguid});
				parent_sel_obj = parent_sel_rows[parent_sel_rows.length -1];
				_sortid = parent_sel_obj._sortid;
				if(indflag == 1){
					parent.eval(_tableid).getRecordSet().delRow(_sortid);
				}
			}
			for ( var key in selMap) {
				if(!fundguid){
					parent_sel_rows = parent.eval(_tableid).getRecordset().query({guid:key});
				}

				if (parent_sel_rows.length > 0 ) {
					parent_sel_obj = parent_sel_rows[parent_sel_rows.length -1];
					_sortid = parent_sel_obj._sortid;
					// 浙江 特殊业务处理（项目测速与绩效指标）
					if(fundguid){
						parent.eval(_tableid).getRecordSet().addData(selMap[key],_sortid - 1);
					}else {
						parent.eval(_tableid).getRecordSet().addData(selMap[key],_sortid + parent.eval(_tableid).getRecordset().toArray().length);
					}
					if((!parent_sel_obj["name"] || parent_sel_obj["name"] =="") && "tree" != _fromtype){
						parent.eval(_tableid).getRecordset().delRow(_sortid);
					}
				}
			}
			parent.Ext.lt.ui.modalWindow.close();
		}
		// if (showtab == "1" || showtab == "3") {
		// 	var params = {};
		// 	params.mainguid = proguid;//模板主键.
		// 	params.yeargoalinfo =  editform.getEditFormValues();
		// 	Ext.lt.RCP.call(serviceid, "saveGoal", params, function(data) {
		// 		parent.Ext.lt.ui.modalWindow.close();
		// 	},function(data){
		// 		alert("引用失败");
		// 	})
		// } else {

		// }
	}

	/**
	 * 新增指标
	 */
	add = function(){
		var url = '/pmkpi/program/prjindex/editindex.page';
		var params = {};
		params.saveAgency = _saveAgency; //项目单位
		params.prolev = _prolev;//项目级别 123
		params.sindex = '';
		params.upguid = '';
		params.type = "add";
		params.is_add = "1";
		params.fundguid = fundguid;
		url = Ext.lt.pmkpi.genPageUrl(url, params);
		indexwindow = Ext.lt.ui.openModalWindow(url,1000,360,"新增指标");
	}


	/**
	 * selguid -- 选中的案例或模板.
	 * @param fromsql -- 查询条件语句.
	 */
	querytabledata = function(fromsql){
		var filter = "";
		if (fromsql && ""!= fromsql){
			filter = fromsql;
		}
		var params = {};
		params.filter= filter;
		params.tabcode = tabcode;
		params.sxflag = sxflag;
		if("index" == tabcode){ //指标查询
			params.saveAgency = _saveAgency; //项目单位
			params.prolev = _prolev;//项目级别 123

			params.beanid = "pmkpi.prjindex.PrjIndexBO";
			params.pagetype = 'recomindex';
			try {
				params.iscommon = currentNode["is_common_ind"];
				params.guid = currentNode["guid"];
				if(isZJ == 1){ // 浙江按项目code查询
					params.guid = currentNode["code"];
				}
				params.mogamisuperid = currentNode["mogamisuperid"];
				params.isleaf = currentNode["isleaf"];
			} catch (e) {
				Ext.lt.pmkpi.alert('请选择类别！',function(){
				});
				return;
			}
			Ext.lt.ui.loadingShow();
			recomtable.queryData(params,function(){
				Ext.lt.ui.loadingClose();
			});
		} else {
			try {
				params.mainguid = currentNode["guid"];//模板主键.
			} catch (e) {
				Ext.lt.pmkpi.alert('请选择类别！',function(){
				});
				return;
			}
			params.showtab = showtab;
			Ext.lt.ui.loadingShow();
			Ext.lt.RCP.call(serviceid, "findTableData", params, function(data) {
				if (data.msg == "Y") {
					recomtable.setDatas(data["data"]);
					// if (tabcode == "case") {
					// 	editform.synchEditformByObj(data["yeargoalinfo"]);
					// }
				} else {
					alert(data.msg);
				}
				Ext.lt.ui.loadingClose();
			},function(data){
				alert("查询失败!")
				Ext.lt.ui.loadingClose();
			})
		}
	}

	/**
	 * 山西(查看省级指标)
	 */
	provinceindex = function(){
		sxflag = "province";
		//刷新左侧树
		_cmp.clicktab(tabconf);
	}

	/**
	 * 山西(查看市级指标)
	 */
	cityindex = function(){
		sxflag = "city";
		_cmp.clicktab(tabconf);
	}

	/**
	 * 山西(查看县级指标)
	 */
	countyindex = function(){
		sxflag = "county";
		_cmp.clicktab(tabconf);
	}

	return _cmp;
}