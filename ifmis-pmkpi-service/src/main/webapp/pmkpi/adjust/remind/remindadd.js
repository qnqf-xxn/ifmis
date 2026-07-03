if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.adjust){
    Ext.lt.pmkpi.adjust = {};
}

Ext.lt.pmkpi.adjust.remindAddService = function(config, service){
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var serviceid = service,
        proguid = config.proguid;
        mainguid = config.mainguid;
        agencyguid = config.agencyguid;
        finintorgguid = config.finintorgguid;

    cmp.save = function(){
        var params = {};
        params = editform.getEditFormValues();
        params.proguid = proguid;
        params.mainguid = mainguid;
        params.agencyguid = agencyguid;
        params.finintorgguid = finintorgguid;
        Ext.lt.RCP.call(serviceid , "save", params, function(rs){
            if (rs && rs.success) {
                Ext.lt.ui.alert('确认成功！',function(){
                    window.parent.cmp.query();
                    Ext.lt.ui.closeModalWindow();
                });
            } else {
                Ext.lt.ui.alert(rs.error,function(){
                    window.parent.cmp.query();
                    Ext.lt.ui.closeModalWindow();
                });
            }
            Ext.lt.ui.loadingClose();
        });
    }


    return cmp;
}