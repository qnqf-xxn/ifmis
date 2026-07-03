if(!Ext.lt.pmkpi)
	Ext.lt.pmkpi = {};
/**
 * 初始化加载.
 */
var isendaiprocess = false; // 单次ai会话是否完成
Ext.lt.pmkpi.airecoindex = function(config, serviceid) {
	var perfcommon = Ext.lt.pmkpi.perfcommon(config, serviceid);
	var _fromtype = config["fromtype"]; // 来源树级表格还是合并表格
	var _frametype = config["frametype"] || 'PM001'; // 指标体系类型
	var _tableid = "";
	var _aiprompt = config["aiprompt"]; // 后台组装ai提示词
	var _proaiprompt = ""; // 项目信息ai提示词
	var _plusprompt = config["plusprompt"]; // 页面追加的提示词
	var _apikey = config["apikey"]; // apikey
	var _apicode = config["apicode"]!= null ? config["apicode"] : "PMKPI_AIRECOINDEX"; // apicode 默认 PMKPI_AIRECOINDEX
	var _signs = config["signs"]; // 计算符号
	var _indmap = config["indmap"];// 指标层次分类
	var _cmp = {};
	var _curindmap = [];
	var _dialogID = "";
	var _isShowThink = config["isShowThink"] == null ? true : config["isShowThink"]; // 是否显示AI思考过程
	for (var i = 0; i < _indmap.length; i++) {
		var item = _indmap[i];
		if (item && item.frametype == _frametype) {
			_curindmap.push(item);
		}
	}
	// 宽高取整避免子窗体加载异常
	var height = Math.floor(document.documentElement.clientHeight * 0.9);
	var width =  Math.floor(document.documentElement.clientWidth * 0.98);
	var _isHuBei = config.isHUBEI;
	var _isGUANGXI = config.isGUANGXI;
	var _currentprovince = config.province;
	var _currentyear = config.year;
	var _procode = config.procode;
	var _proguid = config.proguid;
	var _yearflag = config.yearflag;
	var _isYANSHI = config.isYANSHI;
	var _is_profrompage = config.is_profrompage;
	var _loadingtips = config.loadingtips == null ? "正在思考中" : config.loadingtips;

	/**
	 * 页面加载完成
	 */
	$(function() {
		_cmp.initDivs();
		_cmp.loadDatas();
	})

	/**
	 * ai返回结果前显示加载状态
	 */
	_cmp.openAIthinking = function (){
		var loading = $("#aithinkingimg");
		if(loading.size()==0){
			var htmlArr = [];
			htmlArr.push("<div id='aithinkingimg'>");
			htmlArr.push("<img src='/pmkpi/themes/images/tit-ico.png' />")
			htmlArr.push("<span id='thinkstr'>"+_loadingtips+"</span>")
			htmlArr.push("<div class=\"medium-dots\">\n" +
				"          <div></div><div></div><div></div><div></div>\n" +
				"          <div></div><div></div><div></div><div></div>\n" +
				"        </div>")
			htmlArr.push("</div>")
			loading = $(htmlArr.join(""));
			$(".bd_main").append(loading);
		}
		loading.show();
	}

	/**
	 * ai返回结果后显示加载状态
	 */
	_cmp.closeAIthinking = function (){
		var loading = $("#aithinkingimg");
		if(loading.size()!=0){
			loading.hide();
		}
	}

	// 开启提示生成指标加载框的方法
	_cmp.openResultLoading = function (){
		Ext.lt.HTML.mark(); // 开启遮罩

		// 获取当前窗口尺寸
		var winWidth = $(window).width();
		var winHeight = $(window).height();

		var loading = $("#ailoadingimg");

		if(loading.size() == 0){
			// 根据窗口宽度动态设置容器大小
			var containerWidth = Math.min(440, winWidth * 0.5); // 最大440px或窗口50%宽度
			var containerHeight = Math.min(100, winHeight * 0.2); // 最大100px或窗口20%高度

			var htmlArr = [];
			htmlArr.push("<div id='ailoadingimg' style='");
			htmlArr.push("position: fixed;"); // 改为 fixed 定位
			htmlArr.push("z-index: 200004;");
			htmlArr.push("display: flex;");
			htmlArr.push("flex-direction: column;");
			htmlArr.push("align-items: center;");
			htmlArr.push("justify-content: center;");
			htmlArr.push("height: " + containerHeight + "px;");
			htmlArr.push("width: " + containerWidth + "px;");
			htmlArr.push("background: rgba(255,255,255);");
			htmlArr.push("border-radius: 8px;");
			htmlArr.push("box-shadow: 0 2px 10px rgba(0,0,0,0.1);");
			htmlArr.push("'>");

			// 进度条图片
			htmlArr.push("<img src='"+_APPID_PATH_+"/busfw/images/progress bar.gif' ");
			htmlArr.push("style='max-width: 90%; max-height: 90%;' />"); // 响应式图片大小

			// 文字提示
			htmlArr.push("<div style='");
			htmlArr.push("margin-top: 10px;");     // 文字与图片间距
			htmlArr.push("font-size: 15px;");      // 字体大小
			htmlArr.push("color: #333;");          // 字体颜色
			htmlArr.push("font-weight: 500;");     // 字体粗细
			htmlArr.push("text-align: center;");   // 文字居中
			htmlArr.push("padding: 0 10px;");      // 左右内边距
			htmlArr.push("box-sizing: border-box;"); // 包含内边距在宽度内
			htmlArr.push("'>正在生成指标</div>");

			htmlArr.push("</div>");

			loading = $(htmlArr.join(""));
			$("body").append(loading);
		} else {
			// 如果已存在，更新尺寸
			loading.css({
				width: Math.min(440, $(window).width() * 0.5) + 'px',
				height: Math.min(100, $(window).height() * 0.2) + 'px'
			});
		}

		loading.show();

		// 计算并设置居中位置
		var leftPos = ($(window).width() - loading.width()) / 2;
		var topPos = ($(window).height() - loading.height()) / 2;

		loading.css({
			left: leftPos + 'px',
			top: topPos + 'px'
		});

		// 添加窗口大小变化监听
		$(window).off('resize.ailoading'); // 先移除旧的监听器
		$(window).on('resize.ailoading', function() {
			var newWinWidth = $(window).width();
			var newWinHeight = $(window).height();

			// 更新容器大小
			loading.css({
				width: Math.min(440, newWinWidth * 0.5) + 'px',
				height: Math.min(100, newWinHeight * 0.2) + 'px'
			});

			// 重新计算居中位置
			var newLeft = (newWinWidth - loading.width()) / 2;
			var newTop = (newWinHeight - loading.height()) / 2;

			loading.css({
				left: newLeft + 'px',
				top: newTop + 'px'
			});
		});
	}

	// 更新进度条文字内容的方法
	_cmp.updateResultLoadingText = function(text) {
		var textDiv = $("#ailoadingtext");
		if(textDiv.size() > 0) {
			textDiv.text(text);
		}
	};

	// 关闭加载框的方法
	_cmp.closeResultLoading = function() {
		var loading = $("#ailoadingimg");
		if(loading.size() > 0) {
			loading.hide();
			$(window).off('resize.ailoading'); // 移除事件监听
		}
		Ext.lt.HTML.unmark(); // 关闭遮罩
	}

	/**
	 * 显示审核时间
	 */
	_cmp.setAuditTimeShow = function (){
		var datas = airecoindextable.getRecordset().toArray();
		var timeStr;
		if(datas.length > 0){
			var auditTime = datas[0].create_time; //格式 20260413163900
			if (!/^\d{14}$/.test(auditTime)) {
				timeStr = "";
			}else{
				timeStr = '推荐时间: ' + auditTime.slice(0,4) + '-' + auditTime.slice(4,6) + '-' + auditTime.slice(6,8) + ' ' + auditTime.slice(8,10) + ':' + auditTime.slice(10,12) + ':' + auditTime.slice(12,14);
			}
		}else{
			var now = new Date();
			function padZero(num) {
				return num < 10 ? '0' + num : '' + num;
			}
			timeStr = '推荐时间: ' + now.getFullYear() + '-' + padZero(now.getMonth() + 1) + '-' + padZero(now.getDate())
				+ ' ' + padZero(now.getHours()) + ':' + padZero(now.getMinutes()) + ':' + padZero(now.getSeconds());
		}
		if(!!timeStr){
			var audittimediv = $("#audittimetext");
			if(audittimediv.size() == 0){
				var htmlArr = [];
				htmlArr.push("<div id='audittimetext' style='");
				htmlArr.push("margin-top: 6px;");     // 文字上距
				htmlArr.push("font-size: 15px;");      // 字体大小
				htmlArr.push("color: #333;");          // 字体颜色
				htmlArr.push("font-weight: 500;");     // 字体粗细
				htmlArr.push("text-align: center;");   // 文字居中
				htmlArr.push("padding: 0 10px;");      // 左右内边距
				htmlArr.push("box-sizing: border-box;"); // 包含内边距在宽度内
				htmlArr.push("float: left;"); // 左浮
				htmlArr.push("'>");
				htmlArr.push(timeStr);
				htmlArr.push("</div>");
				var title = $(htmlArr.join(""));
				$(".winfooter").find(".nomalbtn").prepend(title);
			}else{
				audittimediv.text(timeStr);
			}
		}
	}

	// 加载AI指标推荐记录数据
	_cmp.loadDatas = function (){
		var params = {};
		params.procode = _procode;
		params.proguid = _proguid;
		params.yearflag = _yearflag;
		Ext.lt.RCP.call(serviceid, "getAIRecoindexDatas", params,
			function (rs) {
				if(rs.success){
					if(rs.airecoindex.length > 0){
						// 存在推荐指标记录 直接载入
						var output = $("#airecoindexcontent");
						var processedText = rs.thinkingprocess
							.replace(/<br\s*\/?>/gi, '\n')  // 替换 <br> 为换行符
							.replace(/<[^>]+>/g, '');       // 移除其他 HTML 标签
						output.text(processedText);
						output.scrollTop(output.prop('scrollHeight'));
						airecoindextable.setDatas(rs.airecoindex);
						_cmp.setAuditTimeShow();
						isendaiprocess = true;
						if(_isShowThink){
							_cmp.closeAIthinking();
						}else{
							_cmp.closeResultLoading();
						}
					}else{
						// 不存在推荐记录 开始AI推荐
						if(_isHuBei){// 湖北需要等待查询后台结果 测算信息
							_cmp.getAIprompt();
							_cmp.AIrecoindex();
						}else{
							_cmp.getProDataPrompt();
							_cmp.AIrecoindex();
						}
					}
				}
			},
			function () {
				Ext.lt.pmkpi.alert('查询指标推荐记录失败！');
			}
		);
	}

	/**
	 * 初始化div元素和表格对象
	 */
	_cmp.initDivs = function (){
		var output = $("#airecoindexcontent");
		if ($("#airecoindexcontent").length === 0) {
			output = $("#lefttree");
            if($("#lefttree"),length === 0){
                output = $(".tpl_left");
            }
            output.attr('id', 'airecoindexcontent');
			output.attr('class','');
		}
		output.find(".search").hide();
		// 设置思考过程区域样式
		output.css({
			'font-family': 'Microsoft YaHei',
			'font-weight': '400',
			'font-size': '15px',
			'whiteSpace': 'pre-wrap',
			'line-height': '20px',
			'tabSize': 2,
			'overflow': 'hidden auto',
			// 'background-color': '#f5f5f5',
			'display': 'block',
			'padding': '0 0 0 13px',
			'border-left': '2px solid #e5e5e5',
			'color': _isHuBei ? '#222' : '#8b8b8b',
			'min-height': 0.35*height +'px',
			'height': 0.75*height +'px',
			'width' : 0.35*width +'px',
			'position' : 'absolute'
		});
        $("#sliderBar").hide();
		$("#hidden_left").hide(); // 隐藏lefttree的折叠按钮
		if(_isShowThink){ // 显示思考过程
			$(".tpl_right").css({'width':(width*0.6)+'px','left':(width*0.38)+'px'});
			airecoindextable.resize(width*0.6,height*0.95);
		}else{ // 隐藏思考过程
			output.hide();
			$(".tpl_right").css({'width':(width*0.9)+'px','left':'10px'});
			airecoindextable.resize(width*0.9,height*0.95);
		}
		if ("tree" == _fromtype) {
			_tableid = "datatable";
		} else {
			_tableid = "indexdatatable";
		}
		window.parent.indexwindow = window;
		perfcommon.initDatatable(airecoindextable);
		if ($("#airecoindexjosn").length === 0) {
			$(".bd_main").append('<div id="airecoindexjosn" style="display: none;"></div>');
		}
		$(".bd_main").css({'overflow':'hidden','margin-left':'15px'});
		// Ext.lt.ui.loadingShow();
		// 开始加载
		if(_isShowThink){
			_cmp.openAIthinking();
		}else{
			_cmp.openResultLoading();
		}
	}

	/**
	 * 获取后台项目信息拼接提示词
	 */
	_cmp.getAIprompt = function() {
		if(_is_profrompage == "1"){
			try {
				// 项目库嵌套项目基本信息editform
				var proeditformmap = window.parent.parent.editform.getEditFormValues();
				_proaiprompt = "项目名称：" + proeditformmap.pro_name + "，";
				if(proeditformmap.pro_bases){
					_proaiprompt += "立项依据：" + proeditformmap.v_col25 + "，";
				}
				if(proeditformmap.pro_desc){
					_proaiprompt += "项目概述：" + proeditformmap.pro_desc + "，";
				}
				if(proeditformmap.pro_term){
					_proaiprompt += "项目期限：" + proeditformmap.pro_term + "年，";
				}
				if(proeditformmap.manage_dept_code){
					_proaiprompt += "部门：" + proeditformmap.manage_dept_name + "，";
				}
				if(!!_plusprompt){ // 存在页面追加提示词 拼接
					_proaiprompt += _plusprompt;
				}
				resolve(_proaiprompt);
			} catch (e) {
				console.info('获取嵌套页面项目信息失败:', e);
			}
		}
		if(_proaiprompt == ""){
			var params = {};
			params.procode = _procode;
			params.proguid = _proguid;
			params.yearflag = _yearflag;
			var aipromptrs = Ext.lt.RCP.asyncall(serviceid , "getAIprompt", params);
			if(aipromptrs.success){
				_proaiprompt = aipromptrs.aiprompt;
				if(!!_plusprompt){ // 存在页面追加提示词 拼接
					_proaiprompt += _plusprompt;
				}
			}else {
				Ext.lt.pmkpi.alert(aipromptrs.error,function(){});
			}
		}
	};

	/**
	 * 获取嵌套页面项目信息拼接提示词
	 */
	_cmp.getProDataPrompt = function (){
		_proaiprompt = "";
		try {
			// 项目库嵌套项目基本信息editform
			var proeditformmap = window.parent.parent.editform.getEditFormValues();
			_proaiprompt = "项目名称：" + proeditformmap.pro_name + "，";
			if(proeditformmap.pro_term){
				_proaiprompt += "项目期限：" + proeditformmap.pro_term + "年，";
			}
			if(proeditformmap.manage_dept_code){
				_proaiprompt += "部门：" + proeditformmap.manage_dept_name + "，";
			}
			if(_isGUANGXI){
				if(proeditformmap.agency_name){
					_proaiprompt += "单位：" + proeditformmap.agency_name + "，";
				}
				if(proeditformmap.pro_desc){
					_proaiprompt += "项目概述：" + proeditformmap.pro_desc + "，";
				}
				if(proeditformmap.parent_pro_name){
					_proaiprompt += "一级项目名称：" + proeditformmap.parent_pro_name + "，";
				}
			}else{
				if(proeditformmap.pro_desc){
					_proaiprompt += "项目内容：" + proeditformmap.pro_desc + "，";
				}
				if(proeditformmap.pro_bases){
					_proaiprompt += "立项依据：" + proeditformmap.pro_bases + "，";
				}
				if(proeditformmap.v_col7){
					_proaiprompt += "测算依据及说明：" + proeditformmap.v_col7 + "，";
				}
			}
			// 项目库嵌套绩效目标 dcdatatable 下的 editform
			var goaldata;
			if (window.parent.parent.document.getElementById("dcdatatable")) {
				var iframes = window.parent.parent.document.getElementById("dcdatatable").childNodes;
				for (var i=0; i<iframes.length; i++) {
					var iframe = iframes[i];
					if (iframe && iframe.contentDocument) {
						var url = iframe.contentDocument.URL;
						if (url) {
							var f = url.indexOf("/pmkpi/");
							var l = url.lastIndexOf(".page");
							url = url.substring(f,l);
							if (iframe.contentWindow && url == "/pmkpi/program/report/protabgoal") {
								if(_yearflag == "1"){
									if (iframe.contentWindow._curtab == "total") {
										goaldata = iframe.contentWindow.editform.getEditFormValues();
									} else {
										goaldata = iframe.contentWindow.tabcomps["#total"];
									}
								}else if(_yearflag == "0"){
									if (iframe.contentWindow._curtab == "year") {
										goaldata = iframe.contentWindow.editform.getEditFormValues();
									} else {
										goaldata = iframe.contentWindow.tabcomps["#year"];
									}
								}
								if (goaldata && (!goaldata.kpi_target || goaldata.kpi_target == "")) {
									goaldata = undefined;
								}
							}
						}
					}
				}
			} else if(window.parent.parent.document.getElementsByClassName("bd_main")){
				// 绩效自己的填报页
				var iframes = window.parent.parent.document.getElementsByClassName("bd_main")[0].childNodes;
				for (var i=0; i<iframes.length; i++) {
					var iframe = iframes[i];
					if (iframe && iframe.childNodes && iframe.childNodes[0] && iframe.childNodes[0].contentDocument) {
						var url = iframe.childNodes[0].contentDocument.URL;
						if (url) {
							var f = url.indexOf("/pmkpi/");
							var l = url.lastIndexOf(".page");
							url = url.substring(f,l);
							if (iframe.childNodes[0].contentWindow && url == "/pmkpi/program/report/protabgoal") {
								if(_yearflag == "1"){
									if (iframe.childNodes[0].contentWindow._curtab == "total") {
										goaldata = iframe.childNodes[0].contentWindow.editform.getEditFormValues();
									} else {
										goaldata = iframe.childNodes[0].contentWindow.tabcomps["#total"];
									}
								}else if(_yearflag == "0"){
									if (iframe.childNodes[0].contentWindow._curtab == "year") {
										goaldata = iframe.childNodes[0].contentWindow.editform.getEditFormValues();
									} else {
										goaldata = iframe.childNodes[0].contentWindow.tabcomps["#year"];
									}
								}
								if (goaldata && (!goaldata.kpi_target || goaldata.kpi_target == "")) {
									goaldata = undefined;
								}
							} else if (iframe.childNodes[0].contentWindow && url == "/pmkpi/program/report/progoalnewedit") {
								if(_yearflag == "1"){
									goaldata = iframe.childNodes[0].contentWindow.totaleditform.getEditFormValues();
								}else if(_yearflag == "0"){
									goaldata = iframe.childNodes[0].contentWindow.yeareditform.getEditFormValues();
								}
								if (goaldata && (!goaldata.kpi_target || goaldata.kpi_target == "")) {
									goaldata = undefined;
								}
							}
						}
					}
				}
			}
			if(_proaiprompt != "" && goaldata == undefined){
				// 页面获取到项目信息 取不到目标信息，调用后台查询
				var params = {};
				params.procode = _procode;
				params.proguid = _proguid;
				params.yearflag = _yearflag;
				params.type = "onlygoal"
				goaldata = {};
				var aipromptrs = Ext.lt.RCP.asyncall(serviceid , "getAIprompt", params);
				if(aipromptrs.success){
					goaldata.kpi_target = aipromptrs.kpi_target;
				}else {
					Ext.lt.pmkpi.alert(aipromptrs.error,function(){});
				}
			}
			if(_yearflag == "1" && goaldata.kpi_target){
				_proaiprompt += "总体绩效目标：" + goaldata.kpi_target + "，";
			}else if(_yearflag == "0" && goaldata.kpi_target){
				_proaiprompt += "本年度绩效目标：" + goaldata.kpi_target + "，";
			}
		} catch (e) {
			console.info('获取嵌套页面项目信息失败:', e);
		}
		if(_proaiprompt == ""){
			// 页面获取不到项目信息 调用后台查询
			var params = {};
			params.procode = _procode;
			params.proguid = _proguid;
			params.yearflag = _yearflag;
			var aipromptrs = Ext.lt.RCP.asyncall(serviceid , "getAIprompt", params);
			if(aipromptrs.success){
				_proaiprompt = aipromptrs.aiprompt;
			}else {
				Ext.lt.pmkpi.alert(aipromptrs.error,function(){});
			}
		}
		if(_proaiprompt == ""){
			Ext.lt.pmkpi.alert("获取项目信息失败，请先保存项目信息再进行指标推荐！",function(){});
			return;
		}
		if(!!_plusprompt){ // 存在页面追加提示词 拼接
			_proaiprompt += _plusprompt;
		}
	}
	/**
	 * 关闭
	 * @param obj
	 */
	_cmp.closewin = function(obj){
		parent.Ext.lt.ui.modalWindow.close();
	}
	/**
	 * 选中指标引用
	 */
	_cmp.addindex = function(){
		if (!isendaiprocess) {
			Ext.lt.pmkpi.alert("智能指标推荐中，请耐心等待！",function(){});
			return;
		}
		var selRecords = airecoindextable.getSelected();
		if (selRecords.length <= 0) {
			Ext.lt.pmkpi.alert("请选择要引用的推荐指标！",function(){});
			return;
		}
		// 0 选中的推荐数据校验
		for (var i = 0; i < selRecords.length; i++) {
			var indexdata = selRecords[i];
			if(!indexdata.findex || !indexdata.sindex || !indexdata.computesign){
				Ext.lt.pmkpi.alert("推荐的绩效指标存在异常，请重新推荐！");
				return false;
			}
		}
		var selMap = {};
		var tempobj = {};
		var sindex = "";
		var name = "";
		for (var i=0;i<selRecords.length;i++) {
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
			if (parent._curtab == "total") {
				tempobj.yearflag = "1";
			} else if (parent._curtab == "year") {
				tempobj.yearflag = "0";
			}
			if (name && name != "") { // 存在三级指标的才保存替换
				if (!selMap[sindex]) {
					selMap[sindex] = [];
				}
				tempobj.explain = tempobj.indexval; // 指标参考值
				tempobj.indexvalue = ""; // 指标值清空
				tempobj.indexval = "";
				tempobj.kpi_val = "";
				tempobj.kpi_remark = "智能指标推荐";
				selMap[sindex].push(tempobj);
			}
		}
		// 指标符号翻译
		var zbxs_source = [];
		for (var i=0; i<_signs.length; i++) {
			var temparr = [];
			temparr.push(_signs[i]["guid"]);
			temparr.push(_signs[i]["code"]);
			temparr.push(_signs[i]["name"]);
			zbxs_source.push(temparr);
		}
		parent.eval(_tableid).addMapperDatas("computesign",zbxs_source);
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
		parent.Ext.lt.pmkpi.alert("智能指标推荐完成，已推荐指标"+selRecords.length+"个！",function(){});//完成提示
	}
	/**
	 * 选中指标引用 河北模式调用父级页面方法处理
	 * 包含目标-指标
	 */
	_cmp.addindexhb = function(){
		var selRecords = airecoindextable.getSelected();
		if (selRecords.length <= 0) {
			Ext.lt.pmkpi.alert("请选择要引用的推荐指标！",function(){});
			return;
		}
		parent.Ext.lt.pmkpi.AIrecoindexAdd(selRecords);
	}
	/**
	 * 重新推荐
	 */
	_cmp.query = function(){
		if(isendaiprocess){
			Ext.lt.ui.confirm("已经存在智能推荐结果，是否重新生成?",{icon:"warn"},function(ret){
				if(ret){
					if(_isShowThink){
						var output = $("#airecoindexcontent");
						output.text('');
						var airecoindexdiv = $("#airecoindexjosn");
						airecoindexdiv.text('');
						_cmp.openAIthinking();
					}else{
						var airecoindexdiv = $("#airecoindexjosn");
						airecoindexdiv.text('');
						airecoindextable.setDatas([]);
						_cmp.openResultLoading();
					}
					if(_isHuBei){// 湖北需要等待查询后台结果 测算信息
						_cmp.getAIprompt()
							.then(function() {
								console.log('_proaiprompt:', _proaiprompt);
								_cmp.AIrecoindex();
							})
							.catch(function(error) {
								console.error('获取AI提示失败:', error);
							});
					}else{
						_cmp.getProDataPrompt();
						_cmp.AIrecoindex();
					}
				}
			});
		}else {
			Ext.lt.pmkpi.alert("智能指标推荐中，请耐心等待！",function(){});
		}

	}
	/**
	 * 保存结果
	 * @param content 思考过程
	 * @param _airecoindexarry 结果array
	 */
	_cmp.saveresult = function(content,_airecoindexarry){
		if((_yearflag == '0' && _procode!=null && _procode!= undefined) || (_yearflag == '1' && _proguid!=null && _proguid!= undefined) ){
			var params = {};
			params.procode = _procode;
			params.proguid = _proguid;
			params.yearflag = _yearflag;
			params.prompt = _proaiprompt;
			params.thinkingprocess = content;
			params.datas = _airecoindexarry ? _airecoindexarry : datatable.getRecordset().toArray();
			Ext.lt.RCP.call(serviceid, "saveNewAIRecoindexDatas", params, function (rs) {
				if(!rs.success){
					Ext.lt.ui.alert(rs.error,function(){});
				}
			}, function () {
				Ext.lt.pmkpi.alert('保存指标推荐结果失败！', function () {
				});
			});
		}
	}
	/**
	 * AI指标推荐加载
	 */
	_cmp.AIrecoindex = function () {
		var url = '/ifmisLLM/chat/1.0.0.0/rendQStream?tokenid=' + Ext.lt.token.getTokenid() + Ext.lt.token.getAuthorization();
		if(_isHuBei){
			url = '/hbifmisLLM/chat/1.0.0.0/rendQStream?user_code=admin&province='+_currentprovince+'&year='+_currentyear;
		}
		if(_isYANSHI){
			url = '/ifmisLLM/chat/1.0.0.0/rendQStream?usercode=admin';
		}
		var output = $("#airecoindexcontent");
		var airecoindexdiv = $("#airecoindexjosn");
		// 清空是靠过程显示区、推荐指标json缓存区、推荐指标列表
		output.text('');
		airecoindexdiv.text('');
		airecoindextable.setDatas([]);
		try {
			var xhr = createXHR();
			var timeoutTimer = setTimeout(function() {
				xhr.abort(); // 终止请求
				Ext.lt.pmkpi.alert("资源不足，请稍后重试！",function(){
					_cmp.closewin();
				});
			}, 180000); // 3分钟超时（180000毫秒）
			xhr.open('POST', url, true);
			xhr.setRequestHeader('Content-Type', 'application/json');
			xhr.setRequestHeader('accept', 'application/json, text/plain, */*');
			// if(!_isShowThink){
			// 	Ext.lt.ui.loadingShow();
			// }
			var result = '';
			var hideindexobj = '';
			var isafterthink = false;
			var ishavethink = true;
			var buffer = '';
			var position = 0;
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 3 || xhr.readyState === 4) {
					var newData = xhr.responseText.substring(position);
					position = xhr.responseText.length;
					buffer += newData;
					var lines = buffer.split('\n');
					// 保留最后不完整行到缓冲区
					buffer = lines.pop() || '';
					for (var i = 0; i < lines.length; i++) {
						var line = lines[i];
						if (line.indexOf('data:') !== 0) continue;
						try {
							var jsonStr = line.replace('data:', '');
							var data = JSON.parse(jsonStr);
							if (data.dialogID) {
								_dialogID = data.dialogID;
							}
							if (data.answer) {
								if (data.answer.indexOf("<think>") !== -1) {
									if(_isShowThink){
										_cmp.closeAIthinking();
									}else{
										_cmp.closeResultLoading();
									}
									data.answer = data.answer.replace("<think>","");
								}
								// 能拿到nothinkflag 模型无思考过程 ishavethink = false
								if (data.answer.indexOf("nothinkflag") !== -1) {
									ishavethink = false;
									data.answer = data.answer.replace("nothinkflag","");
								}
								if (ishavethink) { // 有思考过程
									// 分离思考内容和指标结果
									if (data.answer.indexOf("</think>") !== -1) {
										// 读取到思考完成标识提示正在生成指标并输出
										output.text(result);
										isafterthink = true;
										if(_isShowThink){
											// Ext.lt.ui.loadingShow();
											_cmp.openResultLoading();
										}
									}
									if(isafterthink){// 加载指标数据到隐藏div以供解析
										hideindexobj += data.answer;
										airecoindexdiv.text(hideindexobj);
									}else{// 正常内容输出到思考格子
										result += data.answer
											.replace(/\n/g, '\n')
											.replace(/\t/g, ' ');
										output.text(result);
									}
									// 定位下拉滑块
									output.scrollTop( output.prop('scrollHeight') );
								} else{ // 无思考过程
									hideindexobj += data.answer;
									airecoindexdiv.text(hideindexobj);
								}
							}
						} catch (e) {
							console.info('解析失败:', e);
						}
					}
				}
				if (xhr.readyState === 4) {
					clearTimeout(timeoutTimer); // 请求完成时清除计时器
					if (xhr.status !== 200) {
						console.error('HTTP错误:', xhr.status);
					}
				}
			};
			xhr.onloadend = function() {
				// 处理思考过程段落和指标表格数据
				var content = output.text();
				output.text(content);
				var airecoindexcontent = airecoindexdiv.text();
				var _airecoindexarry = extractAndParseJSON(airecoindexcontent);
				airecoindextable.setDatas(_airecoindexarry);
				isendaiprocess = true;
				_cmp.saveresult(content,_airecoindexarry);
				clearTimeout(timeoutTimer);
				// Ext.lt.ui.loadingClose();
				_cmp.closeResultLoading();
				setTimeout(function(){
					Ext.lt.HTML.unmark();//关闭遮罩
				},100);
			};
			xhr.send(JSON.stringify({
				"api_code": _apicode,
				"api_key": _apikey,
				"message": _proaiprompt,
				"dialogID": _dialogID
			}));
		} catch (error) {
			output.textContent = '❌ 请求失败: ' + error.message;
			console.info(error);
			isendaiprocess = true;
			clearTimeout(timeoutTimer);
			// Ext.lt.ui.loadingClose();
			_cmp.closeResultLoading();
			Ext.lt.pmkpi.alert("智能指标推荐异常请尝试点击重新推荐！",function(){});
		}
	}
	return _cmp;

	/**
	 * 解析绩效指标的jsonstring 以```jsonstart开始，以```jsonend结束
	 * @param input 绩效指标jsonstring
	 * @returns {[]} 绩效指标array
	 */
	function extractAndParseJSON(input) {
		// 匹配以```jsonstart开始，以```jsonend结束的内容
		var regex = new RegExp("```jsonstart\\s*([\\s\\S]*?)\\s*```jsonend");
		var match = input.match(regex);
		if (!match) {
			// 匹配以```jsonstart开始，以```结束的内容
			var bakregex = new RegExp("```jsonstart\\s*([\\s\\S]*?)\\s*```");
			match = input.match(bakregex);
		}
		if (!match) {
			throw new Error('未找到JSON内容');
		}
		var jsonString = match[1].trim(); // 去除首尾空白
		try {
			var newindexlist = [];
			function removeChars(str, pattern) {
				return str.replace(pattern, '');
			}
			function isEqualAfterRemoval(str1, str2, pattern) {
				return removeChars(str1, pattern) === removeChars(str2, pattern);
			}
			var parsedJson = JSON.parse(jsonString);
			var parsedIndexArray = [];
			if (Object.prototype.toString.call(parsedJson) === '[object Array]') {
				parsedIndexArray = parsedJson;
			} else if (parsedJson !== null && typeof parsedJson === 'object') {
				parsedIndexArray = parsedJson['绩效指标'];
			}
			for(var i=0;i<parsedIndexArray.length;i++){
				indexobj= parsedIndexArray[i];
				for(var a=0; a<_curindmap.length; a++){
					var indname = _curindmap[a]["name"];
					var levelno = _curindmap[a]["levelno"];
					var findexname = (indexobj["一级指标"] || indexobj["一级绩效指标"]).trim();// 列名兼容
					if(levelno ==1 && findexname && isEqualAfterRemoval(indname,findexname,"指标")){
						indexobj["findexname"] = _curindmap[a]["name"];
						indexobj["findex"] = _curindmap[a]["code"];
						break;
					}
				}
				for(var b=0; b<_curindmap.length; b++){
					var indname = _curindmap[b]["name"];
					var levelno = _curindmap[b]["levelno"];
					var sindexname = (indexobj["二级指标"] || indexobj["二级绩效指标"]).trim();// 列名兼容
					if(levelno ==2 && isEqualAfterRemoval(indname,sindexname,"指标")){
						indexobj["sindexname"] = _curindmap[b]["name"];
						indexobj["sindex"] = _curindmap[b]["code"];
						break;
					}else if(levelno ==2 && indexobj["findex"] == "3" && sindexname && sindexname.indexOf("满意度") != -1){
						indexobj["sindexname"] = "服务对象满意度指标";
						indexobj["sindex"] = "31";
						break;
					}
				}
				indexobj["name"] = indexobj["指标名称"] || indexobj["三级指标"] || indexobj["三级指标名称"];// 列名兼容
				for(var c=0; c<_signs.length; c++){
					var signname = _signs[c]["name"];
					if(signname == (indexobj["计算符号"].replace(/=/g, '＝'))){
						indexobj["computesign"] = _signs[c]["code"];
						break;
					}
				}
				if(indexobj["computesign"] =='6'){
					indexobj["indexval"] = indexobj["指标值"];
				}else{
					indexobj["指标值"] = indexobj["指标值"] == "XX" ? 0 : indexobj["指标值"];
					// 定量指标截取指数字标值
					var matchResult = String(indexobj["指标值"] || "").match(/-?\d+\.?\d*/);
					indexobj["indexval"] = matchResult ? matchResult[0] : "";
				}
				indexobj["meterunit"] = indexobj["计量单位"];
				if(!!indexobj["findex"] && !!indexobj["sindex"]){ // 存在符合标准一级二级的指标加入推荐结果中
					newindexlist.push(indexobj);
				}
				indexobj["kpi_target"] = indexobj["绩效目标"];
				indexobj["ai_recoindexmark"] = indexobj["指标推荐标识"];
			}
			return newindexlist;
		} catch (e) {
			throw new Error('JSON解析失败: ' + e.message);
			isendaiprocess = true;
			// Ext.lt.ui.loadingClose();
			_cmp.closeResultLoading();
		}
	}

	// 添加ActiveXObject兼容方案
	function createXHR() {
		if (typeof XMLHttpRequest !== 'undefined') {
			return new XMLHttpRequest();
		} else if (typeof ActiveXObject !== 'undefined') {
			try {
				return new ActiveXObject("Msxml2.XMLHTTP.6.0");
			} catch(e1) {
				try {
					return new ActiveXObject("Msxml2.XMLHTTP.3.0");
				} catch(e2) {
					throw new Error("浏览器不支持XMLHttpRequest");
				}
			}
		}
	}

	/*
	// 解析ai返回信息markdown html
	function renderDifyMarkdown(answer){
		if (!answer) return '';
		// 1. 去掉 <think> 标签及其内容
		var content = (answer || '').replace(/<think>[\s\S]*?<\/think>/gi, '').trim();
		// 2. 用 marked 解析为 HTML（保留原始 HTML 标签）
		var html = marked.parse(content);
		return html;
		// 3. 外面包一层接近 Dify 的 markdown 容器
		// return '<span class="markdown-body ai-dify-markdown">'+html+'</span>';
	}*/
}