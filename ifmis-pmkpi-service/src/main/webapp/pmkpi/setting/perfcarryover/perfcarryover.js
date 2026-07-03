if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.perfcarryover) {
    Ext.lt.pmkpi.perfcarryover = {};
}
var height;
var width;
Ext.lt.pmkpi.perfcarryover = function (config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _tabhidtbtn,//列表页签隐藏按钮
        _tablecode,
        _defquery,//默认查询条件
        _tabcode,//列表页签
        _tabfilter,//页签查询条件
        _lefttab = config.lefttab,//左侧树第一个页签
        _lefttabtype = _lefttab.code,//左侧树页签类型
        _lefttreename,//左侧评价对象树名称
        _lefthidebtn,//左侧树隐藏按钮
        _agency,//左侧树节点-单位
        _queryConfig, //查询区配置
        _querySql;
    var serviceid = service;
    height = Math.floor(document.documentElement.clientHeight * 0.9);
    width =  Math.floor(document.documentElement.clientWidth * 0.9);

    /**
     * 切换左侧树页签
     * @param obj
     * @returns {*}
     */
    tabChange = function (obj) {
        _agency = "treeroot";
        Ext.lt.pmkpi.isleaf = '0';
        _lefttabtype = obj["code"];
        _lefttreename = obj["name"];
        _lefthidebtn = obj.hidebtns;
        common.changTooltoolbuttontStatus(0, _tabhidtbtn + "," + _lefthidebtn);
        var treelist = Ext.lt.pmkpi.querytree();
        obj.datas = treelist;
        return obj;
    }

    /**
     * 查询左侧树
     */
    Ext.lt.pmkpi.querytree = function () {
        var params = {};
        params.tabcode = _tabcode;
        params.lefttabtype = _lefttabtype;
        var datalist = Ext.lt.RCP.asyncall(service, "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
        _agency = "treeroot";
        Ext.lt.pmkpi.isleaf = 0;
        Ext.lt.pmkpi.query();
        return datalist;
    }

    /**
     * 查询列表数据
     */
    Ext.lt.pmkpi.query = function () {
        //获取选中的左侧树code
        if (!_agency) {
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.queryConfig = queryform.getQueryParam();
        params.querySql = _querySql;
        params.tablecode = _tablecode; //视图名称
        params.tabfilter = _tabfilter;
        params.tablesql = _defquery;
        params.tabcode = _tabcode; //页签编码
        params.agency = _agency;
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        params.lefttabtype = _lefttabtype;
        params.beanid = "pmkpi.perfcarryover.PerfCarryOverBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params, function () {
            Ext.lt.ui.loadingClose();
        });
    }

    /**
     * 查询区消息
     */
    Ext.lt.message.hook("perfcommon", "tablequery", function () {
        Ext.lt.pmkpi.query();
    });

    /**
     * 左侧树点击消息
     */
    Ext.lt.message.hook("left", "click", function (obj) {
        var treeNode = obj.node.data;
        if (treeNode) {
            _agency = treeNode.guid;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        Ext.lt.pmkpi.query();
    });

    /**
     * 结转/取消结转
     */
    cmp.carryover = function (obj) {
        var datas = datatable.getSelected();
        var actionname = obj.name;
        var actioncode  = obj.code;
        var params = {};
        params.datas = datas;
        params.actioncode = actioncode;
        params.lefttabtype = _lefttabtype;
        if (!datas || datas.size() <= 0) {
            Ext.lt.ui.alert('请选择要'+ actionname +'的数据！', function () {
            });
            return;
        }
        var message = "是否确认【"+ actionname +"】已选择的数据？";
        if(actioncode == "carryover"){
            var isreportflag = false;
            for (var i=0; i<datas.length; i++) {
                var data = datas[i];
                var isreport_nowyear = data.isreport_nowyear;
                if (isreport_nowyear == "1"){
                    isreportflag = true;
                }
            }
            if(isreportflag){
                message = "所选项目当年已填报年度绩效，如继续同步结转将删除已填报数据，请确认？";
            }
        }else if(actioncode == "cancelcarryover"){
            message += "将清空对应的本年度绩效数据！";
        }
        Ext.lt.ui.confirm(message, {icon: "warn"}, function (is) {
            if (is) {
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(serviceid, "carryover", params, function (rs) {
                    if(rs.success){
                        Ext.lt.ui.loadingClose();
                        Ext.lt.ui.alert(actionname +'成功！', function () {
                            queryform.reset();
                            _querySql = "";
                            Ext.lt.pmkpi.query();
                        });
                    } else {
                        Ext.lt.ui.loadingClose();
                        Ext.lt.ui.alert(rs.error,function(){
                            queryform.reset();
                            _querySql = "";
                            Ext.lt.pmkpi.query();
                        });
                    }
                }, function () {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert(actionname +'失败！', function () {
                    });
                });
            }
        });
    }

    /**
     * 查看项目绩效
     */
    cmp.queryView = function (){
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据查看项目明细！",function(){});
            return;
        }
        var url = "/pmkpi/yearprogram/query/edit.page";
        var params = {};
        params.agency = data[0].agency_code;
        params.mainguid = data[0].pro_id;
        params.pro_code = data[0].pro_code;
        params.projectkind = data[0].projectkind;//项目类型
        params.viewtype = "query";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, width, height, "项目绩效目标查看");
    }

    /**
     * 填报数量指标页面，用于测试
     */
    cmp.reportpayindex = function (){
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据！",function(){});
            return;
        }
        var url = "/pmkpi/program/report/payindex.page";
        var params = {};
        params.pro_code = data[0].pro_code;
        params.payid = data[0].guid;
        params.viewtype = "report";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, width, height, "填报支付项目数量绩效指标");
    }

    /**
     * 切换列表页签
     * @param obj
     */
    cmp.clickTabpage = function (obj) {
        _tabhidtbtn = obj.hidebtns;
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        common.changTooltoolbuttontStatus(0,_tabhidtbtn + "," + _lefthidebtn);
        Ext.lt.pmkpi.querytree();
    }

    /**
     * 关闭页面
     */
    cmp.close = function () {
        Ext.lt.ui.closeModalWindow();
    }

    /**
     * 快速查询消息
     */
    Ext.lt.message.hook("queryform", "doquery", function (obj) {
        _queryConfig = queryform.getQueryParam();
        if(_queryConfig[0].ALL_COLUMNS) {
            _querySql = "";
        } else {
            _querySql = queryform.getQuerySQL();
        }
        Ext.lt.pmkpi.query();
    });

    /**
     * 表格加载消息
     */
    Ext.lt.message.hook("datatable", "beforesetcols", function (obj) {
        var uiconfig = obj.table.uiconfig;
        _tablecode = uiconfig.tablecode; //显示的数据
        _defquery = uiconfig.defquery;
    });

    /**
     * 初始化
     */
    $(function () {
        common.initDatatable();
        tabChange(_lefttab);
    });

    return cmp;
}