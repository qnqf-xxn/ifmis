if(!Ext)
	Ext = {};
if(!Ext.lt)
	Ext.lt = {};
if(!Ext.lt.pmkpi)
	Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.fundCalAdjustIndex)
	Ext.lt.pmkpi.fundCalAdjustIndex = {};
/**
 * 初始化加载.
 */
var _proguid;
var _prolev;
var _saveAgency;
var height;
var width;
var ismergeindex = "1";
var _curtab = ""; //当前页签.
var showtab;
var tabcomps;
var _datatype;
var _mainguid;
var _busguid;
var _bustype;
var _adjustweightTotal = 0;
var _isadjustweight = false;
Ext.lt.pmkpi.fundCalAdjustIndex.index = function(config, serviceid) {
	var deptcmp = Ext.lt.pmkpi.perfcommon(config, serviceid);
	var _procode = config["procode"];
	var _proguid = config["proguid"];
	var _prolev = config["prolev"];
	var _isZJ = config["isZJ"];//标识是否是浙江（1.浙江）
	var isfundcal = config["isfundcal"];
	height = $(window).height()*0.93;
	width = $(window).width()*0.93;
	_curtab = "year";
	showtab = config.showtab; //页签展示
	_datatype = config.datatype;//数据类型
	_mainguid = config.mainguid;//主单guid
	_busguid = config.busguid;//主单guid
    _bustype = config.bustype;
	_saveAgency = config.saveAgency;
	var _cmp = {};
	//页面加载完成后执行
	$(function() {
		deptcmp.initDatatable();
		_cmp.init(true);
	})
	/**
	 * 页面初始化.
	 */
	_cmp.init = function(isquery){
		var params = {};
		params.procode = _procode;
		Ext.lt.ui.loadingShow();
		Ext.lt.RCP.call(serviceid, "findIndex", [params], function(data) {
			datatable.setDatas(data["index"]);
			 setTimeout(function(){
			 	amtTotal(datatable);
			 },100);
			 if (isquery) {
				 setTimeout(function(){
					 parent._isQuery = true;
				 },500);
			 }
			Ext.lt.ui.loadingClose();
		})
	}

	/**
	 * 修改
	 */
	_cmp.mod = function () {
		var data = _cmp.getSeletdata("2");
		if (data.length != 1) {
			Ext.lt.ui.alert("请选择一个三级指标修改！", function () {
			});
			return;
		} else if (data.length == 1 && (!data[0].levelno || data[0].levelno != 3)) {
			Ext.lt.ui.alert("请选择三级指标修改！", function () {
			});
			return;
		} else if (data.length == 1 && data[0].status != 3) {
			Ext.lt.ui.alert("请选择新增状态三级指标修改！", function () {
			});
			return;
		}
		var url = "";
		if (_bustype != null && ("dept" == _bustype || "depttrace" == _bustype)) {
			url = "/pmkpi/adjust/report/deptedit/editindex.page";
		} else if (_bustype != null && ("program" == _bustype || "protrace" == _bustype)) {
			url = "/pmkpi/adjust/report/proedit/editindex.page";
		}
		var params = {};
		params.saveAgency = _saveAgency; //项目单位
		params.findex = data[0].findex;
		params.sindex = data[0].sindex;
		params.modguid = data[0].guid;
		params.type = "mod";
		params.fromtype = "tree";
		url = Ext.lt.pmkpi.genPageUrl(url, params);
		Ext.lt.ui.openModalWindow(url, _scrWidth * 0.8, _scrHeight * 0.8, "修改指标");
	}
    _cmp.save = function () {
        if (!deptcmp.indexCheckAll()) return false;//先校验
        if (_isadjustweight) {
            if (_adjustweightTotal != 100){
                Ext.lt.ui.alert('调整后权重合计为100！',function(){
                });
                return;
            }
        }
        var params = {};
        // params.editinfo = editform.getEditFormValues();
        params.datas = datatable.getRecordSet().toArray();
        params.updatas = datatable.getUpdataData();
        params.deldatas = datatable.getRemoveData();
        params.busguid = _busguid;
        params.proguid = _proguid;
        params.mainguid = _mainguid;
        params.saveAgency = _saveAgency;
        params.bustype = _bustype;
        params.procode = _procode;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid, "save", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
			_cmp.init();
        }
        return rs;
    }

	return _cmp;
}


