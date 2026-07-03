if(!Ext.lt.pmkpi){
	Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.advevalindex){
	Ext.lt.pmkpi.advevalindex = {};
}
var serviceid;
var _mainguid;
var _saveAgency;
var _menuid;
var _viewtype;
Ext.lt.pmkpi.advevalindex = function(config, service){
	var
		_tablecode,//表名
		_defquery,//表配置过滤条件
		_orderby,//表排序sql
		_busguid,//审核定义
		_modelguid//指标模板guid
	;
	var cmp = {};
	serviceid = service;
	_projguid = config.projguid;
	_tablecode = config.tablecode;
	_saveAgency = config.saveAgency;
	_viewtype = config.viewtype,
		_querytype = config.querytype,
		_bustype = config.bustype,
		_scrWidth =document.body.clientWidth;
	_scrHeight =document.body.clientHeight;
	/**
	 *
	 */
	Ext.lt.message.hook("busdatatable", "drawed",function (obj) {
		var config = obj.config;
		_tablecode = obj.uiconfig.tablecode;
		_defquery = obj.uiconfig.defquery;
		_orderby = obj.uiconfig.orderby;
		//审核定义guid，perf_t_busauditdefine表budguid
		_busguid = config.busguid;
		_modelguid = config.modelguid;
	});

	cmp.query = function(){
		var params = {};
		params.tablesql = _defquery;
		params.orderby = _orderby;
		params.tablecode = _tablecode;
		params.projguid = _projguid;
		params.modelguid = _modelguid;
		params.bustype = _bustype;
		params.agency = _saveAgency;
		params.viewtype = _viewtype;
		params.querytype = _querytype;
		params.menuid = _menuid;
		Ext.lt.ui.loadingShow();
		Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
			datatable.setDatas(rs.data);
			setTimeout(function(){
				amtTotal(datatable);
			},100);
			Ext.lt.ui.loadingClose();
		},function(){
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
		params.tablecode = _tablecode;
		params.busguid = _busguid;
		params.mainguid = _mainguid;
		params.projguid = _projguid;
		Ext.lt.ui.loadingShow();
		var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
		Ext.lt.ui.loadingClose();
		cmp.query();
		return rs;
	}

	$(function () {
		cmp.query();
	})

	Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
		var cols = obj.cols;
		if(!Ext.lt.isArray(cols))
			cols = [cols];
		for(var i=0; i<cols.length; i++){
			var col = cols[i];

			if(col["colcode"] == "adv_eva_info"){
				var findex = "";
				var subfindex = "";
				col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
					if(j==2){
						var tabledata = datatable.getRecordSet().toArray();
						var statnum = 0;
						if(i==statnum){
							findex = Ext.lt.cloneobj(rs["adv_eva_info"]);
						}
						if(findex == rs["adv_eva_info"]){
							style ='style="border-bottom-style:none;text-align:center;position:relative;padding-top:5px;';
						} else {
							style ='style="border-top-width:1px;text-align:center;border-top-color:#cccccc;border-bottom-style:none;';
						}
						findex = Ext.lt.cloneobj(rs["adv_eva_info"]);
						if(i == tabledata.length-1){
							style =style +'border-bottom-style:solid;"';
						} else {
							style =style + '"';
						}
						if(datatable.uiconfig.totaltag ==1 && i==0){ //有权重的合计
							style ='style="border-bottom-style:none;text-align:center;position:relative;padding-top:5px;"';
						}
					}
					return style;
				}
				col.fn = function(i,c,rs,value){ //行的显示样式.
					if(rs["adv_eva_info"]){
						subfindex = Ext.lt.cloneobj(rs["adv_eva_info"]);
						var seq = showMidleName(subfindex,"adv_eva_info");
						if(i==seq){
							return value;
						}
						return "";
					}
				}
			}

			if(col["colcode"]=="option_value"){
				col.fn = function(l,c,data,col){
					var yrs = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" id="option_value_y'+data.ordernum+'" name="option_value_radio'+data.ordernum+'" value="1">是';
					var yrsc = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" id="option_value_y'+data.ordernum+'" checked="checked" name="option_value_radio'+data.ordernum+'" value="1">是';
					var nrs = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" id="option_value_n'+data.ordernum+'" name="option_value_radio'+data.ordernum+'" value="0">否';
					var nrsc = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" id="option_value_n'+data.ordernum+'" checked="checked" name="option_value_radio'+data.ordernum+'" value="0">否';
					if(data.datatable_do_sum==true){
						return "";
					}else if(data.option_value == '1'){
						return yrsc + nrs;
					}else if(data.option_value == '0'){
						return yrs + nrsc;
					}else{
						return yrs + nrs;
					}
				}

				col.onclick = function (table, el, l, c, d) {
					var option_value = $("input[name='option_value_radio"+d.ordernum+"']:checked").val();
					if(option_value == '1'){
						d.option_value = '1';
						d.unit_since_score = d.weight;
					}else{
						d.option_value = '0';
						d.unit_since_score = '0';
					}
					amtTotal(table);
				}
			}

		}
	});


	return cmp;
}

showMidleName = function(val,col){
	var tabledata = datatable.getRecordSet().toArray();
	var a = -1,b=-1;
	var atemp = {};
	for ( var i = 0; i < tabledata.length; i++) {
		atemp = tabledata[i];
		if(val == atemp[col]){
			a = atemp["_sortid"]; //首次出现值
			break;
		}
	}
	var btemp = {};
	for ( var i = tabledata.length-1; i >-1; i--) {
		btemp = tabledata[i];
		if(val == btemp[col]){
			b = btemp["_sortid"]; //结束出现值
			break;
		}
	}
	return parseInt((b-a)/2)+a;
}

function amtTotal(table) {
	if(table.getSumobj()){
		var totalrow = table.getRecordset();
		var sumweight = 0;
		var sumscore = 0;
		var rowarr = totalrow.toArray();
		var len = rowarr.length;
		for ( var i = 0; i < len; i++) {
			var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0;
			sumweight += parseFloat(weight);
			var unit_since_score = rowarr[i]["unit_since_score"] ? rowarr[i]["unit_since_score"] : 0;
			sumscore += parseFloat(unit_since_score);
		}
		var totalrs = {};
		totalrs["weight"] = sumweight == 0 ? "" : getPointNum(sumweight);
		totalrs["unit_since_score"] = sumscore == 0 ? "" : getPointNum(sumscore);
		totalrs.datatable_do_sum=true;
		table.getClockRowSet().setData(totalrs,0);
		if((totalrow.size&&totalrow.size()>0)||(totalrow.length&&totalrow.length>0)){
			table.reflashdata();
		}
	}
}

function getPointNum(num){
	var str = String(num);
	var index = str.split(".");
	var str1 = null;
	if(index.length == 2){
		str1 = index[1].substring(0,2);
		str1 = Number(index[0]+"."+str1);
	} else {
		str1 = Number(index[0]);
	}
	return str1;
}