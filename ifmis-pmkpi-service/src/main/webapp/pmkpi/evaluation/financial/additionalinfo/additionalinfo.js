if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.additionalinfo){
    Ext.lt.pmkpi.additionalinfo = {};
}
Ext.lt.pmkpi.additionalinfo = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var serviceid = service,
        _mainguid = config.mainguid,
        _proguid = config.proguid,
        _procode = config.procode,
        _savetable,
        _viewtype = config.viewtype,
        _busguid = config.busguid;
    var cmp = {};
    
    cmp.query = function(isquery){
        var params = {};
        params.mainguid = _mainguid;
        params.tablecode = _savetable;
        params.proguid = _proguid;
        params.procode = _procode;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
        	editform.synchEditformByObj(rs.data);
            Ext.lt.ui.loadingClose()
            if (isquery) {
                parent._isQuery = true;
            }
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }

    cmp.save = function(){
        if (!editform.check()) return false;//先校验
        var params = {};
        params.datas = editform.getEditFormValues();
        params.tablecode = _savetable;
        params.mainguid = _mainguid;
        params.proguid = _proguid;
        params.procode = _procode;
        params.busguid = _busguid;
        var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
        if (rs && rs.success) {
            cmp.query();
        }
        return rs;
    }

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initEditForm();
        if (_viewtype == "query") {
            var cols = editform.cfg.data;
            var c = {};
            for (var i=0; i<cols.length; i++) {
                c[cols[i].colcode.toLowerCase()] = true;
            }
            editform.setdisabled(c);//设置不可编辑
        }
        _savetable = editform.cfg.table;
        cmp.query(true);
    });

    return cmp;
}