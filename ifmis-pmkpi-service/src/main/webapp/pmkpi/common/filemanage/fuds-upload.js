if (Ext.lt.console == null) {
	Ext.lt.console = {};
}
if (Ext.lt.console.component == null) {
	Ext.lt.console.component = {};
}
var filecount=0;
// Ext.lt.console.component.fileuploadtitle = null;
var fudsupload = null;
var uploadhtmlhtml=false;
var defalutheight= 150;

Ext.lt.FUDSUpload = function() {
	fudsupload = {
		fileguid:null,
		filename:null,
		fudsPath:null,
		showUploadButton:true,
		basePath:null,
		appid:null,
		drawDivId:null,
		drawobj:null,
		showMark:null,
		successcallbackfn:null,
		failcallbackfn:null,
		userid:null,
		file_types : "*.*",
		file_upload_limit : 3
	};

	function initdraw(){
		uploadhtmlhtml=false;
		fudsupload.drawobj.style.height=defalutheight+"px";
		var html = [];
		var htmuploadjsppath =Ext.lt.token.urlAddToken(_ROOT_PATH_+_APPID_PATH_+'/common/filemanage/htmlupload.jsp')+Ext.lt.token.getAuthorization();
		html.push('<iframe name="uploadframe" id="uploadframe" width="100%" height="100%" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" src="'+
				htmuploadjsppath+'">');
//		html.push('<form id="uploadfileform" name="uploadfileform" method="post" ENCTYPE="multipart/form-data" '+
//				'action ="'+_APPID_PATH_+'/busfw/ltext/htmlfileupload.jsp?serverid=buscore.fudsclient.htmluploadservice">');
//			
//		html.push('<table id="uploadtable" border="1px">');
//		html.push('	<tr><td>aasdads</td></tr>');
//		html.push('		</table>');
//		html.push('</form>');
		html.push('</iframe>');

		// alert(html);
		fudsupload.drawobj.innerHTML = html.join('');
		//sleep(1000);
		//alert(document.getElementById('uploadframe').contentWindow.document.getElementById("uploadtable"));
		//alert(window.frames["uploadframe"].document.getElementById("uploadtable"));
		whenReady();
	}
	function whenReady(){
		if(uploadhtmlhtml==false){
//			alert(1);
			setTimeout(function (){whenReady();},2000);
		}else{
			goOnLoad();
		}
	}
	function goOnLoad(){
		filecount=0;
//		addOneRow('<input type="button" onclick="addonefile();" value="增加文件"></input>','<label for="file">选择上传文件</label>',
//				'<input type="file" id="file1" name="uploadfiles">','<input type="button" onclick="uploadall();" value="上传"></input>');
		
	}
	function _draw() {
		initdraw();
	}
	
	
	
	fudsupload.show = function() {
		if(!fudsupload.isshow){
			_draw(this);
			fudsupload.isshow = true;
		}
	}
	fudsupload.redraw = function(obj) {
		fudsupload.isshow=false;
		this.draw(fudsupload.drawobj);
	}
	fudsupload.draw = function(obj) {
		// 检查参数是否完整
		if(fudsupload.appid==null){
			alert("请在上传前使用setAppid方法设置appid");
			return;
		}
		if(obj!=null&&obj!='undefine'){
			fudsupload.drawobj = obj;
			
		}
		// 直接执行
		fudsupload.show();
		
	}
	
	
	
	fudsupload.resize = function(w, h) {
	}
	fudsupload.clear = function() {
		
	}
	fudsupload.setAppid = function(appid){
		fudsupload.appid = appid;
	}
	fudsupload.setFileType= function(fileType){
		fudsupload.file_types=fileType;
	}
	fudsupload.setDrawDivId= function(drawDivId){
		fudsupload.drawobj =document.getElementById(drawDivId);
	}
	fudsupload.setShowMark= function(showMark){
		fudsupload.showMark = showMark;
	}
	fudsupload.setSuccesscallbackfn= function(successcallbackfn){
		fudsupload.successcallbackfn = successcallbackfn;
	}
	
	fudsupload.setFailcallbackfn= function(failcallbackfn){
		fudsupload.failcallbackfn =failcallbackfn;
	}
	fudsupload.getFileGuid= function(){
		return fudsupload.fileguid;
	}
	fudsupload.getFileName= function(){
		return fudsupload.filename;
	}
	var regExp=/^\d+(\.\d+)?$/;
	fudsupload.setFileMaxSize=function(size){
		if(regExp.test(size)){
			fudsupload.file_size_limit=size+"MB";
		}else{
			alert("设置文件大小参数应为数字");
		}
	}
	fudsupload.setFileNum =function(num){
		if(regExp.test(num)){
			fudsupload.file_queue_limit=num;
		}else{
			alert("设置文件个数参数应为数字");
		}
	}
	// 设置是否显示上传按钮
	fudsupload.setShowUploadButton=function(show){
		fudsupload.showUploadButton = show;
// alert(showButton+"abc"+fudsupload.showUploadButton);
	}
	// 开始上传文件
	fudsupload.startUpLoad=function(){
		document.getElementById('spanButtonUploadFile').onclick();
	}
	fudsupload.setLeftArea=function(leftArea){
		if(leftArea!="select"&&leftArea!="text"){
			alert("设置左侧显示内容错误，参数值为text或select");
			return;
		}
		fudsupload.leftAreaShow=leftArea;
	}
	
	return fudsupload;
}

