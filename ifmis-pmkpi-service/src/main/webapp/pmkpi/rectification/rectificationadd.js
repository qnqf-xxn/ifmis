if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.rectification)
    Ext.lt.pmkpi.rectification = {};

Ext.lt.pmkpi.rectification.add = function(config, service){
    var cmp = {};
    var isSaveMain=false;//评价类型信息是否已保存
    var rectification = config.rectification;

    $(function () {
        cmp.writeBack();
    })

    cmp.writeBack = function(){
        if (rectification) {
            editform.synchEditformByObj(rectification);
        }
    }

    cmp.infosave = function(){
        if (!editform.check()) return;//先校验
        var params = {};
        var params = editform.getEditFormValues();
        var rs = Ext.lt.RCP.asyncall(service , "infosave", params);
        Ext.lt.ui.loadingClose();
        isSaveMain = true;
        window.parent.cmp.query();// 刷新
        return rs;
    }
    return cmp;
}

