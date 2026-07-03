<%@page import="gov.mof.fasp2.buscore.framework.util.GlobalConfig"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	String time = "" + (new Date().getTime());

	String SYSTEM_STYLE = (String) request.getAttribute("SYSTEM_STYLE");
	String appidpath= (String)request.getAttribute("appidpath");
	String key_Allowed = "BUSCOMMON_UPLOAD_ALLOWEDTYPE";
	String key_warningmsg = "BUSCOMMON_UPLOAD_WARNING";
	String allowed = "null";
	String appid = null;

	if(appidpath!=null && !"".equals(appidpath)){
		appid = appidpath.substring(1,appidpath.length()).toUpperCase();
	}
	String warningmsg=gov.mof.fasp2.buscore.framework.util.GlobalConfig.getConfigDataWithSpecialAppId(key_warningmsg,appid,"");

	//取默认配置
	if("null".equals(allowed)){
		allowed = gov.mof.fasp2.buscore.framework.util.GlobalConfig
				.getConfigData(key_Allowed, "null");
	}
	String key_forbidden = "BUSCOMMON_UPLOAD_FROBIDDENTYPE";
	String forbidden = "null";
	if(appid!=null){
		forbidden = gov.mof.fasp2.buscore.framework.util.GlobalConfig
				.getConfigData(key_forbidden+"_"+appid, "null");
	}else{

	}
	//取默认配置
	if("null".equals(forbidden)){
		forbidden = gov.mof.fasp2.buscore.framework.util.GlobalConfig
				.getConfigData(key_forbidden, "null");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html>
<meta charset="UTF-8">
<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/frameworksupport.js?<%=GlobalConfig.getVersionYear()%>"></script>
<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/ltext_core.js?<%=GlobalConfig.getVersionYear()%>"></script>
<script type="text/javascript" src="<%=(String) request.getAttribute("appidpath")%>/busfw/ltext/jquery-3.7.1.min.js?<%=GlobalConfig.getVersionYear()%>"></script>
<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/common/ui/common.js?<%=GlobalConfig.getVersionYear()%>"></script>
<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/layui/layui.js?<%=GlobalConfig.getVersionYear()%>"></script>
<link rel="stylesheet" type="text/css" href="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/layui/css/layui.css?<%=GlobalConfig.getVersionYear()%>" />
<style>
	a, a:hover, input, input:checked {
		text-decoration: none;
		cursor: pointer;
		outline: none;
	}

	body, input {
		margin: 0px;
		padding: 0px;
	}

	* {
		font-family: 'MicrosoftYaHei';
	}

	.overflowH {
		overflow: hidden;
	}

	.TextCenter {
		text-align: center !important;
	}

	.form_100 {
		width: 100%;
		margin: 0px;
		box-sizing: border-box !important;
	}

	.mt10 {
		margin-top: 10px !important;
	}

	.mb10 {
		margin-bottom: 10px !important;
	}

	.mt20 {
		margin-top: 20px !important;
	}

	.mb20 {
		margin-bottom: 20px !important;
	}

	.Btn {
		display: inline-block;
		line-height: 36px;
		padding: 0px 12px;
		cursor: pointer;
		border-width: 1px;
		border-style: solid;
		font-size: 14px;
		border-radius: 2px;
	}

	.Btn_primary {
		color: #fff;
		background-color: #3571ea;
		border-color: #3571ea;
	}

	.PosR {
		position: relative;
	}

	.fl {
		float: left;
	}

	.fr {
		float: right;
	}

	.FilesBox {
		border-right: 1px solid #e4e4ea;
		border-top: 1px solid #e4e4ea;
		box-sizing: border-box !important;
	}

	.FilesBox .FilesLine {
		border-left: 1px solid #e4e4ea;
		border-bottom: 1px solid #e4e4ea;
		min-height: 32px;
		box-sizing: border-box;
		line-height: 40px;
	}

	.FileImgBox, .FileDel {
		width: 26px;
		height: 26px;
		margin: 7px 20px;
	}

	.FileImg, .FileDelImg {
		display: inline-block;
		width: 26px;
		height: 26px;
		background-repeat: no-repeat;
		background-position: center;
	}

	.FileImg {
		background-image: url(<%=( String) request.getAttribute("appidpath")%>/busfw/images/FileImg.png);
	}

	.FileDelImg {
		background-image: url(<%=( String) request.getAttribute("appidpath")%>/busfw/images/FileDelImg.png);
		cursor: pointer;
	}

	.FileName {
		margin-right: 54px;
		margin-left: 78px;
	}

	.FileName span {
		font-size: 14px;
		color: #808080;
	}

	.SelectBtn, .FileUpBtn {
		position: absolute;
		left: 0px;
		top: 0px;
		z-index: 1;
	}

	#SubminBtn {
		position: absolute;
		left: 0px;
		top: 0px;
		z-index: 9;
		width: 100%;
		height: 100%;
		cursor: pointer;
		background-color: transparent !important;
		color: transparent !important;
		border-color: transparent !important;
	}

	#FileBtn {
		position: absolute;
		left: 0px;
		top: 0px;
		z-index: 9;
		height: 100%;
		filter: Alpha(opacity = 0);
		background-color: transparent !important;
		color: transparent !important;
		border-color: transparent !important;
		width: 120px;
		opacity: 0;
	}

	#FileBtnIE9 {
		position: absolute;
		left: -131px;
		top: 0px;
		z-index: 9;
		height: 100%;
		cursor: pointer;
		filter: Alpha(opacity = 100);
		width: 100%;
		opacity: 1;
	}

	#UpFileBox .FileUpBtn {
		width: 120px;
		text-align: center;
		font-size: 14px;
		box-sizing: border-box !important;
	}

	.FileUpBtnBox {
		height: 36px;
		margin-right: 10px;
	}