// 将文件名写入filenamelist中
//fudsupload.swfUpload.wrapper = fudsupload; 
//我觉得这么写就可以，upload_success_handler的句柄this是fudsupload.swfUpload，
//这样写可以在方法内部通过this.wrapper获取到fudsupload对象
function fileQueued1(file){
	if(file!=null&&file!="undefined")
	document.getElementById('filenamelist').value+=file.name+";";
}
// 整体上传成功后触发
function uploadSuccess1(file , server , received){
	if(server.length==32){
		// 上传成功，返回fileguid
		fudsupload.fileGuid = server;
		// 上传文件索引
		//fudsupload.uploadindex=fudsupload.uploadindex+1
		//fudsupload.filename=fudsupload.swfUpload.getFile(fudsupload.uploadindex-1).name;
		// alert(fudsupload.filename);
		// fudsupload.swfUpload.cancelUpload();
		// alert(fudsupload.swfUpload.getStats().files_queued);
		var result = new Object();
		result.fileGuid=fudsupload.fileGuid;
		result.fileName=file.name;
		// 调用成功的回调函数
//		setTimeout(fudsupload.successcallbackfn+"('"+fudsupload.fileGuid+"','"+file.name+"')",1);
		fudsupload.successcallbackfn(result);
	}else{
			// 调用失败的回调函数
		fudsupload.failcallbackfn(server);
	}
	
} 

function uploadError1(message){
		// 调用失败的回调函数
		if(fudsupload.failcallbackfn!=null){
			fudsupload.failcallbackfn(message);
		}else{
			alert(message);
		}
}

function canAddFile(currentFilenum){
	return currentFilenum<=fudsupload.file_upload_limit;
}
function updateHeight(trs){
	var nums = trs>fudsupload.file_upload_limit?fudsupload.file_upload_limit:trs;
	var height=defalutheight+nums*50
	fudsupload.drawobj.style.height=height+"px";
}

function uploadready(){
	document.getElementById("uploadframe").contentWindow.document.getElementById("uploadfileform").action=Ext.lt.token.urlAddToken(_ROOT_PATH_+_APPID_PATH_+'/common/filemanage/htmlfileupload.jsp?serverid=pmkpi.perfcommon.file.HtmlFileUploadService');
}


//参数n为休眠时间，单位为毫秒:
function sleep(n) {
    var start = new Date().getTime();
    //  console.log('休眠前：' + start);
    while (true) {
        if (new Date().getTime() - start > n) {
            break;
        }
    }
    // console.log('休眠后：' + new Date().getTime());
}
function uploadsuccess(guidresult,nameresult){
	if(guidresult.length>0){
		for( i=0;i<guidresult.split(",").length;i++){
			var guid = guidresult.split(",")[i];
			var filename = nameresult.split(",")[i];
			var file = new Object();
			file.name = filename;
			if(guid=="error"){
				uploadError1(filename)
			}else{
				uploadSuccess1(file,guid);
			}
		}
	}
}

function uploaderror(errormsg){
	uploadError1(errormsg);
}
