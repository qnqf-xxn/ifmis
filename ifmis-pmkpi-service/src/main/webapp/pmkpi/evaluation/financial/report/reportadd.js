if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.reportadd){
    Ext.lt.pmkpi.reportadd = {};
}
Ext.lt.pmkpi.reportadd = function(config, service){
    var perfcommon = Ext.lt.pmkpi.perfcommon(config, service);
    window.parent.Ext.lt.pmkpi.childwindow = window;
    var cmp = {};
    var serviceid = service;
    var _mainguid = config.mainguid,
        _proguid = config.proguid,//项目guid
        _prolev = config.prolev,//项目级次
        _workflow = config.workflow,//工作流guid
        _viewtype = config.viewtype,//区分是否查询:query是查询，其他可修改
        _projcode = config.projcode,//项目编码
        _pro_code = config.pro_code,//项目编码
        _bustype = config.bustype,
        _busguid = config.busguid,//审核定义guid
        _iswf = config.iswf,
        _tablecode = config.tablecode;
        _year = config.year;
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
        params.busguid = _busguid;
        params.workflow = _workflow;
        params.tablecode = _tablecode;
        params.bustype = _bustype;
        params.iswf = _iswf;
        var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
        if (rs.success = true){
            window.parent.parent.Ext.lt.pmkpi.querytree();
        }
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
        params.proguid = _mainguid;
        params.prolev = _prolev;
        params.tablecode = _tablecode;
        params.bustype = _bustype;
        params.iswf = _iswf;
        if (_pro_code == null || _pro_code == ""){
            _pro_code = Ext.lt.RCP.asyncall(serviceid , "getProCode", params);
        }
        params.projcode = _pro_code;
        var editdata = Ext.lt.RCP.asyncall(serviceid , "getData", params);
        if (_viewtype == "query") {
            perfcommon.editSetdisabled(editform);
        }
        if (editdata  != null){
            editform.synchEditformByObj(editdata);
        } else {
            if (_viewtype == "add") {
                editdata = {"year":_year};
                editform.synchEditformByObj(editdata);
            }
        }
        parent._isQuery = true;
    });

    Ext.lt.message.hook("editform", "drawed",function(resp){
        var table_eva={
            dept_code : {
                change: function(param){
                    var dept_code = param._value.value;
                    if(dept_code) {
                        var params = {};
                        params.mainguid = dept_code;
                        params.tablecode = "PMKPI_FASP_T_PUBAGENCY"; // 单位数据源视图
                        var data = Ext.lt.RCP.asyncall(serviceid , "getdeptData", params);
                        params.mainguid = data.finintorgguid;
                        params.tablecode = "fasp_t_pubdepartment"; // 处室
                        var data = Ext.lt.RCP.asyncall(serviceid , "getdeptData", params);
                        var values = {};
                        var values1 = {};
                        values1.text = data.name;
                        values1.value = data.code;
                        values.finintorgguid = values1;
                        editform.getCol("finintorgguid").bind(values);
                    }
                }
            }
        }
        resp.editformpanel.attachEvent(table_eva);
    });
    return cmp;
}