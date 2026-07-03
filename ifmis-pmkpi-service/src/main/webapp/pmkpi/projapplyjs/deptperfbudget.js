if(!Ext.lt.pmkpi){
	Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.deptperfbudget){
	Ext.lt.pmkpi.deptperfbudget = {};
}
var serviceid;
var _mainguid;
var _saveAgency;
var _menuid;
var _viewtype;
Ext.lt.pmkpi.deptperfbudget = function(config, service){
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
	_mainguid = config.mainguid;
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
		params.mainguid = _mainguid;
		params.modelguid = _modelguid;
		params.bustype = _bustype;
		params.agency = _saveAgency;
		params.viewtype = _viewtype;
		params.querytype = _querytype;
		params.menuid = _menuid;
		Ext.lt.ui.loadingShow();
		Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
			datatable1.setDatas(rs.incomdata);
			datatable2.setDatas(rs.paydata);
			datatable3.setDatas(rs.payprojdata);
			setTimeout(function(){
				 amtTotal(datatable2);
			},100);
			Ext.lt.ui.loadingClose();
		},function(){
			Ext.lt.ui.loadingClose();
			Ext.lt.ui.alert('查询失败！',function(){
			});
		});
	}

	cmp.save = function(){
		if (!datatable1.checkAll()) return false;//先校验
		if (!datatable2.checkAll()) return false;//先校验
		if (!datatable3.checkAll()) return false;//先校验
		var params = {};
		params.incomdata = datatable1.getRecordSet().toArray();
		params.paydata = datatable2.getRecordSet().toArray();
		params.payprojdata = datatable3.getRecordSet().toArray();
		params.busguid = _busguid;
		params.mainguid = _mainguid;
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
			if(col["colcode"] == "financial_com"){
				col.oneditend = function (table, el, l, c, d) {
					if(!checkAmt(d.financial_com)){
						d.financial_com = '';
						d.financial_total = '';
						d.total_amt = '';
						return false;
					}
					d.financial_total =  !isNaN(parseFloat(d.financial_com)+parseFloat(d.financial_gov)+parseFloat(d.financial_spe)) ? parseFloat(d.financial_com)+parseFloat(d.financial_gov)+parseFloat(d.financial_spe) : "";
					d.total_amt = !isNaN(parseFloat(d.financial_total)+parseFloat(d.state_capital)+parseFloat(d.social_secfund)+parseFloat(d.carry_forward)+parseFloat(d.other_amt)) ? parseFloat(d.financial_total)+parseFloat(d.state_capital)+parseFloat(d.social_secfund)+parseFloat(d.carry_forward)+parseFloat(d.other_amt) : "";
				}
			}
			if(col["colcode"] == "financial_gov"){
				col.oneditend = function (table, el, l, c, d) {
					if(!checkAmt(d.financial_gov)){
						d.financial_gov = '';
						d.financial_total = '';
						d.total_amt = '';
						return false;
					}
					d.financial_total =  !isNaN(parseFloat(d.financial_com)+parseFloat(d.financial_gov)+parseFloat(d.financial_spe)) ? parseFloat(d.financial_com)+parseFloat(d.financial_gov)+parseFloat(d.financial_spe) : "";
					d.total_amt = !isNaN(parseFloat(d.financial_total)+parseFloat(d.state_capital)+parseFloat(d.social_secfund)+parseFloat(d.carry_forward)+parseFloat(d.other_amt)) ? parseFloat(d.financial_total)+parseFloat(d.state_capital)+parseFloat(d.social_secfund)+parseFloat(d.carry_forward)+parseFloat(d.other_amt) : "";
				}
			}
			if(col["colcode"] == "financial_spe"){
				col.oneditend = function (table, el, l, c, d) {
					if(!checkAmt(d.financial_spe)){
						d.financial_spe = '';
						d.financial_total = '';
						d.total_amt = '';
						return false;
					}
					d.financial_total =  !isNaN(parseFloat(d.financial_com)+parseFloat(d.financial_gov)+parseFloat(d.financial_spe)) ? parseFloat(d.financial_com)+parseFloat(d.financial_gov)+parseFloat(d.financial_spe) : "";
					d.total_amt = !isNaN(parseFloat(d.financial_total)+parseFloat(d.state_capital)+parseFloat(d.social_secfund)+parseFloat(d.carry_forward)+parseFloat(d.other_amt)) ? parseFloat(d.financial_total)+parseFloat(d.state_capital)+parseFloat(d.social_secfund)+parseFloat(d.carry_forward)+parseFloat(d.other_amt) : "";
				}
			}
			if(col["colcode"] == "state_capital"){
				col.oneditend = function (table, el, l, c, d) {
					if(!checkAmt(d.state_capital)){
						d.state_capital = '';
						d.total_amt = '';
						return false;
					}
					d.total_amt = !isNaN(parseFloat(d.financial_total)+parseFloat(d.state_capital)+parseFloat(d.social_secfund)+parseFloat(d.carry_forward)+parseFloat(d.other_amt)) ? parseFloat(d.financial_total)+parseFloat(d.state_capital)+parseFloat(d.social_secfund)+parseFloat(d.carry_forward)+parseFloat(d.other_amt) : "";
				}
			}
			if(col["colcode"] == "social_secfund"){
				col.oneditend = function (table, el, l, c, d) {
					if(!checkAmt(d.social_secfund)){
						d.social_secfund = '';
						d.total_amt = '';
						return false;
					}
					d.total_amt = !isNaN(parseFloat(d.financial_total)+parseFloat(d.state_capital)+parseFloat(d.social_secfund)+parseFloat(d.carry_forward)+parseFloat(d.other_amt)) ? parseFloat(d.financial_total)+parseFloat(d.state_capital)+parseFloat(d.social_secfund)+parseFloat(d.carry_forward)+parseFloat(d.other_amt) : "";
				}
			}
			if(col["colcode"] == "carry_forward"){
				col.oneditend = function (table, el, l, c, d) {
					if(!checkAmt(d.carry_forward)){
						d.carry_forward = '';
						d.total_amt = '';
						return false;
					}
					d.total_amt = !isNaN(parseFloat(d.financial_total)+parseFloat(d.state_capital)+parseFloat(d.social_secfund)+parseFloat(d.carry_forward)+parseFloat(d.other_amt)) ? parseFloat(d.financial_total)+parseFloat(d.state_capital)+parseFloat(d.social_secfund)+parseFloat(d.carry_forward)+parseFloat(d.other_amt) : "";
				}
			}
			if(col["colcode"] == "other_amt"){
				col.oneditend = function (table, el, l, c, d) {
					if(!checkAmt(d.other_amt)){
						d.other_amt = '';
						d.total_amt = '';
						return false;
					}
					d.total_amt = !isNaN(parseFloat(d.financial_total)+parseFloat(d.state_capital)+parseFloat(d.social_secfund)+parseFloat(d.carry_forward)+parseFloat(d.other_amt)) ? parseFloat(d.financial_total)+parseFloat(d.state_capital)+parseFloat(d.social_secfund)+parseFloat(d.carry_forward)+parseFloat(d.other_amt) : "";
				}
			}
			if(col["colcode"] == "halfyear_exec"){
				col.oneditend = function (table, el, l, c, d) {
					if(!checkAmt(d.halfyear_exec)){
						d.halfyear_exec = '';
						return false;
					}
					amtTotal(table);
				}
			}
			if(col["colcode"] == "annual_budget"){
				col.oneditend = function (table, el, l, c, d) {
					if(!checkAmt(d.annual_budget)){
						d.annual_budget = '';
						return false;
					}
					amtTotal(table);
				}
			}
		}
	});


	return cmp;
}

function checkAmt(amt){
	var re = /^\d*\.{0,2}\d{0,2}$/;
	if(!re.test(amt)){
		Ext.lt.ui.alert("请正确填写资金！",{timeout:1},function(){});
		return false;
	}else{
		return true;
	}
}

function amtTotal(table) {
	if(table.getSumobj()){
		var totalrow = table.getRecordset();
		var sumweight = 0;
		var sumscore = 0;
		var rowarr = totalrow.toArray();
		var len = rowarr.length;
		for ( var i = 0; i < len; i++) {
			var halfyear_exec = rowarr[i]["halfyear_exec"] ? rowarr[i]["halfyear_exec"] : 0;
			sumweight += parseFloat(halfyear_exec);
			var annual_budget = rowarr[i]["annual_budget"] ? rowarr[i]["annual_budget"] : 0;
			sumscore += parseFloat(annual_budget);
		}
		var totalrs = {};
		totalrs["halfyear_exec"] = sumweight == 0 ? "" : getPointNum(sumweight);
		totalrs["annual_budget"] = sumscore == 0 ? "" : getPointNum(sumscore);
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