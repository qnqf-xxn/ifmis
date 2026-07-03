if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};

Ext.lt.pmkpi.buseditmenuservice = function(config, service){
    var cmp = {};
    var _superguid = config.superguid,//父级guid
        _levelno = config.levelno,//级次
        _pagetype = config.pagetype;//修改/新增
    window.parent.Ext.lt.pmkpi.childwindow = window;

    $(function () {
        if (_pagetype == "mod") {
            editform.synchEditformByObj(config.menudata);
        } else {
            var data = {};
            data.levelno = parseInt(_levelno)+1;
            data.isleaf = 1;
            data.superguid = _superguid;
            editform.synchEditformByObj(data);
        }
    })

    cmp.save = function () {
        if (!editform.check()) return;//先校验
        var params = {};
        params.pagetype = _pagetype;
        params.data = editform.getEditFormValues();
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(service , "saveMenu", params, function(rs){
            if (rs && rs.success) {
                Ext.lt.ui.alert('保存成功！',function(){
                    parent.Ext.lt.pmkpi.querytree();
                    Ext.lt.ui.closeModalWindow();
                });
            } else {
                Ext.lt.ui.alert('保存失败！',function(){
                });
            }
            Ext.lt.ui.loadingClose();
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('保存失败！',function(){
            });
        });
    }
    return cmp;
}