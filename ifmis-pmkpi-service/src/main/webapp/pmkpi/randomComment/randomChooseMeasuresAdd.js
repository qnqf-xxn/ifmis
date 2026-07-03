if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.randomChooseMeasuresAdd){
	Ext.lt.pmkpi.randomChooseMeasuresAdd = {};
}
var serviceid;
var _mainguid;
Ext.lt.pmkpi.randomChooseMeasuresAdd = function(config, service){
    var serviceid = service,
    	guid = config.guid,
        superid = config.superid,
        levelno = config.levelno,
        projguid = config.projguid,
        ordernum = config.ordernum;
    	mainguid = config.mainguid;
    var cmp = {};
    
    _scrWidth =document.body.clientWidth;
    _scrHeight =document.body.clientHeight;
    
    $(function () {
        debugger
        cmp.query();
    })
    
    cmp.query = function(){
        var params = {};
		params.condition = queryform.getQuerySQL();
		params.keyguid = projguid;
		params.arrangement = guid;
		//params.businesstype = businesstype;
        params.tabcode = "PMKPI_V_PERM_VALUESET_ADJ";
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
            datatable.setDatas(rs.data);
            Ext.lt.ui.loadingClose();
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }
 
	
	cmp.saveSelectedMeasures = function (){
		debugger;
		var params = {};
		var recordSize = datatable.getRecordSet().size();
		if(recordSize>0){
			var selectedsRecords = datatable.getSelected();
			if(selectedsRecords.size()<=0){
				Ext.lt.ui.alert("请选择数据！",{},function(){});
				return;
			}
			var newdatas = new Array();
			for(var i=0;i<selectedsRecords.length;i++){
				selectedsRecord = selectedsRecords[i];
				var uuid = createUUID().replace(/-/g, '');
				var newdata = {};
//				var rnd=RndNum(10);
//				if(params.zbxs =='6'){
//					params.referencepole = params.creferencepole;
//				}
				newdata ={guid:selectedsRecord.guid,
						indexguid:selectedsRecord.guid,
						name:selectedsRecord.measuresname,
						actualvalue:selectedsRecord.referencepole,
						indexval:selectedsRecord.referencepole,
						sindex:guid,
						superid:guid, 
						levelno:'3',
						isleaf:'1',
						oredrnum:parseInt(ordernum)+(i+1),
						agencyguid:selectedsRecord.agencyguid,
						mainguid:mainguid,
						projguid:projguid,
						computesign:selectedsRecord.zbxs,
						meterunit:selectedsRecord.units,
						remarks:selectedsRecord.remarks};
				newdatas.push(newdata);
			}
			zbxs_source = [["1","1","≥"],["2","2",">"],["3","3","="],["4","4","<"],["5","5","≤"],["6","6","定性"]];
			parent.datatable.addMapperDatas("zbxs",zbxs_source);
			parent.datatable.getRecordSet().addData(newdatas);
			parent.Ext.lt.ui.modalWindow.close();
		}else{
			Ext.lt.ui.alert("页面无数据！",{},function(){});
			return;
		}
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