Ext.lt.message.hook("datatable", 'beforesetcols', function(data){
	if(data.table.config.id ="datatable"){
		var cols = data.cols;
		if(!Ext.lt.isArray(cols))
			cols = [cols];
		for(var i=0; i<cols.length; i++){
			var col = cols[i];
			if(col["colcode"]=="obligate"){
					col.style = " text-align:center;color:#468ac9;cursor:pointer;";
					col.fn = function(l,c,data,col){
						var html = "";
						if(data.fundguid) {
							html += "&nbsp;&nbsp;&nbsp;&nbsp;<a herf='#' title = '选择' style='color:#468ac9;cursor:pointer;' onclick=\"recom('" + data["fundguid"] + "');\">选择</a>"
							//html += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a herf='#' title = '删除' style='color:#468ac9;cursor:pointer' onclick=\"delTableRow('" + data["guid"] + "','" + data["fundguid"] + "');\">删除</a>";
						}
						return html;
					}
			}
			if (col["colcode"] == "obligate1") {
				//if (_viewtype != "query") {
					col.style = " text-align:center;color:#468ac9;cursor:pointer;";

					col.onclick = function (td, el, l, c, d) {
						var levelno = d.levelno;
						if (levelno == "3" && d.status != "1") {
								delTableRow(d.guid,d.fundguid);
						} else if (d.levelno == "3" && d.status == "1") {
							Ext.lt.ui.confirm("确认要撤销删除选中指标？", {icon: "warn"}, function (ret) {
								if (ret) {
									var _sortid = d._sortid;
									d.status = "";
									d.obligate1 = "删除";
									d.adjustindexval = "";
									$.extend(d, d); //合并值集刷新
									datatable.reflash(_sortid);
									if (_isadjustweight) {
										gatherWeight(d.superid);
									}
								}
							})

						}
					};
				//}
			}
			if(col["colcode"] == "xmlx"){
				var xmlx = "";
				var subfindex = "";
				col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
					if(j==2){
						var rs_xmlx = rs["xmlx"] == undefined ? "" : rs["xmlx"];

						var tabledata = datatable.getRecordSet().toArray();
						var statnum = 0;
						if(i==statnum){
							xmlx = Ext.lt.cloneobj(rs_xmlx);
						}
						if(xmlx == rs_xmlx){
							style ='style="border-bottom-style:none;text-align:center;position:relative;padding-top:5px;';
						} else {
							style ='style="border-top-width:1px;text-align:center;border-top-color:#cccccc;border-bottom-style:none;';
						}
						xmlx = Ext.lt.cloneobj(rs_xmlx);
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
					var rs_xmlx = rs["xmlx"] == undefined ? "" : rs["xmlx"];

					if(rs_xmlx){
						subfindex = Ext.lt.cloneobj(rs_xmlx);
						var seq = showMidleName(subfindex,"xmlx",2,i);
						if(i==seq){
							return value;
						}
						return "";
					}
				}
			}
			if(col["colcode"] == "xmlb"){
				var xmlx3 = "";
				var xmlb = "";
				var subfindex = "";
				col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
					if(j==3){
						var rs_xmlx3 = rs["xmlx"] == undefined ? "" : rs["xmlx"];
						var rs_xmlb = rs["xmlb"] == undefined ? "" : rs["xmlb"];

						var tabledata = datatable.getRecordSet().toArray();
						var statnum = 0;
						if(i==statnum){
							xmlb = Ext.lt.cloneobj(rs_xmlb);
						}
						if(xmlx3 == rs_xmlx3 && xmlb == rs_xmlb){
							style ='style="border-bottom-style:none;text-align:center;position:relative;padding-top:5px;';
						} else {
							style ='style="border-top-width:1px;text-align:center;border-top-color:#cccccc;border-bottom-style:none;';
						}
						xmlx3 = Ext.lt.cloneobj(rs_xmlx3);
						xmlb = Ext.lt.cloneobj(rs_xmlb);
						
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
					var rs_xmlb = rs["xmlb"] == undefined ? "" : rs["xmlb"];

					if(rs_xmlb){
						subfindex = Ext.lt.cloneobj(rs_xmlb);
						var seq = showMidleName(subfindex,"xmlb",3,i);//val,code,列,行
						if(i==seq){
							return value;
						}
						return "";
					}
				}
			}
			if(col["colcode"] == "xmmxnr"){
				var xmlx4 = "";
				var xmlb4 = "";
				var xmmxnr = "";
				var subfindex = "";
				col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
					if(j==4){
						var rs_xmlx4 = rs["xmlx"] == undefined ? "" : rs["xmlx"];
						var rs_xmlb4 = rs["xmlb"] == undefined ? "" : rs["xmlb"];
						var rs_xmmxnr = rs["xmmxnr"] == undefined ? "" : rs["xmmxnr"];

						var tabledata = datatable.getRecordSet().toArray();
						var statnum = 0;
						if(i==statnum){
							xmmxnr = Ext.lt.cloneobj(rs_xmmxnr);
							
						}
						if(xmlx4 == rs_xmlx4 && xmlb4 == rs_xmlb4 && xmmxnr == rs_xmmxnr){
							style ='style="border-bottom-style:none;text-align:center;position:relative;padding-top:5px;';
						} else {
							style ='style="border-top-width:1px;text-align:center;border-top-color:#cccccc;border-bottom-style:none;';
						}
						xmmxnr = Ext.lt.cloneobj(rs_xmmxnr);
						xmlx4 = Ext.lt.cloneobj(rs_xmlx4);
						xmlb4 = Ext.lt.cloneobj(rs_xmlb4);
						
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
					var rs_xmmxnr = rs["xmmxnr"] == undefined ? "" : rs["xmmxnr"];

					if(rs_xmmxnr){
						subfindex = Ext.lt.cloneobj(rs_xmmxnr);
						var seq = showMidleName(subfindex,"xmmxnr",4,i);//val,code,列,行
						if(i==seq){
							return value;
						}
						return "";
					}
				}
			}

			if(col["colcode"] == "bzy"){
				var xmlx5 = "";
				var xmlb5 = "";
				var xmmxnr5 = "";
				var bzy = "";
				var subfindex = "";
				col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
					if(j==5){
						var rs_xmlx5 = rs["xmlx"] == undefined ? "" : rs["xmlx"];
						var rs_xmlb5 = rs["xmlb"] == undefined ? "" : rs["xmlb"];
						var rs_xmmxnr5 = rs["xmmxnr"] == undefined ? "" : rs["xmmxnr"];
						var rs_bzy = rs["bzy"] == undefined ? "" : rs["bzy"];
						var tabledata = datatable.getRecordSet().toArray();
						var statnum = 0;
						if(i==statnum){
							bzy = Ext.lt.cloneobj(rs_bzy);
						}
						if(xmlx5 == rs_xmlx5 && xmlb5 == rs_xmlb5 && xmmxnr5 == rs_xmmxnr5 && bzy == rs_bzy){
							style ='style="border-bottom-style:none;text-align:center;position:relative;padding-top:5px;';
						} else {
							style ='style="border-top-width:1px;text-align:center;border-top-color:#cccccc;border-bottom-style:none;';
						}
						bzy = Ext.lt.cloneobj(rs_bzy);
						xmmxnr5 = Ext.lt.cloneobj(rs_xmmxnr5);
						xmlx5 = Ext.lt.cloneobj(rs_xmlx5);
						xmlb5 = Ext.lt.cloneobj(rs_xmlb5);
						
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
					var rs_bzy = rs["bzy"] == undefined ? "" : rs["bzy"];

					if(rs_bzy){
						subfindex = Ext.lt.cloneobj(rs_bzy);
						var seq = showMidleName(subfindex,"bzy",5,i);//val,code,列,行
						if(i==seq){
							return value;
						}
						return "";
					}
				}
			}
			
			if(col["colcode"] == "bzjs"){
				var xmlx6 = "";
				var xmlb6 = "";
				var xmmxnr6 = "";
				var bzy6 = "";
				var bzjs = "";
				var subfindex = "";
				col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
					if(j==6){
						var rs_xmlx6 = rs["xmlx"] == undefined ? "" : rs["xmlx"];
						var rs_xmlb6 = rs["xmlb"] == undefined ? "" : rs["xmlb"];
						var rs_xmmxnr6 = rs["xmmxnr"] == undefined ? "" : rs["xmmxnr"];
						var rs_bzy6 = rs["bzy"] == undefined ? "" : rs["bzy"];
						var rs_bzjs = rs["bzjs"] == undefined ? "" : rs["bzjs"];
						
						var tabledata = datatable.getRecordSet().toArray();
						var statnum = 0;
						if(i==statnum){
							bzjs = Ext.lt.cloneobj(rs_bzjs);
						}
						if(xmlx6 == rs_xmlx6 && xmlb6 == rs_xmlb6 && xmmxnr6 == rs_xmmxnr6 && bzy6 == rs_bzy6 && bzjs == rs_bzjs){
							style ='style="border-bottom-style:none;text-align:center;position:relative;padding-top:5px;';
						} else {
							style ='style="border-top-width:1px;text-align:center;border-top-color:#cccccc;border-bottom-style:none;';
						}
						bzjs = Ext.lt.cloneobj(rs_bzjs);
						xmmxnr6 = Ext.lt.cloneobj(rs_xmmxnr6);
						xmlx6 = Ext.lt.cloneobj(rs_xmlx6);
						xmlb6 = Ext.lt.cloneobj(rs_xmlb6);
						bzy6 = Ext.lt.cloneobj(rs_bzy6);
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
					var rs_bzjs = rs["bzjs"] == undefined ? "" : rs["bzjs"];

					if(rs_bzjs){
						subfindex = Ext.lt.cloneobj(rs_bzjs);
						var seq = showMidleName(subfindex,"bzjs",6,i);
						if(i==seq){
							return value;
						}
						return "";
					}
				}
			}
			
			if(col["colcode"] == "jldw1"){
				var xmlx7 = "";
				var xmlb7 = "";
				var xmmxnr7 = "";
				var bzy7 = "";
				var bzjs7 = "";
				var jldw1 = "";
				var subfindex = "";
				col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
					if(j==7){
						var rs_xmlx7 = rs["xmlx"] == undefined ? "" : rs["xmlx"];
						var rs_xmlb7 = rs["xmlb"] == undefined ? "" : rs["xmlb"];
						var rs_xmmxnr7 = rs["xmmxnr"] == undefined ? "" : rs["xmmxnr"];
						var rs_bzy7 = rs["bzy"] == undefined ? "" : rs["bzy"];
						var rs_bzjs7 = rs["bzjs"] == undefined ? "" : rs["bzjs"];
						var rs_jldw1 = rs["jldw1"] == undefined ? "" : rs["jldw1"];
						
						var tabledata = datatable.getRecordSet().toArray();
						var statnum = 0;
						if(i==statnum){
							jldw1 = Ext.lt.cloneobj(rs_jldw1);
						}
						if(xmlx7 == rs_xmlx7 && xmlb7 == rs_xmlb7 && xmmxnr7 == rs_xmmxnr7 && bzy7 == rs_bzy7 && bzjs7 == rs_bzjs7 && jldw1 == rs_jldw1){
							style ='style="border-bottom-style:none;text-align:center;position:relative;padding-top:5px;';
						} else {
							style ='style="border-top-width:1px;text-align:center;border-top-color:#cccccc;border-bottom-style:none;';
						}
						jldw1 = Ext.lt.cloneobj(rs_jldw1);
						xmmxnr7 = Ext.lt.cloneobj(rs_xmmxnr7);
						xmlx7 = Ext.lt.cloneobj(rs_xmlx7);
						xmlb7 = Ext.lt.cloneobj(rs_xmlb7);
						bzy7 = Ext.lt.cloneobj(rs_bzy7);
						bzjs7 = Ext.lt.cloneobj(rs_bzjs7);
						
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
					var rs_jldw1 = rs["jldw1"] == undefined ? "" : rs["jldw1"];

					if(rs_jldw1){
						subfindex = Ext.lt.cloneobj(rs_jldw1);
						var seq = showMidleName(subfindex,"jldw1",7,i);
						if(i==seq){
							return value;
						}
						return "";
					}
				}
			}
			
			if(col["colcode"] == "sl1"){
				var xmlx8 = "";
				var xmlb8 = "";
				var xmmxnr8 = "";
				var bzy8 = "";
				var bzjs8 = "";
				var jldw18 = "";
				var sl1 = "";
				var subfindex = "";
				col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
					if(j==8){
						var rs_xmlx8 = rs["xmlx"] == undefined ? "" : rs["xmlx"];
						var rs_xmlb8 = rs["xmlb"] == undefined ? "" : rs["xmlb"];
						var rs_xmmxnr8 = rs["xmmxnr"] == undefined ? "" : rs["xmmxnr"];
						var rs_bzy8 = rs["bzy"] == undefined ? "" : rs["bzy"];
						var rs_bzjs8 = rs["bzjs"] == undefined ? "" : rs["bzjs"];
						var rs_jldw18 = rs["jldw1"] == undefined ? "" : rs["jldw1"];
						var rs_sl1 = rs["sl1"] == undefined ? "" : rs["sl1"];
						var tabledata = datatable.getRecordSet().toArray();
						var statnum = 0;
						if(i==statnum){
							sl1 = Ext.lt.cloneobj(rs_sl1);
						}
						if(xmlx8 == rs_xmlx8 && xmlb8 == rs_xmlb8 && xmmxnr8 == rs_xmmxnr8 && bzy8 == rs_bzy8 && bzjs8 == rs_bzjs8 && jldw18 == rs_jldw18 && sl1 == rs_sl1){
							style ='style="border-bottom-style:none;text-align:center;position:relative;padding-top:5px;';
						} else {
							style ='style="border-top-width:1px;text-align:center;border-top-color:#cccccc;border-bottom-style:none;';
						}
						sl1 = Ext.lt.cloneobj(rs_sl1);
						xmmxnr8 = Ext.lt.cloneobj(rs_xmmxnr8);
						xmlx8 = Ext.lt.cloneobj(rs_xmlx8);
						xmlb8 = Ext.lt.cloneobj(rs_xmlb8);
						bzy8 = Ext.lt.cloneobj(rs_bzy8);
						bzjs8 = Ext.lt.cloneobj(rs_bzjs8);
						jldw18 = Ext.lt.cloneobj(rs_jldw18);
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
					var rs_sl1 = rs["sl1"] == undefined ? "" : rs["sl1"];

					if(rs_sl1){
						subfindex = Ext.lt.cloneobj(rs_sl1);
						var seq = showMidleName(subfindex,"sl1",8,i);
						if(i==seq){
							return value;
						}
						return "";
					}
				}
			}
			
			if(col["colcode"] == "jldw2"){
				var xmlx9 = "";
				var xmlb9 = "";
				var xmmxnr9 = "";
				var bzy9 = "";
				var bzjs9 = "";
				var jldw19 = "";
				var sl19 = "";
				var jldw2 = "";
				var subfindex = "";
				col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
					if(j==9){
						var rs_xmlx9 = rs["xmlx"] == undefined ? "" : rs["xmlx"];
						var rs_xmlb9 = rs["xmlb"] == undefined ? "" : rs["xmlb"];
						var rs_xmmxnr9 = rs["xmmxnr"] == undefined ? "" : rs["xmmxnr"];
						var rs_bzy9 = rs["bzy"] == undefined ? "" : rs["bzy"];
						var rs_bzjs9 = rs["bzjs"] == undefined ? "" : rs["bzjs"];
						var rs_jldw19 = rs["jldw1"] == undefined ? "" : rs["jldw1"];
						var rs_sl19 = rs["sl1"] == undefined ? "" : rs["sl1"];
						var rs_jldw2 = rs["jldw2"] == undefined ? "" : rs["jldw2"];
						var tabledata = datatable.getRecordSet().toArray();
						var statnum = 0;
						if(i==statnum){
							jldw2 = Ext.lt.cloneobj(rs_jldw2);
						}
						if(xmlx9 == rs_xmlx9 && xmlb9 == rs_xmlb9 && xmmxnr9 == rs_xmmxnr9 && bzy9 == rs_bzy9 && bzjs9 == rs_bzjs9 && jldw19 == rs_jldw19 && sl19 == rs_sl19 && jldw2 == rs_jldw2){
							style ='style="border-bottom-style:none;text-align:center;position:relative;padding-top:5px;';
						} else {
							style ='style="border-top-width:1px;text-align:center;border-top-color:#cccccc;border-bottom-style:none;';
						}
						jldw2 = Ext.lt.cloneobj(rs_jldw2);
						xmmxnr9 = Ext.lt.cloneobj(rs_xmmxnr9);
						xmlx9 = Ext.lt.cloneobj(rs_xmlx9);
						xmlb9 = Ext.lt.cloneobj(rs_xmlb9);
						bzy9 = Ext.lt.cloneobj(rs_bzy9);
						bzjs9 = Ext.lt.cloneobj(rs_bzjs9);
						jldw19 = Ext.lt.cloneobj(rs_jldw19);
						sl19 = Ext.lt.cloneobj(rs_sl19);
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
					var rs_jldw2 = rs["jldw2"] == undefined ? "" : rs["jldw2"];

					if(rs_jldw2){
						subfindex = Ext.lt.cloneobj(rs_jldw2);
						var seq = showMidleName(subfindex,"jldw2",9,i);
						if(i==seq){
							return value;
						}
						return "";
					}
				}
			}
			
			if(col["colcode"] == "sl2"){
				var xmlx10 = "";
				var xmlb10 = "";
				var xmmxnr10 = "";
				var bzy10 = "";
				var bzjs10 = "";
				var jldw110 = "";
				var sl110 = "";
				var jldw210 = "";
				var sl2 = "";
				var subfindex = "";
				col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
					if(j==10){
						var rs_xmlx10 = rs["xmlx"] == undefined ? "" : rs["xmlx"];
						var rs_xmlb10 = rs["xmlb"] == undefined ? "" : rs["xmlb"];
						var rs_xmmxnr10 = rs["xmmxnr"] == undefined ? "" : rs["xmmxnr"];
						var rs_bzy10 = rs["bzy"] == undefined ? "" : rs["bzy"];
						var rs_bzjs10 = rs["bzjs"] == undefined ? "" : rs["bzjs"];
						var rs_jldw110 = rs["jldw1"] == undefined ? "" : rs["jldw1"];
						var rs_sl110 = rs["sl1"] == undefined ? "" : rs["sl1"];
						var rs_jldw210 = rs["jldw2"] == undefined ? "" : rs["jldw2"];
						var rs_sl2 = rs["sl2"] == undefined ? "" : rs["sl2"];
						var tabledata = datatable.getRecordSet().toArray();
						var statnum = 0;
						if(i==statnum){
							sl2 = Ext.lt.cloneobj(rs_sl2);

						}
						if(xmlx10 == rs_xmlx10 && xmlb10 == rs_xmlb10 && xmmxnr10 == rs_xmmxnr10 && bzy10 == rs_bzy10 && bzjs10 == rs_bzjs10 && jldw110 == rs_jldw110 && sl110 == rs_sl110 && jldw210 == rs_jldw210 && sl2 == rs_sl2){
							style ='style="border-bottom-style:none;text-align:center;position:relative;padding-top:5px;';
						} else {
							style ='style="border-top-width:1px;text-align:center;border-top-color:#cccccc;border-bottom-style:none;';
						}
						sl2 = Ext.lt.cloneobj(rs_sl2);
						xmmxnr10 = Ext.lt.cloneobj(rs_xmmxnr10);
						xmlx10 = Ext.lt.cloneobj(rs_xmlx10);
						xmlb10 = Ext.lt.cloneobj(rs_xmlb10);
						bzy10 = Ext.lt.cloneobj(rs_bzy10);
						bzjs10 = Ext.lt.cloneobj(rs_bzjs10);
						jldw110 = Ext.lt.cloneobj(rs_jldw110);
						sl110 = Ext.lt.cloneobj(rs_sl110);
						jldw210 = Ext.lt.cloneobj(rs_jldw210);
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
					var rs_sl2 = rs["sl2"] == undefined ? "" : rs["sl2"];

					if(rs_sl2){
						subfindex = Ext.lt.cloneobj(rs_sl2);
						var seq = showMidleName(subfindex,"sl2",10,i);
						if(i==seq){
							return value;
						}
						return "";
					}
				}
			}
			
			if(col["colcode"] == "zjlywy"){
				var xmlx11 = "";
				var xmlb11 = "";
				var xmmxnr11 = "";
				var bzy11 = "";
				var bzjs11 = "";
				var jldw111 = "";
				var sl111 = "";
				var jldw211 = "";
				var sl211 = "";
				var zjlywy = "";
				var subfindex = "";
				col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
					if(j==11){
						var rs_xmlx11 = rs["xmlx"] == undefined ? "" : rs["xmlx"];
						var rs_xmlb11 = rs["xmlb"] == undefined ? "" : rs["xmlb"];
						var rs_xmmxnr11 = rs["xmmxnr"] == undefined ? "" : rs["xmmxnr"];
						var rs_bzy11 = rs["bzy"] == undefined ? "" : rs["bzy"];
						var rs_bzjs11 = rs["bzjs"] == undefined ? "" : rs["bzjs"];
						var rs_jldw111 = rs["jldw1"] == undefined ? "" : rs["jldw1"];
						var rs_sl111 = rs["sl1"] == undefined ? "" : rs["sl1"];
						var rs_jldw211 = rs["jldw2"] == undefined ? "" : rs["jldw2"];
						var rs_sl211 = rs["sl2"] == undefined ? "" : rs["sl2"];
						var rs_zjlywy = rs["zjlywy"] == undefined ? "" : rs["zjlywy"];
						var tabledata = datatable.getRecordSet().toArray();
						var statnum = 0;
						if(i==statnum){
							zjlywy = Ext.lt.cloneobj(rs_zjlywy);
						}
						if(xmlx11 == rs_xmlx11 && xmlb11 == rs_xmlb11 && xmmxnr11 == rs_xmmxnr11 && bzy11 == rs_bzy11 && bzjs11 == rs_bzjs11 && jldw111 == rs_jldw111 && sl111 == rs_sl111 && jldw211 == rs_jldw211 && sl211 == rs_sl211 && zjlywy == rs_zjlywy){
							style ='style="border-bottom-style:none;text-align:center;position:relative;padding-top:5px;';
						} else {
							style ='style="border-top-width:1px;text-align:center;border-top-color:#cccccc;border-bottom-style:none;';
						}
						zjlywy = Ext.lt.cloneobj(rs_zjlywy);
						xmmxnr11 = Ext.lt.cloneobj(rs_xmmxnr11);
						xmlx11 = Ext.lt.cloneobj(rs_xmlx11);
						xmlb11 = Ext.lt.cloneobj(rs_xmlb11);
						bzy11 = Ext.lt.cloneobj(rs_bzy11);
						bzjs11 = Ext.lt.cloneobj(rs_bzjs11);
						jldw111 = Ext.lt.cloneobj(rs_jldw111);
						sl111 = Ext.lt.cloneobj(rs_sl111);
						jldw211 = Ext.lt.cloneobj(rs_jldw211);
						sl211 = Ext.lt.cloneobj(rs_sl211);
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
					var rs_zjlywy = rs["zjlywy"] == undefined ? "" : rs["zjlywy"];

					if(rs_zjlywy){
						subfindex = Ext.lt.cloneobj(rs_zjlywy);
						var seq = showMidleName(subfindex,"zjlywy",11,i);
						if(i==seq){
							return value;
						}
						return "";
					}
				}
			}

			if(col["colcode"]=="indexval"){
				//处理指标值，计量单位合并显示
				col.fn = function(l,c,data,col){
					if(data.computesign == "6"){
						var indexvalue = !data.indexval? "" : data.indexval;
						return "<font style=\"margin-left:10px;\">" + indexvalue+"</font>";
					} else {
						var computesignstr ="";
						var computesign_source = [{guid:"1",code:"1",name:"≥"},{guid:"2",code:"2",name:">"},{guid:"3",code:"3",name:"="},{guid:"4",code:"4",name:"<"},{guid:"5",code:"5",name:"≤"},{guid:"6",code:"6",name:"定性"}]
						for(var i =0; i<computesign_source.size() ; i++){
							if(data.computesign == computesign_source[i].guid){
								computesignstr = computesign_source[i].name;
							}
						}
						var unit = "";
						if(data.meterunit){
							unit = data.meterunit;
						}
						var returnstr ;
						if(ismergeindex == "1"){//1:单位值符号在一起显示
							returnstr = !data.indexval ? computesignstr + unit :computesignstr + data.indexval + unit;
						}else{
							returnstr = data.indexval==undefined?"":data.indexval;
						}
						return "<font style=\"margin-left:10px;\">"+returnstr+"</font>";
					}
				}
				col.oneditstart = function (table, el, l, c, d) {
					if(!d["name"]){
						return false;
					}
					el.innerText =  d.indexval!=undefined ? d.indexval : '';
					table.getCol(c).mapping = null;
					table.nowtype="input";
					table.getCol(c).format = "";
					// return;
				}
				col.oneditend = function (table, el, l, c, d) {
					if(d.computesign && d.computesign != '6'){
						if(!checkReferencepole(d.indexval)){
							d.indexval = '';
							return false;
						}
					}
				}

			}
			if(col["colcode"]=="weight"){
				col.oneditend = function (table, el, l, c, d) {
					amtTotal(datatable);
				}
			}
			if(col["colcode"]=="adjustweight"){
				_isadjustweight = col.display;
				col.oneditend = function (table, el, l, c, d) {
					amtTotal(datatable);
				}
			}
			if(col["colcode"]=="computesign"){
				col.oneditstart = function (table, el, l, c, d) {
					if(!d["name"]){
						return false;
					}
				}
				col.oneditend = function (table, el, l, c, d) {
					if(d.computesign && d.computesign == '6'){
						d["meterunit"] = "";
						var re = /^\d*\.{0,1}\d{0,2}$/;
						if(!re.test(d["indexval"])){
							d["indexval"] = "";
						}
						table.reflash(d["_sortid"]);
					}
				}
			}
			if(col["colcode"]=="meterunit"){ //单位
				col.oneditstart = function (table, el, l, c, d) {
					if(!d["name"]){
						return false;
					}
					if(!d["computesign"] || d["computesign"] == "6"){
						return false;
					}
				}
			}

		}
	}
});

