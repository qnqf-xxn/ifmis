if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.wfparallel){
    Ext.lt.pmkpi.wfparallel = {};
}

Ext.lt.pmkpi.wfparallel.wfparallelservice = function(config, service){
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};

    var _menuid = config.menuid,//菜单id
        _proworkflow = config.proworkflow,//项目工作流guid
        _deptworkflow = config.deptworkflow,//部门工作流guid
        _tablecode,
        _workflow,//工作流guid
        _datasource,//数据源集合
        _prolev = config.prolev,//项目级次
        _deptcoldatas = config.deptcoldatas,//部门列数据
        _depttabledata = config.depttabledata,//部门表数据
        _deptqfdatas = config.deptqfdatas,//部门查询区数据
        _proqfdatas = config.proqfdatas,//项目查询区数据
        _procoldatas = config.procoldatas,//项目列数据
        _protabledata = config.protabledata,//项目表数据
        _prokey = config.prokey,//项目key
        _deptkey = config.deptkey,//部门key
        _modeltype = config.modeltype,
        _prouikey = config.prouikey,
        _proordinaryuikey = config.proordinaryuikey,
        _deptuikey = config.deptuikey,
        _aduithide = config.aduithide,
        _defquery,//列表查询条件
        _tabfilter,//页签查询条件
        _tabcode,//页签编码
        _saveAgency,//左侧树选择单位
        _lefttreename = config.lefttreename,//左侧评价对象树名称 默认项目支出
        _lefttabtype = config.lefttabtype,//左侧树页签guid 默认项目支出
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;
    var isfirst=true;

    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        _saveAgency = "treeroot";
        Ext.lt.pmkpi.isleaf = '0';
        _lefttabtype = obj["code"];
        var data;
        var key;
        var cols;
        if (_lefttabtype == "program"){
            _defquery = _protabledata.defquery;
            _tablecode = _protabledata.tablecode;
            _lefttreename = "项目支出";
            cols = _procoldatas
            data = _proqfdatas;
            key = _prokey;
            _workflow = _proworkflow;
        } else if (_lefttabtype == "dept") {
            _defquery = _depttabledata.defquery;
            _tablecode = _depttabledata.tablecode;
            key = _deptkey;
            _lefttreename = "部门整体"
            cols = _deptcoldatas;
            data = _deptqfdatas;
            _workflow = _deptworkflow;
        }
        var params = {};
        params.tablecode = _tablecode;
        params.cols = cols;
        try{
            _datasource = Ext.lt.RCP.asyncall(service , "getDataSource", params);
            deptcmp.setColMapper(cols);
        }catch (e) {}
        cmp.setTableColum(cols);
        deptcmp.setworkflow(_workflow);
        queryfrom(data,key);
        var params = {};
        params.menuid = _menuid;
        params.tablecode = _tablecode;
        params.lefttabtype = _lefttabtype;
        params.modeltype = _modeltype;
        params.menuid = _menuid;
        var datalist = Ext.lt.RCP.asyncall(service , "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
        Ext.lt.pmkpi.query();
        obj.datas = datalist
        return obj;
    }

    function queryfrom(data, key) {
        var configqueryform = {
            id: "queryform",
            fastquery : true,
            datatable : 'datatable',
            drawmode :'div',
            key: key,
            label: "快速查询",
            labelwidth: "120",
            appid: "pmkpi",
            config: null,
            serverid: key,
            amtmaxlength:18,
            columnsize: 5,
            data: data
        }
        queryform = new Ext.lt.bus.ui.querypanel(configqueryform);
        queryform.draw($(".busquerypanel_outline")[0]);
    }

    $(function (){
        isfirst = false;
        var params = {};
        params.ordernum = 0;
        params.code = _lefttabtype;
        tabChange(params);
    })

    //查询
    cmp.query = function (obj){
        Ext.lt.pmkpi.query();
    }

    Ext.lt.pmkpi.query = function(){
        if(!_saveAgency){
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.menuid = _menuid;
        params.tabcode = _tabcode;
        params.prolev = _prolev;
        params.saveAgency = _saveAgency;
        params.isleaf = Ext.lt.pmkpi.isleaf+"";
        params.tabfilter = _tabfilter;
        params.workflow = _workflow;
        params.lefttabtype = _lefttabtype;
        params.modeltype = _modeltype;
        deptcmp.setColDatasource(_datasource, datatable);
        params.beanid = "pmkpi.wfparallel.audit.WfParallelAuditBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    /**
     * 左侧树点击
     */
    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode){ //不选择预算单位按类型查询
            _saveAgency = treeNode.guid;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        cmp.query();
    });

    /**
     * 动态配置表格的列.
     *
     * @param data --
     */
    cmp.setTableColum = function(cols){
        var c = [];
        var tmainCol = datatable.getCols();
        c.push(tmainCol[0]);
        c.push(tmainCol[1]);
        for (var i=0; i<cols.length; i++) {
            c.push(cols[i]);
        }
        datatable.setCols(c);
        datatable.headsort(false);
        datatable.setAllowcustom(false);
        datatable.setAllowClock(false);
        var page = {};
        page.columns = "*";
        datatable.setPage(page);
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw();
    }

    //送审情况
    cmp.queryaudit = function (){
        deptcmp.auditquery(datatable);
    }

    //页签方法
    cmp.clickTabpage = function(obj){
        deptcmp.changTooltoolbuttontStatus(0,obj.hidebtns);
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        if (!isfirst) { //首次不走查询
            Ext.lt.pmkpi.query();
        }
    }

    /**
     * 查看明细
     */
    cmp.detailed = function (){
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据进行查看！",function(){});
            return;
        }
        var params = {};
        var _uikey = "";
        if(_modeltype && _modeltype == "trace"){
            params.guid = data[0].proguid;
            params.projguid = data[0].proguid;
            params.agency = data[0].agencyguid;
            params.workflow = data[0].wfid;
            params.wfstatus = data[0].wfstatus;
            params.bustype = _lefttabtype;
            params.taskguid = data[0].taskguid;
            params.pagetype = _lefttabtype;
            params.procode = data[0].pro_code;
            if (_lefttabtype && "program" == _lefttabtype) { //项目支出
                if (data[0].provincetask == "1") {
                    _uikey = _prouikey;
                } else {
                    _uikey = _proordinaryuikey;
                }

            } else if (_lefttabtype && "dept" == _lefttabtype) { //部门整体
                _uikey = _deptuikey;
            }
            params.uikey = _uikey;

        }
        if(_modeltype && _modeltype == "dept"){
            params.guid = data[0].proguid;
            params.mainguid = data[0].proguid;
            params.agency = data[0].agencyguid;
            params.workflow = data[0].wfid;
            params.wfstatus = data[0].wfstatus;
            params.uikey = _deptuikey;
            _uikey = _deptuikey;
            params.viewtype = "query";
        }
        var url = _uikey + ".page";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"绩效目标调整-"+_lefttreename);
    }

    Ext.lt.pmkpi.audit = function(obj) {
        cmp.wfAudit(obj);
    }

    //送审/审核
    cmp.wfAudit = function (obj) {
        var actionname = obj.name;
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + actionname + "的数据！", function () {
            });
            return;
        }
        if (!deptcmp.checkwfstatus(datas)) return false;//先校验审核状态是否一致
        var params = {};
        params.datas = datas;
        params.tablecode = _tablecode;
        params.workflow = _workflow;
        params.auditdata = Ext.lt.pmkpi.auditdata;
        params.mainguid = datas[0].guid;
        params.procode = datas[0].pro_code;
        params.bustype = _lefttabtype;
        if (_modeltype != null && _modeltype == "trace") {
            params.busguid = _lefttabtype + _aduithide + "_" + datas[0].wfstatus;
            _aduithide
        }else if (_modeltype != null && _modeltype == "trace") {
            params.busguid = _menuid + "_" + datas[0].wfstatus;
        }
        deptcmp.doAction(obj, params);
    }

    //审核
    cmp.audit = function (obj){
        var data = datatable.getSelected();
        if(data.length != 1){
            Ext.lt.ui.alert( "请选择一条数据进行审核！",function(){
            });
            return;
        }
        var url = "/pmkpi/audit/view.page";
        var params = {};
        var _uikey = "";
        if(_modeltype && _modeltype == "trace"){
            params.guid = data[0].proguid;
            params.mainguid = data[0].proguid;
            params.projguid = data[0].proguid;
            params.saveAgency = data[0].agencyguid;
            params.agency = data[0].agencyguid;
            params.workflow = data[0].wfid;
            params.wfstatus = data[0].wfstatus;
            params.bustype = _lefttabtype;
            params.taskguid = data[0].taskguid;
            params.pagetype = _lefttabtype;
            params.procode = data[0].pro_code;
            params.viewtype = "query";
            if (_lefttabtype && "program" == _lefttabtype) { //项目支出
                if (data[0].provincetask == "1") {
                    _uikey = _prouikey;
                } else {
                    _uikey = _proordinaryuikey;
                }

            } else if (_lefttabtype && "dept" == _lefttabtype) { //部门整体
                _uikey = _deptuikey;
            }
            params.uikey = _uikey;

        }
        if(_modeltype && _modeltype == "dept"){
            params.guid = data[0].proguid;
            params.mainguid = data[0].proguid;
            params.agency = data[0].agencyguid;
            params.workflow = data[0].wfid;
            params.wfstatus = data[0].wfstatus;
            params.uikey = _deptuikey;
            params.viewtype = "query";
        }
        params.busguid = _menuid + "_" + data[0].wfstatus;
        var nodemap = Ext.lt.RCP.asyncall(service, "queryPrevAuditType", [data[0].wfid, data[0].wfstatus]);
        params.nodeguid = nodemap.nodeguid;
        params.audittype = nodemap.audittype;
        if (!nodemap.audittype || nodemap.audittype == "" || nodemap.audittype == "null" ) {
            Ext.lt.ui.alert( "请对流程审核节点进行配置！",function(){
            });
            return;
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight,"绩效审核");
    }

    Ext.lt.message.hook("perfcommon", "auditquery",function(){
        Ext.lt.pmkpi.query();
        try {
            Ext.lt.ui.closeModalWindow();
        } catch (e) {
            Ext.lt.ui.modalWindow.close();
        }
    });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    /**
     * 查看项目明细
     */
    cmp.prodetailed = function (){
        var params = {};
        var data = datatable.getSelected();
        params.submenu = _menuid;
        params.pro_code = data[0].pro_code;
        deptcmp.proinfoview(datatable,params);
    }

    return cmp;
}