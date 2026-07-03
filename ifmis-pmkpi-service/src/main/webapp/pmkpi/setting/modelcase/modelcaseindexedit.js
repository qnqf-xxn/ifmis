if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.modelcaseindexedit)
    Ext.lt.pmkpi.modelcaseindexedit = {};

Ext.lt.pmkpi.modelcaseindexedit = function(config, service){
    var cmp = {};
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var _tablecode = config.tablecode,//表名
        _pagetype = config.pagetype,//修改/编辑标识
        _mainguid = config.mainguid,//主单id
        _framedata = config.framedata,
        _findex;
    window.parent.Ext.lt.pmkpi.childwindow = window;

    Ext.lt.message.hook("editform", "drawed",function(resp){
        var table_eva={
            sindex:{
                asyncloaddata:function(param){
                    param.data=_framedata;
                },
                change: function(param){
                    _findex = param.sels[0].superitemid;
                }
            }
        }
        resp.editformpanel.attachEvent(table_eva);
    });

    $(function () {
        if (_pagetype == "mod") {
            editform.synchEditformByObj(config.indexdata);
        }
    })

    cmp.save = function () {
        if (!editform.check()) return;//先校验
        var editdata = editform.getEditFormValues();
        if (!common.checkSpaceValue(editdata,null,"editform")) return;//校验空格
        editdata.name = convertStr(editdata.name);
        editdata.perf_ind_name = convertStr(editdata.perf_ind_name);
        editdata.indexval = convertStr(editdata.indexval);
        editdata.kpi_val = convertStr(editdata.kpi_val);
        var params = {};
        params.tablecode = _tablecode;
        params.pagetype = _pagetype;
        params.data = editdata;
        if (_findex && "" != _findex) {
            params.data["findex"] = _findex;
        }
        params.data["mainguid"] = _mainguid;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(service , "save", params, function(rs){
            if (rs && rs.success) {
                Ext.lt.ui.alert('保存成功！',function(){
                    parent.Ext.lt.pmkpi.query();
                    parent.Ext.lt.ui.modalWindow.close();
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

    cmp.close = function () {
        parent.Ext.lt.ui.modalWindow.close();
    }
    return cmp;
}