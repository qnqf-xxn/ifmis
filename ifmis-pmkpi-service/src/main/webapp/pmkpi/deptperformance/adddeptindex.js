if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.deptperformance){
    Ext.lt.pmkpi.deptperformance = {};
}

Ext.lt.pmkpi.deptperformance.deptaddindex = function(config, serviceid){
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var _cmp = {};
    var name = Ext.lt.getparam("name"),
        sindex = Ext.lt.getparam("sindex"),
        findex = Ext.lt.getparam("findex");
    window.parent.Ext.lt.pmkpi.childwindow = window;

    $(function(){
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        deptcmp.initEditForm();
        var params = {};
        params.sindex = config.name;
        editform.synchEditformByObj(params);
    })

    _cmp.save = function(){
        if (!editform.check()) return;//先校验
        var data = editform.getEditFormValues();
        data.sindex = sindex;
        data.findex = findex;
        window.parent.Ext.lt.pmkpi.addrow(data);
        _cmp.close();
    }

    _cmp.close = function(){
        parent.Ext.lt.ui.modalWindow.close();
    }

    Ext.lt.message.hook("editform", "drawed",function(resp){
        var table_eva={
            computesign:{
                change: function(param){
                    var ecomputesignstr = param._value.value;
                    param.formpanel.show(["indexval"]);
                    // param.formpanel.hide(["creferencepole"]);
                    if(ecomputesignstr == "6"){
                        editform.clear("meterunit");
                        param.formpanel.hide(["meterunit"]);
                    } else {
                        var data = editform.getEditFormValues();
                        if(!checkReferencepole(data.indexval)) {
                            editform.clear("indexval");
                        }
                        param.formpanel.show(["meterunit"]);
                    }
                }
            },
            indexval : {
                change: function(param){
                        var data = editform.getEditFormValues();
                        if(data.computesign != "6"){
                            if(!checkReferencepole(data.indexval)) {
                                editform.clear("indexval");
                            }
                        }
                }
            }
        }
        resp.editformpanel.attachEvent(table_eva);
    });

    return _cmp;
}