showMidleName = function(val,col,num1,num2){
	var tabledata = datatable.getRecordSet().toArray();
	var a = -1,b=-1;
	var atemp = {};
	var data = tabledata[num2];
	for ( var i = 0; i < tabledata.length; i++) {
		atemp = tabledata[i];
		if(num1 == 2){
			if(data[col] == atemp[col]){
				a = atemp["_sortid"]; //首次出现值
				break;
			}
		}
		if(num1 == 3){
			if(data[col] == atemp[col] && data["xmlx"] == atemp["xmlx"]){
				a = atemp["_sortid"]; //首次出现值
				break;
			}
		}
		if(num1 == 4){
			if(data[col] == atemp[col] && data["xmlx"] == atemp["xmlx"] && data["xmlb"] == atemp["xmlb"]){
				a = atemp["_sortid"]; //首次出现值
				break;
			}
		}
		if(num1 == 5){
			if(data[col] == atemp[col] && data["xmlx"] == atemp["xmlx"] && data["xmlb"] == atemp["xmlb"] && data["xmmxnr"] == atemp["xmmxnr"]){
				a = atemp["_sortid"]; //首次出现值
				break;
			}
		}
		if(num1 == 6){
			if(data[col] == atemp[col] && data["xmlx"] == atemp["xmlx"] && data["xmlb"] == atemp["xmlb"] && data["xmmxnr"] == atemp["xmmxnr"] && data["bzy"] == atemp["bzy"]){
				a = atemp["_sortid"]; //首次出现值
				break;
			}
		}
		if(num1 == 7){
			if(data[col] == atemp[col] && data["xmlx"] == atemp["xmlx"] && data["xmlb"] == atemp["xmlb"] && data["xmmxnr"] == atemp["xmmxnr"] && data["bzy"] == atemp["bzy"] && data["bzjs"] == atemp["bzjs"]){
				a = atemp["_sortid"]; //首次出现值
				break;
			}
		}
		if(num1 == 8){
			if(data[col] == atemp[col] && data["xmlx"] == atemp["xmlx"] && data["xmlb"] == atemp["xmlb"] && data["xmmxnr"] == atemp["xmmxnr"] && data["bzy"] == atemp["bzy"] && data["bzjs"] == atemp["bzjs"] && data["jldw1"] == atemp["jldw1"]){
				a = atemp["_sortid"]; //首次出现值
				break;
			}
		}
		if(num1 == 9){
			if(data[col] == atemp[col] && data["xmlx"] == atemp["xmlx"] && data["xmlb"] == atemp["xmlb"] && data["xmmxnr"] == atemp["xmmxnr"] && data["bzy"] == atemp["bzy"] && data["bzjs"] == atemp["bzjs"] && data["jldw1"] == atemp["jldw1"] && data["sl1"] == atemp["sl1"]){
				a = atemp["_sortid"]; //首次出现值
				break;
			}
		}
		if(num1 == 10){
			if(data[col] == atemp[col] && data["xmlx"] == atemp["xmlx"] && data["xmlb"] == atemp["xmlb"] && data["xmmxnr"] == atemp["xmmxnr"] && data["bzy"] == atemp["bzy"] && data["bzjs"] == atemp["bzjs"] && data["jldw1"] == atemp["jldw1"] && data["sl1"] == atemp["sl1"] && data["jldw2"] == atemp["jldw2"]){
				a = atemp["_sortid"]; //首次出现值
				break;
			}
		}		
		if(num1 == 11){
			if(data[col] == atemp[col] && data["xmlx"] == atemp["xmlx"] && data["xmlb"] == atemp["xmlb"] && data["xmmxnr"] == atemp["xmmxnr"] && data["bzy"] == atemp["bzy"] && data["bzjs"] == atemp["bzjs"] && data["jldw1"] == atemp["jldw1"] && data["sl1"] == atemp["sl1"] && data["jldw2"] == atemp["jldw2"] && data["sl2"] == atemp["sl2"]){
				a = atemp["_sortid"]; //首次出现值
				break;
			}
		}
	}
	var btemp = {};
	for ( var i = tabledata.length-1; i >-1; i--) {
		btemp = tabledata[i];	
		if(num1 == 2){
			if(data[col] == btemp[col]){
				b = btemp["_sortid"]; //结束出现值
				break;
			}
		}
		if(num1 == 3){
			if(data[col] == btemp[col] && data["xmlx"] == btemp["xmlx"]){
				b = btemp["_sortid"]; //结束出现值
				break;
			}
		}
		if(num1 == 4){
			if(data[col] == btemp[col] && data["xmlx"] == btemp["xmlx"] && data["xmlb"] == btemp["xmlb"]){
				b = btemp["_sortid"]; //结束出现值
				break;
			}
		}
		if(num1 == 5){
			if(data[col] == btemp[col] && data["xmlx"] == btemp["xmlx"] && data["xmlb"] == btemp["xmlb"] && data["xmmxnr"] == btemp["xmmxnr"]){
				b = btemp["_sortid"]; //结束出现值
				break;
			}
		}
		if(num1 == 6){
			if(data[col] == btemp[col] && data["xmlx"] == btemp["xmlx"] && data["xmlb"] == btemp["xmlb"] && data["xmmxnr"] == btemp["xmmxnr"] && data["bzy"] == btemp["bzy"]){
				b = btemp["_sortid"]; //结束出现值
				break;
			}
		}
		if(num1 == 7){
			if(data[col] == btemp[col] && data["xmlx"] == btemp["xmlx"] && data["xmlb"] == btemp["xmlb"] && data["xmmxnr"] == btemp["xmmxnr"] && data["bzy"] == btemp["bzy"] && data["bzjs"] == btemp["bzjs"]){
				b = btemp["_sortid"]; //结束出现值
				break;
			}
		}
		if(num1 == 8){
			if(data[col] == btemp[col] && data["xmlx"] == btemp["xmlx"] && data["xmlb"] == btemp["xmlb"] && data["xmmxnr"] == btemp["xmmxnr"] && data["bzy"] == btemp["bzy"] && data["bzjs"] == btemp["bzjs"] && data["jldw1"] == btemp["jldw1"]){
				b = btemp["_sortid"]; //结束出现值
				break;
			}
		}
		if(num1 == 9){
			if(data[col] == btemp[col] && data["xmlx"] == btemp["xmlx"] && data["xmlb"] == btemp["xmlb"] && data["xmmxnr"] == btemp["xmmxnr"] && data["bzy"] == btemp["bzy"] && data["bzjs"] == btemp["bzjs"] && data["jldw1"] == btemp["jldw1"] && data["sl1"] == btemp["sl1"]){
				b = btemp["_sortid"]; //结束出现值
				break;
			}
		}
		if(num1 == 10){
			if(data[col] == btemp[col] && data["xmlx"] == btemp["xmlx"] && data["xmlb"] == btemp["xmlb"] && data["xmmxnr"] == btemp["xmmxnr"] && data["bzy"] == btemp["bzy"] && data["bzjs"] == btemp["bzjs"] && data["jldw1"] == btemp["jldw1"] && data["sl1"] == btemp["sl1"] && data["jldw2"] == btemp["jldw2"]){
				b = btemp["_sortid"]; //结束出现值
				break;
			}
		}		
		if(num1 == 11){
			if(data[col] == btemp[col] && data["xmlx"] == btemp["xmlx"] && data["xmlb"] == btemp["xmlb"] && data["xmmxnr"] == btemp["xmmxnr"] && data["bzy"] == btemp["bzy"] && data["bzjs"] == btemp["bzjs"] && data["jldw1"] == btemp["jldw1"] && data["sl1"] == btemp["sl1"] && data["jldw2"] == btemp["jldw2"] && data["sl2"] == btemp["sl2"]){
				b = btemp["_sortid"]; //结束出现值
				break;
			}
		}
	}
	return parseInt((b-a)/2)+a;
}

