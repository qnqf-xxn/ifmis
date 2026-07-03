if(!Ext.lt.pmkpi) 
	Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.evaPrjindex)
	Ext.lt.pmkpi.evaPrjindex = {};
var serviceid;
var _code;
Ext.lt.pmkpi.evaPrjindex = function(config, service){
	var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
	var cmp = {};
	var _tablecode,
		_mainguid = config.mainguid;
	var scrWidth =document.body.clientWidth,
		scrHeight =document.body.clientHeight;
	serviceid = service;

	$(function () {
		//组件配置，service不放到第一位时，组件初始化消息不走问题
		deptcmp.initDatatable();
		cmp.query();
		setTimeout(function(){
			initgatherWeight();
			amtTotal(datatable);
		},2000);
	})
	//重新画
    cmp.draw = function(div) {}

	//查询
	cmp.query = function (){
		Ext.lt.pmkpi.query();
	}
    /**
	 * 查询.
     */
	Ext.lt.pmkpi.query = function(){
		var params = {};
		Ext.lt.ui.loadingShow();
		params.tablecode = _tablecode;
		params.mainguid = _mainguid;
		Ext.lt.RCP.call(serviceid , "getData", params, function(rs){
            datatable.setDatas(rs.data);
			setTimeout(function(){
				initgatherWeight();
				amtTotal(datatable);
			},100);
			Ext.lt.ui.loadingClose();
		},function() {
			Ext.lt.ui.loadingClose();
			Ext.lt.ui.alert('查询失败！',function(){
			});
		});
	}
	cmp.save = function(){
		if (!datatable.checkAll()) return false;//先校验
		var params = {};
		params.datas = datatable.getRecordSet().toArray();
		params.updatas = datatable.getUpdataData();
		params.deldatas = datatable.getRemoveData();
		params.mainguid = _mainguid;
		params.tablecode = _tablecode;
		Ext.lt.ui.loadingShow();
		var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
		if(rs && rs.success == true){
		}else{
			Ext.lt.ui.alert(rs.code,function(){});
		}
		Ext.lt.ui.loadingClose();
		Ext.lt.pmkpi.query();
		return rs;
	}
	Ext.lt.message.hook("datatable", 'beforesetcols',function(data){
		var uiconfig = data.table.uiconfig;
		_tablecode = uiconfig.tablecode
		var cols = data.cols;
		if(!Ext.lt.isArray(cols))
			cols = [cols];
		for(var i=0; i<cols.length; i++){
			var col = cols[i];

			if(col["colcode"]=="weight"){
				col.fn = function(l,c,data,col){
					if(data.isleaf == "0"){
						var weight = 0;
						if(data.weight){
							weight = data.weight;
						}
						return "<b>"+Math.round(weight*100)/100+"</b>";
					}else{
						return data.weight ? data.weight : "";
					}
				}
				col.oneditstart = function (table, el, l, c, d) {
					if(d.levelno != "3"){
						return false;
					}
				}
				col.oneditend = function (table, el, l, c, d) {
					d.weight = d.weight!="" ? getPointNum(parseFloat(d.weight)) : "0";
					gatherWeight(d.superid);
					amtTotal(datatable);
				}
			}
			if(col["colcode"]=="obligate"){
				col.fn = function(l,c,data,col){
					var html = "";
					if(data.levelno == "1"||data.levelno == "2"){//层次
						html += '&nbsp;&nbsp;&nbsp;&nbsp';
						html += '<a title = "新增" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:indexadd("'+data.guid+'","'+data.levelno+'")\'>新增</a>';
					}else{
						html += '&nbsp;&nbsp;&nbsp;&nbsp';
					}
					html += '&nbsp;&nbsp;&nbsp;&nbsp';
					html += '<a title = "删除" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:indexdel("'+data.guid+'")\'>删除</a>';
					return html;
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
		newdata.code = newguid;
		newdata.levelno = 1;
		newdata.isleaf = 0;
		newdata.superid = '0';
		newdata.rowtype = "add";
		datatable.getRecordSet().addData(newdata,999);
	});


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
					if (data.length == 0){
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
					if (data.length == 0){
						superdata[0].isleaf = 1;	//父级数据的是否末节点改为  1 -->是
						superdata[0].isedit = 1;    //是末节点数据，就可以编辑
						datatable.reflash(superdata[0].isleaf);
						datatable.reflash(superdata[0].isedit);
					}
				}
			});
		}
	});
	function initgatherWeight(){
		var data = datatable.getRecordSet().toArray();
		var datas = data;
		var superid;
		for(var i = 0; i < data.length; i++){
			var selectData = data[i];
			if(selectData.levelno == '3'){
				superid = selectData.superid;
				gatherWeight(superid);
			}
		}
		amtTotal(datatable);
		datatable.reflash();
	}
	function gatherWeight(superid){
		var datas = datatable.getRecordSet().toArray();
		if(superid){
			if(datas!=null && datas.length > 0){
				var supguid = '';
				var sortid = 0;
				var result = 0;
				var guid = '';
				for(var i=0;i<datas.length;i++){
					var selectDatas = datas[i];
					if(superid == selectDatas.guid){
						supguid = selectDatas.superid;
						guid = selectDatas.guid;
					}
					if(selectDatas.superid == superid && selectDatas.weight && !isNaN(selectDatas.weight)){
						result += parseFloat(selectDatas.weight);
					}
				}
				datas.each(function(data,i){
					if(data.guid == guid){
						datas[i]['weight'] = result==0 ? "" : result.toFixed(1);
					}
				});
				gatherWeight(supguid);
			}
		}
		datatable.reflash();
	}
	function amtTotal(table) {
		if(table.getSumobj()){
			var totalrow = table.getRecordset();
			var sumamt = 0;
			var rowarr = totalrow.toArray();
			var len = rowarr.length;
			for ( var i = 0; i < len; i++) {
				if (rowarr[i].isleaf == "1" && rowarr[i].levelno == "3") {
					var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0;
					sumamt += parseFloat(weight);
				}
			}
			var totalrs = {};
			totalrs["weight"] = (sumamt?sumamt.toFixed(1):"0.00");
			totalrs.datatable_do_sum=true;
			table.getClockRowSet().setData(totalrs,0);
			if((totalrow.size&&totalrow.size()>0)||(totalrow.length&&totalrow.length>0)){
				table.reflashdata();
			}
		}
	}
	function checkReferencepole(referencepole){
		var re = /^\d*\.{0,1}\d{0,1}$/;
		if(!re.test(referencepole)){
			Ext.lt.ui.alert("请填写数字！",{timeout:1},function(){});
			return false;
		}else{
			return true;
		}
	}
	function getPointNum(num){
		var str = String(num);
		var index = str.split(".");
		var str1 = null;
		if(index.length == 2){
			str1 = index[1].substring(0,1);
			str1 = Number(index[0]+"."+str1);
		} else {
			str1 = Number(index[0]);
		}
		return str1;
	}
	return cmp;
}
/**
 * 删除体系
 * @param guid
 */
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
				if (data.length == 0){
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
			if (data.length == 0){
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
/**
 * 新增体系
 */
function indexadd(guid, levelno) {
	var newguid = Ext.lt.RCP.asyncall(serviceid, "getCreateguid", null);
	var newdata = {};
	newdata.guid = newguid;
	newdata.code = newguid;
	newdata.levelno = Number(levelno) + 1;
	newdata.superid = guid;
	if(newdata.levelno<=2){
		newdata.isleaf = 0;
	}else{
		newdata.isleaf = 1;
	}
	newdata.isedit = 1;
	newdata.isadd = 0;
	newdata.rowtype = "add";
	var parent_sel_rows = datatable.getRecordset().query({guid: guid});
	var parent_sel_obj = parent_sel_rows[0];
	var _sortid = parent_sel_obj._sortid;
	parent_sel_obj["isleaf"] = 0;
	parent_sel_obj["_isleaf"] = 0;
	parent_sel_obj["isedit"] = 0;
	datatable.reflash(_sortid);
	datatable.getRecordSet().addData(newdata, 999);
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
