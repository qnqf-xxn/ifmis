if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.financialevaluation){
    Ext.lt.pmkpi.financialevaluation = {};
}
if(!Ext.lt.pmkpi.financialevaluation){
    Ext.lt.pmkpi.financialevaluation = {};
}

Ext.lt.pmkpi.financialevaluation.audit = function(config, service){
    var cmp = {};
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var _menuid = config.menuid,//菜单id
        _leftmenuid,//隐藏菜单
        _proworkflow = config.proworkflow,//项目工作流guid
        _finaudithide = config.finaudithide,
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
        common.setworkflow(_workflow);
        common.setTabNum(obj);
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
        common.initDatatable();
        var _lefttab = lefttree.getActiveTabCfg();
        //查询之前处理待送审，还是被退回页签
        common.pendingtasktab();
        tabChange(_lefttab);
        isfirst = false;
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
        params.beanid = "pmkpi.evaluation.financial.audit.FinancialAuditBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        common.setColDatasource(_datasource, datatable);
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

    //送审情况
    cmp.queryaudit = function (){
        common.auditquery(datatable);
    }

    //页签方法
    cmp.clickTabpage = function(obj){
        common.changTooltoolbuttontStatus(0,obj.hidebtns);
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        if (!isfirst) { //首次不走查询
            Ext.lt.pmkpi.query();
        }
    }

    /**
     *工作流.
     */
    cmp.wfAudit = function (obj){
        var datas = datatable.getSelected();
        var actionname = obj.name;
        var actioncode = obj.code;
        if (actionname == "审核") {
            if (datas.length != 1) {
                Ext.lt.ui.alert("请选择一条数据进行" + actionname + "！",function(){});
                return;
            }
            var params = {};
            params.mainguid = datas[0].guid;
            params.saveAgency = datas[0].agencyguid;
            params.projguid = datas[0].proguid;
            // params.viewtype = "query";
            params.workflow = _workflow;
            params.prolev = _prolev;
            params.bustype = _lefttabtype;
            params.audittype = "finaudit";
            params.actioncode = actioncode;
            var url = "/pmkpi/evaluation/financial/auditedit.page";
            url = Ext.lt.pmkpi.genPageUrl(url, params);
            Ext.lt.ui.openModalWindow(url, scrWidth * 0.7, scrHeight * 0.7, "财政评价审核-" + _lefttreename);
        } else {
            if (datas.length <= 0) {
                Ext.lt.ui.alert("请选择数据进行" + actionname + "！",function(){});
                return;
            }
            if (!common.checkwfstatus(datas)) return false;//先校验审核状态是否一致
            var params = {};
            params.datas = datas;
            params.busguid = _lefttabtype + _finaudithide + "_" + datas[0]["wfstatus"];
            common.doAction(obj, params);
        }

    }

    /**
     * 委托中介
     */
    cmp.intermediary = function (obj){
        var params = {};
        var data = datatable.getSelected();
        if(!data || data.length <= 0){
            Ext.lt.ui.alert("请选择数据进行指派中介！",function(){});
            return;
        }
        params.pagetype = "intermediary";
        if (data.length == 1) {
            params.pagetype = "intermediaryquery";
            params.guid = data[0].guid;
            params.proguid = data[0].guid;
        }
        var url = "/pmkpi/evaluate/thirdevaluate/entrust.page";
        params.workflow = _workflow;
        params.maintablecode = "V_PERF_T_FINEVALUATION";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth*0.8, scrHeight*0.9, "指派中介");
    }

    /**
     * 委托专家
     */
    cmp.expert = function(){
        var params = {};
        var data = datatable.getSelected();
        if(!data || data.length <= 0){
            Ext.lt.ui.alert("请选择数据进行指派专家！",function(){});
            return;
        }
        params.pagetype = "expert";
        if (data.length == 1) {
            params.pagetype = "expertquery";
            params.guid = data[0].guid;
            params.proguid = data[0].guid;
        }
        var url = "/pmkpi/review/entrust/expert.page";
        params.workflow = _workflow;
        params.maintablecode = "V_PERF_T_FINEVALUATION";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth*0.8, scrHeight*0.9, "指派专家");
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
     * 下达评价通知
     */
    cmp.givenotice = function (obj) {
        var datas = datatable.getSelected();
        if(!datas || datas.length <= 0){
            Ext.lt.ui.alert("请选择数据！",function(){});
            return;
        }
        for (var i = 0; i < datas.length; i++) {
            var data = datas[0];
            if (data.isnotice == 1) {
                Ext.lt.ui.alert("已接收通知不能再次操作！",function(){});
                return;
            }
        }
        var type = obj.code;
        // if (type != null && "givenotice" == type) { //下达
        //     wheresql = " set t.isrelease = 1 ";
        // } else if (type != null && "ungivenotice" == type) { //取消下达
        //     wheresql = " set t.isrelease = 2";
        // }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.datas = datas;
        params.type = type;
        Ext.lt.RCP.call(service , "giveNotice", params, function(rs) {
            if (rs && rs.success) {
                Ext.lt.ui.alert(obj.name + '成功！', function () {
                    Ext.lt.pmkpi.query();
                });
            } else {
                Ext.lt.ui.alert(rs.code,function(){
                });
            }
            Ext.lt.ui.loadingClose();
        }, function() {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert(obj.name + '失败！',function(){
            });
        });
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
            url = "/pmkpi/evaluation/finconfirm/proedit.page";
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
                common.proinfoview(datatable,params);
            }else {
                params.vchtypeid = xmxxEditobject[0].vchtypeid;
                params.projectkind = xmxxEditobject[0].projectkind;
                common.queryPromain(datatable,params);
            }
        }else{
            Ext.lt.ui.alert("未查询到该项目的项目库信息数据！",function(){});
        }
    }

    /**
     * 发起监控整改
     */
    cmp.rectify = function () {
        var data = datatable.getSelected();
        if (!data || data.length != 1) {
            Ext.lt.ui.alert("请选中一条数据发起问题整改！", function () {
            });
            return;
        }
        var params = {};
        if (_lefttabtype == "program") { //项目支出
            params.bustype = '1';
            params.workflow = "D7F6D15AB0E47ECFE0533315A8C04610";
            params.tablecode = "V_PERF_PROJECT_INFO";
            var url = '/pmkpi/rectification/programAdd.page';
            //判断是否是财政评价新增项目 只有项目支出能新增
            if(!data || data[0].isadd == 1 ){
                params.isfinadd = data[0].isadd;
                params.tablecode = "V_PERF_T_FINEVALUATION";
                var url = '/pmkpi/rectification/financialAdd.page';
            }
        } else if (_lefttabtype == "dept") { //部门整体
            params.bustype = '3';
            params.workflow = "D7F6D15AB0E57ECFE0533315A8C04610";
            params.tablecode = "V_PERF_T_DEPTPERFDECLARE";
            var url = '/pmkpi/rectification/deptAdd.page';
        }
        var newguid = Ext.lt.RCP.asyncall(service , "getCreateguid", null);
        params.mainguid = newguid;
        params.guid = data[0].guid;
        params.projguid = data[0].proguid;
        params.pro_code = data[0].pro_code;
        params.lefttabtype = _lefttabtype;
        params.pagename = '财政评价';
        params.rectifyType = 'TRACE';
        params.lefttabname = _lefttreename;
        params.rectype = "rectifyfinancialeval";   //业务阶段:  rectifyfinancialeval:财政评价  绩效监控   绩效自评  部门评价
        params.menuid = _menuid;
        params.isfinal = "2";  //isfinal=1(已终审) isfinal = 2(未终审)
        //判断数据是否已发起整改
        var is = Ext.lt.RCP.asyncall(service , "getDataByGuid", params);
        if (is){
            Ext.lt.ui.alert("数据已发起整改，不能重复操作！", function () {
            });
            return;
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"整改通知新增 - "+_lefttreename);
    }

    //保存并送审  送审
    Ext.lt.pmkpi.sendandudit = function(obj,datas){
        var actionname = obj.name;
        var actioncode = obj.code;
        var params = {};
        params.actioncode = actioncode;
        params.tablecode = "perf_t_rectify";
        params.datas = datas;
        params.bustype = _lefttabtype;
        params.workflow = datas[0].wfid;
        params.busguid = _menuid + "_" + datas[0].wfstatus;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(service, "sendandudit", params, function(rt) {
            if (rt && rt.success == true) {
                Ext.lt.ui.alert(actionname + "成功！", function () {
                    Ext.lt.message.send("perfcommon", "auditquery", {});
                });
            }
        });
        Ext.lt.ui.loadingClose();
        Ext.lt.ui.modalWindow.close(); //关闭当前模态框
    }

    Ext.lt.message.hook("perfcommon", "auditquery",function(){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });


    return cmp;
}
