if(!Ext.lt.pmkpi)
	Ext.lt.pmkpi = {};
/**
 * 初始化加载.
 */
Ext.lt.pmkpi.deptrecomindexservice = function(config, service) {
	window.parent.Ext.lt.pmkpi.childwindow = window;
	var common = Ext.lt.pmkpi.perfcommon(config, service);
	var cmp = {};
	var serviceid = service,
		_menuid = config.menuid,
		_nodeguid, //左侧树节点
		_tabfilter, //页签过滤条件
		_tabcode, //页签
		_defquery, //表格过滤条件
		_orderby; //排序
	var isfirst = true;
	var isadjust = config.isadjust;//是否调整
	var isZJ = config["isZJ"];//标识是否是浙江（1.浙江）
	var isHuBei = config["isHuBei"];//标识是否是湖北（1.湖北）
	var isSX = config["isSX"];//标识是否是山西（1.山西）
	var _isHebei = config.isHebei;//标识是否是河北模式（1.河北）
	var _signs = config["signs"]; //计算符号
	var _tableid = config.tableid ? config.tableid : "datatable";//父级树
	var _levelno;

	Ext.lt.message.hook("layout", "endlayout2",function(){
		if (isfirst) {
			var height = $(".bd_main").height();
			var width = $("#recomtable").width();
			recomtable.resize(width,height);
            if(typeof header !== 'undefined') header.doActiveTab(0);
            if(typeof tab !== 'undefined') tab.doActiveTab(0);
			isfirst = false;
			/**
			 * 添加按钮,查询区位移
			 */
			$('.layui-tab-title').append("<button title='取消' onclick=\"pmkpideptrecomindex.closewin();\" type=\"button\" style=\"float:right;margin:0 10px 0 15px;background-color:#3472ef\" class=\"layui-btn btn-black\">取消</button>");
			$('.layui-tab-title').append("<button title='确定' onclick=\"pmkpideptrecomindex.addindex();\" type=\"button\" style=\"float:right;margin:0 10px 0 15px;background-color:#3472ef\" class=\"layui-btn btn-black\">确定</button>");
			$("#queryform").css("top",0);
		}
	});

	Ext.lt.message.hook("datatable", "beforesetcols",function(obj) {
		var uiconfig = obj.table.uiconfig;
		var config = obj.table.config;
		_defquery = uiconfig.defquery;
		_orderby = uiconfig.orderby;
	});

	Ext.lt.message.hook("queryform", "doquery",function(obj){
		Ext.lt.pmkpi.query();
	});

	Ext.lt.pmkpi.query = function(){
		if(!_nodeguid){
			_nodeguid = "treeroot";
			Ext.lt.pmkpi.isleaf = 0;
			_levelno = 1;
		}
		Ext.lt.ui.loadingShow();
		var params = {};
		params.saveAgency=config.saveAgency;
		params.nodeguid = _nodeguid;
		params.isleaf = Ext.lt.pmkpi.isleaf + "";
		params.levelno = _levelno;
		params.menuid = _menuid;
		params.queryConfig = queryform.getQueryParam();
		params.querySql = queryform.getQuerySQL();
		params.tabfilter = _tabfilter;
		params.tabcode = _tabcode;
		params.orderby=_orderby;  //排序
		params.tablesql=_defquery;//查询条件
		params.beanid = "pmkpi.deptperformance.DeptRecomIndexBO";
		recomtable.queryData(params,function(){
			Ext.lt.ui.loadingClose();
		});
	}

	/**
	 * 点击左侧树.
	 */
	Ext.lt.message.hook("left", "click",function(obj){
		var treeNode = obj.node.data;
		if(treeNode){
			_nodeguid = treeNode.guid;
			Ext.lt.pmkpi.isleaf = treeNode.isleaf;
			_levelno = treeNode.levelno;
		} else {
			_nodeguid = "treeroot";
			Ext.lt.pmkpi.isleaf = '0';
		}
		Ext.lt.pmkpi.query();
	});

	//页签方法
	cmp.clicktab = function(obj){
		_tabfilter = obj.filter;
		_tabcode = obj.code;
	}


	cmp.addindex =  function() {
		//被选中的数据
		var selRecords = recomtable.getSelected();
		var selMap = {};
		var tempobj = {};
		var sindex = "";
		var name = "";
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
			if(isHuBei == 1) {
				//参考值
				tempobj.targetvalue = tempobj.kpi_val;
			}
			tempobj.kpi_evalstd = "1"; //部标规范字段
			tempobj.kpi_content = tempobj["name"]; //部标规范字段
			if (isadjust == "true") {
				tempobj.status = "3";
			}
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
		var parent_sel_rows;
		var parent_sel_obj;
		var _sortid;
		for ( var key in selMap) {
			parent_sel_rows = parent.eval(_tableid).getRecordset().query({guid:key});
			if (parent_sel_rows.length > 0 ) {
				parent_sel_obj = parent_sel_rows[parent_sel_rows.length -1];
				_sortid = parent_sel_obj._sortid;
				parent.eval(_tableid).getRecordSet().addData(selMap[key],_sortid + parent.eval(_tableid).getRecordset().toArray().length);
				if((!parent_sel_obj["name"] || parent_sel_obj["name"] =="") && "tree" != _fromtype){
					parent.eval(_tableid).getRecordset().delRow(_sortid);
				}
			}
		}
		parent.Ext.lt.ui.modalWindow.close();
	}

	$(function(){
		//组件配置，service不放到第一位时，组件初始化消息不走问题
		common.initDatatable(recomtable);
	})

	cmp.closewin = function(){
		parent.Ext.lt.ui.modalWindow.close();
	}
	return cmp;
}