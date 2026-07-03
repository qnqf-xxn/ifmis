if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

if(!Ext.lt.pmkpi.randomComment){
    Ext.lt.pmkpi.randomComment = {};
}
Ext.lt.pmkpi.randomComment.randomAdd = function(config, service){
	var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var serviceid = service,
    	bustype = config.bustype,
        randomprojcount = config.randomprojcount,
		random = config.random,
		tabcode = config.tabcode;

	cmp.save = function(){
		var params = {};
		params = editform.getEditFormValues();
		params.bustype = bustype;
		var random = params.random;
	    	Ext.lt.RCP.call(serviceid , "save", params, function(rs){
				if(rs.error){
					Ext.lt.ui.alert(rs.error);
				} else{
					Ext.lt.ui.alert(("确认成功！"),{}, function(ret) {
						Ext.lt.ui.closeModalWindow();
					});
				}
			});
	}
	$(function() {
		var addata = {};
		addata.randomproj = randomprojcount;
		addata.random = random;
		editform.synchEditformByObj(addata);
	});
    /**
     * 编辑区查询前调用
     */
    Ext.lt.message.hook("perfcommon", "editinit",function(obj){

    });

    /**
     * 保存前处理消息
     */
    Ext.lt.message.hook("perfcommon", "beforesave",function(obj){
    });

    return cmp;
}