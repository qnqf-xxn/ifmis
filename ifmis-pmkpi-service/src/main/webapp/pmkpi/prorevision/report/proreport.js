if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.prorevision){
    Ext.lt.pmkpi.prorevision = {};
}

Ext.lt.pmkpi.prorevision.revisionreportservice = function(config, service){
    var cmp = {};
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var _menuid = config.menuid,//菜单id
        _lefttreename,//左侧评价对象树名称 默认项目支出
        _lefthidebtn,//左侧树隐藏按钮
        _tabhidtbtn,//右侧页签隐藏按钮
        _lefttab = config.lefttab,//左侧树第一个页签
        _lefttabtype = _lefttab.code,//左侧树页签类型
        _tablecode,
        _workflow,//工作流guid
        _leftmenuid,//隐藏菜单
        _datasource,//数据源集合
        _prolev = config.prolev,//项目级次
        _deptqfdatas = config.deptqfdatas,//部门查询区数据
        _proqfdatas = config.proqfdatas,//项目查询区数据
        _defquery,//列表查询条件
        _tabfilter,//页签查询条件
        _tabcode,//页签编码
        _saveAgency,//左侧树选择单位
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;
    var isfirst=true;
    var _displaycols = [];
    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        _saveAgency = "treeroot";
        Ext.lt.pmkpi.isleaf = '0';
        _lefttabtype = obj["code"];
        _lefttreename = obj["name"];
        _workflow = obj.leftwfid;
        _lefthidebtn = obj.hidebtns;
        _leftmenuid = obj.leftmenuid;
        var data;
        var key;
        if (_lefttabtype == "program"){
            data = _proqfdatas;
            key = '/pmkpi/prorevision/report/program';
        } else if (_lefttabtype == "dept") {
            key = '/pmkpi/prorevision/report/dept';
            data = _deptqfdatas;
        }
        var params = {};
        params.tablecode = _tablecode;
        cmp.setTableColum();
        common.setworkflow(_workflow);
        common.setTabNum(obj);
        queryfrom(data,key);
        var treedatas = Ext.lt.pmkpi.querytree();
        obj.datas = treedatas;
        return obj;

    }

    Ext.lt.pmkpi.querytree = function (){
        var params = {};
        params.menuid = _menuid;
        params.tablecode = _tablecode;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        var datalist = Ext.lt.RCP.asyncall(service , "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
        cmp.query();
        return datalist;
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

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        var _lefttab = lefttree.getActiveTabCfg();
        //查询之前处理待送审，还是被退回页签
        common.pendingtasktab();
        tabChange(_lefttab);
        isfirst = false;
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
        params.leftmenuid = _leftmenuid;
        params.lefttabtype = _lefttabtype;
        params.beanid = "pmkpi.prorevision.RevisionReportBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        common.setColDatasource(_datasource, datatable);
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
    cmp.setTableColum = function () {
        var cols = datatable.getCols(); //获取列表所有列
        cols.push.apply(cols, _displaycols);
        _displaycols = [];
        for (var i = 0, len = cols.length; i < len; i++) {
            var col = cols[i];
            var config = eval(col.config);
            if (config && !$.isEmptyObject(config) && col.alias != "序号") {
                if (config.lefttabtype == _lefttabtype) {
                    col.display = true;
                } else {
                    _displaycols.push(col); //隐藏前暂存至sfagency;
                    col.display = false; //display置为false，隐藏
                }
            }
        }
        var page = {};
        page.columns = "*";
        datatable.setPage(page);
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw();
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
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + obj.name + "的数据！",function(){});
            return;
        }
        if (!common.checkwfstatus(datas)) return false;//先校验审核状态是否一致
        var params = {};
        params.datas = datas;
        params.tablecode = _tablecode;
        params.busguid = _leftmenuid + "_" + datas[0]["wfstatus"];
        // 校验页签参数
        params.checktable = _tablecode;
        if (_lefttabtype && "program" == _lefttabtype) { //项目支出
            params.checkkey = "/pmkpi/prorevision/report/proedit";
        } else if (_lefttabtype && "dept" == _lefttabtype) { //部门整体
            params.checkkey = "/pmkpi/prorevision/report/deptedit";
        }
        if (obj.code == "sendaudit" && !common.checkTabPageData(params)) return false;//先校验
        common.doAction(obj, params);
    }

    /**
     * 调整
     */
    cmp.revisionment = function (){
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据进行调整！",function(){});
            return;
        }
        var guid = data[0].guid;
        var params = {};
        params.saveAgency = data[0].agencyguid;
        params.mainguid = guid;
        params.proguid = data[0].proguid;
        params.procode = data[0].pro_code;
        params.pro_name = data[0].pro_name;
        params.workflow = _workflow;
        params.viewtype = "mod";
        params.prolev = _prolev;
        params.bustype = _lefttabtype;
        var url = "";
        if (_lefttabtype && "program" == _lefttabtype) { //项目支出
            url = "/pmkpi/prorevision/report/proedit.page";
        } else if (_lefttabtype && "dept" == _lefttabtype) { //部门整体
            url = "/pmkpi/prorevision/report/deptedit.page";
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"绩效目标修订-"+_lefttreename);
    }

    /**
     * 选择项目
     */
    cmp.checkprogram = function(){
        var params = {};
        params.workflow = _workflow;
        params.prolev = _prolev;
        params.saveAgency = _saveAgency;
        params.bustype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        var url = "";
        if (_lefttabtype && "program" == _lefttabtype) { //项目支出
            url = "/pmkpi/prorevision/report/procheck.page";
        } else if (_lefttabtype && "dept" == _lefttabtype) { //部门整体
            url = "/pmkpi/prorevision/report/deptcheck.page";
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth * 0.9, scrHeight * 0.9,"选择项目-"+_lefttreename);
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
        params.proguid = data[0].proguid;
        params.viewtype = "query";
        params.workflow = _workflow;
        params.prolev = _prolev;
        params.bustype = _lefttabtype;
        params.procode = data[0].pro_code;
        var url = "";
        if (_lefttabtype && "program" == _lefttabtype) { //项目支出
            url = "/pmkpi/prorevision/report/proedit.page";
        } else if (_lefttabtype && "dept" == _lefttabtype) { //部门整体
            url = "/pmkpi/prorevision/report/deptedit.page";
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"绩效目标修订-"+_lefttreename);
    }

    Ext.lt.message.hook("datatable", "drawed",function(obj){
        var uiconfig = obj.uiconfig;
        //表配置
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
    });

    cmp.delrevision = function (){
        var data = datatable.getSelected();
        Ext.lt.ui.confirm('是否删除已选中项目？',{icon: "warn"},function(is){
            if(is){
                Ext.lt.ui.loadingShow();
                var params = {};
                params.datas = data
                params.tablecode = _tablecode;
                Ext.lt.RCP.call(service , "delrevision", params, function(rs){
                    Ext.lt.ui.loadingClose();
                    if (rs.flg=="1") {
                        Ext.lt.ui.alert('删除成功！',function(){
                            cmp.query();
                        });
                    }
                },function(){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('删除失败！',function(){
                    });
                });
            }
        })
    }

    Ext.lt.message.hook("perfcommon", "auditquery",function(){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });


    return cmp;
}