</style>
</head>
<body>
<div id="UpFileBox">
	<div class="PosR mt20 FileUpBtnBox overflowH" id="mainupload">
			<span id="SelectBtn" class="Btn Btn_primary FileUpBtn SelectBtn"
				  style="cursor: pointer">选择文件...</span> <input id="FileBtn"
																	type="file" name="uploadfiles"
																	style="filter: Alpha(opacity = 0); opacity: 0;"
																	contenteditable="false" onchange="fileselected(this);" />
	</div>
	<div class="FilesBox mt10">
		<form id="uploadfileform" name="uploadfileform" method="post"
			  ENCTYPE="multipart/form-data" action="aaa">
			<div id="uploadlistdiv">
			</div>
			<div class="TextCenter FilesLine" id="uploadbutton">
			</div>
		</form>
	</div>
</div>
<table id="uploadtable" border="1px">
</body>

<script type="text/javascript">
	parent.uploadready();
	var filetype = parent.fudsupload.file_types;
	if (filetype != "*.*") {
		while (filetype.indexOf("*") > -1) {
			filetype = filetype.replace("*", "");
		}
	}
	var trs = 0;
	function fileselected(inpupobj) {
		var filename = getFileName(inpupobj);
		if (filename != null) {
			if(filevalid(filename)){
				if (parent.canAddFile(trs + 1)) {
					var size = getFileSize(inpupobj);
					if(size==0){
						alert(filename + "为空文件，不允许上传空文件,请重新选择文件上传!");
						inpupobj.outerHTML = inpupobj.outerHTML;
						return;
					}else{
						addfile(filename, inpupobj);
					}
				} else {
					inpupobj.outerHTML = inpupobj.outerHTML;
					alert("无法选择更多文件，一次最多上传" + parent.fudsupload.file_upload_limit + "个文件!");
				}
			}else{
				inpupobj.outerHTML = inpupobj.outerHTML;
			}
		}
	}
	function getFileSize(inpupobj) {
		if (inpupobj.files != null && inpupobj.files.length > 0) {
			return inpupobj.files[0].size;

		}
		return 0;
	}

	function getFileName(inpupobj) {
		if (inpupobj.files != null && inpupobj.files.length > 0) {
			return inpupobj.files[0].name;

		} else {
			if (fileName(inpupobj) != null) {
				return fileName(inpupobj);
			}
		}
	}

	function addfile(filename, inpupobj) {
		var inputid = "fileinput" + trs + "";
		var showfilename =filename;
		if(filename.length>25){
			showfilename = filename.substring(0,25)+".....";
		}
		var html = '';
		html += '<div class="form_100 overflowH FilesLine">';
		html += '<div class="FileImgBox fl">';
		html += '<span class="FileImg"></span>';
		html += '</div>';
		html += '<div class="FileDel fr">';
		html += '<span class="FileDelImg" title="删除" onclick="removefile(this)"></span>';
		html += '</div>';
		html += '<div class="FileName"';
		html += ' id="';
		html += inputid;
		html += '">';
		html += '<span title="';
		html += filename;
		html += '">';
		html += showfilename;
		html += '</span>';
		html += '</div>';
		html += '</div>';
		$("#uploadlistdiv").append(html);
		trs++;
		parent.updateHeight(trs);
		inpupobj.style.display = "none";
		$("#" + inputid).append(inpupobj);
		reDrawMain();
	}

	function reDrawMain() {
		var obj = document.getElementById("mainupload");
		obj.innerHTML = ""; //删除div内容
		var html = "";
		var width = obj.offsetWidth;
		var warningmsg = "<%=warningmsg %>";
		if(!!!!width){
			if(!!!!warningmsg){
				if(warningmsg.length>40){
					warningmsg = warningmsg.substring(0,40)+"<br>"+warningmsg.substring(40,warningmsg.length);
				}
			}
		}
		if (!isIE9()) {
			html = '<span id="SelectBtn" class="Btn Btn_primary FileUpBtn SelectBtn">双击选择文件</span>' +
					'<input id="FileBtn" type="file" name="uploadfiles" onchange="fileselected(this);" contenteditable="false" accept="' + filetype + '"'+
					"<span><font style='color: red;height: 36px;margin-left: 138px;font-size: 13px;display:block;'>"+warningmsg+"</font> </span>";
		} else {
			html = '<input id="FileBtnIE9" type="file" name="uploadfiles" onchange="fileselected(this);" contenteditable="false" accept="' + filetype + '"';
			html += '';
			obj.style.overflow = "visible";
		}
		html += '</>';
		obj.innerHTML = html;

	}

	function removefile(span) {
		span.parentNode.parentNode.parentNode.removeChild(span.parentNode.parentNode);
		trs--;
		parent.updateHeight(trs);
	}


	var uploading = false;

	function uploadall() {
		if (uploading) {
			alert("正在上传，请稍后再点击!");
			return;
		}
		//检测是否都选了文件
		var uploadfiles = document.getElementsByName("uploadfiles");
		var totalfiles = 0;
		var files = [];
		for (i = 0; i < uploadfiles.length; i++) {
			var tmpfile = uploadfiles[i];
			if (tmpfile.files != null){
				totalfiles += tmpfile.files.length;
				for (j = 0; j < tmpfile.files.length; j++) {
					//alert(tmpfile.files[j].name+"---"+tmpfile.files[j].size);
					//检测文件大小是否超过设置最大值
					var filename = getFileName(tmpfile);
					//检测文件名是否违规
					if (!filevalid(filename)) {
						tmpfile.outerHTML = tmpfile.outerHTML;
						return;
					}
					files.push(tmpfile.files[j]);
				}
			} else { //ie9情况
				if (tmpfile.value != "") {
					var filename = fileName(tmpfile);
					if (!filevalid(filename)) {
						tmpfile.outerHTML = tmpfile.outerHTML;
						return;
					}
					totalfiles++;
				}
			}
		}
		if (totalfiles == 0) {
			alert("没有选择上传的文件!");
		} else {
			uploading = true;
			try{
				if(files.length>0){
					upload(files);
					return;
				}
			}catch(err){
				if(console && console.log)console.log(err);
			}
			document.getElementById("uploadfileform").submit();
		}

	}

	var uploadtime = 0;
	var uploadlayer = null;
	var loadedsize = 0;
	// 文件上传
	function upload(files) {
		window.parent.layui.use(['layer','element'], function(){
			uploadlayer = window.parent.layui.layer.open({
				type: 1
				,title: false //不显示标题栏
				,closeBtn: false
				,btn: false
				,area: ['500px', '76px']
				,shade: 0.8
				,id: 'LAY_layuipro' //设定一个id，防止重复弹出
				,moveType: 1 //拖拽模式，0或者1
				,content: '<div style="padding: 25px;height:26px; line-height: 22px; background-color: #393D49; color: #fff; font-weight: 300;"><div class="layui-progress layui-progress-big" lay-showpercent="true" lay-filter="demo"><div class="layui-progress-bar layui-bg-green" lay-percent="0%"><span class="layui-progress-text"></span></div> </div></div>'
				,success: function(layero){
				}
			});
		});

		uploadtime = 0;
		loadedsize = 0;
		var formData = new FormData();
		var url = parent.Ext.lt.token.urlAddToken(parent._ROOT_PATH_ + parent._APPID_PATH_ + "/buscommon/v1/file/upload");
		files.forEach(function (file) {
			formData.append("upFile", file);
		});
		uploadtime = (new Date()).getTime();
		$.ajax({
			url : url, //"/file/upload",
			type : "POST",
			data : formData,
			processData : false, // 告诉jQuery不要去处理发送的数据
			contentType : false, // 告诉jQuery不要去设置Content-Type请求头
			success : function(result) {
				if(console && console.log)console.log(result);
				if(result.success){
					var data = result.data;
					var fileguids = [], filenames = [];
					data.forEach(function (fileobj) {
						fileguids.push(fileobj.fileguid);
						filenames.push(fileobj.filename);
					});
					window.parent.layer.close(uploadlayer);
					window.parent.uploadsuccess(fileguids.join(","), filenames.join(","));
					window.location.reload();
				}else{
					var msg = result.message;
					window.parent.layer.alert("上传失败:"+msg);
					window.parent.layer.close(uploadlayer);
					window.location.reload();
				}
			},
			xhr : function() {
				var xhr = $.ajaxSettings.xhr();
				// xhr.upload专用于上传事件监听
				if (xhr.upload) {
					//处理进度条的事件
					xhr.upload.addEventListener("progress", progressHandle,
							false);
					//加载完成的事件
					xhr.addEventListener("load", uploadSuccess, false);
					//加载出错的事件
					xhr.addEventListener("error", uploadFail, false);
					return xhr;
				}
			}
		});
	}
	//进度条更新
	function progressHandle(e) {
		loadedsize = e.loaded;
		var percent = (e.loaded / (e.total*2) * 100).toFixed(2);
		if(console && console.log)console.log(e.loaded+" / "+e.total+" = "+percent + "%");
		window.parent.layui.element.progress('demo', percent+'%');
		if(e.loaded == e.total){
			uploadtime = (new Date()).getTime() - uploadtime + 1000;
			var percent = 50, timer = setInterval(function(){
				percent += 1;
				if(percent>100){
					percent = 100;
					clearInterval(timer);
				}
				window.parent.layui.element.progress('demo', percent+'%');
			}, (uploadtime/50).toFixed(0));
		}
	};
	//上传完成处理函数
	function uploadSuccess(e) {
		//alert("上传完成");
	};
	//上传出错处理函数
	function uploadFail(e) {
		if(console && console.log)console.log(e);
		var msg = "";
		if(loadedsize>0){
			msg = ",错识原因可能是上传的单个文件大小或总大小超过允许上传的最大值！\n 改上传单个小文件，如果还上传不了，请联系系统管理员。";
		}
		window.parent.layer.alert("上传失败"+msg);
		window.parent.layer.close(uploadlayer);
		uploading = false;
	};


	parent.updateHeight(trs);
	var allowedtype= "<%=appidpath%>";
	var allowedtype= "<%=allowed%>";
	var forbiddentype= "<%=forbidden%>";

	//检测文件名是否违规
	function filevalid(filename) {
		//如果有allowedtype，只验证允许类型就可以
		if("null"!=allowedtype && ""!=allowedtype){
			var alloweds = allowedtype.split(",");
			for(var i=0;i<alloweds.length;i++){
				if(filename.indexOf("."+alloweds[i]) > 0){
					return true;
				}
			}
			window.parent.layer.alert("只允许上传为"+allowedtype+"类型的文件,请检查上传文件!");
			return false;
		}
		if("null"==forbiddentype){
			//forbiddentype="exe,jsp,php,asp,js,jar,cmd,bat,sh";
			forbiddentype="exe,jsp,php,asp,js,cmd,bat,sh";
		}
		var forbiddens = forbiddentype.split(",");
		for(var i=0;i<forbiddens.length;i++){
			if(filename.indexOf("."+forbiddens[i]) > 0){
				window.parent.layer.alert("不允许上传为"+forbiddens+"类型的文件,请检查上传文件!");
				return false;
			}
		}
		return true;
	}
	window.onload = function() {
		var obj = document.getElementById("uploadbutton");
		var html = '';
		if (false) {
			html += '<div class="PosR FileUpBtnBox mt20 mb20" style="display:inline-block;">';
			html += '<div class="Btn Btn_primary FileUpBtn">上传</div>';
			html += '<input type="submit" id="SubminBtn" value="">';
			html += '</div>';
		} else {
			html += '<div class="PosR FileUpBtnBox mt20 mb20" style="display:inline-block;">';
			html += '<div class="Btn Btn_primary FileUpBtn"  onclick="uploadall();">上传</div>';
			html += '</div>';
			html += '</div>';
		}
		obj.innerHTML = html;
		reDrawMain();

	}
	function closeWin() {

		if (navigator.userAgent.indexOf('MSIE') > 0) { // close IE
			if (navigator.userAgent.indexOf('MSIE 6.0') > 0) {
				window.opener = null;
				window.close();
			} else {
				window.open('', '_top');
				window.top.close();
			}
		} else { // close chrome;It is effective when it is only one.
			window.opener = null;
			window.open('', '_self');
			window.close();
		}
		window.parent.parent.Ext.lt.ui.closeModalWindow();
	}
	function fileName(inpupobj) {
		var long = inpupobj.value;
		//扩展名的文件名
		var pos = long.lastIndexOf("\\");
		var aaa = long.substring(pos + 1);
		//扩展名
		var bbb = aaa.lastIndexOf(".");
		var ccc = aaa.substring(bbb + 1);
		//文件名
		var strFileName = long.replace(/^.+?\\([^\\]+?)(\.[^\.\\]*?)?$/gi, "$1");
		//alert(strFileName);
		//alert("扩展名:" + ccc + " " + ",文件名:" + strFileName + " " + ",扩展名的文件名:" + aaa);
		return aaa;
	}
	function isIE9() {
		if (getIEVersion() == 'undefined')
			return false;
		if (getIEVersion() == 9) {
			return true;
		}
		return false;
	}
	function getIEVersion() {
		var ua = navigator.userAgent;
		var ver = 100;
		if (ua) {
			if (ua.match(/MSIE\s+([\d]+)\./i)) {
				ver = RegExp.$1;
			} else if (ua.match(/Trident.*rv\s*:\s*([\d]+)\./i)) {
				ver = RegExp.$1;
			}
		}
		return parseInt(ver);
	}
</script>

</html>