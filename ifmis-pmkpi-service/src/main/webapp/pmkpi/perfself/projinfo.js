if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.selfprojinfo){
	Ext.lt.pmkpi.selfprojinfo = {};
}

Ext.lt.pmkpi.selfprojinfo = function(config, service){
    var serviceid = service,
        _projguid = config.projguid, //关联项目id.
        _bustype = config.bustype,
        _agencyguid = config.saveAgency,
        _workflow = config.workflow,
        _procode = config.procode,
        _viewtype = config.viewtype, //查询
        _busguid = config.busguid,
        _mainguid = config.mainguid, //主键
        _queryYear = config.queryYear,//跨年查询查询年度
        _queryProvince = config.queryProvince,//跨年查询查询区划
        _type = config.type; //区分部门综合评价或自评
    var cmp = {};
    
    cmp.query = function(isquery){
        var params = {};
        if (typeof (selfeditform) != 'undefined' && selfeditform){
            var temptable = selfeditform.cfg["table"];
            params.downtable = temptable;//表的table.
        }
        params.uptable = editform.cfg["table"];//显示的主表
        params.type = editform.cfg["type"];//bumen
        params.projguid = _projguid;
        params.procode = _procode; //项目code
        params.agencyguid = _agencyguid;
        params.bustype = _bustype;
        params.mainguid = _mainguid; //主键
        params.compconfigid = "editform";
        params.url = editform.cfg.pageurl;
        params.queryYear = _queryYear;
        params.queryProvince = _queryProvince;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
            var upinfo = rs.upinfo[0];
            var cols = editform.cfg.data;
            var c = {};
            for (var i=0; i<cols.length; i++) {
                c[cols[i].colcode.toLowerCase()] = true;
            }
            editform.setdisabled(c);//设置基本信息不可编辑
        	editform.synchEditformByObj(upinfo);
            if (typeof (selfeditform) != 'undefined' && selfeditform){
                var downinfo = rs.downinfo[0];
                selfeditform.synchEditformByObj(downinfo);
            }
            Ext.lt.ui.loadingClose();
            setMidSaveHidButtons({hidButtons:"暂存"});
            parent._issavetmp = false;
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
     * 切换保存.
     * @returns {*}
     */
    cmp.save = function(){
        var params = {};
        var temptable = "";
        if (typeof (selfeditform) != 'undefined' && selfeditform){
            if (!selfeditform.check()) return false;//先校验
            temptable = selfeditform.cfg["table"];
            params.datas = selfeditform.getEditFormValues();
        }
        params.tablecode = temptable;
        params.projguid = _projguid;
        params.procode = _procode; //项目code
        params.bustype = _bustype;
        params.busguid = _busguid; //业务单据
        params.mainguid = _mainguid; //主键
        params.workflow = _workflow;
        var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
        return rs;
    }
    
    $(function () {
        cmp.query(true);
    })

    return cmp;
}