if (Ext.lt.pmkpi == null) {
	Ext.lt.pmkpi = {};
}

if (Ext.lt.outfile == null) {
	Ext.lt.outfile = {}
}

Ext.lt.pmkpi.impexp_a = function(config, service) {
	var _impexp = {};

	var _expconfig = {/*导出默认配置*/
			tableuikey:null,/*导入列表的ui配置*/
			islinenumber:true,/*是否导出序号*/
			busbo:null/*业务bo,也可以配置到数据库link表中*/
	};
	
	
	_impexp.imp = function(impconfig, callBackFunc){
		var _impconfig = {/*导入默认配置*/
			tableuikey:null,/*导入列表的ui配置*/
			busbo:null,/*业务bo,也可以配置到数据库link表中*/
			ispageconfirm:true,/*是否页面确认*/
			isconfirmedit:true,/*页面确认导入数据是否可修改*/
			impfiletypes:'xls'/*允许导入文件的扩展名*/
		};
		jQuery.extend(_impconfig, impconfig);
		Ext.lt.outfile.args = Object.toJSON(_impconfig);
		_impwindow(_impconfig, callBackFunc);
	}
	
	_impexp.exp=function(expconfig){
		jQuery.extend(_expconfig, expconfig);
		if (!expconfig.expimp) {
			_expconfig.expimp = "exp";
		}
		_exppost(_expconfig);
	}
	
	function _impwindow (_impconfig, callBackFunc){
		Ext.lt.outfile.tokenid = _impconfig.tokenid;
		Ext.lt.outfile.callBackFunc = callBackFunc;
		var url = _APPID_PATH_ + "/perfcommon/impexp/excelselect.jsp";
		url = Ext.lt.pmkpi.genPageUrl(url, _impconfig);
		openimportModalWindow(url,600,240,"选择文件",true);
	}
	
	_impexp.draw=function(el){
	}
	
	return _impexp;
}

/**
 * 打开模态窗口
 * @param url
 * @param width
 * @param height
 * @returns
 */
function openimportModalWindow(url,width,height,titlename,closebtn){
	url=Ext.lt.token.urlAddToken(url);
	if(!titlename){
		titlename="";
	}
	if(!closebtn){
		closebtn = false;
	}
	Ext.lt.outfile.window = new Ext.lt.window({
		title:titlename,
		pop:true,
		mark:true,
		close:closebtn,
		w:width,
		h:height,
		fitmode:'content',
		className:'windpop',
		top:50
	});
	var framediv = $('<div style="width:'
		+ width + 'px; height:' + height + 'px;overflow:hidden;"><iframe src="'
		+ url + '" scrolling="no" style="width:'
		+ width + 'px; height:' + height + 'px"></iframe>'+
		+'</div>');

	Ext.lt.outfile.window.draw(framediv[0]);
	detaildiv=Ext.lt.outfile.window;
	lastdiv=null;
}
var detaildiv = null;
var lastdiv =null;

function showerrordiv(fileguid){
	var url="";
	if (_APPID_PATH_ == null || _APPID_PATH_ == "") {
		url = '/buscommon/fileimport/errormsg.page?tokenid='+Ext.lt.token.getTokenid();
	}else{
		url = _APPID_PATH_+'/buscommon/fileimport/errormsg.page?tokenid='+Ext.lt.token.getTokenid();
	}
	url+="&fileguid="+fileguid;
	if(lastdiv==null){
		var framediv1=$('<div style="width:'
			+ 600 + 'px; height:' + 300 + 'px;overflow:hidden;"><iframe id="errorframe" src="'
			+ url + '" scrolling="auto" style="width:'
			+ '600px; height:300px"></iframe></div>');
		if(lastdiv){
		}
		detaildiv.appendChild(framediv1[0]);
		lastdiv=framediv1;
	}else{
		document.getElementById("errorframe").src=url;
	}
	//alert("导入文件有误，请检查错误信息");
}

function _exppost(params){
	setTimeout(function(){
		window.parent.Ext.lt.RCP.down("pmkpi.perfcommon.impexp.ImpExpAComponet", 'impexp',params,function(resp){
				alert(resp);
		});
		Ext.lt.ui.loadingClose();
	},200);
}