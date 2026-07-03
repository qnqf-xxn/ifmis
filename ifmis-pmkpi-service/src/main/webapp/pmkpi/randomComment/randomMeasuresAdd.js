if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.randomMeasuresAdd){
	Ext.lt.pmkpi.randomMeasuresAdd = {};
}
var serviceid;
var _mainguid;
Ext.lt.pmkpi.randomMeasuresAdd = function(config, service){
    var serviceid = service,
        superid = config.guid,
        levelno = config.levelno,
        projguid = config.projguid,
		findex = config.findex,
		sindex = config.sindex,
		_signs = config.signs,
		_type = 'add',
        ordernum = config.ordernum;
    	mainguid = config.mainguid;
    	agencyguid = config.agencyguid;
    var cmp = {};
    
    _scrWidth =document.body.clientWidth;
    _scrHeight =document.body.clientHeight;
    
	/*cmp.save = function(){
		if (!editform.check()) return;
		var params = editform.getEditFormValues();
		params.superid = superid;
		params.levelno = levelno;
		params.projguid = projguid;
		params.agencyguid = agencyguid;
		params.arrangement = superid;
		params.findex = findex;
		params.sindex = sindex;
		var uuid = createUUID().replace(/-/g, '');
		if(params.referencepole){
			if(params.referencepole.length > 200){
				Ext.lt.ui.alert('指标值不能大于200字！',function(){});
				return;
			}
			if('6'!=params.zbxs){
				var patrn = /^\d+$|^\d*\.\d+$/g;
				if (!patrn.exec(params.referencepole)) {
	                Ext.lt.ui.alert("定量指标标准值必须为数字！",{},function(){});
	                return;
	            }
			}
		}
		Ext.lt.RCP.call(serviceid , "save", params,function(rs){
			if(rs.error){
				Ext.lt.ui.alert(rs.error);
			}else{
				var newdatas = new Array();
				var newdata = {};
				newdata ={guid:rs.guid,
						indexguid:uuid,
						name:params.measuresname,
						actualvalue:params.referencepole,
						indexval:params.referencepole,
						sindex:superid,
						superid:superid,
						levelno:'3',
						isleaf:'1',
						oredrnum:parseInt(ordernum)+1,
						mainguid:mainguid,
						projguid:projguid,
						computesign:params.zbxs,
						meterunit:params.units,
						remarks:params.remarks};
				newdatas.push(newdata);
				zbxs_source = [["1","1","≥"],["2","2",">"],["3","3","="],["4","4","<"],["5","5","≤"],["6","6","定性"]];
				parent.datatable.addMapperDatas("computesign",zbxs_source);
				parent.datatable.getRecordSet().addData(newdatas);
				parent.Ext.lt.ui.modalWindow.close();
			}
		});	
	}*/
	cmp.save = function(){
		if(!editform.check()){
			return false;
		}
		var formobj = editform.getEditFormValues();
		formobj["guid"] = createUUID().replace(/-/g, '');
		var parTabid;
		parTabid = parent.eval("datatable");
		if ("add" == _type){
			var parent_sel_rows;
			parent_sel_rows = parTabid.getRecordset().query({guid:sindex});
			var parent_sel_obj = parent_sel_rows[0];
			var _sortid = parent_sel_obj._sortid;
			if (parent_sel_obj["levelno"] == 2) {
				parent_sel_obj["check"] = null;
				parent_sel_obj["isleaf"] = 0;
				parent_sel_obj["_isleaf"] = 0;
				parTabid.reflash(_sortid);
			}
			formobj["findex"] = findex;
			formobj["sindex"] = sindex;
			formobj.superid = sindex;
			formobj.levelno = 3;
			formobj.isleaf = 1;
			formobj._isleaf = 1;
			formobj.rowtype = "add";
			formobj.is_add = "1";
			var zbxs_source = [];
			for(var i=0; i<_signs.length; i++){
				var temparr = [];
				temparr.push(_signs[i]["guid"]);
				temparr.push(_signs[i]["code"]);
				temparr.push(_signs[i]["name"]);
				zbxs_source.push(temparr);
			}
			parTabid.addMapperDatas("computesign",zbxs_source);
			var addarr = [];
			addarr.push(formobj);
			parTabid.getRecordSet().addData(addarr,_sortid + parTabid.getRecordset().toArray().length);
			if((!parent_sel_obj["name"] || parent_sel_obj["name"] =="") && "tree" != _fromtype && fundguid == ""){
				parTabid.getRecordset().delRow(_sortid);
			}
		}
		parent.Ext.lt.ui.modalWindow.close();
	}
	
	cmp.closePopupWin = function(){
		parent.Ext.lt.ui.modalWindow.close();
	}

    return cmp;
}

var createUUID = (function(uuidRegEx, uuidReplacer) {
	return function() {
		return "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(uuidRegEx,
				uuidReplacer).toUpperCase();
	};
})(/[xy]/g, function(c) {
	var r = Math.random() * 16 | 0, v = c == "x" ? r : (r & 3 | 8);
	return v.toString(16);
});