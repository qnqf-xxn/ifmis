if(!Ext)
	Ext = {};
if(!Ext.lt)
	Ext.lt = {};
if(!Ext.lt.pmkpi)
	Ext.lt.pmkpi = {};
/**
 * 初始化加载.
 */
var _proguid;
var _prolev;
var _saveAgency;
var height;
var width;
var ismergeindex = "1";

Ext.lt.pmkpi.prjindexservice = function(config, serviceid) {
	var deptcmp = Ext.lt.pmkpi.perfcommon(config, serviceid);
	var _proguid = config["proguid"];
	var _viewtype = config["viewtype"]; //修改还是查看
	_saveAgency = config["saveAgency"]; //项目单位
	ismergeindex = config["ismergeindex"];//指标值是否合并单位符号
	isZJ = config["isZJ"];//标识是否是浙江（1.浙江）
	if(_saveAgency == "" || _saveAgency == null){//嵌套页面获取父及页面的单位
		if(parent.editform){
			if(parent.editform.getCol("agencyguid")){
				_saveAgency = parent.editform.getCol("agencyguid").getvalue();
			}
		}
	}
	var _busguid = config.busguid;//审核定义guid
	_prolev = config["prolev"]; //项目等级123级项目
	var _cmp = {};
	var tabcomps = {};
	var iframeurl = config.iframeurl;//嵌套url
	//是否显示编辑区，1不显示、2显示
	var isshowedit = config.isshowedit;
	var editinfo = config.editinfo;
	var hideIframeHtml = "";
	height = $(window).height()*0.8;
	width = $(window).width()*0.8;
	if (iframeurl && iframeurl != "") {
		var url = document.location.protocol+"//"+ document.location.host +"/"+ iframeurl;
		url = Ext.lt.pmkpi.genPageUrl(url, null);
		hideIframeHtml = "<iframe scrolling='no' frameborder=0 style='display: none' src =' " + url + " '></iframe>";
	}
	//页面加载完成后执行
	$(function() {
		_cmp.init();
		if(hideIframeHtml != null && hideIframeHtml != ""){
			$("#indexdatatable").append(hideIframeHtml);
		}
		if (isshowedit != "2") {
			document.getElementById("editform").style.display = "none";
		} else {
			editform.synchEditformByObj(editinfo[0]);
		}
		if (_viewtype == "query") {
			$("div[compid='toolbutton']").hide();
		}
		$("#"+indexdatatable.id+"_tablePaginationDiv").hide();
		if(isZJ == 1){
			deptcmp.changTooltoolbuttontStatus(0,['新增指标']);
		}
	});
	/**
	 * 页面初始化.
	 */
	_cmp.init = function(){
		var params = {};
		params.proguid = _proguid;
		Ext.lt.ui.loadingShow();
		Ext.lt.RCP.call(serviceid, "findIndex", [params], function(data) {
			tabcomps = data["#index"];
			indexdatatable.setDatas(tabcomps);
			setTimeout(function(){
				amtTotal(indexdatatable);
			},100);
			Ext.lt.ui.loadingClose();
		})
	}
	/**
	 * 项目指标保存方法
	 * @param obj
	 */
	_cmp.save = function(obj){
		if (!indexdatatable.check()) return;//先校验
		var params = {};
		if (isshowedit == "2") {
			if (!editform.check()) {
				return;
			}
			params.editinfo = editform.getEditFormValues();
		}
		params.isshowedit = isshowedit;
		var datas = indexdatatable.getRecordSet().toArray();
		params.projguid = _proguid;
		params.datas = datas;
		params.saveAgency = _saveAgency;
		params.busguid = _busguid;
		Ext.lt.ui.loadingShow();
		var rs = Ext.lt.RCP.asyncall(serviceid , "savePrjIndex", params);
		Ext.lt.ui.loadingClose();
		if(rs && rs.success){
			_cmp.init();
		}
		return rs;
	}
	/**
	 * 精准推荐方法.
	 */
	_cmp.recom = function(){
		var url = '/pmkpi/program/prjindex/recomindex.page';
		var params = {};
		params.proguid = _proguid;
		params.saveAgency = _saveAgency; //项目单位
		params.prolev = _prolev;//项目级别 123
		url = Ext.lt.pmkpi.genPageUrl(url, params);
		indexwindow = Ext.lt.ui.openModalWindow(url,1100,600,"精准推荐");
	}
	/**
	 * 挑选指标.
	 * frame -- 二级指标
	 * guid -- guid
	 */
	_cmp.pick = function(){
		var data = indexdatatable.getSelected();
		var url = '/pmkpi/program/prjindex/pickindex.page';
		var params = {};
		if(data.length > 0){
			params.sindex = data[0].sindex;
			params.guid = data[0].guid;
		}
		params.saveAgency = _saveAgency; //项目单位
		params.prolev = _prolev;//项目级别 123
		params.proguid = _proguid;
		url = Ext.lt.pmkpi.genPageUrl(url, params);
		if(isZJ == 1){
			indexwindow = Ext.lt.ui.openModalWindow(url,width,550,"挑选指标");
		} else {
			indexwindow = Ext.lt.ui.openModalWindow(url,width,height,"挑选指标");
		}

	}
	/**
	 * 删除.
	 */
	_cmp.del = function(){
		var data = indexdatatable.getSelected();
		if(data.length == 0){
			Ext.lt.pmkpi.alert("请选择需要删除的数据！",function(){});
			return;
		}
		Ext.lt.ui.confirm("确认要删除选中指标？",{icon:"warn"},function(ret){
			if(ret){
				var delrows = data;
				if (delrows && delrows.length>0) {
					var delobj = delrows[0];
					var _sortid = delobj._sortid;
					//判断二级下是否还有没有保留一条空的二级
					var delrow = indexdatatable.getRecordset().query({sindex:delobj["sindex"]});
					if(delrow.length == 1){
						var formobj = {};
						formobj["mainguid"] =_proguid;
						formobj["findex"] = delobj["findex"];
						formobj["sindex"] = delobj["sindex"];
						var uuid = createUUID().replace(/-/g, '');
						formobj["guid"] = uuid;
						indexdatatable.getRecordSet().addData(formobj,_sortid);
					}
					indexdatatable.getRecordset().delRow(_sortid);
				}
			}
		})
	}
	/**
	 * 新增
	 */
	_cmp.add = function(frame,guid){
		var data = indexdatatable.getSelected();
		if(data.length != 1){
			Ext.lt.pmkpi.alert("请选择一条二级指标！",function(){});
			return;
		}
		var url = '/pmkpi/program/prjindex/editindex.page';
		var params = {};
		params.saveAgency = _saveAgency; //项目单位
		params.prolev = _prolev;//项目级别 123
		params.sindex = data[0].sindex;
		params.upguid = data[0].guid;
		params.type = "add";
		url = Ext.lt.pmkpi.genPageUrl(url, params);
		indexwindow = Ext.lt.ui.openModalWindow(url,1000,450,"新增指标");
	}
	/**
	 * 修改
	 */
	_cmp.mod = function(){
		var data = indexdatatable.getSelected();
		if(data.length != 1) {
			Ext.lt.pmkpi.alert("请选择二级指标进行修改！",function(){});
			return;
		} else if (data.length == 1 && (!data[0].name || data[0].name == "")) {
			Ext.lt.pmkpi.alert("请先录入三级指标！",function(){});
			return;
		}
		var url = '/pmkpi/program/prjindex/editindex.page';
		var params = {};
		params.saveAgency = _saveAgency; //项目单位
		params.prolev = _prolev;//项目级别 123
		params.sindex = data[0].sindex;
		params.modguid = data[0].guid;
		params.type = "mod";
		url = Ext.lt.pmkpi.genPageUrl(url, params);
		indexwindow = Ext.lt.ui.openModalWindow(url,1000,450,"修改指标");
	}

	return _cmp;
}


