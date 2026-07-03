if(!Ext.lt.pmkpi)
	Ext.lt.pmkpi = {};
/**
 * 初始化加载.
 */
var isendaiprocess = false; // 单次ai会话是否完成
Ext.lt.pmkpi.aisupportaudit = function(config, serviceid) {
	var perfcommon = Ext.lt.pmkpi.perfcommon(config, serviceid);
	var _proaiprompt = ""; // 项目信息ai提示词
	var _proaipromptlist = []; // 项目信息ai提示词
	var _apikey = config["apikey"]; // apikey
	var _apicode = config["apicode"]!= null ? config["apicode"] : "PMKPI_AISUPPORTAUDIT"; // apicode 默认 PMKPI_AISUPPORTAUDIT
	var _cmp = {};
	var _dialogID = "";
	var _isShowThink = config["isShowThink"];
	var _isLoadTaskData = config["isLoadTaskData"];
	var _timeout_ms = config["timeout_ms"] ? config["timeout_ms"] : 300000;
	// 加载任务数据时默认隐藏思考过程
	_isShowThink = _isLoadTaskData == "1" ? false : _isShowThink;
	// 宽高取整避免子窗体加载异常
	var height = Math.floor(document.documentElement.clientHeight * 0.9);
	var width =  Math.floor(document.documentElement.clientWidth * 0.9);
	var _auditpointmap = {};
	var _isHuBei = config.isHuBei;
	var _currentprovince = config.province;
	var _currentyear = config.year;
	var _isYANSHI = config.isYANSHI;
	var _loadingtips = config.loadingtips == null ? "正在思考中" : config.loadingtips;

	/**
	 * 页面加载完成
	 */
	$(function() {
		_cmp.initDivs();
		if(_isLoadTaskData == "1"){
			perfcommon.changTooltoolbuttontStatus(0,",保存结果记录"); // 查询记录隐藏保存按钮
			_cmp.loadTaskDatas();
		}else{
			queryform.hide();// 实时AI模式隐藏查询区
			_cmp.getauditpointmap();
			_cmp.getProDataPrompt();
		}
	})

	Ext.lt.message.hook("queryform", "doquery",function(obj){
		_cmp.loadTaskDatas();
	});

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
		// 设置思考过程区域样式
		output.css({
			'font-family': 'Microsoft YaHei',
			'font-weight': '400',
			'font-size': '14px',
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
		if(_isShowThink){
			$(".tpl_right").css({'width':width*0.6+'px','left':(width*0.38)+'px'});
			datatable.resize((width*0.55),height);
		}else{
			output.hide();
			$(".tpl_right").css({'width':(width*0.9)+'px','left':'10px'});
			datatable.resize((width*0.9),height);
		}
		window.parent.indexwindow = window;
		perfcommon.initDatatable(datatable);
		if ($("#airecoindexjosn").length === 0) {
			$(".bd_main").append('<div id="airecoindexjosn" style="display: none;"></div>');
		}
		$(".bd_main").css({'overflow':'hidden','margin-left':'15px'});
	}
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
			htmlArr.push("<div id='ailoadingtext' style='");
			htmlArr.push("margin-top: 10px;");     // 文字与图片间距
			htmlArr.push("font-size: 15px;");      // 字体大小
			htmlArr.push("color: #333;");          // 字体颜色
			htmlArr.push("font-weight: 500;");     // 字体粗细
			htmlArr.push("text-align: center;");   // 文字居中
			htmlArr.push("padding: 0 10px;");      // 左右内边距
			htmlArr.push("box-sizing: border-box;"); // 包含内边距在宽度内
			htmlArr.push("'>正在进行智能审核</div>");

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
	 * 获取审核要点解析名
	 */
	_cmp.getauditpointmap = function(){
		var cols = datatable.getCols();
		for (var i = 0, len = cols.length; i < len; i++) {
			var col = cols[i];
			if (!!col.colcode && col.colcode.indexOf("auditpoint") === 0) {
				_auditpointmap[col.colcode] = col.alias;
			}
		}
	}
	/**
	 * 获取任务加载数据
	 */
	_cmp.loadTaskDatas = function (){
		Ext.lt.ui.loadingShow();
		var params = {};
		params.queryConfig = queryform.getQueryParam();
		var querySql = queryform.getQuerySQL();
		params.querySql = querySql;
		params.datas = parent.datatable.getSelected();
		params.beanid = "pmkpi.aisupportaudit.AISupportAuditBOTX";
		Ext.lt.bus.exportBeanid = params.beanid;
		datatable.queryData(params,function(){
			Ext.lt.ui.loadingClose();
		});
	}
	/**
	 * 获取项目信息拼接提示词
	 */
	_cmp.getProDataPrompt = function (){
		var seldatas = parent.datatable.getSelected();
		if (seldatas.size() <= 0) {
			Ext.lt.ui.alert('请选择项目！',function(){
				parent.Ext.lt.ui.modalWindow.close();
			});
		}
		// Ext.lt.ui.loadingShow();
		if(_isShowThink){
			_cmp.openAIthinking();
		}else{
			_cmp.openResultLoading();
		}
		var params = {};
		params.datas = seldatas;
		Ext.lt.RCP.call(serviceid, "getProPrompt", params, function (rs) {
			Ext.lt.ui.loadingClose();
			if(rs.success){
				if(rs.aiprompt){
					_proaiprompt = rs.aiprompt;
					_proaipromptlist = rs.aipromptList;
					_cmp.AIstart();
				}
			}else {
				parent.Ext.lt.ui.modalWindow.close();
				parent.Ext.lt.ui.alert(rs.error,function(){});
			}
		}, function () {
			Ext.lt.ui.loadingClose();
			Ext.lt.ui.alert('获取项目信息失败！', function () {
			});
		});
	}
	/**
	 * 关闭
	 * @param obj
	 */
	_cmp.closewin = function(obj){
		parent.Ext.lt.ui.modalWindow.close();
	}

	/**
	 * 重新加载
	 */
	_cmp.query = function(){
		if(isendaiprocess){
			Ext.lt.ui.confirm("清空并重新加载分析，请确认?",{icon:"warn"},function(ret){
				if(ret){
					_cmp.AIrecoindex();
				}
			});
		}else {
			Ext.lt.ui.alert("智能辅助审核处理中，请耐心等待！",function(){});
		}

	}

	/**
	 * 保存辅助审核结果
	 */
	_cmp.saveresult = function(){
		Ext.lt.ui.loadingShow();
		var params = {};
		params.prompt = _proaiprompt;
		params.aipromptList = _proaipromptlist;
		params.thinkingprocess = $("#airecoindexcontent").text();
		params.datas = datatable.getRecordset().toArray()
		Ext.lt.RCP.call(serviceid, "saveNewAISupportAuditDatas", params, function (rs) {
			Ext.lt.ui.loadingClose();
			if(rs.success){
				Ext.lt.ui.alert('保存辅助审核结果成功！', function () {
				});
			}else {
				Ext.lt.ui.alert(rs.error,function(){});
			}
		}, function () {
			Ext.lt.ui.loadingClose();
			Ext.lt.ui.alert('保存辅助审核结果失败！', function () {
			});
		});
	}

	/**
	 * AI指标推荐加载
	 */
	_cmp.AIstart = function () {
		var url = '/ifmisLLM/chat/1.0.0.0/rendQStream?tokenid=' + Ext.lt.token.getTokenid() + Ext.lt.token.getAuthorization();
		if(_isHuBei){
			url = '/hbifmisLLM/chat/1.0.0.0/rendQStream?user_code=admin&province='+_currentprovince+'&year='+_currentyear;
		}
		if(_isYANSHI){
			url = '/ifmisLLM/chat/1.0.0.0/rendQStream?usercode=admin';
		}
		var output = $("#airecoindexcontent");
		var airecoindexdiv = $("#airecoindexjosn");
		// 清空是靠过程显示区、列表json缓存区、列表
		output.text('');
		airecoindexdiv.text('');
		datatable.setDatas([]);
		try {
			var xhr = createXHR();
			var timeoutTimer = setTimeout(function() {
				xhr.abort(); // 终止请求
				// Ext.lt.ui.loadingClose();
				if(_isShowThink){
					_cmp.closeAIthinking();
				}else{
					_cmp.closeResultLoading();
				}
				Ext.lt.ui.alert("资源不足，请稍后重试！",function(){
					_cmp.closewin();
				});
			}, _timeout_ms); // 5分钟超时（300000毫秒）
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
										result += "\n⏳ 正在深度思考中...";
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
									output.text("⏳ 正在深度思考生成指标...");
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
				var content = output.text().replace("⏳ 正在深度思考中...","")
				output.text(content);
				var airecoindexcontent = airecoindexdiv.text();
				var _airecoindexarry = extractAndParseJSON(airecoindexcontent);
				datatable.setDatas(_airecoindexarry);
				datatable.config.pagenum = "";// 实时隐藏分页
				isendaiprocess = true;
				clearTimeout(timeoutTimer);
				// Ext.lt.ui.loadingClose();
				_cmp.closeResultLoading();
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
			clearTimeout(timeoutTimer);
			// Ext.lt.ui.loadingClose();
			_cmp.closeResultLoading();
			Ext.lt.ui.alert("智能辅助审核异常请尝试点击重新加载！",function(){});
		}
	}

	/**
	 * 选中数据导出列表xls，未选中则默认选中全部数据导出
	 * @param obj
	 */
	_cmp.expxls = function (obj){
		var selecteddatas = datatable.getSelected();
		if (selecteddatas.length <= 0) {
			var alltabledata = datatable.getRecordSet().toArray();
			for (var i = 0; i < alltabledata.length; i++) {
				var insData = alltabledata[i];
				insData.check = 1;
			}
			datatable.redraw();
		}
		Ext.lt.pmkpi.expdata(obj);
	}

	return _cmp;

	/**
	 * 解析jsonstring 以'``jsonstart开始，以```jsonend结束
	 * @param input jsonstring
	 * @returns {[]} array
	 */
	function extractAndParseJSON(input) {
		// 匹配以```jsonstart开始，以```jsonend结束的内容
		var regex = /```jsonstart\s*([\s\S]*?)\s*```jsonend/;
		var match = input.match(regex);
		if (!match) {
			// 匹配以```jsonstart开始，以```结束的内容
			var bakregex = /```jsonstart\s*([\s\S]*?)\s*```/;
			match = input.match(bakregex);
		}
		if (!match) {
			throw new Error('未找到JSON内容');
		}
		var jsonString = match[1].trim(); // 去除首尾空白
		try {
			var newindexlist = [];
			var parsedJson = JSON.parse(jsonString);
			var parsedIndexArray = [];
			if (Array.isArray(parsedJson)) {
				parsedIndexArray = parsedJson;
			}
			for(var i=0;i<parsedIndexArray.length;i++){
				indexobj= parsedIndexArray[i];
				indexobj["agency_code"] = indexobj["单位编码"];
				indexobj["agency_name"] = indexobj["单位名称"];
				indexobj["pro_code"] = indexobj["项目编码"];
				indexobj["pro_name"] = indexobj["项目名称"];
				for(var auditpointkey in _auditpointmap){// 审核要点解析，根据配置列名解析
					indexobj[auditpointkey] = indexobj[_auditpointmap[auditpointkey]];
				}
				newindexlist.push(indexobj);
			}
			return newindexlist;
		} catch (e) {
			throw new Error('JSON解析失败: ' + e.message);
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

}