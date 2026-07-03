if(!Ext.lt.pmkpi) 
	Ext.lt.pmkpi = {};

var serviceid;
var _deldatas = [];
var _treeid = "programevaluatescore"; //业务类型,默认财政评价
Ext.lt.pmkpi.curingindex = function(config, service){
	var cmp = {};
	var common = Ext.lt.pmkpi.perfcommon(config, service);
	var _tablecode,
		_province = config.province,
		_year = config.year,
		_query,//查询方式
		_defquery,
		_delcols,
		_updatecols;
	serviceid = service;
	Ext.lt.pmkpi.isleaf = 1;

	$(function (){
		common.initDatatable();
		if (datatable.config["tiptext"] && datatable.config["tiptext"] != null) {
			$('.busnomalbtn').append("<p title='' style=\"color: red;\" class=\"layui-text\">" + datatable.config["tiptext"] + "</p>");
		}
		Ext.lt.pmkpi.query();
	})

    /**
	 * 查询.
     */
	Ext.lt.pmkpi.query = function(){
		if (Ext.lt.pmkpi.isleaf == 0) {
			Ext.lt.ui.alert('请点击末级查询！',function(){
			});
			return;
		}
		var params = {};
		Ext.lt.ui.loadingShow();
		params.tablecode = _tablecode;
		params.tablesql = _defquery;
		if(_query == 'querydata'){
			Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
				datatable.setDatas(rs.data);
				Ext.lt.ui.loadingClose();
			},function(){
				Ext.lt.ui.loadingClose();
				Ext.lt.ui.alert('查询失败！',function(){
				});
			});
		}else{
			/*params.beanid = "pmkpi.curingindex.CuringIndexSetBOTX";
			datatable.queryData(params,function(){
				Ext.lt.ui.loadingClose();
			});*/
		}
	}


	Ext.lt.message.hook("perfcommon", "tablequery",function(){
		Ext.lt.pmkpi.query();
	});

	//多主键保存方法
	cmp.savemajorkey = function(){
		if (!cmp.checkall()) return;//先校验
		var params={};
		params.tablecode = _tablecode;
		params.province = _province;
		params.year = _year;
		params.delcols = _delcols;
		params.updatecols =_updatecols;
		params.datas = datatable.getRecordSet().toArray();
		params.deldatas = datatable.getRemoveData();
		Ext.lt.RCP.call(serviceid, "savemajorkey", params, function(rs){
			if (rs && rs.success) {
				Ext.lt.ui.alert('保存成功！',function(){
					Ext.lt.pmkpi.query();
				});
			}
			Ext.lt.ui.loadingClose();
		}, function(){
			Ext.lt.ui.alert('保存失败！',function(){
			});
			Ext.lt.ui.loadingClose();
		});
	}

	cmp.checkall = function (){
		var cols = datatable.getCols(); //获取列表所有列
		var datas = datatable.getRecordSet().toArray();
		for (var j = 0,lenj = cols.length; j < lenj; j++) {
			var col = cols[j];
			var config = eval(col.config);
			if (col.colcode =="indexval" || col.colcode == "computesign") {
				for (var i = 0,leni = datas.length; i < leni; i++) {
					if (datas[i]["isleaf"] == 1) {
						var value = datas[i][cols[j].colcode];
						if (value == null || value == "" || ("" + value).trim().length == 0) {
							var str = "第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "为必录项，必须有值！";
							Ext.lt.ui.alert(str,function(){
							});
							return false;
						}
					}
				}
			}
		}
		return true;
	}

	Ext.lt.message.hook("datatable", 'beforesetcols',function(data){
		var uiconfig = data.table.uiconfig;
		_tablecode = uiconfig.tablecode;
		_defquery = uiconfig.defquery;
		var config = data.table.config;
		_query = config.query;
		_delcols = config.delcols;
		_updatecols = config.updatecols;
		var cols = data.cols;
		if(!Ext.lt.isArray(cols))
			cols = [cols];
		for(var i=0; i<cols.length; i++){
			var col = cols[i];
			if(col["colcode"]=="obligate"){  //操作列
				col.fn = function(l,c,data,col){
					var html = "";
					// if(data.isleaf == "0"){//层次
						html += '&nbsp;&nbsp;&nbsp;&nbsp';
						html += '<a title = "新增" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:indexadd("'+data.guid+'","'+data.levelno+'")\'>新增</a>';
					// }else{
					// 	html += '&nbsp;&nbsp;&nbsp;&nbsp';
					// }
					html += '&nbsp;&nbsp;&nbsp;&nbsp';
					html += '<a title = "删除" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:indexdel("'+data.guid+'")\'>删除</a>';
					return html;
				}
			}
			//非末级节点 是否可编辑、指标值、符号、单位四列不可编辑
			if (col["colcode"] == "indexval" || col["colcode"] == "computesign" || col["colcode"] == "meterunit" || col["colcode"] == "isedit"){
				col.oneditstart = function (table, e, l, c, d) {
					if(d.isleaf == '0') {
						return false;
					}
				}
			}

		}
	});
    /**
	 * 新增
     */
    Ext.lt.message.hook("addRow", "uidatatable", function(editdatatable){
        var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
        var newdata ={};
        newdata.guid = newguid;
        newdata.levelno = 1;
        newdata.isleaf = 1;
        newdata.superid = '0';
        newdata.isedit = 1;
        newdata.isadd = 0;
		newdata.istotal = 1;
        newdata.rowtype = "add";
		datatable.getRecordSet().addData(newdata,999);
    });
    /**
	 * 刪除表格.
     */
    Ext.lt.message.hook("delRow", "uidatatable", function(editdatatable){
		//获取选中的数据
        var selDatas = datatable.getSelected();
        var guid = selDatas[0].guid;		//选中数据的guid
		//获取选中数据的父级数据
		var superguid = selDatas[0].superid;//选中数据的父级id
		var superdata = datatable.getRecordSet().query({guid:superguid});
        if (selDatas.size() <= 0) {
            Ext.lt.ui.alert('请选择要删除的数据！',function(){
            });
            return;
        }
		//查询选中的数据有没有下级
        var datas = datatable.getRecordSet().query({superid:guid});
		if(datas.length > 0 && datas != null){
			Ext.lt.ui.confirm("将删除该指标及其下级所有指标，是否确认删除？",{icon:"warn"},function(ret){
				if(ret){
					subdeldata(guid);
					//判断选中数据的父级数据还有没有下级数据
					var data = datatable.getRecordSet().query({superid:superguid});
					//没有下级数据
					if (data.length == 0 && superdata.length>0){
						superdata[0].isleaf = 1;	//父级数据的是否末节点改为  1 -->是
						superdata[0].isedit = 1;    //是末节点数据，就可以编辑
						datatable.reflash(superdata[0].isleaf);
						datatable.reflash(superdata[0].isedit);
					}
				}
			});
		}else{
			Ext.lt.ui.confirm("是否确定删除已选择的数据？", {icon: "warn"}, function (ret) {
				if (ret) {
					//查询选中的数据
					var datas = datatable.getRecordSet().query({guid:guid});
					var superid = datas[0].superid;	//被删除数据的父级id
					var superdata = datatable.getRecordSet().query({guid:superid});  	//被删除数据的父级数据
					if (datas != null && datas.length > 0) {
						datatable.removeData(datas);
					}
					//判断父级数据还有没有下级数据
					var data = datatable.getRecordSet().query({superid:superid});
					//没有下级数据
					if (data.length == 0 && superdata.length>0){
						superdata[0].isleaf = 1;	//父级数据的是否末节点改为  1 -->是
						superdata[0].isedit = 1;    //是末节点数据，就可以编辑
						datatable.reflash(superdata[0].isleaf);
						datatable.reflash(superdata[0].isedit);
					}
				}
			});
		}
    });

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

	return cmp;
}

