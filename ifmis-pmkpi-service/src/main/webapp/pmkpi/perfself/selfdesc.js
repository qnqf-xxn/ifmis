if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.selfdesc){
    Ext.lt.pmkpi.selfdesc = {};
}

Ext.lt.pmkpi.selfdesc = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var serviceid = service,
        _mainguid = config.mainguid,
        _projguid = config.projguid,
        _procode = config.procode,
        _saveAgency = config.saveAgency,
        _bustype = config.bustype,
        _viewtype = config.viewtype,
        _savetable,//保存的表
        _queryYear = config.queryYear,//跨年查询查询年度
        _queryProvince = config.queryProvince,//跨年查询查询区划
        _busguid = config.busguid;//审核定义guid
    var _isNINGXIA = config.isNINGXIA;
    var _isGUANGXI = config.isGUANGXI;
    var cmp = {};
    
    cmp.query = function(isquery){
        var params = {};
        params.mainguid = _mainguid;
        params.projguid = _projguid;
        params.procode = _procode; //项目code
        params.saveAgency = _saveAgency;
        params.bustype = _bustype;
        params.compconfigid = "editform";
        params.url = editform.cfg.pageurl;
        params.viewtype = _viewtype;
        params.queryYear = _queryYear;
        params.queryProvince = _queryProvince;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
        	editform.synchEditformByObj(rs.data);
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
    /**
     * 保存.
     * @returns {*}
     */
    cmp.save = function(){
        var data = editform.getEditFormValues();
        if (!editform.check()) return false;//先校验
        if (_isNINGXIA){
            if (data.score < 80 && !data.rectification) {
                Ext.lt.ui.alert("总分在80分以下时[存在的问题]必填！");
                return false;
            }
            if (data.score < 80 && !data.deviationanaly) {
                Ext.lt.ui.alert("总分在80分以下时[整改措施]必填！");
                return false;
            }
        }
        if (_isGUANGXI) {
            var bgtremark = data.bgtremark;
            if (Math.abs(data.bgtrate) >= 30 && data.score > 90 && !bgtremark) {
                Ext.lt.ui.alert("预算调整率超30%,自评总得分不能超过90分，请调整自评得分或在预算调整超30%原因说明中填写原因！");
                return false;
            }
            if (bgtremark && bgtremark.match(RegExp("[ *_-]")) != null) {
                Ext.lt.ui.alert("预算调整超30%原因说明中填写原因填报不符合规范，请重新填写。", {timeout: 1}, function () {
                });
                return false;
            }
        }
        var params = {};
        params.datas = data;
        params.tablecode = _savetable; //保存的表
        params.mainguid = _mainguid;
        params.projguid = _projguid;
        params.procode = _procode; //项目code
        params.busguid = _busguid;
        params.saveAgency = _saveAgency;
        params.bustype = _bustype;
        params.compconfigid = "editform";
        params.url = editform.cfg.pageurl;
        var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
        if (rs && rs.success) {
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
        params.data = editform.getEditFormValues();
        params.url = editform.cfg.pageurl;
        params.componentid = editform.cfg.server;
        params.compconfigid = "editform";
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
        params.url = editform.cfg.pageurl;
        params.componentid = editform.cfg.server;
        params.compconfigid = "editform";
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid , "midsavedel", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            cmp.query();
        }
        return rs;
    }

    $(function () {
        _savetable = editform.cfg.table;
        cmp.query(true);
        if (_viewtype == "query") {
            var cols = editform.cfg.data;
            var c = {};
            for (var i=0; i<cols.length; i++) {
                c[cols[i].colcode.toLowerCase()] = true;
            }
            editform.setdisabled(c);//设置基本信息不可编辑
        }
    })

    return cmp;
}