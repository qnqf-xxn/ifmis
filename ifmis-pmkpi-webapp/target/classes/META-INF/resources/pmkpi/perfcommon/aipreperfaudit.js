if(!Ext.lt.pmkpi)
	Ext.lt.pmkpi = {};
/**
 * 初始化加载.
 */
var isendaiprocess = false; // 单次ai会话是否完成
Ext.lt.pmkpi.aipreperfaudit = function(config, serviceid) {
	var perfcommon = Ext.lt.pmkpi.perfcommon(config, serviceid);
	var _proaiprompt = ""; // 项目信息ai提示词
	var _proinfo = {}; // 项目信息
	var _procode = config.pro_code; // 项目编码
	var _apikey = config["apikey"]; // apikey
	var _apicode = config["apicode"]!= null ? config["apicode"] : "PMKPI_AIPREPERFAUDIT"; // apicode 默认 PMKPI_AIPREPERFAUDIT
	var _cmp = {};
	var _dialogID = "";
	var _isLoadTaskData = config["isLoadTaskData"];
	var _timeout_ms = config["timeout_ms"] ? config["timeout_ms"] : 300000;
	var _isHuBei = config.isHuBei;
	var _currentprovince = config.province;
	var _currentyear = config.year;
	var _isYANSHI = config.isYANSHI;
	var _isautosave = config.isautosave;

	/**
	 * 页面加载完成
	 */
	$(function() {
		_cmp.initDivs();
		_cmp.openResultLoading();
		_cmp.getAIprompt()
			.then(function() {
				console.log('_proaiprompt:', _proaiprompt);
				_cmp.setTableTitle();
				if(_isLoadTaskData == "1"){
					perfcommon.changTooltoolbuttontStatus(0,",保存结果记录"); // 查询记录隐藏保存按钮
					_cmp.loadTaskDatas(false);
				}else{
					_cmp.loadTaskDatas(true);
				}
			})
			.catch(function(error) {
				console.error('获取AI提示词失败:', error);
			});
	})

	/**
	 * 获取后台项目信息拼接提示词 根据pro_code
	 */
	_cmp.getAIprompt = function() {
		return new Promise(function(resolve, reject) {
			try {
				var params = {};
				params.pro_code = _procode;
				Ext.lt.RCP.call(serviceid, "getProPrompt", params,
					function (rs) {
						if(rs.success){
							_proaiprompt = rs.aiprompt;
							_proinfo = rs.proinfo;
							if(_proinfo.indi_count == 0){
								Ext.lt.pmkpi.alert("该项目没有总体绩效信息，无法审核！",function(){
									reject(new Error("该项目没有总体绩效信息，无法审核！"));
									_cmp.closewin();
								});
							}else{
								resolve(rs.aiprompt);
							}
						} else {
							reject(new Error(rs.error));
						}
					},
					function () {
						reject(new Error('查询失败'));
					}
				);
			} catch (error) {
				console.error('请求失败:', error);
				reject(error);
			}
		});
	};

	/**
	 * 初始化div元素和表格对象
	 */
	_cmp.initDivs = function (){
		perfcommon.editSetdisabled(editform);
		if ($("#airecoindexjosn").length === 0) {
			$(".bd_main").append('<div id="airecoindexjosn" style="display: none;"></div>');
		}
		$(".bd_main").css({'overflow':'hidden','margin-left':'15px'});
	}

	/**
	 * 获取任务加载数据
	 * @param isopenAIprogress 是否开启AI进程
	 */
	_cmp.loadTaskDatas = function (isopenAIprocess){
		_cmp.updateResultLoadingText("正在查询智能审核结果");
		var params = {};
		params.pro_code = _procode;
		Ext.lt.RCP.call(serviceid , "getAuditData", params, function(rs){
			var audit_data = rs.data;
			if(!audit_data){
				if(isopenAIprocess){
					Ext.lt.HTML.mark();
					_cmp.AIstart();
				}else{
					Ext.lt.pmkpi.alert("该项目还未进行智能审核",function(){
						_cmp.closewin();
					});
				}
			}else{
				editform.synchEditformByObj(audit_data);
				_cmp.closeResultLoading();
				_cmp.setAuditTimeShow();
				isendaiprocess = true;
			}
		},function(){
			_cmp.closeResultLoading();
			Ext.lt.ui.alert('查询失败！',function(){
				_cmp.closewin();
			});
		});
	}

	/**
	 * 显示审核时间
	 */
	_cmp.setAuditTimeShow = function (){
		var data = editform.getEditFormValues();
		var timeStr;
		if(!!data && !!data.create_time){
			var auditTime = data.create_time; //格式 20260413163900
			if (!/^\d{14}$/.test(auditTime)) {
				timeStr = "";
			}else{
				timeStr = '审核时间: ' + auditTime.slice(0,4) + '-' + auditTime.slice(4,6) + '-' + auditTime.slice(6,8) + ' ' + auditTime.slice(8,10) + ':' + auditTime.slice(10,12) + ':' + auditTime.slice(12,14);
			}
		}else{
			var now = new Date();
			function padZero(num) {
				return num < 10 ? '0' + num : '' + num;
			}
			timeStr = '审核时间: ' + now.getFullYear() + '-' + padZero(now.getMonth() + 1) + '-' + padZero(now.getDate())
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

	/**
	 * 设置表头为项目信息
	 */
	_cmp.setTableTitle = function(){
		var tabletitlestr = "项目编码："+_proinfo.pro_code+" | 项目名称："+_proinfo.pro_name+" | 单位名称："+_proinfo.agency_name;
		$("#editform .edittitle div").text(tabletitlestr);
		$("#editform .edittitle div").attr('title',tabletitlestr);
		$("#editform .edittitle div").css({'width':'96%','white-space': 'nowrap','overflow':'hidden','text-overflow':'ellipsis'});
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
	_cmp.reaudit = function(){
		if(isendaiprocess){
			Ext.lt.ui.confirm("已经存在智能审核结果，是否重新生成?",{icon:"warn"},function(ret){
				if(ret){
					_cmp.openResultLoading();
					_cmp.AIstart();
				}
			});
		}else {
			Ext.lt.pmkpi.alert("智能审核处理中，请耐心等待！",function(){});
		}
	}

	/**
	 * 保存辅助审核结果
	 * @param _airecoindexarry 结果array
	 */
	_cmp.saveresult = function(_audit_data){
		Ext.lt.ui.loadingShow();
		var params = {};
		params.proinfo = _proinfo;
		params.datas = _audit_data ? _audit_data : editform.getEditFormValues();
		Ext.lt.RCP.call(serviceid, "saveNewAISupportAuditDatas", params, function (rs) {
			Ext.lt.ui.loadingClose();
			if(rs.success){
				if(_isautosave != "1"){
					Ext.lt.pmkpi.alert('保存辅助审核结果成功！', function () {
					});
				}
			}else {
				Ext.lt.ui.alert(rs.error,function(){});
			}
		}, function () {
			Ext.lt.ui.loadingClose();
			Ext.lt.pmkpi.alert('保存辅助审核结果失败！', function () {
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
			url = '/ifmisLLM/chat/1.0.0.0/rendQStream?user_code=admin';
		}
		var airecoindexdiv = $("#airecoindexjosn");
		// 清空是靠过程显示区、列表json缓存区、列表
		airecoindexdiv.text('');
		editform.synchEditformByObj({});
		try {
			var xhr = createXHR();
			var timeoutTimer = setTimeout(function() {
				xhr.abort(); // 终止请求
				// Ext.lt.ui.loadingClose();
				_cmp.closeResultLoading();
				Ext.lt.pmkpi.alert("资源不足，请稍后重试！",function(){
					_cmp.closewin();
				});
			}, _timeout_ms); // 5分钟超时（300000毫秒）
			xhr.open('POST', url, true);
			xhr.setRequestHeader('Content-Type', 'application/json');
			xhr.setRequestHeader('accept', 'application/json, text/plain, */*');
			// Ext.lt.ui.loadingShow();
			isendaiprocess = false;
			_cmp.updateResultLoadingText("正在进行智能审核");
			var hideindexobj = '';
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
							var jsonStr = line.replace('data:', '').replace("<think>","");
							var data = JSON.parse(jsonStr);
							if (data.dialogID) {
								_dialogID = data.dialogID;
							}
							if (data.answer) {
								hideindexobj += data.answer;
								airecoindexdiv.text(hideindexobj);
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
				var airecoindexcontent = airecoindexdiv.text();
				var audit_data = extractAndParseJSON(airecoindexcontent);
				editform.synchEditformByObj(audit_data);
				isendaiprocess = true;
				if(_isautosave == "1"){
					_cmp.saveresult(audit_data);
				}
				clearTimeout(timeoutTimer);
				_cmp.closeResultLoading();
				_cmp.setAuditTimeShow();
				// Ext.lt.ui.loadingClose();
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
			Ext.lt.pmkpi.alert("智能辅助审核异常请尝试点击重新加载！",function(){});
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
			htmlArr.push("'>正在获取项目信息和读取报告内容</div>");

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

	return _cmp;

	/**
	 * 解析jsonstring 以'``jsonstart开始，以```jsonend结束
	 * @param input jsonstring
	 * @returns {[]} array
	 */
	function extractAndParseJSON(input) {
		var jsonString = input.trim(); // 去除首尾空白
		try {
			var newresultmap = {};
			var parsedJson = JSON.parse(jsonString);
			var parsedIndexArray = []; // 审核结果集合
			if (Object.prototype.toString.call(parsedJson) === '[object Array]') {
				parsedIndexArray = parsedJson;
			}
			if (parsedIndexArray.length>0) {
				for(var i=0;i<parsedIndexArray.length;i++){
					indexobj= parsedIndexArray[i];
					indexobj["conclusion"] = indexobj["conclusion"];
					indexobj["reportproblem"] = indexobj["reportProblem"];
					indexobj["indicator"] = indexobj["indicator"];
					newresultmap = indexobj;
				}
			}else{
				newresultmap["conclusion"] = parsedJson["conclusion"];
				newresultmap["reportproblem"] = parsedJson["reportProblem"];
				newresultmap["indicator"] = parsedJson["indicator"];
			}

			return newresultmap;
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
