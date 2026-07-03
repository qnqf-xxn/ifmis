if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.adjust) {
    Ext.lt.pmkpi.adjust = {};
}

Ext.lt.pmkpi.adjust.reportservice = function (config, service) {
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
        _prolev = config.prolev,//项目级次
        _deptqfdatas = config.deptqfdatas,//部门查询区数据
        _proqfdatas = config.proqfdatas,//项目查询区数据
        _defquery,//列表查询条件
        _tabcode,//页签编码
        _saveAgency,//左侧树选择单位
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;
    var isfirst = true;
    var _displaycols = [];
    var tab_filters = {};//页签过滤条件集合
    var _isNINGXIA = config.isNINGXIA;
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
        if (_lefttabtype == "program") {
            data = _proqfdatas;
            key = '/pmkpi/adjust/report/program';
        } else if (_lefttabtype == "dept") {
            key = '/pmkpi/adjust/report/dept';
            data = _deptqfdatas;
        }
        cmp.setTableColum();
        common.setworkflow(_workflow);
        common.setTabNum(obj);
        queryfrom(data, key);
        if (_isNINGXIA) {
            if (_lefttabtype == "dept") {
                tabpage.hidden("删除目标调整申请");
                if (_tabcode == "delwaitaudit") {
                    tabpage.doActiveTab(0);
                }
            } else {
                tabpage.unhidden("删除目标调整申请");
            }
        }
        common.changTooltoolbuttontStatus(0,  _lefthidebtn + "," + _tabhidtbtn);
        var treedatas = Ext.lt.pmkpi.querytree();
        obj.datas = treedatas;
        return obj;
    }

    Ext.lt.pmkpi.querytree = function () {
        var params = {};
        params.menuid = _menuid;
        params.tablecode = _tablecode;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        var datalist = Ext.lt.RCP.asyncall(service, "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
        Ext.lt.pmkpi.query();
        return datalist;
    }

    function queryfrom(data, key) {
        var configqueryform = {
            id: "queryform",
            fastquery: true,
            datatable: 'datatable',
            drawmode: 'div',
            key: key,
            label: "快速查询",
            labelwidth: "120",
            appid: "pmkpi",
            config: null,
            serverid: key,
            amtmaxlength: 18,
            columnsize: 5,
            data: data
        }
        queryform = new Ext.lt.bus.ui.querypanel(configqueryform);
        queryform.draw($(".busquerypanel_outline")[0]);
    }

    $(function () {
        common.initDatatable();
        var _lefttab = lefttree.getActiveTabCfg();
        //查询之前处理待送审，还是被退回页签
        common.pendingtasktab();
        tabChange(_lefttab);
        isfirst = false;
    })

    //查询
    cmp.query = function (obj) {
        Ext.lt.pmkpi.query();
    }

    Ext.lt.pmkpi.query = function () {
        if (!_saveAgency) {
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
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        params.tabfilter = tab_filters[_lefttabtype + "_" + _tabcode];
        params.workflow = _workflow;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid =_leftmenuid;
        params.beanid = "pmkpi.adjust.report.AdjustReportBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params, function () {
            Ext.lt.ui.loadingClose();
        });
    }

    /**
     * 左侧树点击
     */
    Ext.lt.message.hook("left", "click", function (obj) {
        var treeNode = obj.node.data;
        if (treeNode) { //不选择预算单位按类型查询
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
            if (_isNINGXIA) {
                if (_lefttabtype == "program") {
                    if ((_tabcode == "delwaitaudit" || _tabcode == "delaudit" || _tabcode == "delalreadyaudit")
                        && col.colcode == "wfstatus") {
                        _displaycols.push(col); //隐藏前暂存至sfagency;
                        col.display = false; //display置为false，隐藏
                    } else if (col.colcode == "wfstatus") {
                        col.display = true;
                    }

                    if ((_tabcode == "alreadyaudit" || _tabcode == "back" || _tabcode == "alldeals")
                        && (col.colcode == "delopinion" || col.colcode == "delwfstatus" || col.colcode == "delauditopinion")) {
                        _displaycols.push(col); //隐藏前暂存至sfagency;
                        col.display = false; //display置为false，隐藏
                    } else if (col.colcode == "delopinion" || col.colcode == "delwfstatus" || col.colcode == "delauditopinion") {
                        col.display = true;
                    }
                } else {
                    if (col.colcode == "wfstatus") {
                        col.display = true;
                    }
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
    cmp.queryaudit = function () {
        common.auditquery(datatable);
    }

    //页签方法
    cmp.clickTabpage = function (obj) {
        _tabhidtbtn = obj.hidebtns;
        var tabconfig = eval('(' + obj.config + ')');
        tab_filters[_lefttabtype + "_" + obj.code] = tabconfig[_lefttabtype + "filter"];
        _tabcode = obj.code;
        if (!isfirst) {
            common.changTooltoolbuttontStatus(0, _tabhidtbtn + "," + _lefthidebtn);
            Ext.lt.pmkpi.query();
            if (_isNINGXIA) {
                cmp.setTableColum();
            }
        }
    }

    /**
     *工作流.
     */
    cmp.wfAudit = function (obj) {
        var datas = datatable.getSelected();
        if (!datas || datas.length == 0) {
            Ext.lt.ui.alert("请选择要" + obj.name + "的数据！", function () {
            });
            return;
        }

        if (_isNINGXIA && obj.code == "sendaudit" && _lefttabtype == "program") {
            for (var i=0; i<datas.length; i++) {
                var status = datas[i].delwfstatus;
                if (status == "1" || status == "2") {
                    Ext.lt.ui.alert('请选择申请删除状态为空或审批不通过数据进行送审！', function () {
                    });
                    return;
                }
            }
        }

        if (!common.checkwfstatus(datas)) return false;//先校验审核状态是否一致
        var params = {};
        params.datas = datas;
        params.tablecode = _tablecode;
        params.busguid = _leftmenuid + "_" + datas[0]["wfstatus"];
        // 校验页签参数
        params.checktable = "v_perf_t_adjust";
        if (_lefttabtype && "program" == _lefttabtype) { //项目支出
            params.checkkey = "/pmkpi/adjust/report/proedit";
        } else if (_lefttabtype && "dept" == _lefttabtype) { //部门整体
            params.checkkey = "/pmkpi/adjust/report/deptedit";
        }
        if (obj.code == "sendaudit" && !common.checkTabPageData(params)) return false;//先校验
        //if (!cmp.checkFileData(params)) return false;
        common.doAction(obj, params);
    }

    /**
     * 调整
     */
    cmp.adjustment = function () {
        var data = datatable.getSelected();
        if (!data || data.length != 1) {
            Ext.lt.ui.alert("请选中一条数据进行调整！", function () {
            });
            return;
        }
        var guid = data[0].guid;
        var params = {};
        params.saveAgency = data[0].agencyguid;
        params.mainguid = guid;
        params.proguid = data[0].proguid;
        params.projectkind = data[0].projectkind;
        params.workflow = _workflow;
        params.prolev = _prolev;
        params.bustype = _lefttabtype;
        var url = "";
        if (_lefttabtype && "program" == _lefttabtype) { //项目支出
            url = "/pmkpi/adjust/report/proedit.page";
            params.pro_name = encodeURIComponent(data[0].name);
            params.procode = data[0].pro_code;
        } else if (_lefttabtype && "dept" == _lefttabtype) { //部门整体
            url = "/pmkpi/adjust/report/deptedit.page";
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "绩效目标调整-" + _lefttreename);
    }

    /**
     * 选择项目
     */
    cmp.checkprogram = function () {
        var params = {};
        params.workflow = _workflow;
        params.prolev = _prolev;
        params.saveAgency = _saveAgency;
        params.bustype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        var url = "";
        if (_lefttabtype && "program" == _lefttabtype) { //项目支出
            url = "/pmkpi/adjust/report/procheck.page";
        } else if (_lefttabtype && "dept" == _lefttabtype) { //部门整体
            url = "/pmkpi/adjust/report/deptcheck.page";
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth * 0.9, scrHeight * 0.9, "调整选择-" + _lefttreename);
    }

    /**
     * 查看明细
     */
    cmp.detailed = function () {
        var data = datatable.getSelected();
        if (!data || data.length != 1) {
            Ext.lt.ui.alert("请选中一条数据进行查看！", function () {
            });
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
        params.projectkind = data[0].projectkind;
        var url = "";
        if (_lefttabtype && "program" == _lefttabtype) { //项目支出
            url = "/pmkpi/adjust/report/proedit.page";
        } else if (_lefttabtype && "dept" == _lefttabtype) { //部门整体
            url = "/pmkpi/adjust/report/deptedit.page";
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "绩效目标调整-" + _lefttreename);
    }

    //删除项目
    cmp.deladjust = function (obj) {
        var data = datatable.getSelected();
        var isadd = false;
        if (_isNINGXIA && _lefttabtype == "program") {
            var arr = [];
            for (var i=0; i<data.length; i++) {
                arr.push(data[i].adjustsource);
                if (data[i].adjustsource == "1") {
                    isadd = true;
                }
                if (!isadd && (data[i].delwfstatus && data[i].delwfstatus != "3")) {
                    Ext.lt.ui.alert('请选择申请删除状态为空或审批不通过的数据进行操作！', function () {
                    });
                    return;
                }
                if (data[i].wfstatus != "000") {
                    Ext.lt.ui.alert('请选择流程状态为新增的数据进行操作！', function () {
                    });
                    return;
                }
            }
            if (isadd && new Set(arr).size !== 1) {
                Ext.lt.ui.alert('请选择数据来源同类型的数据！', function () {
                });
                return;
            }
        } else {
            isadd = true;
        }
        //宁夏删除分类型，新增的可以直接删除，接口的要走流程
        if (!isadd) {
            var url = "/pmkpi/audit/adjdelopinion.page";
            var params = {};
            params.delwfstatus = "1";
            url = Ext.lt.pmkpi.genPageUrl(url, params);
            Ext.lt.ui.openModalWindow(url,scrWidth * 0.75,scrHeight * 0.75,"删除目标调整申请意见");
        } else {
            Ext.lt.ui.confirm('是否删除已选中项目？', {icon: "warn"}, function (is) {
                if (is) {
                    Ext.lt.ui.loadingShow();
                    var params = {};
                    params.datas = data
                    params.tablecode = _tablecode;
                    params.bustype = _lefttabtype;
                    Ext.lt.RCP.call(service, "deladjust", params, function (rs) {
                        Ext.lt.ui.loadingClose();
                        if (rs.flg == "1") {
                            Ext.lt.ui.alert('删除成功！', function () {
                                cmp.query();
                            });
                        }
                    }, function () {
                        Ext.lt.ui.loadingClose();
                        Ext.lt.ui.alert('删除失败！', function () {
                        });
                    });
                }
            })
        }
    }


    /**
     * 删除审批
     */
    cmp.canceldel = function (obj) {
        var datas = datatable.getSelected();
        if (!datas || datas.length == 0) {
            Ext.lt.ui.alert("请选择要操作的数据！", function () {
            });
            return;
        }
        var cfg = eval("(" + obj.config + ")");
        var type = cfg.type;
        var delwfstatus = cfg.delwfstatus;
        for (var i=0; i<datas.length; i++) {
            if (datas[i].delwfstatus != type) {
                Ext.lt.ui.alert('请选择申请删除状态为审批中的数据进行操作！', function () {
                });
                return;
            }
            if (datas[i].wfstatus != "000") {
                Ext.lt.ui.alert('请选择流程状态为新增的数据进行操作！', function () {
                });
                return;
            }
        }
        var params = {};
        if (delwfstatus == "1") {
            params.delwfstatus = "";
            params.remark = "";
            Ext.lt.pmkpi.delWFAction(params);
        } else {
            var url = "/pmkpi/audit/adjdelopinion.page";
            params.delwfstatus = delwfstatus;
            params.btnname = encodeURIComponent(obj.name);
            url = Ext.lt.pmkpi.genPageUrl(url, params);
            Ext.lt.ui.openModalWindow(url,scrWidth * 0.75,scrHeight * 0.75,"删除目标调整审核意见");
        }
    }

    Ext.lt.message.hook("datatable", "drawed",function(obj){
        var uiconfig = obj.uiconfig;
        //表配置
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
    });

    Ext.lt.message.hook("perfcommon", "auditquery", function () {
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("queryform", "doquery", function (obj) {
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
        common.proinfoview(datatable,params);
    }

    Ext.lt.pmkpi.delWFAction = function(obj) {
        var msg = !obj.btnname ? "对已选择项目进行删除目标调整申请？" : decodeURIComponent(obj.btnname) + "对已选择项目进行删除目标审批?";
        Ext.lt.ui.confirm(msg , {icon: "warn"}, function (is) {
            if (is) {
                Ext.lt.ui.loadingShow();
                var datas = datatable.getSelected();
                var params = {};
                params.datas = datas;
                params.remark = obj.remark;
                params.delwfstatus = obj.delwfstatus;
                Ext.lt.RCP.call(service, "delWFAction", params, function (rs) {
                    Ext.lt.ui.loadingClose();
                    if (rs.success) {
                        Ext.lt.ui.alert('操作成功！', function () {
                            cmp.query();
                            Ext.lt.ui.modalWindow.close();
                        });
                    }
                }, function () {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('操作失败！', function () {
                    });
                });
            }
        });
    }

    /**
     * 调整原因必填校验附件
     */
    // cmp.checkFileData = function (params) {
    //     var flag = true;
    //     var warndata = Ext.lt.RCP.asyncall(serviceid, "checkFileData", params);
    //     var datas = warndata.esg;
    //     if (datas.length > 0) {
    //         var str = "";
    //         for (var i = 0; i < datas.length; i++) {
    //             str += datas[i] + "\n";
    //         }
    //         Ext.lt.ui.alert(str, function () {
    //         });
    //         flag = false;
    //     }
    //     return flag;
    // }

    return cmp;
}