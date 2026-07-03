if(!Ext.lt.pmkpi) 
	Ext.lt.pmkpi = {};
/**
 * 初始化加载.
 */
Ext.lt.pmkpi.pickindexservice = function(config, serviceid) {
	var sindex = config["sindex"];
	var rowguid = config["guid"]; //选择行的guid
	var prolev = config["prolev"]; //项目级别：1 2 3
	var saveAgency = config["saveAgency"]; //项目单位
    var _fromtype = config["fromtype"]; //来源树级表格还是合并表格
	var deptdata = [];//部门
	var _tableid = "";
	var _signs = config["signs"]; //计算符号
	var _cmp = {};
	/**
	 * 页面布局完成.
	 */
	Ext.lt.message.hook("layout", "endlayout2",function(){
		var height = $(window).height() - 68;
		var width = $(window).width() ;
		picktable.resize(width,height);
        if ("tree" == _fromtype){
            _tableid = "datatable";
        } else {
            _tableid = "indexdatatable";
        }
	});
	
	/**
	 * 页面加载完成
	 */
	$(function() {
		window.parent.indexwindow = window;
		if(queryform.getCol("agencyguid")){
			deptdata = Ext.lt.RCP.asyncall(serviceid , "getDeptGuid", saveAgency);
			var sycMap ={};
			sycMap.agencyguid = {
					value:deptdata[0].guid,
					text: deptdata[0].agency
			};
			queryform.getCol("agencyguid").bind(sycMap);
			_cmp.query();
		}else{
			_cmp.query();
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
	 * 选中
	 */
	_cmp.addindex = function(){
		var selRecords = picktable.getSelected();
		if(selRecords.size()<=0){
			Ext.lt.pmkpi.alert("请选择数据！",{},function(){});
			return;
		}
        var selMap = {};
        var tempobj = {};
        var sindex = "";
        var name = "";
        for(var i=0;i<selRecords.length;i++){
            tempobj = selRecords[i];
            var uuid = createUUID().replace(/-/g, '');
            tempobj["guid"] = uuid;
            tempobj["tindex"] = tempobj["guid"];
            sindex = tempobj["sindex"];
            name = tempobj["name"];
            tempobj.superid = tempobj["sindex"];
            tempobj.levelno = 3;
            tempobj.isleaf = 1;
            tempobj._isleaf = 1;
            tempobj.rowtype = "add";
			tempobj.isfixed = "";
			tempobj.isfromparent = "0";
			tempobj.isapply = "1";
            if(name && name != ""){ //存在三级指标的才保存替换
                if(!selMap[sindex]){
                    selMap[sindex] = [];
                }
                tempobj.indexvalue = ""; //指标值清空
                tempobj.kpi_val = "";
                selMap[sindex].push(tempobj);
            }
			if (parent._curtab == "total") {
				tempobj.yearflag = "1";
			} else if (parent._curtab == "year") {
				tempobj.yearflag = "0";
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
        var parent_sel_rows;
        var parent_sel_obj;
        var _sortid;
        for ( var key in selMap) {
            parent_sel_rows = parent.eval(_tableid).getRecordset().query({guid:key});
            if (parent_sel_rows.length > 0 ) {
                parent_sel_obj = parent_sel_rows[parent_sel_rows.length -1];
                _sortid = parent_sel_obj._sortid;
                parent.eval(_tableid).getRecordSet().addData(selMap[key],_sortid);
                if((!parent_sel_obj["name"] || parent_sel_obj["name"] =="") && "tree" != _fromtype){
                    parent.eval(_tableid).getRecordset().delRow(_sortid);
                }
            }
        }
		parent.Ext.lt.ui.modalWindow.close();
	}
	/**
	 * 查询
	 */
	_cmp.query = function(){
		debugger;
		var filter = queryform.getQuerySQL();
		//var tablewhere = picktable //获取表格的过滤数据
		var params = {"filter":filter,"sindex":sindex,"prolev":prolev,"saveAgency":saveAgency};
		params.beanid = "pmkpi.prjindex.PrjIndexBO";
		params.pagetype = 'pickindex';
		Ext.lt.ui.loadingShow();
		Ext.lt.bus.exportBeanid = params.beanid;
		picktable.queryData(params,function(){
        	Ext.lt.ui.loadingClose();
        });
	}

	/**
	 * 新增
	 */
	_cmp.add = function(frame,guid){
		var url = '/pmkpi/program/prjindex/editindex.page';
		var params = {};
		params.saveAgency = saveAgency; //项目单位
		params.prolev = prolev;//项目级别 123
		params.sindex = sindex;
		params.upguid = rowguid;
		params.type = "add";
		url = Ext.lt.pmkpi.genPageUrl(url, params);
		indexwindow = Ext.lt.ui.openModalWindow(url,1000,450,"新增指标");
	}

	/**
	 * 查询区
	 */
	Ext.lt.message.hook("queryform", "doquery",function(obj){
		_cmp.query();
	});
	return _cmp;
}