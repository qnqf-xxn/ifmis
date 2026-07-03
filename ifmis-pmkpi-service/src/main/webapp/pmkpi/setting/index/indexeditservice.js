if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.indexservice)
    Ext.lt.pmkpi.indexservice = {};

Ext.lt.pmkpi.indexservice = function(config, service){
    var cmp = {};
    var _treeid = config.treeid,
        _indextype = config.indextype,//左侧树类型
        _tablecode = config.tablecode,//表名
        _pagetype = config.pagetype,//修改/新增
        _sindexdata = [],//指标数据
        _findex;//一级指标
        window.parent.Ext.lt.pmkpi.childwindow = window;

    Ext.lt.message.hook("editform", "drawed",function(resp){
        var cols = resp.configs;
        for (var i=0; i<cols.length; i++) {
            if (cols[i].name == "framesystem") {
                cols[i].isvisiable = 0;
                cols[i].isedit = false;
            }
        }
        var table_eva={
            framesystem:{
                change: function(param){
                    if (_indextype == "DEPT") {
                        param.formpanel.hide(["framesystem"]);
                    } else { //共性指标显示指标体系，其他隐藏
                        if (param.sels[0] && param.sels[0].itemid) {
                            var frametype = param.sels[0].itemid;
                            _sindexdata = Ext.lt.RCP.asyncall(service , "getFrame", [frametype]);
                            editform.clear("sindex");
                        }
                    }
                }
            },
            sindex:{
                asyncloaddata:function(param){
                    if (_sindexdata && _sindexdata.length >0 ) {
                        param.data = _sindexdata;
                    } else {
                        _sindexdata = Ext.lt.RCP.asyncall(service , "getFrame", ["DEPT"]);
                        param.data = _sindexdata;
                    }
                },
                change: function(param){
                    if (param.sels && param.sels.length == 1) {
                        _findex = param.sels[0].superitemid;
                    } else {
                        _findex = "";
                    }
                }
            }
        }
        resp.editformpanel.attachEvent(table_eva);
    });

    $(function () {
        if (_pagetype == "mod") {
            editform.synchEditformByObj(config.indexdata);
        } else {
            if (_indextype == "DEPT") {
                var data = {};
                data.framesystem = _indextype;
                editform.synchEditformByObj(data);
            }
        }
    })

    cmp.save = function () {
        if (!editform.check()) return;//先校验
        var params = {};
        params.treeid = _treeid;
        params.indextype = _indextype;
        params.tablecode = _tablecode;
        params.pagetype = _pagetype;
        params.data = editform.getEditFormValues();
        if (_findex) {
            params.data["findex"] = _findex;
        }
        if (_indextype != "FINANCE") {
            params.data["framesystem"] = _indextype;
        }
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(service , "save", params, function(rs){
            if (rs && rs.success) {
                Ext.lt.ui.alert('保存成功！',function(){
                    parent.Ext.lt.pmkpi.query();
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