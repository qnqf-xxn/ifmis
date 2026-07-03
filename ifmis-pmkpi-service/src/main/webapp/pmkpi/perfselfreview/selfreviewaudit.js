if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.perfselfreview) {
    Ext.lt.pmkpi.perfselfreview = {};
}

Ext.lt.pmkpi.perfselfreview.audit = function (config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};

    var _workflow = config.workflow,
        _menuid = config.menuid,
        _lefttreename,//左侧评价对象树名称 默认项目支出
        _lefthidebtn,//左侧树隐藏按钮
        _tabhidtbtn,//右侧页签隐藏按钮
        _lefttab = config.lefttab,//左侧树第一个页签
        _lefttabtype = _lefttab.code,//左侧树页签类型
        _leftmenuid,//隐藏菜单
        _tablecode,
        _queryConfig,
        _querySql,
        _agency,
        _tabcode,
        _uikey,
        _isfirst = true, // 是否第一次进页面（控制查询方法）
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;

    var tab_filters = {};//页签过滤条件集合

    //查询
    cmp.query = function (obj) {
        Ext.lt.pmkpi.query();
    }

    Ext.lt.pmkpi.query = function () {
        //获取选中的左侧树code
        if (!_agency) {
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.agency = _agency;
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        params.menuid = _menuid;
        params.workflow = _workflow;
        params.queryConfig = _queryConfig;
        params.tablecode = _tablecode;
        params.querySql = _querySql;
        params.pagetype = common;
        params.tabfilter = tab_filters[_lefttabtype + "_" + _tabcode];
        params.tabcode = _tabcode;
        params.leftmenuid =_leftmenuid;
        params.beanid = "pmkpi.perfselfreview.PerfSelfReviewAuditBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params, function () {
            Ext.lt.ui.loadingClose();
            setTimeout(function(){
                datatable.resetSum();
            },300);
        });
    }

    Ext.lt.message.hook("left", "click", function (obj) {
        var treeNode = obj.node.data;
        if (treeNode) {
            _agency = treeNode.guid;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        cmp.query();
    });

    Ext.lt.message.hook("perfcommon", "auditquery", function () {
        cmp.query();
        try {
            Ext.lt.ui.closeModalWindow();
        } catch (e) {
            Ext.lt.ui.modalWindow.close();
        }
    });

    Ext.lt.message.hook("datatable", "drawed",function(obj){
        var uiconfig = obj.uiconfig;
        //表配置
        _tablecode = uiconfig.tablecode;
    });

    Ext.lt.message.hook("queryform", "doquery", function (obj) {
        _queryConfig = queryform.getQueryParam();
        _querySql = queryform.getQuerySQL();
        // var wheresql = "";
        // var company = _queryConfig[0].company; //金额单位
        // var oper_pro_total_amt = _queryConfig[0].oper_pro_total_amt; //项目总金额最大值
        // var pro_total_amt = _queryConfig[0].pro_total_amt; //项目总金额最小值
        // var oper_bgtamt = _queryConfig[0].oper_bgtamt;  //当年预算金额查询范围
        // var bgtamt = _queryConfig[0].bgtamt;  //当年预算金额值
        // if (company == "2") { //单位：万元
        //     pro_total_amt = pro_total_amt != null ? (parseFloat(pro_total_amt) * 10000) : null;
        //     bgtamt = bgtamt != null ? (parseFloat(bgtamt) * 10000) : null;
        // } else if (company == "3") { //单位：亿元
        //     pro_total_amt = pro_total_amt != null ? (parseFloat(pro_total_amt) * 100000000) : null;
        //     bgtamt = bgtamt != null ? (parseFloat(bgtamt) * 100000000) : null;
        // }
        // var a = _querySql.indexOf("(COMPANY");
        // var b = _querySql.indexOf("(PRO_TOTAL_AMT");
        // var c = _querySql.indexOf("(BGTAMT");
        // var  index = a;
        // if (a == -1) {
        //     index = b;
        //     if (b == -1) {
        //         index = c;
        //     }
        // }
        // if (index != -1) {
        //     wheresql = _querySql.substring(0, index);
        //     if (pro_total_amt != null) {
        //         wheresql += "(pro_total_amt " + oper_pro_total_amt + pro_total_amt + ") and ";
        //     }
        //     if (bgtamt != null) {
        //         wheresql += "(bgtamt " + oper_bgtamt + bgtamt + ") and ";
        //     }
        //     wheresql = wheresql.substring(0, wheresql.length - 4);
        //     _querySql = wheresql;
        // }
        cmp.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols", function (obj) {
        var cols = obj.cols;
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
            if (col["colcode"] == "warn") { //目标值构建符号和单位
                col.cseditfn = function (i, j, rs, style) { //列的单元格样式.
                    style = 'style="text-align:center;"';
                    return style;
                }
                col.fn = function (l, c, data, val) {
                    var warn = !data.warn ? "" : data.warn;
                    if (warn == "red") {
                        warn = '3';
                    } else if (warn == "yellow") {
                        warn = '1';
                    } else if (warn == "green") {
                        warn = '0';
                    } else if (warn == "blue") {
                        warn = '4';
                    } else {
                        return "";
                    }
                    return '<img id="image" style="vertical-align:middle;margin-top:9px;" src="/pmkpi/themes/images/' + warn + '.gif"/>';
                }
            }
        }
    });

    //审核
    cmp.audit = function (obj) {
        var data = datatable.getSelected();
        if (data.length != 1) {
            Ext.lt.ui.alert("请选择一条数据进行审核！", function () {
            });
            return;
        }
        var url = "/pmkpi/audit/view.page";
        var params = {};
        params.mainguid = data[0].guid;
        params.guid = data[0].guid;
        params.projguid = data[0].projguid;
        params.proguid = data[0].projguid;
        params.procode = data[0].pro_code;
        params.agency = data[0].agencyguid;
        params.saveAgency = data[0].agencyguid;
        params.workflow = data[0].wfid;
        params.wfstatus = data[0].wfstatus;
        params.bustype = _lefttabtype;
        params.uikey = _uikey;
        params.wfstatus = data[0].wfstatus;
        params.pagetype = "audit";
        params.querycode = "true";
        //审核页面是否显示查看监控历史记录按钮（1 是  2 否）
        var nodemap = Ext.lt.RCP.asyncall(service, "queryPrevAuditType", [data[0].wfid, data[0].wfstatus]);
        params.nodeguid = nodemap.nodeguid;
        params.audittype = nodemap.audittype;
        if (!nodemap.audittype || nodemap.audittype == "" || nodemap.audittype == "null") {
            Ext.lt.ui.alert("请对流程审核节点进行配置！", function () {
            });
            return;
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "绩效审核");
    }

    Ext.lt.pmkpi.audit = function (obj) {
        cmp.wfAudit(obj);
    }

    //送审/审核
    cmp.wfAudit = function (obj) {
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + obj.name + "的数据！", function () {
            });
            return;
        }
        if (!common.checkwfstatus(datas)) return false;//先校验审核状态是否一致
        var params = {};
        params.datas = datas;
        params.workflow = _workflow;
        params.busguid = _leftmenuid + "_" + datas[0]["wfstatus"];
        common.doAction(obj, params);
    }
    //送审情况
    cmp.queryaudit = function () {
        common.auditquery(datatable);
    }

    //页签方法
    cmp.clickTabpage = function (obj) {
        _tabhidtbtn = obj.hidebtns;
        var tabconfig = eval('(' + obj.config + ')');
        tab_filters[_lefttabtype + "_" + obj.code] = tabconfig[_lefttabtype + "filter"];
        _tabcode = obj.code;
        if (!_isfirst) {
            common.changTooltoolbuttontStatus(0, _tabhidtbtn + "," + _lefthidebtn);
            Ext.lt.pmkpi.querytree();
        }
    }

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        var _lefttab = lefttree.getActiveTabCfg();
        //查询之前处理待送审，还是被退回页签
        common.pendingtasktab();
        tabChange(_lefttab);
        _isfirst = false;
    })

    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        _agency = "treeroot";
        Ext.lt.pmkpi.isleaf = '0';
        _lefttabtype = obj["code"];
        _lefttreename = obj["name"];
        _workflow = obj.leftwfid;
        _lefthidebtn = obj.hidebtns;
        _leftmenuid = obj.leftmenuid;
        var data;
        _uikey = "/pmkpi/selfreview/result/edit";
        common.changTooltoolbuttontStatus(0,  _lefthidebtn + "," + _tabhidtbtn);
        cmp.setTableColum();
        common.setworkflow(_workflow);
        common.setTabNum(obj);
        var treelist = Ext.lt.pmkpi.querytree();
        obj.datas = treelist;
        return obj;
    }

    Ext.lt.pmkpi.querytree = function () {
        var params = {};
        params.lefttabtype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        params.tablecode = _tablecode;
        var datalist = Ext.lt.RCP.asyncall(service, "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
        Ext.lt.pmkpi.query();
        return datalist;
    }

    /**
     * 动态配置表格的列.
     *
     * @param data --
     */
    cmp.setTableColum = function () {
        var cols = datatable.getCols(); //获取列表所有列
        var page = {};
        page.columns = "*";
        datatable.setPage(page);
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw(); //从新绘制表格
    }

    /**
     * 查看明细
     */
    cmp.detailed = function (obj) {
        var data = datatable.getSelected();
        if (!data || data.length != 1) {
            Ext.lt.ui.alert("请选中一条数据进行查看！", function () {
            });
            return;
        }
        var url = _uikey + ".page";
        var params = {};
        params.mainguid = data[0].guid;
        params.saveAgency = data[0].agencyguid;
        params.projguid = data[0].projguid;
        params.procode = data[0].pro_code;
        params.viewtype = "query";
        params.workflow = _workflow;
        params.bustype = _lefttabtype;
        params.wfstatus = data[0].wfstatus;
        params.proguid = data[0].projguid;
        params.querycode = true;  //部门整体目标查询条件
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth*0.95, scrHeight*0.9, obj.name + "-" + _lefttreename);
    }

    /**
     * 查看自评
     */
    cmp.selfproject = function (obj){
        var data = datatable.getSelected();
        if (!data || data.length != 1) {
            Ext.lt.ui.alert("请选中一条数据进行查看！", function () {
            });
            return;
        }
        var url = "/pmkpi/perfself/apply/edit.page";
        var params = {};
        params.mainguid = data[0].selfproguid;
        params.saveAgency = data[0].agencyguid;
        params.projguid = data[0].projguid;
        params.procode = data[0].pro_code;
        params.viewtype = "query";
        params.bustype = _lefttabtype;
        params.proguid = data[0].projguid;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth*0.95, scrHeight*0.9, obj.name + "-" + _lefttreename);
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
        params.proguid = data[0].projguid;
        var xmxxEditobject = Ext.lt.RCP.asynserver("pmkpi.doubleprocess.TlpJxAuditService", "getProInfo", params);
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
    }

    return cmp;
}