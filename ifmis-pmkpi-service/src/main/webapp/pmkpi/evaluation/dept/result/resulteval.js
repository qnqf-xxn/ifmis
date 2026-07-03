if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.resulteval){
    Ext.lt.pmkpi.resulteval = {};
}
Ext.lt.pmkpi.resulteval = function(config, service){
    var perfcommon = Ext.lt.pmkpi.perfcommon(config, service);
    window.parent.Ext.lt.pmkpi.childwindow = window;
    var cmp = {};
    var serviceid = service;
    var _mainguid = config.mainguid,
        _viewtype = config.viewtype,//区分是否查询:query是查询，其他可修改
        _bustype = config.bustype,
        _busguid = config.busguid,//审核定义guid
        _iswf = config.iswf,
        _tablecode = config.tablecode;
    //根据组件id存放表名
    Ext.lt.pmkpi.isadd = false;
    /**
     *
     * 基础信息保存
     */
    cmp.save = function (obj) {
        if (!editform.check()) return false; //编辑区必填校验
        var params = {};
        params.mainguid = _mainguid;
        params.infodata = editform.getEditFormValues();
        //params.busguid = _busguid;
        //params.workflow = _workflow;
        params.tablecode = _tablecode;
        params.bustype = _bustype;
        params.iswf = _iswf;
        var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
        return rs;
    }


    /**
     * 页面初始化加载，查看的话不显示按钮
     */
    $(function(){
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        perfcommon.initEditForm();
        _tablecode = editform.cfg.tablecode;
        _iswf = editform.cfg.iswf;
        var params = {};
        params.mainguid = _mainguid;
        params.tablecode = _tablecode;
        params.bustype = _bustype;
        params.iswf = _iswf;
        var editdata = Ext.lt.RCP.asyncall(serviceid , "getData", params);
        if (_viewtype == "query") {
            perfcommon.editSetdisabled(editform);
        }
        if (editdata  != null){
            editform.synchEditformByObj(editdata);
        }
        //document.getElementById('myInput').placeholder = '新的提示信息';
        parent._isQuery = true;
    });

    Ext.lt.message.hook("editform", "drawed",function(resp){
        var table_eva={
            eval_score : {
                change: function(param){
                    var eval_levlo;
                    var score = param.value;
                    if (score >= 90) {
                        eval_levlo = "优";
                    } else if (score >= 80) {
                        eval_levlo = "良";
                    } else if (score >= 60) {
                        eval_levlo = "中";
                    } else {
                        eval_levlo = "差";
                    }
                    var values = {};
                    values.eval_levlo = eval_levlo;
                    editform.getCol("eval_levlo").bind(values);
                }
            }
            // ,
            // eval_target:{
            //     change:function(param){
            //         var target =param.value;
            //         if(target.length>=200){
            //             var msg='年度目标实际完成情况字数限制200字，请检查！';
            //             resp.editformpanel.showValidate(false,"eval_target","warnning",msg);
            //         }
            //
            //     }
            // }
        }
        resp.editformpanel.attachEvent(table_eva);
    });

    return cmp;
}