function delTableRow(guid,fundguid){
	if(guid != "undefined"){
		Ext.lt.ui.confirm("确认要删除选中指标？",{icon:"warn"},function(ret){
			if(ret){
				getdataSource();
				var delrows = datatable.getRecordset().query({guid:guid});
				if (delrows && delrows.length>0) {
					var delobj = delrows[0];
					var _sortid = delobj._sortid;
					var fundrow = datatable.getRecordset().query({fundguid:fundguid});
					if (delobj.levelno == 3) {
						if (delobj.status == 3) {
							if(fundrow && fundrow.length == 1){
								var formobj = {};
								formobj["fundguid"] =fundguid;
								formobj["xmlx"] = delobj["xmlx"];
								formobj["xmlb"] = delobj["xmlb"];
								//formobj["xmmxnr"] = delobj["xmmxnr"];
								formobj["bzy"] = delobj["bzy"];
								formobj["bzjs"] = delobj["bzjs"];
								formobj["jldw1"] = delobj["jldw1"];
								formobj["sl1"] = delobj["sl1"];
								formobj["jldw2"] = delobj["jldw2"];
								formobj["sl2"] = delobj["sl2"];
								formobj["zjlywy"] = delobj["zjlywy"];
								formobj["procode"] = delobj["procode"];
								datatable.getRecordSet().addData(formobj,_sortid);
							}
							datatable.getRecordset().delRow(_sortid);
						} else {
							var _sortid = delobj._sortid;
							delobj.status = 1;
							delobj.obligate1 = "撤销删除";
							$.extend(delobj, delobj); //合并值集刷新
							datatable.reflash(_sortid);
						}
						if (_isadjustweight) {
							gatherWeight(delobj.superid);
						}
					}
				}
			}
		})
	} else {
		Ext.lt.ui.alert("该项目资金无对应指标！",function(){});
		return;
	}

}


