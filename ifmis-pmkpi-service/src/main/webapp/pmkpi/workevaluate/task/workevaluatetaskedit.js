if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.workevaluate){
    Ext.lt.pmkpi.workevaluate = {};
}
Ext.lt.pmkpi.workevaluate.taskeditservice = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _bustype = config.bustype,
        _guid = config.guid,
        _viewtype = config.viewtype,
        _tabData = config.tabData,
        _taskyear = config.taskyear,
        _tablecode = config.tablecode,
        _taskprovince = config.taskprovince;

    $(function () {
        if (_viewtype == "query"){
            $("div[compid='toolbutton']").hide();
            $(".winfooter").hide();
        }
        Ext.lt.pmkpi.query();
    })

    /**
     * 查询
     */
    Ext.lt.pmkpi.query = function () {
        if(_viewtype != 'add'){
            var params = {};
            params.guid = _guid;
            params.tablecode = _tablecode;
            params.taskyear = _taskyear;
            params.taskprovince = _taskprovince;
            params.viewtype = _viewtype;
            Ext.lt.ui.loadingShow();
            Ext.lt.RCP.call(service , "editquery", params, function(rs) {
                if(rs && rs.success){
                    var editdatas = rs.data;
                    editdatas[0]["taskyear"] = _taskyear;
                    editform.synchEditformByObj(editdatas[0]);
                    Ext.lt.ui.loadingClose();
                }
            });
            Ext.lt.ui.loadingClose();
        } else {
            var editinfo = {};
            editinfo["taskyear"] = _taskyear;
            editform.synchEditformByObj(editinfo);
        }
        _isQuery = true;
    }

    /**
     * 保存
     */
    cmp.save = function(){
        if (!editform.check()) return;//先校验
        var datas = editform.getEditFormValues();
        datas.guid = _guid;
        var startdate = parseInt(datas.startdate);
        var enddate = parseInt(datas.enddate);
        if (startdate > enddate) {
            Ext.lt.ui.alert("【结束时间】不能小于【开始时间】",function(){
            });
            return;
        }
        /*if(_viewtype == 'add'){
            var newguid = Ext.lt.RCP.asyncall(service , "getGuid", null);
            _guid = newguid;
            datas.guid = newguid;
        }*/
        var params = {};
        params.tablecode = _tablecode;
        params.bustype = (_bustype == undefined) ? datas.bustype : _bustype;
        params.datas = datas;
        params.viewtype = _viewtype;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(service , "infosave", params, function(rs) {
            if(rs && rs.success){
                Ext.lt.ui.alert('保存成功！',function(){
                    _guid = datas.guid;
                    _viewtype = "mod";
                    Ext.lt.pmkpi.query();
                    parent.Ext.lt.pmkpi.query();
                });
            }
            Ext.lt.ui.loadingClose();
        }, function() {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('保存失败！',function(){
            });
        });
    }

    /**
     * 关闭页面
     */
    cmp.close = function () {
        Ext.lt.ui.closeModalWindow();
        window.parent.Ext.lt.pmkpi.query();
    }

    /**
     * 页签方法
     */
    cmp.clickTabpage = function(obj){
        obj.isquerydata = true;//是否不走查询
        common.tabpageOnclick(obj, _tabData, toolbutton);
    }

    Ext.lt.message.hook("editform", "drawed",function(obj){
        var config = obj.configs;
        _tablecode = _tablecode == null ? config[0].tablecode : _tablecode;
        var table_eva={
            tasktype : {
                change: function(param){
                    if (param.sels && param.sels.length == 1) {
                        _bustype = param.sels[0].superitemid != null ? param.sels[0].superitemid : _bustype;
                    } else {
                        _bustype = "";
                    }
                }
            }
        }
        obj.editformpanel.attachEvent(table_eva);
    });

    /**
     * 保存编辑区之前封装参数
     */
    Ext.lt.message.hook("perfcommon", "beforesave",function(obj){
        var datas = editform.getEditFormValues();
        datas.guid = _guid;
        obj.params.tablecode = _tablecode;
        obj.params.viewtype = _viewtype;
        obj.params.bustype = (_bustype == undefined) ? datas.bustype : _bustype;
        obj.params.datas = datas;
    });

    Ext.lt.message.hook("perfcommon", "iframeinit", function(obj){
        var params = obj.params;
        params.viewtype = _viewtype;
        params.mainguid = _guid;
        params.taskyear = _taskyear;
        params.taskprovince = _taskprovince;
    })

    return cmp;
}