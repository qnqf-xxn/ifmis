if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.gdindexedit)
    Ext.lt.pmkpi.gdindexedit = {};

Ext.lt.pmkpi.gdindexedit = function(config, service){
    var cmp = {};
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var _treeid = config.treeid,
        _indextype = config.indextype,//财政还是部门
        _pagetype = config.pagetype,//修改/新增
        _viewtype = config.viewtype,//查看
        _sindexdata = [],//指标数据
        _tabtype = config.tabtype, //左侧树数据源页签类型
        _superid = config.superid,
        _indexframe = config.indexframe,//指标层次分类
        _workflow = config["workflow"],
        _treename = config.treename,//左侧树名称
        _findex;//一级指标
        window.parent.Ext.lt.pmkpi.childwindow = window;

    Ext.lt.message.hook("editform", "drawed",function(resp){
        var table_eva={
            computesign:{
                change: function(param){
                    var ecomputesignstr = param._value.value;
                    if(ecomputesignstr != "6"){
                        editform.show(['unit'],false);
                    } else { //隐藏计量单位
                        editform.clear("unit");
                        editform.hide(['unit'],false);
                    }
                }
            },
            sindex:{
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
            var sindex = config.indexdata.sindex;
            for (var i=0; i<_indexframe.length; i++) {
                if (_indexframe[i].guid == sindex) {
                    editform.synchEditform({sindex:{text:_indexframe[i].name, value:sindex}});
                    break;
                }
            }
        }
    })

    cmp.save = function () {
        if (!editform.check()) return;//先校验
        var params = {};
        params.treeid = _treeid;
        params.indextype = _indextype;
        params.pagetype = _pagetype;
        params.tabtype = _tabtype;
        var editdata = editform.getEditFormValues();
        if (_pagetype != "mod") {
            editdata.agencyguid = _treeid;
            editdata.agency_code =_treeid;
            editdata.agency_name = _treename;
        }
        editdata.findex = _findex;
        if (!common.checkSpaceValue(editdata,null,"editform")) return;//校验空格
        editdata.name = convertStr(editdata.name);
        editdata.perf_ind_name = convertStr(editdata.perf_ind_name);
        editdata.indexval = convertStr(editdata.indexval);
        editdata.kpi_val = convertStr(editdata.kpi_val);
        params.data = editdata;
        params.workflow = _workflow;
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