if(!Ext.lt.pmkpi){
	Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.perfprojaudit){
	Ext.lt.pmkpi.perfprojaudit = {};
}
var serviceid;
var _mainguid;
var _saveAgency;
var _menuid;
var _viewtype;
Ext.lt.pmkpi.perfprojaudit = function(config, service){
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
				// amtTotal(datatable);
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

	Ext.lt.message.hook('datatable','buildLineStyle',function(paramobj){
		var d = paramobj.rowdata;
		var remarks = d.remark.split(",");
		if(remarks.indexOf("option")==-1 && remarks.indexOf("total")==-1){
			paramobj.style = 'style="background-color: #f2f2f2;"';
			paramobj.selfdefcolor = 1;
		}
	});

	Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
		var cols = obj.cols;
		if(!Ext.lt.isArray(cols))
			cols = [cols];
		for(var i=0; i<cols.length; i++){
			var col = cols[i];

			if(col["colcode"]=="audit_info"){
				col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
					var remarks = rs["remark"].split(",");
					if(remarks.indexOf("total")!=-1){
						style ='style="border-right-style:none;text-align:center;position:relative;padding-left:25px;';
					}
					return style;
				}
			}
			if(col["colcode"]=="audit_point"){
				col.fn = function(l,c,data,col){
					var audit_point = data.audit_point;
					var remarks = data.remark.split(",");
					if(remarks.indexOf("total")==-1 && remarks.indexOf("option")==-1){
						return "<span>"+ audit_point.replace(/br/g,"&nbsp&nbsp") +"</span>";
					}else{
						return data.audit_point;
					}
				}

				col.oneditstart = function (table, el, l, c, d) {
					var remarks = d.remark.split(",");
					if(remarks.indexOf("option")==-1){
						return false;
					}
				}

				col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
					var remarks = rs["remark"].split(",");
					if(remarks.indexOf("total")!=-1){
						style ='style="border-left-style:none;text-align:center;position:relative;padding-left:15px;';
					}
					if(remarks.indexOf("option")!=-1){
						style ='style="border-right-style:none;text-align:center;position:relative;padding-left:5px;';
					}
					return style;
				}
			}

			if(col["colcode"]=="option_value1"){
				col.fn = function(l,c,data,col){
					if(_viewtype!="01"){
						var yrs = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio"  disabled="disabled" id="option_value1_y'+data.ordernum+'" name="option_value1_radio'+data.ordernum+'" value="1">是';
						var yrsc = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" disabled="disabled" id="option_value1_y'+data.ordernum+'" checked="checked" name="option_value1_radio'+data.ordernum+'" value="1">是';
						var nrs = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" disabled="disabled" id="option_value1_n'+data.ordernum+'" name="option_value1_radio'+data.ordernum+'" value="0">否';
						var nrsc = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" disabled="disabled" id="option_value1_n'+data.ordernum+'" checked="checked" name="option_value1_radio'+data.ordernum+'" value="0">否';
					}else{
						var yrs = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" id="option_value1_y'+data.ordernum+'" name="option_value1_radio'+data.ordernum+'" value="1">是';
						var yrsc = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" id="option_value1_y'+data.ordernum+'" checked="checked" name="option_value1_radio'+data.ordernum+'" value="1">是';
						var nrs = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" id="option_value1_n'+data.ordernum+'" name="option_value1_radio'+data.ordernum+'" value="0">否';
						var nrsc = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" id="option_value1_n'+data.ordernum+'" checked="checked" name="option_value1_radio'+data.ordernum+'" value="0">否';
					}
					var remarks = data.remark.split(",");
					if(remarks.indexOf("1")!=-1 || remarks.indexOf("total")!=-1){
						if(data.datatable_do_sum==true){
							return "";
						}else if(data.option_value1 == '1'){
							return yrsc + nrs;
						}else if(data.option_value1 == '0'){
							return yrs + nrsc;
						}else{
							return yrs + nrs;
						}
					}else{
						return "";
					}
				}

				col.oneditstart = function (table, el, l, c, d) {
					var remarks = d.remark.split(",");
					if(remarks.indexOf("1")!=-1){
						return false;
					}
				}


				col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
					var remarks = rs["remark"].split(",");
					if(remarks.indexOf("option")!=-1){
						style ='style="border-left-style:none;border-right-style:none;text-align:center;position:relative;padding-left:5px;';
					}
					return style;
				}

				col.onclick = function (table, el, l, c, d) {
					var option_value = $("input[name='option_value1_radio"+d.ordernum+"']:checked").val();
					if(option_value == '1'){
						d.option_value1 = '1';
					}else{
						d.option_value1 = '0';
					}
					var deptpassflag=true;
					var allDatas = datatable.getRecordSet().toArray();
					var sortid = 0;
					if(allDatas!=null && allDatas.length > 0){
						for(var i=0;i<allDatas.length;i++){
							var datas = allDatas[i];
							if(datas.remark == "total"){
								sortid = datas._sortid;
								break;
							}
						}
						for(var i=0;i<allDatas.length;i++){
							var datas = allDatas[i];
							if((datas.option_value1 == "0" || datas.option_value1 == "") && datas.remark != "total" && datas.remark != "option"){
								deptpassflag = false;
								break;
							}
						}
						if(deptpassflag){
							table.getRecordSet().getData(sortid).option_value1="1";
							$("#option_value1_y"+eval(sortid+1)).prop("checked",true);
							$("#option_value1_n"+eval(sortid+1)).prop("checked",false);
						}else{
							table.getRecordSet().getData(sortid).option_value1="0";
							$("#option_value1_n"+eval(sortid+1)).prop("checked",true);
							$("#option_value1_y"+eval(sortid+1)).prop("checked",false);
						}
					}
				}
			}

			if(col["colcode"]=="option_value2"){
				col.fn = function(l,c,data,col){
					if(_viewtype!="02"){
						var yrs = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" disabled="disabled"  id="option_value2_y'+data.ordernum+'" name="option_value2_radio'+data.ordernum+'" value="1">是';
						var yrsc = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" disabled="disabled"  id="option_value2_y'+data.ordernum+'" checked="checked" name="option_value2_radio'+data.ordernum+'" value="1">是';
						var nrs = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" disabled="disabled" id="option_value2_n'+data.ordernum+'" name="option_value2_radio'+data.ordernum+'" value="0">否';
						var nrsc = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" disabled="disabled" id="option_value2_n'+data.ordernum+'" checked="checked" name="option_value2_radio'+data.ordernum+'" value="0">否';

					}else{
						var yrs = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" id="option_value2_y'+data.ordernum+'" name="option_value2_radio'+data.ordernum+'" value="1">是';
						var yrsc = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" id="option_value2_y'+data.ordernum+'" checked="checked" name="option_value2_radio'+data.ordernum+'" value="1">是';
						var nrs = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" id="option_value2_n'+data.ordernum+'" name="option_value2_radio'+data.ordernum+'" value="0">否';
						var nrsc = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" id="option_value2_n'+data.ordernum+'" checked="checked" name="option_value2_radio'+data.ordernum+'" value="0">否';
					}
					var remarks = data.remark.split(",");
					if(remarks.indexOf("2")!=-1 || remarks.indexOf("total")!=-1){
						if(data.datatable_do_sum==true){
							return "";
						}else if(data.option_value2 == '1'){
							return yrsc + nrs;
						}else if(data.option_value2 == '0'){
							return yrs + nrsc;
						}else{
							return yrs + nrs;
						}
					}else{
						return "";
					}
				}

				col.oneditstart = function (table, el, l, c, d) {
					var remarks = d.remark.split(",");
					if(remarks.indexOf("option")!=-1){
						return false;
					}
				}

				col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
					var remarks = rs["remark"].split(",");
					if(remarks.indexOf("total")!=-1 ){
						style ='style="border-right-style:none;text-align:center;position:relative;padding-left:15px;';
					}else if(remarks.indexOf("option")!=-1){
						style ='style="border-left-style:none;border-right-style:none;text-align:center;position:relative;';
					}
					return style;
				}

				col.onclick = function (table, el, l, c, d) {
					var option_value = $("input[name='option_value2_radio"+d.ordernum+"']:checked").val();
					if(option_value == '1'){
						d.option_value2 = '1';
					}else{
						d.option_value2 = '0';
					}

					var perfpassflag=true;
					var allDatas = datatable.getRecordSet().toArray();
					var sortid = 0;
					if(allDatas!=null && allDatas.length > 0){
						for(var i=0;i<allDatas.length;i++){
							var datas = allDatas[i];
							if(datas.remark == "total"){
								sortid = datas._sortid;
								break;
							}
						}
						for(var i=0;i<allDatas.length;i++){
							var datas = allDatas[i];
							if((datas.option_value2 == "0" || datas.option_value2 == "" || datas.option_value3 == "0" || datas.option_value3 == "" ) && datas.remark != "total" && datas.remark != "option"){
								perfpassflag = false;
								break;
							}
						}
						if(perfpassflag){
							table.getRecordSet().getData(sortid).option_value2="1";
							$("#option_value2_y"+eval(sortid+1)).prop("checked",true);
							$("#option_value2_n"+eval(sortid+1)).prop("checked",false);
						}else{
							table.getRecordSet().getData(sortid).option_value2="0";
							$("#option_value2_n"+eval(sortid+1)).prop("checked",true);
							$("#option_value2_y"+eval(sortid+1)).prop("checked",false);
						}
					}
				}
			}

			if(col["colcode"]=="option_value3"){
				col.fn = function(l,c,data,col){
					if(_viewtype!="03"){
						var yrs = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" disabled="disabled" id="option_value3_y'+data.ordernum+'" name="option_value3_radio'+data.ordernum+'" value="1">是';
						var yrsc = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" disabled="disabled" id="option_value3_y'+data.ordernum+'" checked="checked" name="option_value3_radio'+data.ordernum+'" value="1">是';
						var nrs = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" disabled="disabled" id="option_value3_n'+data.ordernum+'" name="option_value3_radio'+data.ordernum+'" value="0">否';
						var nrsc = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" disabled="disabled" id="option_value3_n'+data.ordernum+'" checked="checked" name="option_value3_radio'+data.ordernum+'" value="0">否';

					}else{
						var yrs = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" id="option_value3_y'+data.ordernum+'" name="option_value3_radio'+data.ordernum+'" value="1">是';
						var yrsc = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" id="option_value3_y'+data.ordernum+'" checked="checked" name="option_value3_radio'+data.ordernum+'" value="1">是';
						var nrs = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" id="option_value3_n'+data.ordernum+'" name="option_value3_radio'+data.ordernum+'" value="0">否';
						var nrsc = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" id="option_value3_n'+data.ordernum+'" checked="checked" name="option_value3_radio'+data.ordernum+'" value="0">否';

					}
					var remarks = data.remark.split(",");
					if(remarks.indexOf("3")!=-1){
						if(data.datatable_do_sum==true){
							return "";
						}else if(data.option_value3 == '1'){
							return yrsc + nrs;
						}else if(data.option_value3 == '0'){
							return yrs + nrsc;
						}else{
							return yrs + nrs;
						}
					}else{
						return "";
					}
				}

				col.oneditstart = function (table, el, l, c, d) {
					var remarks = d.remark.split(",");
					if(remarks.indexOf("option")!=-1){
						return false;
					}
				}

				col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
					var remarks = rs["remark"].split(",");
					if(remarks.indexOf("total")!=-1 || remarks.indexOf("option")!=-1){
						style ='style="border-left-style:none;text-align:center;position:relative;padding-left:5px;';
					}
					return style;
				}

				col.onclick = function (table, el, l, c, d) {
					var option_value = $("input[name='option_value3_radio"+d.ordernum+"']:checked").val();
					if(option_value == '1'){
						d.option_value3 = '1';
					}else{
						d.option_value3 = '0';
					}

					var perfpassflag=true;
					var allDatas = datatable.getRecordSet().toArray();
					var sortid = 0;
					if(allDatas!=null && allDatas.length > 0){
						for(var i=0;i<allDatas.length;i++){
							var datas = allDatas[i];
							if(datas.remark == "total"){
								sortid = datas._sortid;
								break;
							}
						}
						for(var i=0;i<allDatas.length;i++){
							var datas = allDatas[i];
							if((datas.option_value2 == "0" || datas.option_value2 == "" || datas.option_value3 == "0" || datas.option_value3 == "" ) && datas.remark != "total" && datas.remark != "option"){
								perfpassflag = false;
								break;
							}
						}
						if(perfpassflag){
							table.getRecordSet().getData(sortid).option_value2="1";
							$("#option_value2_y"+eval(sortid+1)).prop("checked",true);
							$("#option_value2_n"+eval(sortid+1)).prop("checked",false);
						}else{
							table.getRecordSet().getData(sortid).option_value2="0";
							$("#option_value2_n"+eval(sortid+1)).prop("checked",true);
							$("#option_value2_y"+eval(sortid+1)).prop("checked",false);
						}
					}
				}
			}

		}
	});


	return cmp;
}
