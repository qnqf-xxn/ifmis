if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.problemtaskinfo) {
    Ext.lt.pmkpi.problemtaskinfo = {};
}
Ext.lt.pmkpi.problemtaskinfo = function (config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var serviceid = service,
        _workflow = config.workflow,
        _taskguid = config.taskguid,
        _mainguid = config.mainguid,
        _saveAgency = config.saveAgency,
        _pagetype = config.pagetype,
        _viewtype = config.viewtype,
        _jsfiltersql = config.jsfiltersql;
        _curprovince = config.curprovince,
        _curyear = config.curyear,
        _busguid = config.busguid;//审核定义guid
    var cmp = {};
    var editformname;
    if(_pagetype == "issue"){
        editformname = "infoeditform";
    }else if(_pagetype == "feedback"){
        editformname = "feedbackeditform";
    }else if(_pagetype == "plan"){
        editformname = "planeditform";
    }
    var editformobj;

    /**
     *获取消息处理自定义过滤条件-编辑区
     */
    Ext.lt.message.hook("buseditform", "jsfiltersql", function (obj) {
        obj.jsfiltersql = _jsfiltersql;
    });

    cmp.query = function(isquery){
        var params = {};
        params.taskguid = _taskguid;
        params.mainguid = _mainguid;
        params.saveAgency = _saveAgency;
        params.pagetype = _pagetype;
        params.compconfigid = editformname;
        params.url = editformobj.cfg.pageurl;
        params.viewtype = _viewtype;
        params.curprovince = _curprovince;
        params.curyear = _curyear;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "getData", params, function(rs){
            editformobj.synchEditformByObj(rs.data);
            setMidSaveHidButtons(rs);
            Ext.lt.ui.loadingClose()
            if (isquery) {
                parent._isQuery = true;
            }
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }

    cmp.save = function(){
        if (!editformobj.check()) return false;//先校验
        var params = {};
        params.workflow = _workflow;
        params.datas = editformobj.getEditFormValues();
        if(_pagetype == "plan" && params.datas.evaluated_contact){
            var re = /^\d{11}$/;
            if(!re.test(params.datas.evaluated_contact)){
                Ext.lt.ui.alert("被评价单位联系方式请填写手机号！");
                return false;
            }
        }
        params.taskguid = _taskguid;
        params.mainguid = _mainguid;
        params.busguid = _busguid;
        params.saveAgency = _saveAgency;
        params.pagetype = _pagetype;
        params.compconfigid = editformname;
        params.url = editformobj.cfg.pageurl;
        var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
        if (rs && rs.success) {
            if(_pagetype == "issue"){// 问题任务编辑保存直接关闭
                parent.Ext.lt.ui.closeModalWindow();
            }else{
                parent.parent.Ext.lt.pmkpi.query();
            }
            cmp.query();
        }
        return rs;
    }

    /**
     * 暂存
     */
    cmp.savetmp = function (obj){
        var params = {};
        params.mainguid = _mainguid;
        params.data = editformobj.getEditFormValues();
        params.url = editformobj.cfg.pageurl;
        params.componentid = editformobj.cfg.server;
        params.compconfigid = editformname;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid , "midsave", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            cmp.query();
        }
        return rs;
    }

    /**
     * 清除暂存
     */
    cmp.savetmpdel = function (obj){
        var params = {};
        params.mainguid = _mainguid;
        params.url = editformobj.cfg.pageurl;
        params.componentid = editformobj.cfg.server;
        params.compconfigid = editformname;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid , "midsavedel", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            cmp.query();
        }
        return rs;
    }

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initEditForm();
        editformobj =eval(editformname);
        if (_viewtype == "query") {
            var cols = editformobj.cfg.data;
            var c = {};
            for (var i=0; i<cols.length; i++) {
                c[cols[i].colcode.toLowerCase()] = true;
            }
            editformobj.setdisabled(c);//设置基本信息不可编辑
        }
        cmp.query(true);
    })

    return cmp;
}
