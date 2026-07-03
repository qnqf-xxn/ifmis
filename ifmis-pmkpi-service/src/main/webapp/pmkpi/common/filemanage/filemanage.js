if (Ext.lt.pmkpi == null) {
	Ext.lt.pmkpi = {};
}
var table= {};
Ext.lt.onload(function(){
	initUpLoadFile();
	table=new Ext.lt.datatable35(new Ext.lt.recordset({}));
	table.setCols([
	table.columns.seq,
	{name:'filename',alias:'附件名称',style:'text-align:left',width:'260'},
	{name:'creatername',alias:'上传人',style:'text-align:left',width:'150'},
	{name:'create_time',alias:'上传时间',style:'text-align:left',width:'150'},
	{name:'manage',alias:'操作',style:'text-align:center',width:'150',
			fn:function(i,j,rs,value){
				var html = '<div><img src="/pmkpi/themes/images/download.gif" title="下载" '
				+ ' style="cursor:pointer"  onclick="downfile(\''+rs.fileguid+'\',\''+rs.url+'\')" />'
				if (Ext.lt.pmkpi.viewtype == "query"){ // 查询模式下显示预览按钮，否则显示删除按钮
					html = html + '&nbsp;&nbsp;&nbsp;&nbsp;<img src="/pmkpi/themes/images/i_29.png" title="预览" '
						+ ' style="cursor:pointer" onclick="previewfile(\''+rs.fileguid+'\',\''+rs.filename+'\')" />'
						+ '</div>';
				}else{
					html = html + '&nbsp;&nbsp;&nbsp;&nbsp;<img src="/pmkpi/themes/images/delete.gif" title="删除" '
						+ ' style="cursor:pointer" onclick="deletefile(\''+rs.fileguid+'\',\''+rs.filename+'\',\''+rs.creater+'\',\''+Ext.lt.pmkpi.guid+'\')" />'
						+ '</div>';
				}
				return html;
		}
	}
	]);
	table.setEditSelectCheckbox(false);
	table.setMouselight('#fbefda');
	table.mousedrag(false);
	table.setClassName('busdttheme_ifmis');
	table.draw(filelistdiv);
	initFileList();
})
function downfile(guid,url){
//	alert("下载 guid="+guid+" filename="+filename);
	if(!!url && url != "null"){
		window.open(url);
	}else{
		//设置下载文件的guid
		Ext.lt.pmkpi.download.setFileGuid(guid);
		//直接下载，以ie对话框方式保存
		Ext.lt.pmkpi.download.download();
	}
}

function previewfile(guid, filename) {
	var lastDot = filename.lastIndexOf('.');
	if (lastDot == 0 || lastDot == -1) { //没有后缀
		var params = {};
		params.guid = guid; //附件的guid
		var resp = Ext.lt.RCP.asynserver(Ext.lt.pmkpi.serverid, "queryFileName", [params]);
		if (resp.filename) {
			filename = resp.filename;
		} else if (resp.errmsg) {
			alert(resp.errmsg);
			return;
		}
	}
	Ext.lt.pmkpi.download.setFileGuid(guid);
	Ext.lt.pmkpi.download.preview(filename);
}

function deletefile(guid,filename,creater,billguid){
	/*if(Ext.lt.pmkpi.curuserid != creater){
		alert("只有上传人可以删除附件！");
		return;
	}*/
	if (Ext.lt.pmkpi.viewtype == "query"){
		alert("查询页面，不能删除附件！")
		return;
	}
	var params = {};
    params.guid = guid; //附件的guid
    params.billguid = billguid;
	if(!window.confirm('您确定要删除“'+filename+'”吗？'))return false ;
	Ext.lt.RCP.call(Ext.lt.pmkpi.serverid, "deleteFile",[params], function(resp){
		initFileList();
		alert(resp);
	}, function(resp){
		alert("删除失败");
	});
}

function successCallBack(result) {
	var params = {};
    params.guid = Ext.lt.pmkpi.guid;
    params.fileGuid = result.fileGuid;
    params.fileName=result.fileName;
    params.filetype=Ext.lt.pmkpi.type;
	Ext.lt.RCP.call(Ext.lt.pmkpi.serverid, "saveFileData", [params] , function(resp){
	  initFileList();
	}, function(resp){
		alert("异步请求失败！");
	});
}

function initFileList(){
	var params = {};
    params.guid = Ext.lt.pmkpi.guid;
    params.filetype = Ext.lt.pmkpi.type;
	params.queryYear = Ext.lt.pmkpi.queryYear;//跨年查询查询年度
	params.queryProvince = Ext.lt.pmkpi.queryProvince;//跨年查询查询区划
	Ext.lt.RCP.call(Ext.lt.pmkpi.serverid, "getFileList",[params], function(resp){
		if (resp && resp.length >= 0) {//删除最后一个文件时，length为0，如果条件为>0的话不会走下面的方法重画表格，导致最后一个文件一直显示在列表上
			var data = new Ext.lt.recordset();
			data.addData(resp);
			table.setRecordset(data);
			table.redraw();
			var filenames = '';
			for (var i=0; i<resp.length; i++) {
				filenames += resp[i].filename +"；";
			}
			if (filenames != '') {
				filenames = filenames.substr(0, filenames.length - 1);
			}
			try {
				//列表显示对回显进行处理
				window.parent.Ext.lt.pmkpi.setFileName(filenames, Ext.lt.pmkpi.guid, Ext.lt.pmkpi.type);
			} catch (e) {}
		}
	});
}
function initUpLoadFile(){
	if(Ext.lt.pmkpi.viewtype == "query"){
		$("#filediv").hide();
		$("#filediv").parent().parent().hide();
		setTimeout(function () {
			table.resize($("#filelistdiv").width(),document.body.clientHeight-20);
		}, 100);

	}else{
		//创建上传对象
		Ext.lt.pmkpi.upload = new Ext.lt.FUDSUpload();
		//设置应用的appid
		Ext.lt.pmkpi.upload.setAppid("pmkpi");
		//绘制上传控件
		Ext.lt.pmkpi.upload.draw(document.getElementById("filediv"));
		//设置上传成功回调方法
		Ext.lt.pmkpi.upload.setSuccesscallbackfn(successCallBack);
	}
	//创建下载组件
	Ext.lt.pmkpi.download = new Ext.lt.FUDSDownload();
	//设置appid
	Ext.lt.pmkpi.download.setAppid('pmkpi');
}
Ext.lt.pmkpi.fileManageService = function(config, serviceid){
	Ext.lt.pmkpi.curuserid=config.curuserid;
	Ext.lt.pmkpi.serverid=serviceid;
	Ext.lt.pmkpi.type=config.filetype;
	Ext.lt.pmkpi.guid=config.billguid;
    Ext.lt.pmkpi.viewtype = config.viewtype; //判断附件是否是查看
	Ext.lt.pmkpi.queryYear = config.queryYear;//跨年查询查询年度
	Ext.lt.pmkpi.queryProvince = config.queryProvince;//跨年查询查询区划
}

Ext.lt.pmkpi.filemanage =function(config,server){
	var _cmp = {};
	var bdgbody = $(window);
	_cmp.draw=function(){
		resize();
  	}
	_cmp.resize=function(){
		resize();
	}
	Ext.lt.message.hook("layout","endlayout",function(){
		resize();
	});

	function resize(){
	}
	return _cmp;
}