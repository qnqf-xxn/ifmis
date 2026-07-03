if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.typicalcaseedit)
    Ext.lt.pmkpi.typicalcaseedit = {};

Ext.lt.pmkpi.typicalcaseedit = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _tablecode = config.tablecode,//表名
        _mainguid = config.mainguid,//主单id
        _viewtype = config.viewtype,
        _taskyear = config.taskyear,
        _taskprovince = config.taskprovince,
        _casetype = config.casetype;
    window.parent.Ext.lt.pmkpi.childwindow = window;

    $(function () {
        common.initEditForm();
        if (_viewtype == "query") {
            var cols = editform.cfg.data;
            var c = {};
            for (var i=0; i<cols.length; i++) {
                c[cols[i].colcode.toLowerCase()] = true;
            }
            editform.setdisabled(c);//设置不可编辑
        }
        cmp.query(true);
    })

    cmp.query = function(isquery){
        var params = {};
        params.mainguid = _mainguid;
        params.casetype = _casetype;
        params.tablecode = _tablecode;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(service , "editquery", params, function(rs){
            editform.synchEditformByObj(rs.editdata);
            Ext.lt.ui.loadingClose();
            parent._isQuery = true;
            if (isquery) {
                parent._isQuery = true;
            }
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }

    cmp.save = function () {
        if (!editform.check()) return;//先校验
        var params = {};
        params.tablecode = _tablecode;
        params.casetype = _casetype;
        params.data = editform.getEditFormValues();
        params.mainguid = _mainguid;
        var rs = Ext.lt.RCP.asyncall(service , "infosave", params);
        if (rs && rs.success) {
            cmp.query();
        }
        return rs;
    }

    cmp.close = function () {
        parent.Ext.lt.ui.modalWindow.close();
    }

    Ext.lt.message.hook("perfcommon", "iframeinit", function(obj){
        var params = obj.params;
        params.viewtype = _viewtype;
        params.mainguid = _mainguid;
        params.taskyear = _taskyear;
        params.taskprovince = _taskprovince;
    })

    return cmp;
}