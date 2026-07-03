if(!Ext.lt.pmkpi)
	Ext.lt.pmkpi = {};

var serviceid;
Ext.lt.pmkpi.deptPerfEvalTJ = function(config, service){
	var cmp = {};
	var common = Ext.lt.pmkpi.perfcommon(config, service);
	var _tablecode,
		_workflow = config.workflow,
		_province = config.province,
		_year = config.year,
		_tabfilter,//页签查询条件
		_tabcode,//页签编码
		_agency,
		_agency_name,
		_defquery,
		_delcols,
		_updatecols,
		_menuid = config.menuid,
		_scrWidth = document.body.clientWidth,
		_scrHeight = document.body.clientHeight;
	serviceid = service;
	var _eval_types = config.eval_types;
	var _viewtype = "edit";
	var _type = config.type ? config.type : "query";
	if(_type == "audit" || _type == "query"){
		_viewtype = "query";
	}
	var is_checktab = true;
	var isfirst = true;
	var _coleditmap = {};

	$(function (){
		common.initDatatable();
		if (datatable.config["tiptext"] && datatable.config["tiptext"] != null) {
			$('.busnomalbtn').append("<p title='' style=\"float:right;margin: 10px 325px 10px 15px;color: red;\" class=\"layui-text\">" + datatable.config["tiptext"] + "</p>");
		}
		if (_viewtype == "query") {
			cmp.setTableEdit(false);
		}
		if(isfirst){
			for(var i = 2; i<datatable.getCols().length; i++){
				var col =datatable.getCols()[i];
				_coleditmap[col.colcode] = col.edit;
			}
			Ext.lt.pmkpi.query();
		}
		isfirst = false;
	})

	Ext.lt.message.hook("queryform", "doquery",function(obj){
		Ext.lt.pmkpi.query();
	});

	Ext.lt.message.hook("perfcommon", "auditquery",function(){
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
		params.tablesql = _defquery;
		params.workflow = _workflow;
		params.tabcode = _tabcode;
		params.tabfilter = _tabfilter;
		params.queryConfig = queryform.getQueryParam();
		params.querySql = queryform.getQuerySQL();
		params.menuid = _menuid;
		params.beanid = "pmkpi.deptperfevalTJ.DeptPerfEvalTJBOTX";
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
	cmp.save = function(){
		var rns = datatable.getEditor();
		if (rns){
			datatable.closeEdit();
		}
		if (!cmp.checkall()) return;//先校验
		if (!cmp.checkspecial()) return;//先校验
		var params={};
		params.tablecode = _tablecode;
		params.province = _province;
		params.year = _year;
		params.workflow = _workflow;
		params.delcols = _delcols;
		params.updatecols =_updatecols;
		params.datas = datatable.getRecordSet().toArray();
		params.deldatas = datatable.getRemoveData();
		Ext.lt.RCP.call(serviceid, "save", params, function(rs){
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
	 * 特殊校验
	 * @returns {boolean}
	 */
	cmp.checkspecial = function (){
		var datas = datatable.getRecordSet().toArray();
		for (var i = 0,leni = datas.length; i < leni; i++) {
			var eval_type = datas[i].eval_type ? datas[i].eval_type : ""; //评价方式
			var inst_name = datas[i].inst_name ? datas[i].inst_name : ""; //机构名称
			if(eval_type == "2" && (inst_name == null || inst_name == "")){
				var str = "第" + (datas[i]["_sortid"] + 1) + "行的【评价方式】为”委托第三方机构“，请填写【机构名称】！";
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
			if(col["colcode"]=="eval_year"){
				col.oneditend = function(table,el,l,c,d){
					if (d.eval_year && !/^\d{4}$/.test(d.eval_year)) {
						var str = "请填写正确的年度！";
						Ext.lt.ui.alert(str,function(){
						});
						d.eval_year = '';
					}
				}
			}
			if(col["colcode"]=="file1"){ // 附件（报告）
				col.style = "background-color:#f2f2f2;";
				col.cseditfn = function (i, j, rs, style) {
					return updateStyle(style, 'text-align:center;');
				}
				col.fn = function(l, c, data, val){
					var name =data.file1;
					var html = '<a title = ' + name + ' style="color:#468ac9;cursor:pointer;">' + name + '</a>';
					return html;
				}
				col.onclick = function(td, el, l, c, d) {
					var params = {};
					params.mainguid = d.guid;
					params.filetype = "deptperfevalTJ_file1";
					if(_type == "report" && (_tabcode == "alreadyaudit" || _tabcode == "alldeals")){
						params.viewtype = "query";
					}else{
						params.viewtype = _viewtype;
					}
					if (isGreyStyle()) {
						Ext.lt.pmkpi.newfilePanelInit(params);
					}else{
						var url = '/pmkpi/file/index.page';
						url = Ext.lt.pmkpi.genPageUrl(url, params);
						Ext.lt.ui.openModalWindow(url,_scrWidth * 0.8, _scrHeight * 0.8,"附件管理");
					}
				};
			}
			if(col["colcode"]=="file2"){ // 附件（指标体系评分表）
				col.style = "background-color:#f2f2f2;";
				col.cseditfn = function (i, j, rs, style) {
					return updateStyle(style, 'text-align:center;');
				}
				col.fn = function(l, c, data, val){
					var name = data.file2;
					var html = '<a title = ' + name + ' style="color:#468ac9;cursor:pointer;">' + name + '</a>';
					return html;
				}
				col.onclick = function(td, el, l, c, d) {
					var params = {};
					params.mainguid = d.guid;
					params.filetype = "deptperfevalTJ_file2";
					if(_type == "report" && (_tabcode == "alreadyaudit" || _tabcode == "alldeals")){
						params.viewtype = "query";
					}else{
						params.viewtype = _viewtype;
					}
					if (isGreyStyle()) {
						Ext.lt.pmkpi.newfilePanelInit(params);
					}else{
						var url = '/pmkpi/file/index.page';
						url = Ext.lt.pmkpi.genPageUrl(url, params);
						Ext.lt.ui.openModalWindow(url,_scrWidth * 0.8, _scrHeight * 0.8,"附件管理");
					}
				};
			}
			if (_viewtype == 'query' && !config[col.colcode] && col["name"] != "check") {
				col.style = "background-color:#f2f2f2;";
			}
		}
	});

	/**
	 * 附件页操作回调-更新列表上传显示
	 * @param filenames
	 * @param billguid
	 * @param filetype
	 */
	Ext.lt.pmkpi.setFileName = function (filenames, billguid, filetype){
		var parent_sel_rows = datatable.getRecordset().query({guid:billguid});
		var parent_sel_obj = parent_sel_rows[0];
		var _sortid = parent_sel_obj._sortid;
		if(filetype == "deptperfevalTJ_file1" && filenames != ""){
			parent_sel_obj["file1"] = "已上传";
		}else if (filetype == "deptperfevalTJ_file1" && filenames == ""){
			parent_sel_obj["file1"] = "未上传";
		}else if(filetype == "deptperfevalTJ_file2" && filenames != ""){
			parent_sel_obj["file2"] = "已上传";
		}else if (filetype == "deptperfevalTJ_file2" && filenames == ""){
			parent_sel_obj["file2"] = "未上传";
		}
		datatable.reflash(_sortid);
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
		Ext.lt.ui.confirm("是否确定删除已选择的数据？删除后请点击【保存】刷新页面数据", {icon: "warn"}, function (ret) {
			if (ret) {
				datatable.removeData(selDatas);
			}
		});
	}

	/**
	 * 新增
	 */
	cmp.addrow = function (){
		if(!_agency || _agency == "treeroot"){
			Ext.lt.ui.alert("请选择左侧部门进行新增操作！",function(){});
			return;
		}
		var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
		var newdata ={};
		newdata.guid = newguid;
		newdata.isedit = 1;
		newdata.rowtype = "add";
		newdata.dept_code = _agency;
		newdata.dept_name = _agency_name;
		newdata.agvencyguid = _agency;
		newdata.file1 = "未上传";
		newdata.file2 = "未上传";
		newdata.ordernum = datatable.getRecordSet().toArray().size+1;
		cmp.getdataSource();
		datatable.getRecordSet().addData(newdata,999);
	}

	/**
	 * 送审/审核
	 */
	cmp.wfAudit = function (obj){
		var datas = datatable.getSelected();
		if (datas.length <= 0) {
			Ext.lt.ui.alert("请选择要【" + obj["name"] + "】的数据！",function(){});
			return;
		}
		var params = {};
		params.datas = datas;
		params.workflow = _workflow;
		params.busguid = _menuid + "_" + datas[0].wfstatus;
		if (_type == "report" && obj["code"] == "sendaudit") {
			if(cmp.hasUnsavedData()){
				Ext.lt.ui.alert("当前页面存在【新增/修改/删除】未保存数据，请先确认【保存】后再送审",{icon:"warn"},function(){
					return;
				});
			}else{
				common.doAction(obj, params);
			}
		}else{
			common.doAction(obj, params);
		}
	}

	/**
	 * 送审情况
	 */
	cmp.queryaudit = function (){
		common.auditquery(datatable);
	}

	/**
	 * 批量导出附件
	 */
	cmp.expfile = function(obj) {
		var buttonconfig = eval('(' + obj.config + ')');
		var data = datatable.getSelected();
		if(data.length < 1){
			Ext.lt.ui.alert( "请选择数据进行附件导出！",function(){
			});
			return;
		}
		var list = [];
		for (var i = 0; i < data.size(); i++) {
			var params = {};
			params.guid = data[i].guid;//数据id
			params.name = data[i].eval_pro_name;//名称
			params.agency = data[i].dept_code+"-"+data[i].dept_name;//单位
			list.push(params);
		}
		var params = {};
		params.bustype = "deptperfevalTJ_file" ; // 文件表类型
		params.fileexptype = "deptperfevalTJ_file";
		params.list = list;
		params.tokenid = Ext.lt.token.getTokenid();
		params.zipname = buttonconfig.zipname;
		Ext.lt.RCP.down("pmkpi.perfcommon.fileexp.FileExpService",'indexFileExp',params,'downframe');
	}

	/**
	 * 切换页签方法
	 */
	cmp.clickTabpage = function(obj){
		var fisttabnum = _tabcode == "back" ? 2 : 0;
		// 切换前先更新按钮状态
		common.changTooltoolbuttontStatus(0, obj.hidebtns);
		// 非填报场景直接切换
		if (_type != "report") {
			cmp.doSwitchTab(obj);
			return;
		}
		// 填报场景：需要校验未保存数据的tab类型（undefined/待审核/退回）
		var needCheckTab = !_tabcode || _tabcode == "waitaudit" || _tabcode == "back";
		if (!needCheckTab) {
			cmp.doSwitchTab(obj);
			return;
		}
		if (datatable.getEditor()) {
			datatable.closeEdit();
		}
		// 无未保存数据直接切换
		if (!cmp.hasUnsavedData()) {
			cmp.doSwitchTab(obj);
			return;
		}
		// 有未保存数据，弹确认框（保留防重复触发逻辑）
		if (is_checktab) {
			is_checktab = false;
			Ext.lt.ui.confirm("当前页面存在【新增/修改/删除】未保存数据，确认不保存切换到其他页签吗？", {icon:'warn',buttons:[{确定:true},{返回:false}]}, function (ret) {
				if (ret) {
					cmp.doSwitchTab(obj);
				} else {
					// 取消切换，回到原tab
					tabpage.doActiveTab(fisttabnum);
				}
				// 恢复标记，允许下次触发
				is_checktab = true;
			});
		}
	}

	/**
	 * ---------------工具类------------start
	 */
	cmp.hasUnsavedData= function (datas){
		var hasUnsaved = false;
		var datas = datas || datatable.getRecordSet().toArray();
		for (var i = 0; i < datas.length; i++) {
			if (datas[i].rowtype && datas[i].rowtype == "add") {
				hasUnsaved = true;
				break;
			}
		}
		if (datatable.onchange()) {
			hasUnsaved = true;
		}
		return hasUnsaved;
	}

	cmp.doSwitchTab = function (obj) {
		cmp.setTableEditAfterChanegTab(obj);
		_tabfilter = obj.filter;
		_tabcode = obj.code;
		Ext.lt.pmkpi.query();
		is_checktab = true;
	}

	cmp.setTableEditAfterChanegTab = function (obj){
		if(obj.code == "waitaudit" || obj.code == "back"){
			cmp.setTableEdit(true);
		}else{
			cmp.setTableEdit(false);
		}
	}

	/**
	 * @param isedit boolean
	 */
	cmp.setTableEdit = function (isedit){
		for(var i = 2; i<datatable.getCols().length; i++){
			var col = datatable.getCols()[i];
			if(_coleditmap != {} && _coleditmap[col.colcode]){
				datatable.getCols()[i].edit = isedit;
			}
		}
		datatable.redraw();
	}

	/**
	 * 设置数据源
	 */
	cmp.getdataSource = function () {
		var _eval_type_source = [];
		for (var i = 0; i < _eval_types.length; i++) {
			var temparr = [];
			temparr.push(_eval_types[i]["guid"]);
			temparr.push(_eval_types[i]["code"]);
			temparr.push(_eval_types[i]["name"]);
			_eval_type_source.push(temparr);
		}
		datatable.addMapperDatas("eval_type", _eval_type_source);
	}

	/**
	 * ---------------工具类------------end
	 */

	return cmp;
}
