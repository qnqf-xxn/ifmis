// 保存方法
function savewf(){
	var params = {};
	var tablecode = "";
	params.keyguid = keyguid;
	var formMap = Ext.lt.RCP.asynserver("pmkpi.PmkpiTreeTabsLayoutService", "findField", {formid:tableguid});
	if(formMap){
		if(formMap.textList){
			var text = formMap.textList;
			if(!tablecode){
				tablecode = text[0].tablename;
			}
			for(var i=0;i<text.length;i++){
				var filedname = text[i].fieldname.toLowerCase();
				params[filedname] = $("input[fieldname='"+text[i].fieldname+"']").val();
			}
		}
		if(formMap.selectList){
			var select = formMap.selectList;
			if(!tablecode){
				tablecode = select[0].tablename;
			}
			for(var i=0;i<select.length;i++){
				var filedname = select[i].fieldname.toLowerCase();
				params[filedname] = $("select[fieldname='"+select[i].fieldname+"']").find("option:selected").text();
			}
		}
		
		if(formMap.textareaList){
			var textarea = formMap.textareaList;
			if(!tablecode){
				tablecode = textarea[0].tablename;
			}
			for(var i=0;i<textarea.length;i++){
				var filedname = textarea[i].fieldname.toLowerCase();
				params[filedname] = $("textarea[fieldname='"+textarea[i].fieldname+"']").val();
			}
		}
		
		params.tablecode = tablecode;
		Ext.lt.ui.loadingShow();
		var formMap = Ext.lt.RCP.asynserver("pmkpi.PmkpiTreeTabsLayoutService", "save", params);
		if(formMap.success){
			Ext.lt.ui.loadingClose();
			Ext.lt.ui.alert(("保存成功！"),{}, function(ret) {});
		}
	}
}

function writeBack(){
	var params = {};
	var saveMap = Ext.lt.RCP.asynserver("pmkpi.PmkpiTreeTabsLayoutService", "selWpInfo", {keyguid:keyguid,formid:tableguid});
	if(saveMap){
		for(var i=0;i<saveMap.length;i++){
			var type = saveMap[i].type;
			if(type == "text"){
				$("input[fieldname='"+saveMap[i].name+"']").val(saveMap[i].value);
			}else if(type == "select"){
				$("select[fieldname='"+saveMap[i].name+"']").val(saveMap[i].value);
			}else if(type == "textarea"){
				$("textarea[fieldname='"+saveMap[i].name+"']").val(saveMap[i].value);
			}
		}
	}
}

function formReadonly(){
	$("#formHtml").find("input,select").attr("disabled", "disabled");
	$("#formHtml").find("input,select").css({border:"0",outline:"none",backgroundColor:"rgba(0, 0, 0, 0)"});
	$("#formHtml").find("select").css({"appearance":"none", "-webkit-appearance":"none"});
	$("#formHtml").find("textarea").css({border:"0",outline:"none",backgroundColor:"rgba(0, 0, 0, 0)",resize:"none"});
//	$("#formHtml").find("select").attr("readonly", true);
}