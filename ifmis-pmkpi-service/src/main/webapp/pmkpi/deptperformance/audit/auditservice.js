if(!Ext.lt.pmkpi){
	Ext.lt.pmkpi = {};
}
var scrWidth =document.body.clientWidth-20;
var scrHeight =document.body.clientHeight-10;
var isShowRight = true; //是否显示右侧的审核意见div
var uitabpagenum =  0; //记录审核页面点击查看信息的哪个页签
Ext.lt.pmkpi.auditservice = function(config, serviceid){
	var common = Ext.lt.pmkpi.perfcommon(config, serviceid);
	var _cmp = {},
		_auditype = config.audittype,
		_jxaudit = config.jxaudit;
	//审核页面是否显示查看监控历史记录按钮（1 是  2 否）
	var _isshowhistracebtn = config.isshowhistracebtn;
	window.parent.Ext.lt.pmkpi.childwindow = window;

	function _init(){
		var divhtml = '<div style="margin:0 auto;">'
			+'<div id="_proview_" style="width:' + (scrWidth/4*3-20) + 'px; height:' + scrHeight + 'px;overflow-x: hidden;position:relative;float:left;">'
			+'<span class="span" style="display:block;float:left;width:15px;height:30px;font-size:20px;font-weight:bolder;color:#487FEC;cursor:pointer;position:absolute;top:0;right:0;"onclick=\'javascript:showhide();\'>|||</span>'
			+'</div>'
			+'<div id="_right_" style="width:' + scrWidth/4 + 'px; height:' + (scrHeight-50) + 'px;float:right;">'
			+'<div id="_auditview_" style="width:' + scrWidth/4 + 'px; height:' + (scrHeight-50) + 'px;"></div>'
			+'<div id="toolbtn" style="width:' + scrWidth/4 + 'px; height:' + 50 + 'px;"></div>'
			+ '</div></div>';
		$('.bd_main').append(divhtml);
		var buttondiv = $("#toolbtn");
		toolbutton.draw(buttondiv[0]);
		var prodiv = document.getElementById("_proview_");
		var auditdiv = document.getElementById("_auditview_");

		var _viewiframe = document.createElement("iframe");
		var _auditiframe = document.createElement("iframe");

		_setFrame(_viewiframe);
		var url = config.uikey + ".page";
		var params = {};
		var tst = Object.keys(config);
		for(var j = 0,len=tst.length; j < len; j++) {
			if (tst[j].indexOf("service") == -1 && tst[j].indexOf("server") == -1) {
				var vualue = config[tst[j]];
				if (isString(vualue) || isNumber((vualue))) {
					params[tst[j]] = vualue;
				}
			}
		}
		if(config.isnzzj == "true"){ // 年中追加使用项目guid
			params.mainguid = !config.projguid ? config.proguid : config.projguid;
		}else{
			params.mainguid = config.guid;
		}
		params.viewtype = "query";
		url = Ext.lt.pmkpi.genPageUrl(url, params);
		_viewiframe.src = url;
		_viewiframe.id = "infoframe";
		prodiv.appendChild(_viewiframe);
		_setFrames(_auditiframe);
		_auditiframe.id="_audit_iframe_";
		url = "/pmkpi/audit/index/"+_auditype+".page";
		if(_isshowhistracebtn == undefined || _isshowhistracebtn == "" || _isshowhistracebtn !="1"){
			common.changTooltoolbuttontStatus(0,['查看历史监控记录','查看历史年度监控记录']);
		}
		var params = {};
		var tst = Object.keys(config);
		for(var j = 0,len=tst.length; j < len; j++) {
			if (tst[j].indexOf("service") == -1 && tst[j].indexOf("server") == -1) {
				var vualue = config[tst[j]];
				if (isString(vualue) || isNumber((vualue))) {
					params[tst[j]] = vualue;
				}
			}
		}
		url = Ext.lt.pmkpi.genPageUrl(url, params);
		_auditiframe.src = url;
		auditdiv.appendChild(_auditiframe);
		if(_SYSTEMSTYLE_ != "grey"){
			setTimeout(function () {
				$(".winfooter").children().first().css("float","right");
			}, 300);
		}
	}

	function _setFrame(obj){
		obj.setAttribute('frameBorder', 0);
		obj.style.cssText = 'border: 0 none;';
		obj.width = scrWidth/4*3-20;
		obj.height = scrHeight;
	}
	function _setFrames(obj){
		obj.setAttribute('frameBorder', 0);
		obj.style.cssText = 'border: 0 none;';
		obj.width = scrWidth/4;
		obj.height = scrHeight;
	}

	/**
	 * 保存
	 */
	_cmp.save = function(){
		_doWork();
	}
	/**
	 * 审核
	 */
	_cmp.audit = function(obj){
		var _win = $("#_audit_iframe_")[0].contentWindow;
		var maindata = _win.editform.getEditFormValues();
		var audittype =  maindata.audittype;
		var pinggutype =  maindata.pinggutype;
		if (_auditype == "traceopinion" && (audittype == "2" || audittype == "4")) {
			if (!_win.editform.check()) {
				return;
			}
			_cmp.traceaudit(audittype, maindata.remark);
		} else if (_auditype == "evaluation" && audittype == "1" && pinggutype == "1"){ //事前绩效评估审核
			var params ={};
			params.guid = config.mainguid;
			params.proguid = config.proguid;
			Ext.lt.RCP.call(serviceid, "queryFileCount", params, function(rt){
				if (!rt.result){
					Ext.lt.ui.alert(("“事前绩效再评估附件未上传！”"),{}, function(ret) {
					});
				} else {
					_doWork(true, obj);
				}
			});
		} else {
			_doWork(true, obj);
		}
	}

	/**
	 * 退回
	 */
	_cmp.back = function(obj){
		_doWork(true, obj);
	}

	/**
	 * 查看监控历史记录
	 */
	_cmp.showhistrace = function (obj) {
		var params = {};
		//params.mainguid = config.guid;
		params.procode = config.procode;
		params.projguid = config.projguid;
		params.province = config.province;
		params.year = config.year;
		params.saveAgency = config.saveAgency;
		params.bustype = config.bustype;
		params.querytype = obj.code;
		url = "/pmkpi/audit/program/showhistrace.page";
		url = Ext.lt.pmkpi.genPageUrl(url, params);
		Ext.lt.ui.openModalWindow(url, scrWidth*0.9, scrHeight*0.9, "监控历史记录");
	}

	function _doWork (isaudit, auditparam){
		var _win = $("#_audit_iframe_")[0].contentWindow;
		var parms = {};
		var maindata = _win.Ext.lt.pmkpi.editmap||{};
		_win.editform && (jQuery.extend(maindata, _win.editform.getEditFormValues()));
		_win.datatable && (parms.datas = _win.datatable.getRecordSet().toArray());
		Ext.lt.ui.loadingShow();
		maindata["type"] = _auditype;
		var tst = Object.keys(config);
		for(var j = 0,len=tst.length; j < len; j++) {
			var vualue = config[tst[j]];
			if (isString(vualue) || isNumber((vualue))) {
				parms[tst[j]] = vualue;
			}
		}
		parms.mainguid = config.guid;
		parms.maindata = maindata;
		if(auditparam.code != "back" && _win.editform){
			if(!_win.editform.check()){
				Ext.lt.ui.loadingClose();
				return;
			}
		}
		if(_win.datatable){
			if(!_win.datatable.checkAll()){
				Ext.lt.ui.loadingClose();
				return;
			}
		}
		if(isaudit){
			window.parent.Ext.lt.pmkpi.auditdata = parms;
			if(parms.audittype == "part" && auditparam.action=="audit"){

			}else{
				auditparam.pagetype = config.pagetype;
				auditparam.procode = config.procode;
				window.parent.Ext.lt.pmkpi.audit(auditparam);
			}
			Ext.lt.ui.loadingClose();
		}else{
			Ext.lt.RCP.call(serviceid, "save", parms, function(rt){
				if(rt.status == "1"){
					Ext.lt.ui.alert(("保存成功！"),{}, function(ret) {
					});
					_win.location.reload(true);
				}else{
					Ext.lt.ui.alert(("保存失败！"),{}, function(ret) {
					});
				}
				Ext.lt.ui.loadingClose();
			}, function(){
				Ext.lt.ui.loadingClose();
				Ext.lt.ui.alert(("保存失败！"),{}, function(ret) {
				});
			});
		}
	}

	/**
	 * 项目绩效目标审核(绩效处退回)
	 */
	_cmp.backjxaudit = function(obj){
		ajax();
	}

	$(function () {
		_init();
		if(_jxaudit == "jxaudit"){
			common.changTooltoolbuttontStatus(0,['退回']);
		}
	})

	/**
	 * 山西双流程调用
	 */
	function ajax() {
		var selUrl = "/pmkpi/doubleprocess/backDoublePress.do?tokenid="+Ext.lt.token.getTokenid();
		var _win = $("#_audit_iframe_")[0].contentWindow;
		var params = {};
		var maindata = _win.Ext.lt.pmkpi.editmap||{};
		_win.editform && (jQuery.extend(maindata, _win.editform.getEditFormValues()));
		_win.datatable && (parms.datas = _win.datatable.getRecordSet().toArray());
		Ext.lt.ui.loadingShow();
		maindata["type"] = _auditype;
		var remark = maindata.remark;
		var list = [];
		list.push({
			"pro_code" : config.procode,
			"mainguid": config.projguid,
			"remark": remark
		});
		params.backData = JSON.stringify(list);
		params.remark = remark;
		$.ajax({
			type: "post",
			url: selUrl,
			data: JSON.stringify(params),
			dataType: "text",
			contentType: "application/json",
			success: function (data) {
				var data = JSON.parse(data);
				if (true== data.result) {
					Ext.lt.ui.alert(("退回成功！"),{}, function(ret) {
					});
					Ext.lt.message.send("perfcommon", "auditquery",{});
					Ext.lt.ui.closeModalWindow;
				} else {
					Ext.lt.ui.alert('退回失败！',function(){
					});
				}
				Ext.lt.ui.loadingClose();
			}
		});
	}

	/**
	 * 广西监控是否走成果上传审核
	 */
	_cmp.traceaudit = function(audittype, remark){
		var winname = "";
		var params = {};
		params.bustype = config.bustype;
		if(_auditype == "traceopinion" && audittype == "2"){
			var url = "/pmkpi/review/entrust/expert.page";
			params.pagetype = "expertquery";
			winname = "委托专家";
		}else if(_auditype == "traceopinion" && audittype == "4"){ //委托中介
			var url = "/pmkpi/evaluate/thirdevaluate/entrust.page";
			params.pagetype = "intermediaryquery";
			winname = "委托中介";
		}
		params.guid = config.mainguid;
		params.proguid = config.proguid;
		params.workflow = config.workflow;
		params.maintablecode = "V_PERF_T_PROMONITOR";
		params.remark = remark;
		url = Ext.lt.pmkpi.genPageUrl(url, params);
		Ext.lt.ui.openModalWindow(url, scrWidth * 0.9, scrHeight * 0.9, winname);
	}

	return _cmp;
}
function showhide(){
	if ($("#infoframe")[0].contentWindow.tabpage){
		uitabpagenum = $("#infoframe")[0].contentWindow.tabpage.cfg.activeTab;
	}
	var _iframe1=document.getElementById('infoframe');
	_iframe1.height = scrHeight-40;
	isShowRight = !isShowRight;
	if(!isShowRight){
		$("#_right_").css({
			display:"none"
		});
		$("#_proview_").css({
			width:scrWidth
		});
		_iframe1.width = scrWidth;
	}else{
		$("#_right_").css({
			display:"block"
		});
		$("#_proview_").css({
			width:scrWidth/4*3-20
		});
		_iframe1.width = scrWidth/4*3-20;
	}
	//刷新左边数据
	_iframe1.contentWindow.location.reload(true);
	locationTabpage();
}
function locationTabpage(){
	setTimeout(function(){ //延迟执行处理页签
		//tabpage.doActiveTab(uitabpagenum);
		$("#infoframe")[0].contentWindow.tabpage.doActiveTab(uitabpagenum);
	},500);
}