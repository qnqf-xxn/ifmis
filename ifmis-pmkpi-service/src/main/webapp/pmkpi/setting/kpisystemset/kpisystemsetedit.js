if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.kpisystemset)
    Ext.lt.pmkpi.kpisystemset = {};

Ext.lt.pmkpi.kpisystemset.infoedit = function(config, service){
    var cmp = {};
    var serviceid = service,
        _guid = config.guid,
        _tablecode = config.tablecode,
        _infoedit = config.infoedit;

    /**
     * 表格保存
     */
    cmp.infosave = function (){
        if (!editform.check()) return;//先校验
        var params= {};
        params.tablecode = _tablecode;
        params.guid = _guid;
        params.infodata = editform.getEditFormValues();
        Ext.lt.RCP.call(serviceid , "saveSystem", params, function(rs){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('保存成功！',function(){
                Ext.lt.ui.closeModalWindow();
                parent.Ext.lt.pmkpi.query();
            });
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('保存失败！',function(){
            });
        });
    }

    $(function () {
        editform.synchEditformByObj(_infoedit);
    })

    return cmp;
}

