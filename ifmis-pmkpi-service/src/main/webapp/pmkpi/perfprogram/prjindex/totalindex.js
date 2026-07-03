if(!Ext.lt.pmkpi) 
	Ext.lt.pmkpi = {};
/**
 * 初始化加载.
 */
Ext.lt.pmkpi.totalindexservice = function(config, serviceid) {
	var common = Ext.lt.pmkpi.perfcommon(config, serviceid);
	var sindex = config["sindex"];
	var prolev = config["prolev"]; //项目级别：1 2 3
	var saveAgency = config["saveAgency"]; //项目单位
	var proguid = config["proguid"];//项目guid
	var procode = config["procode"];//项目guid
	var pagetype = config["pagetype"];//项目guid
	var _signs = config["signs"];//计算符号
	var _displaycols = [];
	var _cmp = {};
	var isadjust = config.isadjust;//是否调整
	/**
	 * 页面布局完成.
	 */
	Ext.lt.message.hook("layout", "endlayout2",function(){
		var height = $(window).height() - 68;
		var width = $(window).width() ;
        lasttable.resize(width,height);
	});
	
	/**
	 * 页面加载完成
	 */
	$(function() {
		common.initDatatable(lasttable);
		_cmp.setTableColum();
		_cmp.query();
		window.parent.indexwindow = window;
	})

	/**
	 * 动态配置表格的列.
	 *
	 * @param data --
	 */
	_cmp.setTableColum = function(){
		var cols = lasttable.getCols(); //获取列表所有列
		cols.push.apply(cols, _displaycols);
		_displaycols = [];
		for (var i = 0, len = cols.length; i < len; i++) {
			var col = cols[i];
			if (col.colcode == "obligate1") {
				_displaycols.push(col); //隐藏前暂存至sfagency;
				col.display = false; //display置为false，隐藏
			}
		}
		lasttable.redraw(); //从新绘制表格
	}

	/**
	 * 重画表格列.
	 */
	Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
		var uiconfig = obj.table.uiconfig;
		zcolumns = uiconfig.columns;
		var cols = obj.cols;
		if(!Ext.lt.isArray(cols))
			cols = [cols];
		for(var i=0; i<cols.length; i++){
			var col = cols[i];
			if (col["name"] != "check") {
				col.style = "background-color:#f2f2f2;";
				col.oneditstart = function (table, e, l, c, d) {
					return false;
				}
			}

		}
	})

	/**
	 * 关闭
	 * @param obj
	 */
	_cmp.closewin = function(obj){
		parent.Ext.lt.ui.modalWindow.close();
	}
	/**
	 * 查询
	 */
	_cmp.query = function(){
		var filter;
		//var tablewhere = picktable //获取表格的过滤数据
		var params = {"filer":filter,"sindex":sindex,"prolev":prolev,"saveAgency":saveAgency,"proguid": proguid,"pagetype": pagetype};
		params.beanid = "pmkpi.prjindex.PrjIndexBOTX";
		params.pagetype = 'totalindex';
		params.procode = procode;
		Ext.lt.ui.loadingShow();
        lasttable.queryData(params,function(){
        	Ext.lt.ui.loadingClose();
        });
	}

	/**
	 * 确定
	 */
	_cmp.addindex = function(){
		var datas = lasttable.getSelected().toArray();
		for(var i=0; i<datas.length; i++) {
			var data = datas[i];
			data.guid = getCreateguid(serviceid);
			data.rowtype = "add";
			data.levelno = 3;
			data.isleaf = 1;
			data._isleaf = 1;
			data.isfixed = "";
			data.isfromparent = "0";
			data.isapply = "1";
			if (parent._curtab == "total") {
				data.yearflag = "1";
			} else if (parent._curtab == "year") {
				data.yearflag = "0";
			}
			if (isadjust == "true") {
				data.status = "3";
				data.yearflag = "0";
				data.obligate1 = "删除";
			} else {
				parent.tabcomps["#year"].push(data);
			}
		}
		if (isadjust == "true") {
			parent.getdataSource();
		}
		var zbxs_source = [];
		for(var i=0; i<_signs.length; i++){
			var temparr = [];
			temparr.push(_signs[i]["guid"]);
			temparr.push(_signs[i]["code"]);
			temparr.push(_signs[i]["name"]);
			zbxs_source.push(temparr);
		}
		parent.datatable.addMapperDatas("computesign", zbxs_source);
		if (parent.datatable.getCol("isapply") && parent.datatable.getCol("isapply")["isvisiable"] == 1){
			var isapply_source = [];
			var _isapply = [{guid: "2", code: 2, name: "否"}, {guid: "1", code: 1, name: "是"}];
			for (var i = 0; i < _isapply.length; i++) {
				var temparr = [];
				temparr.push(_isapply[i]["guid"]);
				temparr.push(_isapply[i]["code"]);
				temparr.push(_isapply[i]["name"]);
				isapply_source.push(temparr);
			}
			parent.datatable.addMapperDatas("isapply", isapply_source);
		}
		if (parent._curtab == "year" || isadjust == "true") {
			parent.datatable.getRecordSet().addData(datas);
		}
		parent.Ext.lt.ui.modalWindow.close();
	}

	return _cmp;
}