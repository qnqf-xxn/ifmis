if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.financialevaluation){
    Ext.lt.pmkpi.financialevaluation = {};
}
if(!Ext.lt.pmkpi.financialevaluation){
    Ext.lt.pmkpi.financialevaluation = {};
}

Ext.lt.pmkpi.financialevaluation.query = function(config, service){
    var cmp = {};
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var _menuid = config.menuid,//菜单id
        _leftmenuid,//隐藏菜单
        _proworkflow = config.proworkflow,//项目工作流guid
        _finqueryhide = config.finqueryhide,
        _lefttab = config.lefttab,//左侧树第一个页签
        _lefttabtype = _lefttab.code,//左侧树页签类型
        _lefttreename,//左侧评价对象树名称
        _datasource,//数据源集合
        _workflow,//工作流guid
        _tabcode,//页签code
        _tabfilter,//页签过滤条件
        _defquery,
        _prolev = config.prolev,//项目级次
        _displaycols = [],
        _saveAgency,//左侧树选择单位
        _bustype,
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;
    var isfirst=true;
    var _isNINGXIA = config.isNINGXIA;
    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        _saveAgency = "treeroot";
        Ext.lt.pmkpi.isleaf = '0';
        _workflow = obj.leftwfid;
        _lefttabtype = obj["code"];
        _lefttreename = obj["name"];
        _leftmenuid = obj.leftmenuid;
        _bustype = _lefttabtype;
        cmp.setTableColum();
        deptcmp.setworkflow(_workflow);
        var treedatas =Ext.lt.pmkpi.querytree();
        Ext.lt.pmkpi.query();
        obj.datas = treedatas;
        return obj;
    }

    Ext.lt.pmkpi.querytree = function (){
        var params = {};
        params.menuid = _menuid;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        params.bustype = _bustype;
        var datalist = Ext.lt.RCP.asyncall(service , "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
        return datalist;
    }

    $(function (){
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        deptcmp.initDatatable();
        if (isfirst) {
            isfirst = false;
        }
        tabChange(_lefttab);
    })

    Ext.lt.pmkpi.query = function(){
        if(!_saveAgency){
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.menuid = _menuid;
        params.prolev = _prolev;
        params.saveAgency = _saveAgency;
        params.isleaf = Ext.lt.pmkpi.isleaf+"";
        params.workflow = _workflow;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        params.tabfilter = _tabfilter;
        params.tabcode = _tabcode;
        params.tablesql = _defquery;
        params.beanid = "pmkpi.evaluation.financial.query.FinancialQueryBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        deptcmp.setColDatasource(_datasource, datatable);
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    Ext.lt.message.hook("datatable", "drawed",function(obj){
        var uiconfig = obj.uiconfig;
        _defquery = uiconfig.defquery;
    });

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
        Ext.lt.pmkpi.query();
    });

    /**
     * 动态配置表格的列.
     *
     * @param data --
     */
    cmp.setTableColum = function(){
        var cols = datatable.getCols(); //获取列表所有列
        cols.push.apply(cols, _displaycols);
        _displaycols = [];
        for (var i = 0, len = cols.length; i < len; i++) {
            var col = cols[i];
            var config = eval(col.config);
            if (_lefttabtype == "program") {
                if (config && config.isdept == 1) {
                    _displaycols.push(col); //隐藏前暂存至sfagency;
                    col.display = false; //display置为false，隐藏
                } else {
                    col.display = true;
                }
            } else if (_lefttabtype == "dept") {
                if (config && config.ispro == 1) {
                    _displaycols.push(col); //隐藏前暂存至sfagency;
                    col.display = false; //display置为false，隐藏
                } else {
                    col.display = true;
                }
            }
        }
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw(); //从新绘制表格
    }

    /**
     * 查看项目明细
     */
    cmp.detailed = function (){
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据进行查看！",function(){});
            return;
        }
        var params = {};
        params.mainguid = data[0].guid;
        params.saveAgency = data[0].agencyguid;
        params.projguid = data[0].proguid;
        params.projcode = data[0].pro_code;
        params.viewtype = "query";
        params.workflow = _workflow;
        params.prolev = _prolev;
        params.bustype = _lefttabtype;
        var url = "";
        if (_lefttabtype && "program" == _lefttabtype) { //项目支出
            if (_isNINGXIA){
                url = "/pmkpi/evaluation/finconfirm/proeditnx.page";
            } else {
                url = "/pmkpi/evaluation/finconfirm/proedit.page";
            }
        } else if (_lefttabtype && "dept" == _lefttabtype) { //部门整体
            url = "/pmkpi/evaluation/finconfirm/deptedit.page";
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"财政评价审核-"+_lefttreename);
    }

    /**
     * 查看项目
     */
    cmp.showProjView = function (obj){
        var params = {};
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据进行查看！",function(){});
            return;
        }
        params.proguid = data[0].proguid;
        var xmxxEditobject = Ext.lt.RCP.asynserver("pmkpi.doubleprocess.TlpJxAuditService", "getProInfo", params);
        if(xmxxEditobject.length>0){
            params.submenu = _menuid;
            params.pro_code = data[0].pro_code;
            var pro_lev = xmxxEditobject[0].pro_lev;
            if(pro_lev && pro_lev == "2"){
                deptcmp.proinfoview(datatable,params);
            }else {
                params.vchtypeid = xmxxEditobject[0].vchtypeid;
                params.projectkind = xmxxEditobject[0].projectkind;
                deptcmp.queryPromain(datatable,params);
            }
        }else{
            Ext.lt.ui.alert("未查询到该项目的项目库信息数据！",function(){});
        }
    }

    /**
     * 审核情况
     */
    cmp.queryaudit = function (){
        deptcmp.auditquery(datatable);
    }

    /**
     * 查看自评信息
     */
    cmp.queryassessment = function (){
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据进行查看！",function(){});
            return;
        }
        var params = {};
        params.mainguid = data[0].guid;
        params.proguid = data[0].proguid;
        params.workflow = _workflow;
        params.bustype = _lefttabtype;
        params.viewtype = "query";
        params.saveAgency = data[0].agencyguid;
        var url = "";
        if (_lefttabtype && "program" == _lefttabtype) { //项目支出
            url = "/pmkpi/evaluation/financial/deptfill/proedit.page";
        } else if (_lefttabtype && "dept" == _lefttabtype) { //部门整体
            url = "/pmkpi/evaluation/financial/deptfill/deptedit.page";
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "查看自评信息-" + _lefttreename);
    }
    /**
     * 批量导出评分表附件
     */
    cmp.batchExp = function(obj) {
        var buttonconfig = eval('(' + obj.config + ')');
        var data = datatable.getSelected();
        if(data.length < 1){
            Ext.lt.ui.alert( "请选择数据进行附件导出！",function(){
            });
            return;
        }
        var list = [];
        for (var i = 0; i < data.size(); i++) {
            var params = {};
            params.guid = data[i].guid;
            params.name = data[i].name;
            params.code = data[i].code;
            list.push(params);
        }
        var params = {};
        params.bustype =  _bustype + "evaluatescore" ; //  + "deptscore"    文件表类型
        params.list = list;
        params.tokenid = Ext.lt.token.getTokenid();
        params.zipname = buttonconfig.zipname;
        // var ins = Ext.lt.RCP.down("pmkpi.selfEvalService",'batchExp',config,'downframe');
        var ins = Ext.lt.RCP.down("pmkpi.evaluation.financial.query.FinancialQueryService",'batchExp',params,'downframe');
        // Ext.lt.RCP.asyncall(service , "batchExp", config);
    }

    cmp.queryresult = function(obj){
        var params = {};
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选择一条数据进行查看！",function(){});
            return;
        }

        params.viewtype = "query";
        params.mainguid = data[0].guid;
        params.proguid = data[0].proguid;
        params.procode = data[0].pro_code;
        params.workflow = _workflow;
        params.bustype = _lefttabtype;
        params.saveAgency = data[0].agencyguid;
        var url = "";
        if (_lefttabtype && "program" == _lefttabtype) { //项目支出
            if (_isNINGXIA){
                url = "/pmkpi/evaluation/financial/result/editnx.page";
            } else {
                url = "/pmkpi/evaluation/financial/result/edit.page";
            }
        } else if (_lefttabtype && "dept" == _lefttabtype) { //部门整体
            if (_isNINGXIA){
                url = "/pmkpi/evaluation/financial/result/depteditnx.page";
            } else {
                url = "/pmkpi/evaluation/financial/result/deptedit.page";
            }
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "上传结果-" + _lefttreename);
    }

    Ext.lt.message.hook("perfcommon", "auditquery",function(){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    /**
     * 批量导出批量导出所有附件 (指标完成情况及评价成果附件)
     */
    cmp.allFileExp = function(obj) {
        var buttonconfig = eval('(' + obj.config + ')');
        var data = datatable.getSelected();
        if(data.length < 1){
            Ext.lt.ui.alert( "请选择数据进行附件导出！",function(){
            });
            return;
        }
        var list = [];
        for (var i = 0; i < data.size(); i++) {
            var params = {};
            params.guid = data[i].guid;//数据id
            params.name = data[i].name;//名称
            params.code = data[i].pro_code;//项目编码
            params.agency = data[i].agencyguid;//单位
            list.push(params);
        }
        var params = {};
        params.bustype =  _lefttabtype + "finevalindexfile" ; // 文件表类型
        params.fileexptype = "finevaluation"; //附件导出类型: 财政评价
        params.list = list;
        params.tokenid = Ext.lt.token.getTokenid();
        params.zipname = buttonconfig.zipname;
        var ins = Ext.lt.RCP.down("pmkpi.perfcommon.fileexp.FileExpService",'indexFileExp',params,'downframe');
    }

    return cmp;
}