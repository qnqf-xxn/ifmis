if(!Ext.lt.pmkpi)
	Ext.lt.pmkpi = {};

var serviceid;
var _finintorgds;
var _deptcodeds;
Ext.lt.pmkpi.transpayproindex = function(config, service){
	var cmp = {};
	var common = Ext.lt.pmkpi.perfcommon(config, service);
	var _tablecode,
		_province = config.province,
		_year = config.year,
		_defquery,
		_delcols,
		_updatecols,
		_menuid = config.menuid,
		_currentyear = config.currentyear,
		_currentprovince = config.currentprovince,
		_scrWidth = document.body.clientWidth,
		_scrHeight = document.body.clientHeight;
	serviceid = service;
	_viewtype = 'edit';
	_finintorgds = config.finintorgds;
	_deptcodeds = config.deptcodeds;
	_viewtype = config.viewtype ? config.viewtype : _viewtype;

	$(function (){
		common.initDatatable();
		if (datatable.config["tiptext"] && datatable.config["tiptext"] != null) {
			$('.busnomalbtn').append("<p title='' style=\"float:right;margin: 10px 325px 10px 15px;color: red;\" class=\"layui-text\">" + datatable.config["tiptext"] + "</p>");
		}
		if (_viewtype == "query") {
			var buttons = toolbutton.cfg.data.buttons;
			for(var i=0,length = buttons.length;i<length;i++){
				var btn = buttons[i];
				var hidebtns ="保存,新增,删除";
				if((","+hidebtns+",").indexOf(","+btn.name+",")!=-1){
					toolbutton.hidden(btn.name);
				}
			}
			for(var i = 2; i<datatable.getCols().length; i++){
				datatable.getCols()[i].edit = false;
			}
			datatable.redraw();
		}
		Ext.lt.pmkpi.query();
	})

	Ext.lt.message.hook("queryform", "doquery",function(obj){
		Ext.lt.pmkpi.query();
	});

	Ext.lt.message.hook("perfcommon", "tablequery",function(){
		Ext.lt.pmkpi.query();
	});
    /**
	 * 查询
     */
	Ext.lt.pmkpi.query = function(){
		var params = {};
		Ext.lt.ui.loadingShow();
		params.tablecode = _tablecode;
		params.tablesql = _defquery;
		params.queryConfig = queryform.getQueryParam();
		params.querySql = queryform.getQuerySQL();
		params.menuid = _menuid;
		params.beanid = "pmkpi.transpaypro.TranspayProIndexBOTX";
		Ext.lt.bus.exportBeanid = params.beanid;
		datatable.queryData(params,function(){
			Ext.lt.ui.loadingClose();
			setTimeout(function(){
				datatable.resetSum();
			},300);
		});
	}

	/**
	 * 保存
	 */
	cmp.savemajorkey = function(){
		// if (!cmp.checkall()) return;//先校验
		// if (!cmp.checkyearcol()) return;//先校验
		var params={};
		params.tablecode = _tablecode;
		params.province = _province;
		params.year = _year;
		params.delcols = _delcols;
		params.updatecols =_updatecols;
		params.datas = datatable.getRecordSet().toArray();
		params.deldatas = datatable.getRemoveData();
		Ext.lt.RCP.call(serviceid, "savemajorkey", params, function(rs){
			if (rs && rs.success == true) {
				Ext.lt.ui.alert('保存成功！',function(){
					Ext.lt.pmkpi.query();
				});
			} else {
				if (rs.success == false){
					Ext.lt.pmkpi.openlistdiv(rs);
				} else if (rs){
					if (rs && rs.msg) {
						Ext.lt.ui.alert(rs.msg,function(){
							Ext.lt.ui.loadingClose();
						});
					} else {
						Ext.lt.ui.alert('保存失败！',function(){
							Ext.lt.ui.loadingClose();
						});
					}
				}
			}
			Ext.lt.ui.loadingClose();
		}, function(){
			Ext.lt.ui.alert('保存失败！',function(){
			});
			Ext.lt.ui.loadingClose();
		});
	}

	/**
	 * 必填校验
	 * @returns {boolean}
	 */
	cmp.checkall = function (){
		var cols = datatable.getCols(); //获取列表所有列
		var datas = datatable.getRecordSet().toArray();
		for (var j = 0,lenj = cols.length; j < lenj; j++) {
			for (var i = 0,leni = datas.length; i < leni; i++) {
				for (var j = 0,lenj = cols.length; j < lenj; j++) {
					if (cols[j].requirement == '1') {
						var value = datas[i][cols[j].colcode];
						if (value == null || value == "" || ("" + value).trim().length == 0) {
							Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的【" + cols[j].alias + "】为必录项，必须有值。",{timeout:1},function(){});
							return false;
						}
					}
				}
			}
		}
		return true;
	}

	/**
	 * 年度校验
	 * @returns {boolean}
	 */
	cmp.checkyearcol = function (){
		var datas = datatable.getRecordSet().toArray();
		for (var i = 0,leni = datas.length; i < leni; i++) {
			var yearcol1 = parseFloat(datas[i].yearcol1 ? datas[i].yearcol1 : 0);
			var yearcol2 = parseFloat(datas[i].yearcol2 ? datas[i].yearcol2 : 0);
			var yearcol3 = parseFloat(datas[i].yearcol3 ? datas[i].yearcol3 : 0);
			var yearcol4 = parseFloat(datas[i].yearcol4 ? datas[i].yearcol4 : 0);
			var yearcol5 = parseFloat(datas[i].yearcol5 ? datas[i].yearcol5 : 0);
			var yearcol6 = parseFloat(datas[i].yearcol6 ? datas[i].yearcol6 : 0);
			var yearcol7 = parseFloat(datas[i].yearcol7 ? datas[i].yearcol7 : 0);
			//yearcol4 +1<>yearcol1 就提示他本轮政策实施期 和上轮政策实施期年度不连贯，请修改
			// if(yearcol4 != 0 && yearcol4 + 1 != yearcol1){
			// 	var str = "第" + (datas[i]["_sortid"] + 1) + "行的[本轮政策实施期]和[上轮政策实施期]年度不连贯，请修改！";
			// 	Ext.lt.ui.alert(str,function(){
			// 	});
			// 	return false;
			// }
			if(yearcol1 > yearcol2){
				var str = "第" + (datas[i]["_sortid"] + 1) + "行的[本轮政策实施期]起始年度必须小于终止年度，请修改！";
				Ext.lt.ui.alert(str,function(){
				});
				return false;
			}
			if(yearcol3 != 0 && yearcol4 != 0 && yearcol3 > yearcol4){
				var str = "第" + (datas[i]["_sortid"] + 1) + "行的[上轮政策实施期]起始年度必须小于终止年度，请修改！";
				Ext.lt.ui.alert(str,function(){
				});
				return false;
			}
			if(yearcol6 != 0 && yearcol7 != 0 && yearcol6 > yearcol7){
				var str = "第" + (datas[i]["_sortid"] + 1) + "行的[绩效评价覆盖预算年度]起始年度必须小于终止年度，请修改！";
				Ext.lt.ui.alert(str,function(){
				});
				return false;
			}
		}
		return true;
	}

	Ext.lt.message.hook("datatable", 'beforesetcols',function(data){
		var uiconfig = data.table.uiconfig;
		_tablecode = uiconfig.tablecode;
		_defquery = uiconfig.defquery;
		var config = data.table.config;
		_delcols = config.delcols;
		_updatecols = config.updatecols;
		var cols = data.cols;
		if(!Ext.lt.isArray(cols))
			cols = [cols];
		for(var i=0; i<cols.length; i++){
			var col = cols[i];
			if(col["colcode"]=="yearcol1" || col["colcode"]=="yearcol2" || col["colcode"]=="yearcol3" || col["colcode"]=="yearcol4" || col["colcode"]=="yearcol5" || col["colcode"]=="yearcol6" || col["colcode"]=="yearcol7"){
				col.oneditend = function(table,el,l,c,d){
					var colname = datatable.getAllCols()[c].name;
					if (d[colname] && !/^\d{4}$/.test(d[colname])) {
						var str = "请填写正确的年度！";
						Ext.lt.ui.alert(str,function(){
						});
						d[colname] = '';
					}
				}
			}
			if(col["colcode"]=="warn"){
				col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
					style = 'style="text-align:center;"';
					return style;
				}
				col.fn = function(l,c,data,val){
					var warn = !data.warn? "" : data.warn;
					if (warn == "red") {
						warn = '3';
					} else if (warn == "yellow") {
						warn = '1';
					} else if (warn == "green") {
						warn = '0';
					} else if (warn == "blue") {
						warn = '4';
					} else {
						return "";
					}
					return '<img id="image" style="vertical-align:middle;margin-top:9px;" src="/pmkpi/themes/images/' + warn + '.gif"/>';
				}
			}
			if(col["colcode"]=="obligate1"){ // 本轮资金管理文件（上传）
				col.style = " text-align:center;";
				col.fn = function(l, c, data, val){
					var name = "上传附件"
					if (_viewtype == "query") {
						name = "查看附件";
					}
					var html = '<a title = ' + name + ' style="color:#468ac9;cursor:pointer;">' + name + '</a>';
					return html;
				}
				col.onclick = function(td, el, l, c, d) {
					var params = {};
					params.mainguid = d.guid;
					params.filetype = "fundmanagefile";
					params.viewtype = _viewtype;
					if (isGreyStyle()) {
						Ext.lt.pmkpi.newfilePanelInit(params);
					}else{
						var url = '/pmkpi/file/index.page';
						url = Ext.lt.pmkpi.genPageUrl(url, params);
						Ext.lt.ui.openModalWindow(url,_scrWidth * 0.8, _scrHeight * 0.8,"附件管理");
					}
				};
			}
			if(col["colcode"]=="obligate2"){ // 到期绩效评价报告（最新）（上传）
				col.style = " text-align:center;";
				col.fn = function(l, c, data, val){
					var name = "上传附件"
					if (_viewtype == "query") {
						name = "查看附件";
					}
					var html = '<a title = ' + name + ' style="color:#468ac9;cursor:pointer;">' + name + '</a>';
					return html;
				}
				col.onclick = function(td, el, l, c, d) {
					var params = {};
					params.mainguid = d.guid;
					params.filetype = "evalreportfile";
					params.viewtype = _viewtype;
					if (isGreyStyle()) {
						Ext.lt.pmkpi.newfilePanelInit(params);
					}else{
						var url = '/pmkpi/file/index.page';
						url = Ext.lt.pmkpi.genPageUrl(url, params);
						Ext.lt.ui.openModalWindow(url,_scrWidth * 0.8, _scrHeight * 0.8,"附件管理");
					}
				};
			}
			if(col["colcode"]=="url1"){ //url1查项目信息
				col.style = " text-align:center;";
				col.fn = function(l, c, data, val){
					var name = "查看";
					var html = '<a title = ' + name + ' style="color:#468ac9;cursor:pointer;">' + name + '</a>';
					return html;
				}
				col.onclick = function(td, el, l, c, d) {
					cmp.queryProView(d);
				};
			}
			if(col["colcode"]=="url2"){ //url1查年度绩效信息
				col.style = " text-align:center;";
				col.fn = function(l, c, data, val){
					var name = "查看";
					var html = '<a title = ' + name + ' style="color:#468ac9;cursor:pointer;">' + name + '</a>';
					return html;
				}
				col.onclick = function(td, el, l, c, d) {
					cmp.queryPerfView(d);
				};
			}
			if(col["colcode"]=="selfevalresult1"){ //selfevalresult1查三年前的自评信息
				col.style = " text-align:center;";
				col.fn = function(l, c, data, val){
					if(val){
						var html = '<a title = ' + val + ' style="color:#468ac9;cursor:pointer;">'+val+'</a>';
						return html;
					}else{
						return "";
					}
				}
				col.onclick = function(td, el, l, c, d) {
					if(d.selfevalresult1){
						var procode = d.pro_code;
						var selfevalguid = d.selfevalguid1;
						var currentyear = _currentyear-3;
						cmp.querySelfevalView(procode,selfevalguid,currentyear);
					}
				};
			}
			if(col["colcode"]=="selfevalresult2"){ //selfevalresult1查两年前的自评信息
				col.style = " text-align:center;";
				col.fn = function(l, c, data, val){
					if(val){
						var html = '<a title = ' + val + ' style="color:#468ac9;cursor:pointer;">'+val+'</a>';
						return html;
					}else{
						return "";
					}
				}
				col.onclick = function(td, el, l, c, d) {
					if(d.selfevalresult2){
						var procode = d.pro_code;
						var selfevalguid = d.selfevalguid2;
						var currentyear = _currentyear-2;
						cmp.querySelfevalView(procode,selfevalguid,currentyear);
					}
				};
			}
			if(col["colcode"]=="selfevalresult3"){ //selfevalresult1查一年前的自评信息
				col.style = " text-align:center;";
				col.fn = function(l, c, data, val){
					if(val){
						var html = '<a title = ' + val + ' style="color:#468ac9;cursor:pointer;">'+val+'</a>';
						return html;
					}else{
						return "";
					}
				}
				col.onclick = function(td, el, l, c, d) {
					if(d.selfevalresult3){
						var procode = d.pro_code;
						var selfevalguid = d.selfevalguid3;
						var currentyear = _currentyear-1;
						cmp.querySelfevalView(procode,selfevalguid,currentyear);
					}
				};
			}
		}
	});

	/**
	 * 查看项目库详情
	 */
	cmp.queryProView = function(data){
		var params = {};
		params.submenu = _menuid;
		params.pro_code = data.pro_code;
		var params = [];
		params.push('noguidflag=1');
		params.push('submenu=' + _menuid );
		params.push('pro_code='+ data.pro_code);
		params.push('vchtypeid=7EB7DFB2BC71875A1B7C50130CD8388F');
		params.push('pagetype=detailinfo');
		var url = Ext.lt.token.urlAddToken('/pdm/prodetail/detailinfo.page') + '&' + params.join('&')  + Ext.lt.token.getAuthorization();
		Ext.lt.pdm = {};
		Ext.lt.pdm.common = {};
		Ext.lt.pdm.common.config = {};
		Ext.lt.pdm.common.config.pagetype = 'detailinfo';
		var width = _scrWidth * 0.9, height =  _scrHeight * 0.9;
		Ext.lt.pdm.common.window = new Ext.lt.window({
			title:'',
			pop:true,
			mark:true,
			drag:true,
			close:true,
			w:width,
			h:height,
			fitmode:'content',
			className:'windpblue',
			onclose:function(){
			}
		});
		var framediv = $('<div style="width:'
			+ (width) + 'px; height:' + height + 'px;overflow:hidden;"><iframe src="'
			+ url + '"  frameborder="0"  style="top:auto;left:auto;scrolling: yes;width:'+(width)+'px'
			+ '; height:'+height+'px;'+'"></iframe></div>');
		Ext.lt.pdm.common.window.draw(framediv[0]);
	}

	/**
	 * 查看项目年度绩效详情
	 */
	cmp.queryPerfView = function (data){
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
	 * 查看项目自评详情
	 */
	cmp.querySelfevalView = function (procode,selfevalguid,currentyear){
		var params = {};
		var url = "/pmkpi/perfself/apply/edit.page";
		params.mainguid = selfevalguid;
		params.procode = procode;
		params.viewtype = "query";
		params.bustype = "program";
		params.queryYear = currentyear;
		params.queryProvince = _currentprovince;
		url = Ext.lt.pmkpi.genPageUrl(url, params);
		Ext.lt.ui.openModalWindow(url,_scrWidth * 0.9, _scrHeight * 0.9,"自评详情("+currentyear+")");
	}

	/**
	 * 删除
	 */
    cmp.delrows = function(){
		var selDatas = datatable.getSelected();
		if (selDatas.size() <= 0) {
			Ext.lt.ui.alert('请选择要删除的数据！', function () {
			});
			return;
		}
		Ext.lt.ui.confirm("是否确定删除已选择的数据？", {icon: "warn"}, function (ret) {
			if (ret) {
				datatable.removeData(selDatas);
			}
		});
	}

	/**
	 * 新增行
	 */
	cmp.addrow = function (){
		var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
		var newdata ={};
		newdata.guid = newguid;
		newdata.isedit = 1;
		newdata.rowtype = "add";
		newdata.ordernum = datatable.getRecordSet().toArray().size+1;
		datatable.getRecordSet().addData(newdata,999);
	}

	/**
	 * 新增-选择项目
	 */
	cmp.addselectpro = function (){
		var params = {};
		var url = '/pmkpi/majorpolicy/selrpro.page';
		url = Ext.lt.pmkpi.genPageUrl(url, params);
		Ext.lt.ui.openModalWindow(url, _scrWidth * 0.8, _scrHeight * 0.8, "选择项目");
	}

	return cmp;
}

/**
 * 设置数据源
 */
function getdataSource() {
	var _finintorg_source = [];
	for (var i = 0; i < _finintorgds.length; i++) {
		var temparr = [];
		temparr.push(_finintorgds[i]["guid"]);
		temparr.push(_finintorgds[i]["code"]);
		temparr.push(_finintorgds[i]["name"]);
		_finintorg_source.push(temparr);
	}
	datatable.addMapperDatas("finintorgguid", _finintorg_source);
	var _dept_code_source = [];
	for (var i = 0; i < _deptcodeds.length; i++) {
		var temparr = [];
		temparr.push(_deptcodeds[i]["guid"]);
		temparr.push(_deptcodeds[i]["code"]);
		temparr.push(_deptcodeds[i]["name"]);
		_dept_code_source.push(temparr);
	}
	datatable.addMapperDatas("dept_code", _dept_code_source);
}