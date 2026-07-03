if (Ext.lt.pmkpi == null) {
	Ext.lt.pmkpi = {}
};
if (Ext.lt.pmkpi.common1 == null) {
	Ext.lt.pmkpi.common1 = {}
};

Ext.lt.pmkpi.common1.uploadfiles = function(config,service){
	var cmp = {cfg:config};
	var upload_toolbutton = config.upload_toolbutton;
	var upload_uidatatable = config.upload_uidatatable;	
	var fudsupload = {
		fileguid:null,
		filename:null,
		fudsPath:null,
		showUploadButton:true,
		leftAreaShow:"select",
		uploadindex:0,
		basePath:null,
		appid:"common",
		drawDivId:null,
		drawobj:null,
		showMark:null,
		successcallbackfn:null,
		failcallbackfn:null,
		userid:null,
		// flash地址
		flash_url : Ext.lt.token.urlAddToken(config.fudsPath+"ltext/swfupload/jslib/swfupload.swf"),
		flash9_url :Ext.lt.token.urlAddToken(config.fudsPath+"ltext/swfupload/jslib/swfupload_fp9.swf"),
		// 上传url
		upload_url : config.fudsPath+"fileUploadServlet?appid=common&userid="+config.userid,
		file_size_limit : "100MB",
		file_types : "*.*",
		// file_post_name : "uploadFile",
		file_types_description : "All Files",
		file_upload_limit : 10,
		file_queue_limit : 5,
		custom_settings : {
			progressTarget : "fsUploadProgress",
			uploadButtonId : "btnUpload",
			cancelButtonId : "btnCancel"
		},
		debug : false,//

		// Button settings
//		button_image_url :Ext.lt.token.urlAddToken(_APPID_PATH_+"/pmkpi/common/XPButtonUploadText_61x23.html"),
		button_image_url :Ext.lt.token.urlAddToken(_APPID_PATH_+"/busfw/ltext/swfupload/images/XPButtonUploadText_61x22.html"),
//		button_image_url :Ext.lt.token.urlAddToken(_APPID_PATH_+"/busfw/ltext/swfupload/images/upload.png"),
		button_width : "78",
		button_height : "28",
		button_placeholder_id : config.filebutton || "新增附件1",
		button_text : '<span class="theFont" ></span>',
		button_text_style : ".theFont { font-size: 15; }",
		button_text_left_padding : 12,
		button_text_top_padding : 3,
		upload_button_image : Ext.lt.token.urlAddToken(_APPID_PATH_+"/busfw/ltext/swfupload/images/upload.png"),
		_buttons : [],
		// The event handler functions are defined in handlers.js
		file_queued_handler : config.fileQueued || fileQueued,
//		file_queue_error_handler : fileQueueError,
		file_dialog_complete_handler : fileDialogComplete,
//		upload_start_handler : uploadStart,
//		upload_progress_handler : uploadProgress,
//		upload_error_handler : uploadError,
		upload_success_handler : config.uploadSuccess || uploadSuccess,
		upload_complete_handler : config.uploadComplete || uploadComplete
		// queue_complete_handler : queueComplete
	};
	
	function fileQueued(file){
		var fileobj = {};
		fileobj.guid = file.id;
		fileobj.billid = config.billid;
		fileobj.fileclass = config.fjlb;
		fileobj.billtypeid = config.billtypeid;
		fileobj.filename = file.name;
		fileobj.filetype = file.type;
		fileobj.filesize = file.size/1024;
		fileobj.progress = "0"+"%";
		fileobj.tosave =1;
		upload_uidatatable.getRecordSet().addData(fileobj);
		upload_uidatatable.reflash();
	}
	
	function fileQueueError(file, errorCode, message){
		//var QUEUE_ERROR = fudsupload.swfUpload.QUEUE_ERROR;
		if(errorCode==-100){
			Ext.lt.ui.alert("选择上传的文件超过了队列上限个数:"+fudsupload.file_queue_limit);
		}
		if(errorCode==-110){
			Ext.lt.ui.alert("选择上传的文件"+file.name+"超过了大小上限:"+fudsupload.file_size_limit);
		}
		if(errorCode==-120){
			Ext.lt.ui.alert("选择上传的文件"+file.name+"大小为0字节!");
		}
		if(errorCode==-130){
			Ext.lt.ui.alert("选择上传的文件"+file.name+"类型不允许上传!");
		}
	}
	
	function fileDialogComplete(numFilesSelected, numFilesQueued, numFilesInQueue) {
		if (fudsupload.swfUpload.getStats().files_queued > 0) {
			fudsupload.swfUpload.startUpload();
		}
	}
	function uploadProgress(file, bytesComplete, bytesTotal) {
		var fileobj = upload_uidatatable.getRecordSet().query({
			guid: file.id
		})[0];
		fileobj.progress = (""+(bytesComplete/bytesTotal*100)).toNumber(2)+"%";
		upload_uidatatable.reflash();
	};
	function uploadError(file, errorCode, message) {
		if(file && file.id){
			var fileobj = upload_uidatatable.getRecordSet().query({
				guid: file.id
			})[0];
			fileobj.progress = errorCode+"-"+message;
			upload_uidatatable.reflash();
		}else{
			if(errorCode==-240){
				Ext.lt.ui.alert("选择上传的文件超过了允许上传的上限个数:"+fudsupload.file_upload_limit);
			}
		}
	}

	function uploadSuccess(file, serverData, responseReceived) {
		var fileobj = upload_uidatatable.getRecordSet().query({
			guid: file.id
		})[0];
		if(serverData!=null && serverData.length==32){
			fileobj.progress = 100+"%";
			// 上传成功，返回fileguid
			fileobj.guid = serverData;
		}else{
			fileobj.progress = "上传失败！"+serverData;
			fileobj.guid = null;
		}
		upload_uidatatable.reflash();
	};
	function uploadComplete(file) {
		try {
			if (fudsupload.swfUpload.getStats().files_queued == 0 && fudsupload.swfUpload.getStats().successful_uploads>0) {
				cmp.save();
			}
		} catch (ex) {
		}
		return;
	};
	config.fudsupload = fudsupload;
	fudsupload = Ext.lt.apply(fudsupload,config);
	cmp.add = function(){

	}
	
	cmp.save = function(){
		if (upload_uidatatable.getRecordset().size() != 0) {
			var fileobj = upload_uidatatable.getRecordSet().query({
				tosave: 1
			})
			for(var i=0,len = fileobj.length;i<len;i++){
				if(fileobj[i].guid == null || fileobj[i].guid.length!=32){
					alert("上传的文件有问题，请重新上传");
					return;
				}
			}
			var params = {};
			params.urlparameters = Ext.lt.ui.getUrlParameters();
			params.datas = fileobj;
			Ext.lt.RCP.call(service, "saveAttachments", params,
				function (resp) {
					Ext.lt.ui.alert("上传成功！",{timeout:5},function(){
						for(var i=0,len = fileobj.length;i<len;i++){
							delete fileobj[i].tosave;
						}
					    fudsupload.swfUpload.destroy();
					    upload_toolbutton.redraw();
					    if(document.getElementById("新增附件")){
					    	document.getElementById("新增附件").parentElement.id="新增附件1";
					    }
						fudsupload.swfUpload = new SWFUpload(fudsupload);
					});
					Ext.lt.ui.appendLog("上传成功,上传文件："+Object.toLOGJSON(fileobj));
				}, function (resp) {
					Ext.lt.ui.alert("上传失败！\n失败原因：" + resp,{timeout:5},function(){
						for(var i=0,len = fileobj.length;i<len;i++){
							fileobj[i].progress = "保存失败";
						}
					});
					Ext.lt.ui.appendLog("上传失败！\n失败原因：" + resp);
				}
			);
			return;
		} else {
			Ext.lt.ui.alert("页面无数据！",{timeout:1},function(){});
			return;
		}
	}
	cmp["deletefile"] = function(){
		if (upload_uidatatable.getRecordset().size() != 0) {
			var selectDatas = upload_uidatatable.getSelected();
			if (selectDatas.length == 0) {
				Ext.lt.ui.alert("请选择要删除的附件！",{timeout:1},function(){});
				return;
			}
			Ext.lt.ui.confirm("你确定删除选定的附件？",{icon:"warn"},function(ret){
				if(ret){
					var delDatas =[];
					for(var i=0,len = selectDatas.length;i<len;i++){
						if(!!!selectDatas[i].tosave){
							delDatas.push(selectDatas[i]);
						}
					}
					var params = {};
					params.urlparameters = Ext.lt.ui.getUrlParameters();
					params.datas = delDatas;
					Ext.lt.ui.loadingShow();
					Ext.lt.RCP.call(service, "delAttachments", params,
						function (resp) {
							Ext.lt.ui.appendLog("删除附件个数：" + delDatas.length+",文件数据："+JSON.stringify(delDatas));
							Ext.lt.ui.loadingClose();
							upload_uidatatable.removeSelected();
						}, function (resp) {
							Ext.lt.ui.loadingClose();
							Ext.lt.ui.appendLog("删除失败！\n失败原因：" + resp);
							Ext.lt.ui.alert("删除失败！\n失败原因：" + resp,{timeout:2},function(){});
						}
					);
				}
			});
		} else {
			Ext.lt.ui.alert("页面无数据！",{timeout:1},function(){});
			return;
		}
	}

	cmp.close = function(){
		parent.Ext.lt.ui.modalWindow.close();
	}
	cmp.draw=function(div){
		if(config.edit){
			if(document.getElementById("新增附件")){
				document.getElementById("新增附件").parentElement.id="新增附件1";
			}
			fudsupload.swfUpload = new SWFUpload(fudsupload);
		}else{
			$("#增加").hide();
			$("#删除").hide();
		}
//		cmp.query();
	}
	cmp.resize=function(w,h){

	}
	cmp.query=function(){
		var params = {};
		params.urlparameters = Ext.lt.ui.getUrlParameters();
		params.beanid = config.bobeanid;
		params.billid = config.billid;
		params.fjlb = config.fjlb;
		params.tabsid = config.tabsid;
		params.bizlogicguid = config.bizlogicguid;
		upload_uidatatable.queryData(params,function(){});
	}
	return cmp;
}

Ext.lt.message.hook("datatable",'beforesetcols',function(resp){
	if(resp.table.key=="/busfw/common/upload/index"){
		var cols=resp.cols;
		cols[3].width=150;
		cols[4].width=50;
		cols[3].fn=function(i,j,rs,v){
			return "<a onclick='downloadfile(\""+ rs.guid + "\")' href='#'>"+v+"</a>";
		};
	}
});
function downloadfile(guid){
	//创建下载组件
  	var obj = new Ext.lt.FUDSDownload();
	//设置appid
  	obj.setAppid('pmkpi');
	//设置下载文件的guid
  	obj.setFileGuid(guid);
  	obj.download();
};