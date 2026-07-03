if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.impexpmainedit)
    Ext.lt.pmkpi.impexpmainedit = {};

Ext.lt.pmkpi.impexpmainedit = function(config, service) {
    var cmp = {};
    var serviceid = service,
        _tablecode=config.tablecode,//表名
        _province = config.province,
        _year = config.year;
         _viewtype = config.viewtype;//修改/新增
    $(function () {
        if (_viewtype == "mod") {
            cmp.editSetdisabled(editform);  //编辑时，编码不可编辑
            editform.synchEditformByObj(config.datas);
        }
    })

    cmp.infosave = function () {
        if (!editform.check()) return;//先校验
        var params = {};
        params.tablecode = _tablecode;
        params.year=_year;
        params.province=_province;
        params.viewtype=_viewtype;
        params.data = editform.getEditFormValues();
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(service , "saveDatas", params, function(rs){
            if (rs && rs.success) {
                Ext.lt.ui.alert('保存成功！',function(){
                    Ext.lt.ui.closeModalWindow();
                    parent.location.reload();
                });
            } else {
                Ext.lt.ui.alert('保存失败,'+rs.msg,function(){
                    Ext.lt.ui.loadingClose();
                });
            }
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('保存失败！',function(){
            });
        });
    }

    /**
     * 设置编辑区不可编辑
     */
    cmp.editSetdisabled = function (editfrom){
        var cols = editfrom.cfg.data;
        var c = {};
        for (var i=0; i<cols.length; i++) {
            if(cols[i].colcode=="CODE"){
                c[cols[i].colcode.toLowerCase()] = true;
            }
        }
        editfrom.setdisabled(c);//设置基本信息不可编辑
    }
    return cmp;
}