Ext.lt.message.hook("datatable", 'beforesetcols', function(data){
	if(data.table.config.id ="indexdatatable"){
		var cols = data.cols;
		if(!Ext.lt.isArray(cols))
			cols = [cols];
		for(var i=0; i<cols.length; i++){
			var col = cols[i];
			if(col["colcode"]=="cz"){
				col.fn = function(l,c,data,col){
					var html = "";
					html += "&nbsp;&nbsp;&nbsp;&nbsp;<a herf='#' title = '选择' style='color:#468ac9;cursor:pointer;' onclick=\"selectMeasuresToAdd('"+data["sindex"]+"','"+data["guid"]+"');\">选择</a>"
					if(data["name"] && data["name"] != ""){
						html += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a herf='#' title = '删除' style='color:#468ac9;cursor:pointer' onclick=\"delTableRow('"+data["guid"]+"');\">删除</a>";
					}
					return html;
				}
			}
			if(col["colcode"]=="noxz"){ //不用选择释放此列
				col.fn = function(l,c,data,col){
					var html = "";
					if(data["name"] && data["name"] != ""){
						html += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a herf='#' title = '删除' style='color:#468ac9;cursor:pointer' onclick=\"delTableRow('"+data["guid"]+"');\">删除</a>";
					}
					return html;
				}
			}
			/*if(col["colcode"]=="targetvalue"){ //目标值构建符号和单位
				col.fn = function(l,c,data,val){
					if(data["name"] && data["name"] != ""){
						if(escape(data["computesign"]).indexOf("%u")>-1){
							return "<font style=\"margin-left:10px;\">"+val+"</font>";
						} else {
							return "<font style=\"margin-left:10px;\">"+data["computesign"]+val+data["targetunit"]+"</font>";
						}
					}
					return "";
				}
				col.oneditstart = function(table, e, l, c, d){
					if(!d["name"]){
						return false;
					}
					e.innerText =  d["targetvalue"]!=undefined ? d["targetvalue"] : ''; //回返的本身值
				}
			}*/
			if(col["colcode"] == "findex"){
				var findex = "";
				var subfindex = "";
				col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
					if(j==2){
						var tabledata = indexdatatable.getRecordSet().toArray();
						var statnum = 0;
						if(i==statnum){
							findex = Ext.lt.cloneobj(rs["findex"]);
						}
						if(findex == rs["findex"]){
							style ='style="border-bottom-style:none;text-align:center;position:relative;padding-top:5px;';
						} else {
							style ='style="border-top-width:1px;text-align:center;border-top-color:#cccccc;border-bottom-style:none;';
						}
						findex = Ext.lt.cloneobj(rs["findex"]);
						if(i == tabledata.length-1){
							style =style +'border-bottom-style:solid;"';
						} else {
							style =style + '"';
						}
						if(indexdatatable.uiconfig.totaltag ==1 && i==0){ //有权重的合计
							style ='style="border-bottom-style:none;text-align:center;position:relative;padding-top:5px;"';
						}
					}
					return style;
				}
				col.fn = function(i,c,rs,value){ //行的显示样式.
					if(rs["findex"]){
						subfindex = Ext.lt.cloneobj(rs["findex"]);
						var seq = showMidleName(subfindex,"findex");
						if(i==seq){
							return value;
						}
						return "";
					}
				}
			}
			if(col["colcode"] == "sindex"){
				var sindex = "";
				var subsindex = "";
				col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
					if(j==3){
						var tabledata = indexdatatable.getRecordSet().toArray();
						var statnum = 0;
						if(i==statnum){
							sindex = Ext.lt.cloneobj(rs["sindex"]);
						}
						if(sindex == rs["sindex"]){
							style ='style="border-bottom-style:none;text-align:center;';//position:relative;padding-top:5px;
						} else {
							style ='style="border-top-width:1px;text-align:center;border-top-color:#cccccc;border-bottom-style:none;';
						}
						sindex = Ext.lt.cloneobj(rs["sindex"]);
						if(i == tabledata.length-1){
							style =style +'border-bottom-style:solid;"';
						} else {
							style =style + '"';
						}
						if(indexdatatable.uiconfig.totaltag ==1 && i==0){ //有权重的合计
							style ='style="border-bottom-style:none;text-align:center;"';//position:relative;padding-top:5px;
						}
					}
					return style;
				}
				col.fn = function(i,c,rs,value){ //行的显示样式.
					if(rs["sindex"]){
						subsindex = Ext.lt.cloneobj(rs["sindex"]);
						var seq = showMidleName(subsindex,"sindex");
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
					amtTotal(indexdatatable);
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

showMidleName = function(val,col){
	var tabledata = indexdatatable.getRecordSet().toArray();
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

function delTableRow(guid){
	Ext.lt.ui.confirm("确认要删除选中指标？",{icon:"warn"},function(ret){
		if(ret){
			var delrows = indexdatatable.getRecordset().query({guid:guid});
			if (delrows && delrows.length>0) {
				var delobj = delrows[0];
				var _sortid = delobj._sortid;
				//判断二级下是否还有没有保留一条空的二级
				var delrow = indexdatatable.getRecordset().query({guid:guid});
				if(delrow.length == 1){
					var formobj = {};
					formobj["mainguid"] =_proguid;
					formobj["findex"] = delobj["findex"];
					formobj["sindex"] = delobj["sindex"];
					var uuid = createUUID().replace(/-/g, '');
					formobj["guid"] = uuid;
					indexdatatable.getRecordSet().addData(formobj,_sortid);
				}
				indexdatatable.getRecordset().delRow(_sortid);
			}
		}
	})
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
			} else if (rowarr[i].isleaf == undefined && rowarr[i].levelno == undefined) {
				var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0;
				sumamt += parseFloat(weight);
			}
		}
		var totalrs = {};
		totalrs["weight"] = sumamt == 0 ? "" : sumamt.toFixed(2);
		totalrs.datatable_do_sum=true;
		table.getClockRowSet().setData(totalrs,0);
		if((totalrow.size&&totalrow.size()>0)||(totalrow.length&&totalrow.length>0)){
			table.reflashdata();
		}
	}
}

function selectMeasuresToAdd(sindex, guid) {
	var url = '/pmkpi/program/prjindex/pickindex.page';
	var params = {};
	params.sindex = sindex;
	params.guid = guid;
	params.saveAgency = _saveAgency; //项目单位
	params.prolev = _prolev;//项目级别 123
	params.proguid = _proguid;
	url = Ext.lt.pmkpi.genPageUrl(url, params);
	indexwindow = Ext.lt.ui.openModalWindow(url,width,height,"挑选指标");
}