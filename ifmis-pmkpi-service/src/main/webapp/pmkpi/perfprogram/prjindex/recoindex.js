if(!Ext.lt.pmkpi)
	Ext.lt.pmkpi = {};
/**
 * 初始化加载.
 */
Ext.lt.pmkpi.recomindexservice = function(config, serviceid) {
	var perfcommon = Ext.lt.pmkpi.perfcommon(config, serviceid);
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
	var _indexstandards = config["standards"]; //绩效标准
	var showtab = config.showtab;//1总+年 2总 3年
	var proguid = config.proguid;//项目guid
	var _goalguid = config.goalguid;//关联目标guid
	var isfirst = true;
	var isadjust = config.isadjust;//是否调整
	isZJ = config["isZJ"];//标识是否是浙江（1.浙江）
	var isHuBei = config["isHuBei"];//标识是否是湖北（1.湖北）
	var isSX = config["isSX"];//标识是否是山西（1.山西）
	var _isHebei = config.isHebei;//标识是否是河北模式（1.河北）
	var _isJiangXI = config["isJiangXI"]; //是否江西参数
	var fundguid = config["fundguid"];
	var indmap = config["indmap"];//指标层次分类
	var sxflag = "";//山西查询标识(省级指标，市级指标，县级指标)
	var tabconf;//页签配置
	var _authData = config.authData;//指标授权信息
	var _isaddAuthSelect = false;
	var _selectedAuth;
	var _pagination = null;
	var lefttype = "idexcomcls";
	var _displaycols = [];
	var _indsource = config.indsource;
	var _isNINGXIA = config.isNINGXIA;
	var _isquery = false;

	// /**
	//  * 页面布局完成.
	//  */
	$(function () {
		if (isfirst) {
			var height = $(".bd_main").height();
			var width = $("#recomtable").width();
			recomtable.resize(width,height-10);
			if(typeof header !== 'undefined') header.doActiveTab(0);
			if(typeof tab !== 'undefined') tab.doActiveTab(0);
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
			if(_isaddAuthSelect){
				_cmp.buildAuthSelectHtml();
			}else{
				$("#waitdiv").hide();
			}
		}
		if (_pagination != null) {
			_pagination.turnPage(recomtable.config.page);
		}
		_cmp.setTableColum();
		if(_SYSTEMSTYLE_ == "grey"){
			$("#recomtable").find(".tbtitle").hide();
			setTimeout(function () {
				recomtable.resize($("#queryform").width(),document.body.clientHeight-115);
			}, 100);
		}
		isfirst = false;
	});

	/**
	 * 推荐指标-共享指标库类型下拉框
	 */
	_cmp.buildAuthSelectHtml = function (){
		$("#switchBar").css({"margin-top": "-60px"});
		var html = [];
		html.push("<div id='waitdiv' style='padding: 10px;border-bottom: 1px solid #e5e5e5;line-height: 30px;'>");//class='tree-choise-list'
		html.push("<span class='title' style='font-size: 14px;font-weight: bold;'>指标库类型：</span>");
		html.push("<select name='authtype'>");
		for (var a = 0; a < _authData.size(); a++) {
			html.push("<option value='"+_authData[a].selecttype+"'>" +_authData[a].selecttype+"-"+ _authData[a].remark + "</option>");
		}
		html.push("</select>");
		html.push("</div>");
		$("div.busui_leftree").prepend(html.join(" "));
		$("select[name='authtype']").change(_cmp.authtypeChange);
	}

	/**
	 * 推荐指标-切换指标库类型
	 */
	_cmp.authtypeChange = function (){
		_selectedAuth = $("select[name='authtype']").val();
		var params = {};
		params.tabcode = tabcode;
		params.tabfilter = tabfilter;
		params.saveAgency = _saveAgency;
		params.sxflag = sxflag;
		params.selectedAuth = _selectedAuth;
		params.menuid = _menuid;
		Ext.lt.ui.loadingShow();
		Ext.lt.RCP.call(serviceid, "finTreeData", params, function(result) {
			if (tabcode == "case" || tabcode == "mode") {
				lefttree.cfg.outformart = "#name";
				lefttree.cfg.trees[0].cfg.outformart = "#name";
			} else {
				lefttree.cfg.outformart = "#code-#name";
				lefttree.cfg.trees[0].cfg.outformart = "#code-#name";
			}
			Ext.lt.ui.loadingClose();
			recomtable.setDatas([]);
			if(_selectedAuth!=undefined){//初始化分页组件
				recomtable.config.page.currpage = 0;
				recomtable.config.page.totalrows = 0;
				recomtable.config.page.totalpages = 0;
				currentNode = null;
				if (_pagination == null) {
					_pagination = new Ext.lt.pmkpi.perfpagination(recomtable.config, serviceid, recomtable)
				}
				_pagination.draw(document.getElementById(recomtable.id + "_tablePaginationList"));
				_pagination.turnPage(recomtable.config.page);
			}
			queryform.reset();
			lefttree.setRecordset(result.datalist, 0);
		},function(data){
			alert("查询失败!")
			Ext.lt.ui.loadingClose();
		});
		if (!isfirst && _isNINGXIA && _isquery) {
			if (tabcode == "index") {
				queryform.setdisabled({pro_name:false});
			} else {
				queryform.setdisabled({pro_name:true});
			}
			queryform.clear();
		}
	}

	Ext.lt.message.hook("busquerypanel", "drawed",function(obj){
		if (!isfirst && _isNINGXIA) {
			if (tabcode == "index") {
				queryform.setdisabled({pro_name:false});
			} else {
				queryform.setdisabled({pro_name:true});
			}
			queryform.clear();
			_isquery = true;
		}
	});

	/**
	 * 点击触发.
	 */
	Ext.lt.message.hook("left","click",function(datas){
		currentNode = datas.node.data;
		var superguid = currentNode.superguid == "#" ? currentNode.guid : currentNode.superguid;
		if (tabcode == "index" && lefttype != superguid) {
			lefttype = superguid;
			_cmp.setTableColum();
		}
		querytabledata();
	});

	/**
	 * 动态配置表格的列.
	 *
	 * @param data --
	 */
	_cmp.setTableColum = function(){
		var cols = recomtable.getCols(); //获取列表所有列
		cols.push.apply(cols, _displaycols);
		_displaycols = [];
		for (var i = 0, len = cols.length; i < len; i++) {
			var col = cols[i];
			var config = eval(col.config);
			if (config && !$.isEmptyObject(config) && col.alias != "序号") {
				if (tabcode == 'index' && config.iscommon == '0' && lefttype != "idexcomcls") {
					col.display = true;
				} else if (tabcode == 'index' && config.lefttype == 'index') {
					col.display = true;
				} else {
					_displaycols.push(col); //隐藏前暂存至sfagency;
					col.display = false; //display置为false，隐藏
				}
			}
		}
		recomtable.redraw();
	}

	/**
	 * 页签选中.
	 */
	_cmp.clicktab = function(obj){
		tabconf = obj;
		var code = obj.code;
		if (onclicktab  == code && isSX != 1) {
			return;
		}
		if("index" == code && _authData.size()>1){//推荐指标，显示共享指标库类型下拉框
			_isaddAuthSelect = true;
			$("#waitdiv").show();
		}else{
			_isaddAuthSelect = false;
			$("#waitdiv").hide();
		}
		tabcode = obj["code"];
		tabfilter = obj["filter"]; //页签过滤条件
		tabconfig = obj["config"];
		onclicktab = code;
		_cmp.authtypeChange();
		lefttype = "idexcomcls";
		_cmp.setTableColum();
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
		if(queryform.getQueryParam()[0].ALL_COLUMNS) {
			return;
		}
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
						tempobj.kpi_evalstd = "1"; //部标规范字段
						tempobj.kpi_content = tempobj["name"]; //部标规范字段
						tempobj.obligate1 = "删除";
						tempobj.isfixed = "";
						tempobj.isfromparent = "0";
						tempobj.isapply = "1";
						tempobj.indsource = '2';
						if (parent._curtab == "total") {
							tempobj.yearflag = "1";
						} else if (parent._curtab == "year") {
							tempobj.yearflag = "0";
						}
						if (isadjust == "true") {
							tempobj.status = "3";
						}
						tempobj.is_add = "2";
						if(isHuBei == 1) {
							//参考值
							tempobj.targetvalue = tempobj.kpi_val;
							//目标id
							tempobj.goalguid = _goalguid;
						}
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
							tempobj.pro_name = "";
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
					//绩效标准翻译
					var indexstandards_source = [];
					for(var i=0; i<_indexstandards.length; i++){
						var temparr = [];
						temparr.push(_indexstandards[i]["guid"]);
						temparr.push(_indexstandards[i]["code"]);
						temparr.push(_indexstandards[i]["name"]);
						indexstandards_source.push(temparr);
					}
					parent.eval(_tableid).addMapperDatas("indexstandards",indexstandards_source);
					if (parent.eval(_tableid).getCol("is_add") && parent.eval(_tableid).getCol("is_add")["isvisiable"] == 1){
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
					}
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
					if (parent.eval(_tableid).getCol("indsource") && parent.eval(_tableid).getCol("indsource")["isvisiable"] == 1) {
						perfcommon.setColDatasource({"indsource" : _indsource}, parent.eval(_tableid));
					}
					if(isZJ == 1){
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
			if(isSX == 1) {
				var checkindexstandard = true;
				for(var i=0;i<selRecords.length;i++){
					var iscommon = selRecords[i].is_common_ind;
					var agencycode = selRecords[i].agency_code;
					if(iscommon == "2" && agencycode != undefined){//只有部门个性指标校验
						var indexstandards = selRecords[i].indexstandards;
						if(indexstandards!=undefined && indexstandards!=""){
							var indexstandardsArr = indexstandards.split(",");
							if(indexstandardsArr.size()!=1){
								checkindexstandard = false;
							}
						}else{
							checkindexstandard = false;
						}
					}
				}
				if(!checkindexstandard){
					Ext.lt.pmkpi.alert("选中指标的必须选择一项绩效标准！", function (){});
					return;
				}
			}
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
				tempobj.indsource = '2';
				if (parent._curtab == "total") {
					tempobj.yearflag = "1";
				} else if (parent._curtab == "year") {
					tempobj.yearflag = "0";
				}
				if(isHuBei == 1) {
					//参考值
					tempobj.targetvalue = tempobj.kpi_val;
					//目标id
					tempobj.goalguid = _goalguid;
				}
				tempobj.kpi_evalstd = "1"; //部标规范字段
				tempobj.kpi_content = tempobj["name"]; //部标规范字段
				if (isadjust == "true") {
					tempobj.status = "3";
				}
				tempobj.is_add = "2";
				if (_isJiangXI =="1"){ //江西的选中，清空字段
					tempobj.indexcategories = null;
					tempobj.industrycategory = null;
					tempobj.indexcategory = null;
					tempobj.filed = null;
					tempobj.occupation = null;
				}
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
						var indexstandardsval = "";
						var iscommon = tempobj.is_common_ind;
						if(iscommon == "1"){
							indexstandardsval = tempobj.indexvalue;
						}else if(tempobj.indexstandards == "indexstandards001"){
							indexstandardsval = tempobj.indexstandardsval1;
						}else if(tempobj.indexstandards == "indexstandards002"){
							indexstandardsval = tempobj.indexstandardsval2;
						}else if(tempobj.indexstandards == "indexstandards003"){
							indexstandardsval = tempobj.indexstandardsval3;
						}else if(tempobj.indexstandards == "indexstandards004"){
							indexstandardsval = tempobj.indexstandardsval4;
						}else if(tempobj.indexstandards == "indexstandards005"){
							indexstandardsval = tempobj.indexstandardsval5;
						}
						if (tempobj.computesign == "6" || tempobj.computesign == "9" || tempobj.computesign == "10") {
							tempobj.explain = indexstandardsval;
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
							tempobj.explain = !indexstandardsval ? computesignstr + '***' + zqunit : computesignstr + ' ' + indexstandardsval + ' ' + zqunit;
						}
					}
					// tempobj.explain = computesignstr + tempobj.indexvalue +tempobj.meterunit
					tempobj.indexvalue = ""; //指标值清空
					tempobj.kpi_val = "";
					tempobj.pro_name = "";
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
			//绩效标准翻译
			var indexstandards_source = [];
			for(var i=0; i<_indexstandards.length; i++){
				var temparr = [];
				temparr.push(_indexstandards[i]["guid"]);
				temparr.push(_indexstandards[i]["code"]);
				temparr.push(_indexstandards[i]["name"]);
				indexstandards_source.push(temparr);
			}
			parent.eval(_tableid).addMapperDatas("indexstandards",indexstandards_source);
			if (parent.eval(_tableid).getCol("is_add") && parent.eval(_tableid).getCol("is_add")["isvisiable"] == 1){
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
			}
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
			if (parent.eval(_tableid).getCol("indsource") && parent.eval(_tableid).getCol("indsource")["isvisiable"] == 1) {
				perfcommon.setColDatasource({"indsource" : _indsource}, parent.eval(_tableid));
			}
			if(isZJ == 1){
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
		if (parent._curtab == "total") {
			params.yearflag = "1";
		} else if (parent._curtab == "year") {
			params.yearflag = "0";
		}
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
		} else {
			filter = queryform.getQuerySQL();
		}
		var params = {};
		params.filter= filter;
		params.tabcode = tabcode;
		params.sxflag = sxflag;
		if("index" == tabcode){ //指标查询
			params.saveAgency = _saveAgency; //项目单位
			params.prolev = _prolev;//项目级别 123

			params.beanid = "pmkpi.prjindex.PrjIndexBO";
			Ext.lt.bus.exportBeanid = params.beanid;
			params.pagetype = 'recomindex';
			params.selectedAuth = _selectedAuth;
			try {
				params.iscommon = currentNode["is_common_ind"];
				params.guid = currentNode["guid"];
				params.superguid = currentNode["superguid"];
				params.levelno = currentNode["levelno"];
				params.agencyguid = currentNode["agencyguid"];
				params.mogamisuperid = currentNode["mogamisuperid"];
				params.isleaf = currentNode["isleaf"];
			} catch (e) {
				Ext.lt.pmkpi.alert('请选择类别！',function(){
				});
				return;
			}
			Ext.lt.ui.loadingShow();
			if(_isHebei ==1 && _selectedAuth!=undefined && _selectedAuth!="00"){ //分库模式走接口获取共享指标库数据
				params.pageobj = recomtable.config.page;
				params.key = recomtable.config.key;
				Ext.lt.RCP.call(serviceid, "getHBAuthIndex", params, function(rs) {
					if (_pagination == null) {
						_pagination = new Ext.lt.pmkpi.perfpagination(recomtable.config, serviceid, recomtable)
						_pagination.draw(document.getElementById(recomtable.id + "_tablePaginationList"));
					}
					_pagination.turnPage(rs.pageobj);
					recomtable.setRecordset(rs.datalist);
					var mapperdata = rs.mapperdata.mapperdata;
					var cols =recomtable.config.data[0].columns;
					for (var i = 0; i < cols.length; i++) {
							if (mapperdata[cols[i].colcode]) {
							if (cols[i].addMapperDatas) {
								cols[i].addMapperDatas(mapperdata[cols[i].colcode].datas);
							}
						}
					}
					recomtable.config.page = rs.pageobj;
					recomtable.pageToRowtolists();
					if (rs.datalist.toArray().size < 1) {
						recomtable.closeRows();
					}
					recomtable.reflash();
					Ext.lt.ui.loadingClose();
				});
			}else{
				recomtable.queryData(params,function(){
					Ext.lt.ui.loadingClose();
				});
			}
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
	 * @param fromsql -- 查询条件语句.
	 */
	Ext.lt.pmkpi.querytabledata = function(fromsql){
		var filter = "";
		if (fromsql && ""!= fromsql){
			filter = fromsql;
		}
		var params = {};
		params.filter= filter;
		params.tabcode = tabcode;
		if("index" == tabcode){ //指标查询
			params.saveAgency = _saveAgency; //项目单位
			params.prolev = _prolev;//项目级别 123
			params.beanid = "pmkpi.prjindex.PrjIndexBO";
			Ext.lt.bus.exportBeanid = params.beanid;
			params.pagetype = 'recomindex';
			params.selectedAuth = _selectedAuth;
			try {
				params.iscommon = currentNode["is_common_ind"];
				params.guid = currentNode["guid"];
				params.mogamisuperid = currentNode["mogamisuperid"];
				params.isleaf = currentNode["isleaf"];
			} catch (e) {
				Ext.lt.pmkpi.alert('请选择类别！',function(){
				});
				return;
			}
			Ext.lt.ui.loadingShow();
			if(_isHebei ==1 && _selectedAuth!=undefined && _selectedAuth!="00"){ //分库模式走接口获取共享指标库数据
				params.pageobj = recomtable.config.page;
				params.key = recomtable.config.key;
				Ext.lt.RCP.call(serviceid, "getHBAuthIndex", params, function(rs) {
					if (_pagination == null) {
						_pagination = new Ext.lt.pmkpi.perfpagination(recomtable.config, serviceid, recomtable)
						_pagination.draw(document.getElementById(recomtable.id + "_tablePaginationList"));
					}
					_pagination.turnPage(rs.pageobj);
					recomtable.setRecordset(rs.datalist);
					var mapperdata = rs.mapperdata.mapperdata;
					var cols =recomtable.config.data[0].columns;
					for (var i = 0; i < cols.length; i++) {
						if (mapperdata[cols[i].colcode]) {
							if (cols[i].addMapperDatas) {
								cols[i].addMapperDatas(mapperdata[cols[i].colcode].datas);
							}
						}
					}
					recomtable.config.page = rs.pageobj;
					recomtable.pageToRowtolists();
					if (rs.datalist.toArray().size < 1) {
						recomtable.closeRows();
					}
					recomtable.reflash();
					Ext.lt.ui.loadingClose();
				});
			}
		}
	}

/*	/!**
	 * 山西(查看省级指标)
	 *!/
	provinceindex = function(){
		sxflag = "province";
		//刷新左侧树
		_cmp.clicktab(tabconf);
	}

	/!**
	 * 山西(查看市级指标)
	 *!/
	cityindex = function(){
		sxflag = "city";
		_cmp.clicktab(tabconf);
	}

	/!**
	 * 山西(查看县级指标)
	 *!/
	countyindex = function(){
		sxflag = "county";
		_cmp.clicktab(tabconf);
	}*/

	return _cmp;
}

Ext.lt.pmkpi.perfpagination = function(config, service, table) {
	// 分页
	var c = {simple:false};
	var p = config.page;
	var obj = null;
	//分页对象绘制完毕后使用此方法，改变分页对象行为
	c.turnPage = function(page) {
		p = _initPageInfo(page);
		c.reflash(true);
	}
	function _initPageInfo(p) {
		p.currpage = p.currpage <= 0 ? 1 : p.currpage;
		p.totalpages = p.totalpages <= 0 ? 1 : p.totalpages;
		p.totalrows = p.totalrows < 0 ? 1 : p.totalrows;
		if (p.rows != -1) {
			p.rows = p.rows < 0 ? 100 : p.rows;
			if (p.totalrows % p.rows == 0) {
				p.totalpages = p.totalrows / p.rows
			} else {
				try {
					p.totalpages = Math.floor(p.totalrows / p.rows) + 1;
				} catch(e) {}
			}
		} else {
			p.totalpages = 1;
		}
		p.totalpages = p.totalpages <= 0 ? 1 : p.totalpages;
		// 是否有上一页
		p.hasPreviousPage = p.currpage != 1 ? (p.totalpages > 1) : false;
		// 是否有下一页
		p.hasNextPage = p.currpage < p.totalpages;
		return p;
	}
	c.draw = function(div) {
		obj = div;
		c.reflash(true);
	}
	c.reflash = function(init){
		if(obj){
			layui.use(['laypage', 'layer'], function () {
				var laypage = layui.laypage;
				var currentPage = p.currpage;
				var pageSize = p.rows;
				var limits =  [20, 50, 100, 200, 500, 1000, 2000, 5000,20000];
				if(typeof(Ext.lt.bus.exportBeanid) == "string" &&　Ext.lt.bus.exportBeanid != "" && typeof(dataexport)!="undefined"){
					limits =  [20, 50, 100, 200, 500, 1000, 2000, 5000,20000, '导出全部'];
				}
				//完整功能
				laypage.render({
					elem: table.id+'_tablePaginationList'
					, count: p.totalrows
					, limit: pageSize
					, curr: currentPage
					, layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']
					, limits: limits//如果pageSize 10条，每页10条 每页20 每页30 每页40 每页 50
					, jump: function (obj, first) {
						if (!first) {//首次加载不需要触发查询
							p.currpage = obj.curr;//将layui的页码赋值给组件
							p.rows = obj.limit;//将layui的每页显示条数赋值给组件
							Ext.lt.pmkpi.querytabledata();
						}
						$('.layui-laypage-btn').text('跳转')
					}
				});
			});
		}
	}
	return c;
}