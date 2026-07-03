if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.deptperfindexedit){
    Ext.lt.pmkpi.deptperfindexedit = {};
}

Ext.lt.pmkpi.deptperfindexedit = function(config, service){
    var serviceid = service,
        _guid = config.guid,
        _tableid = config.datatable,
        _signs = config.signs;
    var cmp = {};

    Ext.lt.message.hook("editform", "drawed",function(resp){
        var table_eva={
            computesign:{
                change: function(param){
                    var ecomputesignstr = param._value.value;
                    if(ecomputesignstr != "6"){
                        var data = editform.getEditFormValues();
                        if(!checkReferencepole(data.halfindexval)) {
                            editform.clear("halfindexval");
                        }
                        if(!checkReferencepole(data.indexval)) {
                            editform.clear("indexval");
                        }
                        editform.clear("meterunit");
                        editform.show(['meterunit'],false);
                    } else { //隐藏计量单位
                        editform.clear("meterunit");
                        editform.hide(['meterunit'],false);
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

    cmp.save = function(){
        if (!editform.check()) return false;//先校验
        var formobj = editform.getEditFormValues();
        var parent_sel_rows = parent.eval(_tableid).getRecordset().query({guid:_guid});
        var parent_sel_obj = parent_sel_rows[0];
        var _sortid = parent_sel_obj._sortid;
        $.extend(parent_sel_obj, formobj); //合并值集刷新
        var zbxs_source = [];
        for(var i=0; i<_signs.length; i++){
            var temparr = [];
            temparr.push(_signs[i]["guid"]);
            temparr.push(_signs[i]["code"]);
            temparr.push(_signs[i]["name"]);
            zbxs_source.push(temparr);
        }
        parent.eval(_tableid).addMapperDatas("computesign",zbxs_source);
        parent.eval(_tableid).reflash(_sortid);
        parent.Ext.lt.ui.modalWindow.close();
    }

    /**
     * 加载完成后执行.
     */
    $(function(){
        var row = {};
        var parent_sel_rows = parent.eval(_tableid).getRecordset().query({guid:_guid});
        var row = parent_sel_rows[0];
        editform.synchEditformByObj(row);
    });

    return cmp;
}