/**
 * 删除体系
 * @param guid
 */
function indexdel(guid) {
	//获取选中数据
	var seldata = datatable.getRecordset().query({guid:guid});
	//获取选中数据的父级数据
	var superguid = seldata[0].superid;
	var superdata = datatable.getRecordSet().query({guid:superguid});
	//查询选中的数据有没有下级
	var datas = datatable.getRecordSet().query({superid:guid});
	if (datas != null && datas.length > 0) {
		Ext.lt.ui.confirm("将删除该指标及其下级所有指标，是否确认删除？",{icon:"warn"},function(ret){
			if(ret){
				subdeldata(guid);
				//判断选中数据的父级数据还有没有下级数据
				var data = datatable.getRecordSet().query({superid:superguid});
				//没有下级数据
				if (data.length == 0 && superdata.length>0){
					superdata[0].isleaf = 1;	//父级数据的是否末节点改为  1 -->是
					superdata[0].isedit = 1;    //是末节点数据，就可以编辑
					datatable.reflash(superdata[0].isleaf);
					datatable.reflash(superdata[0].isedit);
				}
			}

		});
	}else{
		Ext.lt.ui.confirm("是否确定删除已选择的数据？", {icon: "warn"}, function (ret) {
			if (ret) {
				//选中删除的数据
				var datas = datatable.getRecordSet().query({guid:guid});
				if (datas != null && datas.length > 0) {
					datatable.removeData(datas);
				}
			}
			//获取被删除数据的父级
			var superid = datas[0].superid;	//被删除数据的父级id
			var superdata = datatable.getRecordSet().query({guid:superid});
			//判断父级数据还有没有下级数据
			var data = datatable.getRecordSet().query({superid:superid});
			//没有下级数据
			if (data.length == 0 && superdata.length>0){
				superdata[0].isleaf = 1;	//父级数据的是否末节点改为  1 -->是
				superdata[0].isedit = 1;    //是末节点数据，就可以编辑
				datatable.reflash(superdata[0].isleaf);
				datatable.reflash(superdata[0].isedit);
			}
		});
	}
}

/**
 * 新增体系
 */
function indexadd(guid, levelno) {
	var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
	var newdata ={};
	newdata.guid = newguid;
	newdata.levelno = Number(levelno)+1;
	newdata.superid = guid;
	newdata.isedit = 1;
	newdata.isadd = 0;
	newdata.isleaf = 1;
	newdata.rowtype = "add";
	var parent_sel_rows = datatable.getRecordset().query({guid:guid});
	var parent_sel_obj = parent_sel_rows[0];
	var _sortid = parent_sel_obj._sortid;
	parent_sel_obj["isleaf"] = 0;
	parent_sel_obj["_isleaf"] = 0;
	parent_sel_obj["isedit"] = 0;
	datatable.reflash(_sortid);
	datatable.getRecordSet().addData(newdata,999);
}

function subdeldata(guid){
	//删除选中数据
	var parent_sel_rows = datatable.getRecordset().query({guid:guid});
	datatable.removeData(parent_sel_rows);
	//查询选中数据下级
	var datas = datatable.getRecordset().query({superid:guid});
	//循环查询删除最末级
	for (var i = 0; i < datas.length; i++) {
		//选中数据的下级的下级数据
		var data2 = datatable.getRecordset().query({superid:datas[i].guid});
		datatable.removeData(data2);
		//datatable.removeData(datas[i].guid);
		subdeldata(datas[i].guid);
	}
}