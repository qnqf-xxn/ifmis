if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.evaluation){
    Ext.lt.pmkpi.evaluation = {};
}

Ext.lt.pmkpi.evaluation.proauditservice = function(config, service){
    var cmp = {};
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var _menuid = config.menuid,//菜单id
        _proguid = config.proguid,
        _usertype = config.usertype, //用户类型0为单位
        _viewtype = config.viewtype;


    $(function () {
        var tablecode = editform.cfg.tablecode;
        var params = {};
        params.proguid = _proguid;
        params.tablecode = tablecode;
        var editdata = Ext.lt.RCP.asyncall(service , "getEditInfo", params);
        if (_viewtype == "query") {
            deptcmp.editSetdisabled(editform);
            $("div[compid='toolbutton']").hide();
        }
        if (_usertype =="0"){ //单位用户不显示这俩字段
            editform.getCol("organization").hide();
            editform.getCol("score").hide();
        }
        editform.synchEditformByObj(editdata);
    })
    
    /**
     * 基础信息保存
     */
    cmp.save = function (obj){
        if (!editform.check()) return false;
        var params = {};
        params.proguid = _proguid;
        params.infodata = editform.getEditFormValues();
        var rs = Ext.lt.RCP.asyncall(service, "save", params);
        if (rs && rs.success) {
            Ext.lt.ui.alert('保存成功！', function () {
                Ext.lt.ui.closeModalWindow();
            });
        }
        return rs;
    }
    return cmp;
}