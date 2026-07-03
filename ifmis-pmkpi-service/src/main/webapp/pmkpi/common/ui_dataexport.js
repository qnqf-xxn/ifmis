if (Ext.lt.ui == null) {
	Ext.lt.ui = {}
};


var tmpfileguid=null;
var interId=null;
Ext.lt.ui.dataexport=function(config,service){
	//导出模板：templettag
	//导出全部/选择导出:
	//导出文件名称 filename
	//导出后缀名设置   1：03格式，2：07格式3：压缩格式--一般用于透视图
	//文件内容标题 titleflag 显示标题，配置成1 你的标题和副标题是什么？
	//文件内容副标题 subtitle 1显示0不显示
	//导出人 exportauthor 1显示0不显示
	//导出时间 exporttime 1显示0不显示
	//是否有合集sumflag 显示合计，配置成1
	//前后台导出 hassql 1有0无(导出全部)
	//前后台导出 config 传自定义配置(主要给  业务BO.getvodsql() 传值)
	var ret={};
	var exportinfo = {};
	function excelexport(cfg){
		var table;
		if(typeof uidatatable !="undefined"){
			table = uidatatable;
		}else if(typeof indiuidatatable !="undefined"){
			table = indiuidatatable;
		}else if(typeof indiuidatatable1 !="undefined"){
			table = indiuidatatable1;
		}else if(typeof indiuidatatable2 !="undefined"){
			table = indiuidatatable2;
		}
		//istitleflag 不为''时:使用 '菜单+时间(yyyymmhhmimiss)'导出文件名
		ret.cfg=Ext.lt.apply({titleflag:'excel2003',sumflag:1,exporttime:0,exportauthor:1,subtitle:1,downtype:'.xls',key:'/demo/ui/testtable/*',hassql:2,bustable:table,istitleflag:''},cfg);
		var exportconfig = ret.cfg;
		if(exportconfig.titleflag){
			if ('excel2003' == exportconfig.titleflag) {//默认  文件名
				var myDate = new Date();
				var nowmonth = (myDate.getMonth() + 1).toString();
				if (nowmonth.length < 2) {
					nowmonth = '0' + nowmonth;
				}
				var nowdate = myDate.getDate().toString();
				if (nowdate.length < 2) {
					nowdate = '0' + nowdate;
				}
				var filename = myDate.getFullYear().toString() + nowmonth
						+ nowdate + myDate.getHours().toString()
						+ myDate.getMinutes().toString()
						+ myDate.getSeconds().toString()
						+ myDate.getMilliseconds().toString();
				exportinfo.titleflag = filename;//默认  文件名
			}
			//else   自定义文件名
		}
		exportinfo.istitleflag=exportconfig.istitleflag;

		
		if(exportconfig.exporttime == 1){
			exportinfo.exporttime = new Date().toLocaleDateString();
		}
		
		//标记展示导出人 穿入后台获取
		if(exportconfig.exportauthor == 1){
			exportinfo.exportauthor = 1;
		}
		if(exportconfig.subtitle){
			exportinfo.subtitle = exportconfig.subtitle;
		}
		//设置文件下载格式
		exportinfo.downtype = exportconfig.downtype;
//		if(exportconfig.downtype == '1'){
//			exportinfo.downtype = exportconfig.downtype;
//		}
		exportinfo.colspacing = ',';//列间隔符
//		if(exportconfig.colspacing != '')
//			exportinfo.colspacing = exportconfig.colspacing;
		exportinfo.rowspacing = '.';//行间隔符
//		if(exportconfig.rowspacing != '')
//			exportinfo.rowspacing = exportconfig.rowspacing;		
		
		exportinfo.key = exportconfig.key;
		exportinfo.hassql = exportconfig.hassql;
		
		exportinfo.config = exportconfig.config;//传自定义配置(主要给  getvodsql() 传值)
		
		//前台过滤条件
//		exportinfo.filter = exportconfig.filter;//是否有页签
//		if(typeof(exportinfo.filter)==undefind){
//			exportinfo.filter = ' 1=1 ';
//		}
		//added by zhangkai,增加一个遮罩层
		//Ext.lt.ui.loadingShow();
		var date = new Date();
		tmpfileguid=date.getTime()+"";
		//设置合计行的数据
		var totalamt = cfg.bustable.getSumobj();
		exportinfo.totalamt = totalamt;

		//前台导出需要把数据和列配置传给后台处理
		//导出已选择数据
		var datas=null;
		datas = exportconfig.bustable.getSelected();
		data2 = exportconfig.bustable.getRecordSet().toArray();
		if (datas.length <= 0) {
			datas = exportconfig.bustable.getRecordSet().toArray();
		}
		var columns = [];
		for(var j=0 ;j<datas.length;j++){//复制 列表 内容
			datas[j] = Ext.lt.apply({},datas[j]);
		}
		//列配置
		var cols = exportconfig.bustable.getCols();
		var tablecode = exportconfig.bustable.uiconfig.tablecode;
		var colList = exportconfig.bustable.uiconfig.columns;
		for(var i = 0;i<cols.length;i++){
			var column = {};
			if(cols[i].name != '_locationposition' && cols[i].name!='check'){
				column.name = cols[i].name;//code
				column.colcode = cols[i].name;//code
				column.alias = cols[i].alias;
				column.issource = cols[i].issource;//是否有来源数据
				column.format = cols[i].format;//显示格式
				//---
				//有来源数据  翻译
				if(cols[i].issource == '1'){//判断是否 是有来源数据
					if(cols[i].format){
						if(cols[i].format!=null&&cols[i].format.indexOf('code')>0 || cols[i].format.indexOf('name')>0 ){//判断  显示样式
							for(var j=0 ;j<datas.length;j++){
								datas[j][cols[i].name] = cols[i]._formatValue(datas[j][cols[i].name]);
							}
						}
					}
				}
				column.exportwidth=getColumnWidth(cols[i]);
				columns.push(column);
				//----
			}
		}
		var coldatas = [];
		for(var a = 0;a<colList.length;a++){
			var coldata = {};
			coldata.colcode =colList[a].colcode;
			coldata.alias =colList[a].alias;
			coldata.bottomcontrl =colList[a].bottomcontrl;
			coldata.colindex =colList[a].colindex;
			coldata.coltype =colList[a].coltype;
			coldata.colwidth =colList[a].colwidth;
			coldata.config =colList[a].config;
			coldata.datatype =colList[a].datatype;
			coldata.defaultvalue =colList[a].defaultvalue;
			coldata.display =colList[a].display;
			coldata.dtype =colList[a].dtype;
			coldata.edit =colList[a].edit;
			coldata.format =colList[a].format;
			coldata.guid =colList[a].guid;
			coldata.head =colList[a].head;
			coldata.id =colList[a].id;
			coldata.issource =colList[a].issource;
			coldata.isvisiable =colList[a].isvisiable;
			coldata.key =colList[a].key;
			coldata.minwidth =colList[a].minwidth;
			coldata.name =colList[a].name;
			coldata.oldwidth =colList[a].oldwidth;
			coldata.ordernum =colList[a].ordernum;
			coldata.requirement =colList[a].requirement;
			coldata.showlevel =colList[a].showlevel;
			coldata.sort =colList[a].sort;
			coldata.status =colList[a].status;
			coldata.style =colList[a].style;
			coldata.totaltag =colList[a].totaltag;
			coldata.type =colList[a].type;
			coldata.width =colList[a].width;


			coldatas.push(coldata);
		}

		var para = {};
		//titleflag:导出文件名、istitleflag!=''：菜单+时间 为文件名
		para = Ext.lt.apply({titleflag:'excel2003',istitleflag:''},exportinfo);
		para.exportinfo = exportinfo;
		para.columns = columns;
		delete datas[0].gptag;
		para.datas = datas;
		para.tablecode = tablecode;
		para.colList = coldatas;
		//设置文件id
		para.fileguid=tmpfileguid;
//			var a = Ext.lt.RCP.down('busfw.dataexport','down2',para,'downframe');
//			//定时检查文件的下载状态，是否下载完成
//			interId = window.setInterval(checkFileStatus,500);

		Ext.lt.RCPConsole.processdown("pmkpi.dataexport",'down2',para,'downframe');
		Ext.lt.ui.appendLog("，导出参数：" + Object.toLOGJSON(exportinfo));
	}
	
	ret.excelexport = function(cfg){
		excelexport(cfg);
	}
	
	ret.draw = function(){
		
		
	}

	var starttime =null;
	function checkFileStatus(){
		if(starttime==null){
			starttime=new Date();
		}
		if(new Date().getTime()-starttime.getTime()>1000*60){//后台处理下载超过60秒
			window.clearInterval(interId)
			Ext.lt.ui.loadingClose();
			return;
		}
		var params={};
		params.fileguid=tmpfileguid;
		try{
			var rtn = Ext.lt.RCP.asynserver("busfw.dataexport", "getFileStatus", params,exceptionCallback);
			if(rtn==true){//下载完成，取消这招层
				window.clearInterval(interId)
				Ext.lt.ui.loadingClose();
			}else{
			}
		}catch(e){
			window.clearInterval(interId)
			Ext.lt.ui.loadingClose();
		}
	}
	
	function exceptionCallback(pm){
		window.clearInterval(interId)
		Ext.lt.ui.loadingClose();
		return;
//		if(pm && pm.indexOf("ERROR NO") != -1){
//			if(error[pm.substring(9,pm.length)]){
//				alert(error[pm.substring(9,pm.length)]);
//			}else{
//				Ext.lt.ui.alert("操作有误!");
//			}
//		}
	};
	
	
	/**
	 * 获取  排列顺序(减少大小)
	 * @param cols
	 * @returns {Array}
	 */
	getcols = function(cols){
		var columns = [];
		for(var i=0;i<cols.length ;i++){
			if(cols[i].name != '_locationposition' && cols[i].name!='check'){
				var column = {};
				column.colcode = cols[i].name;//code
				column.exportwidth = cols[i].exportwidth;
				columns.push(column);
			}
		}
		return columns;
	}
	
	return ret;
	
}
function getColumnWidth(cols){
	var width = cols.width;
	width = parseInt(width);
	if(width == 0){
		width = cols.headobject ? cols.headobject.offsetWidth : 0;
	}
	if(cols.minwidth){
		if(width<cols.minwidth){
			width=cols.minwidth;
		}
	}
	return width;
}