function amtTotal(table) {
    if (table.getSumobj()) {
        var totalrow = table.getRecordset();
        var sumamt = 0.00;
        var adjsumamt = 0.00;
        var rowarr = totalrow.toArray();
        var len = rowarr.length;
        for (var i = 0; i < len; i++) {
            if (rowarr[i].isleaf == "1" && rowarr[i].levelno == "3" && rowarr[i].status !="1") {
                var adjustweight = rowarr[i]["adjustweight"] ? rowarr[i]["adjustweight"] : 0.00;
                adjsumamt += parseFloat(adjustweight);
                var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0.00;
                sumamt += parseFloat(weight);
            } else if (rowarr[i].isleaf == "1" && rowarr[i].levelno == "3") {
                var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0.00;
                sumamt += parseFloat(weight);
            } else if (rowarr[i].isleaf == undefined && rowarr[i].levelno == undefined) {
                var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0.00;
                var adjustweight = rowarr[i]["adjustweight"] ? rowarr[i]["adjustweight"] : 0.00;
                sumamt += parseFloat(weight);
                adjsumamt += parseFloat(adjustweight);
            }
        }
        var totalrs = {};
        totalrs["weight"] = sumamt == 0 ? "" : sumamt.toFixed(2);
        totalrs["adjustweight"] = adjsumamt == 0 ? "" : adjsumamt.toFixed(2);
        totalrs.datatable_do_sum = true;
        _adjustweightTotal = totalrs["adjustweight"];
        table.getClockRowSet().setData(totalrs, 0);
        if ((totalrow.size && totalrow.size() > 0) || (totalrow.length && totalrow.length > 0)) {
            table.reflashdata();
        }
    }
}
function gatherWeight(superid) {
    var datas = datatable.getRecordSet().toArray();
    if (superid) {
        if (datas != null && datas.length > 0) {
            var supguid = '';
            var result = 0.00;
            var ajdresult = 0.00;
            var guid = '';
            for (var i = 0; i < datas.length; i++) {
                var selectDatas = datas[i];
                if (superid == selectDatas.guid) {
                    supguid = selectDatas.superid;
                    guid = selectDatas.guid;
                }
                if (selectDatas.superid == superid && selectDatas.adjustweight && !isNaN(selectDatas.adjustweight) && selectDatas.status !="1") {
                    if (selectDatas.weight) {
                        result += parseFloat(selectDatas.weight);
                    }
                    ajdresult += parseFloat(selectDatas.adjustweight);
                } else if (selectDatas.superid == superid && selectDatas.weight && !isNaN(selectDatas.weight)) {
                    result += parseFloat(selectDatas.weight);
                }
            }
            datas.each(function (data, i) {
                if (data.guid == guid) {
                    datas[i]['weight'] = result == 0.00 ? "" : result.toFixed(2);
                    datas[i]['adjustweight'] = ajdresult == 0.00 ? "" : ajdresult.toFixed(2);
                }
            });
            gatherWeight(supguid);
            amtTotal(datatable);
        }
    }
    datatable.reflash();
}




/**
 * 精准推荐方法.
 */
function recom (fundguid){
	var url = '/pmkpi/program/prjindex/recomindex.page';
	var params = {};
	params.fundguid = fundguid;
	params.proguid = _proguid;
	params.saveAgency = _saveAgency; //项目单位
	params.prolev = _prolev;//项目级别 123
	params.fromtype = "tree";
	params.showtab = '3';
	url = Ext.lt.pmkpi.genPageUrl(url, params);
	indexwindow = Ext.lt.ui.openModalWindow(url,width,height,"指标推荐");
}

function getdataSource() {
    var datatype_source = [];
    for (var i = 0; i < _datatype.length; i++) {
        var temparr = [];
        temparr.push(_datatype[i]["guid"]);
        temparr.push(_datatype[i]["code"]);
        temparr.push(_datatype[i]["name"]);
        datatype_source.push(temparr);
    }
    datatable.addMapperDatas("status", datatype_source);
}