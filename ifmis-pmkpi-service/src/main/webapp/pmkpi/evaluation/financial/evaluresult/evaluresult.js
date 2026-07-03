if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.evaluresult){
    Ext.lt.pmkpi.evaluresult = {};
}

Ext.lt.pmkpi.evaluresult = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var serviceid = service,
        _mainguid = config.mainguid,
        _proguid = config.proguid,
        _procode = config.procode,
        _savetable,//保存的表
        // _saveAgency = config.saveAgency,
        // _bustype = config.bustype,
        _viewtype = config.viewtype,
        _busguid = config.busguid;//审核定义guid
    var cmp = {};
    
    cmp.query = function(isquery){
        var params = {};
        params.mainguid = _mainguid;
        params.tablecode = _savetable; //保存的表
        params.proguid = _proguid;
        params.procode = _procode; //项目code
        // params.saveAgency = _saveAgency;
        // params.bustype = _bustype;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
        	editform.synchEditformByObj(rs.data);
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
    /**
     * 保存.
     * @returns {*}
     */
    cmp.save = function(){
        if (!editform.check()) return false;//先校验
        // if (!editform.haschange()){ //数据没有变化,不进行后台保存
        //     var obj = {};
        //     obj.success = true;
        //     return obj;
        // }
        var params = {};
        params.datas = editform.getEditFormValues();
        params.tablecode = _savetable; //保存的表
        params.mainguid = _mainguid;
        params.proguid = _proguid;
        params.procode = _procode; //项目code
        params.busguid = _busguid;
        // params.saveAgency = _saveAgency;
        // params.bustype = _bustype;
        var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
        if (rs && rs.success) {
            cmp.query();
        }
        return rs;
    }

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initEditForm();
        var cols = editform.cfg.data;
        if (_viewtype == "query") {
            var cols = editform.cfg.data;
            var c = {};
            for (var i=0; i<cols.length; i++) {
                c[cols[i].colcode.toLowerCase()] = true;
            }
            editform.setdisabled(c);//设置基本信息不可编辑
        }
        _savetable = editform.cfg.table;
        cmp.query(true);
    })

    return cmp;
}