if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}

Ext.lt.pmkpi.caseservice = function (config,service){
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
        _defquery,//列表查询条件
        _tabcode,//页签编码
        _leftsource,
        _nodeguid,//左侧树选择数据
        _saveAgency,
        _finintorgguid,//处室
        _isCasetype,//是否分类
        _scrWidth = document.body.clientWidth,
        _scrHeight = document.body.clientHeight;
    var isfirst = true;
    var tab_filters = {};//页签过滤条件集合
    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        _nodeguid = "treeroot";
        Ext.lt.pmkpi.isleaf = 0;
        _lefttabtype = obj["code"];
        _lefttreename = obj["name"];
        _workflow = obj.leftwfid;
        _lefthidebtn = obj.hidebtns;
        _leftmenuid = obj.leftmenuid;
        var _leftconfig = eval('(' + obj.config + ')');
        _leftsource = _leftconfig.leftsource;
        common.setworkflow(_workflow);
        common.changTooltoolbuttontStatus(0,  _lefthidebtn + "," + _tabhidtbtn);
        var treeDatas = Ext.lt.pmkpi.querytree();
        obj.datas = treeDatas;
        return obj;
    }

    Ext.lt.pmkpi.querytree = function () {
        var params = {};
        params.menuid = _menuid;
        params.tablecode = _tablecode;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        params.leftsource = _leftsource;
        var rt = Ext.lt.RCP.asyncall(service, "getTreeData", params);
        if (rt.agencyguid && rt.agencyguid != "") {
            _saveAgency = rt.agencyguid;
        }
        if (rt.finintorgguid && rt.finintorgguid != "") {
            _finintorgguid = rt.finintorgguid;
        }
        _isCasetype = rt.isCasetype;
        lefttree.setRecordset(rt.treeDatas, 0);
        Ext.lt.pmkpi.query();
        return rt.treeDatas;
    }

    $(function () {
        common.initDatatable();
        var _lefttab = lefttree.getActiveTabCfg();
        //查询之前处理待送审，还是被退回页签
        common.pendingtasktab();
        tabChange(_lefttab);
        if (isfirst) {
            isfirst = false;
        }
    })

    //查询
    cmp.query = function (obj) {
        Ext.lt.pmkpi.query();
    }

    Ext.lt.pmkpi.query = function () {
        Ext.lt.ui.loadingShow();
        var params = {};
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.tabcode = _tabcode;
        params.nodeguid = _nodeguid;
        params.isCasetype = _isCasetype;
        params.leftsource = _leftsource;
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        params.tabfilter = tab_filters[_lefttabtype + "_" + _tabcode];
        params.workflow = _workflow;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid =_leftmenuid;
        params.beanid = "pmkpi.casepage.report.CaseReportBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params, function () {
            Ext.lt.ui.loadingClose();
        });
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
        }
    }

    /**
     * 左侧树点击
     */
    Ext.lt.message.hook("left", "click", function (obj) {
        var treeNode = obj.node.data;
        if (treeNode) {
            _nodeguid = treeNode.guid;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
            if (!_isCasetype) {
                _finintorgguid = treeNode.finintorgguid;
            }
        } else{
            _nodeguid = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        cmp.query();
    });

    /**
     * 新增
     */
    cmp.add = function(){
        if(!_nodeguid || _nodeguid == "treeroot" || Ext.lt.pmkpi.isleaf != "1"){
            Ext.lt.ui.alert("请选择左侧树末级节点数据！",function(){});
            return;
        }
        var params = {};
        var url = "";
        if (_lefttabtype && "PM001" == _lefttabtype) { //项目支出
            url = "/pmkpi/setting/caseinfo/edit.page";
        } else if (_lefttabtype && "DEPT" == _lefttabtype) { //部门整体
            url = "/pmkpi/case/deptedit.page";
        }
        var newguid = Ext.lt.RCP.asyncall(service , "getCreateguid", null);
        params.bustype = _lefttabtype;
        params.mainguid = newguid;
        params.workflow = _workflow;
        params.viewtype = "add";
        params.finintorgguid = _finintorgguid;
        params.nodeguid = _nodeguid;
        if (!_isCasetype) {//左侧树不是单位数，获取不到单位
            params.saveAgency = _nodeguid;
        } else {
            params.saveAgency = _saveAgency;
        }
        if (!params.saveAgency) {
            Ext.lt.ui.alert("请使用单位/部门用户进行新增！",function(){});
            return;
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,_scrWidth,_scrHeight,"案例新增");
    }

    /**
     *修改
     */
    cmp.update = function(){
        var selDatas = datatable.getSelected();
        if (selDatas.length != 1) {
            Ext.lt.ui.alert("请选择一条数据修改！",function(){});
            return;
        }
        var data = selDatas[0];
        if (data.status == "3") {
            Ext.lt.ui.alert("案例状态为删除的数据不能进行修改！",function(){});
            return;
        }
        var params = {};
        var url = "";
        if (_lefttabtype && "PM001" == _lefttabtype) { //项目支出
            url = "/pmkpi/setting/caseinfo/edit.page";
        } else if (_lefttabtype && "DEPT" == _lefttabtype) { //部门整体
            url = "/pmkpi/case/deptedit.page";
        }
        params.bustype = _lefttabtype;
        params.mainguid = data.guid;
        params.finintorgguid = _finintorgguid;
        params.nodeguid = _nodeguid;
        if (!_isCasetype) {//左侧树不是单位数，获取不到单位
            params.saveAgency = _nodeguid;
        } else {
            params.saveAgency = _saveAgency;
        }
        if (data.adjustguid && data.adjustguid != "") {
            params.viewtype = "adjust";
        } else {
            params.viewtype = "mod";
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,_scrWidth,_scrHeight,"案例修改");
    }

    /**
     *工作流.
     */
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
        params.tablecode = _tablecode;
        params.bustype = _lefttabtype;
        params.busguid = _leftmenuid + "_" + datas[0]["wfstatus"];
        common.doAction(obj, params);
    }

    /**
     * 选择案例
     */
    cmp.checkcase = function () {
        var params = {};
        params.workflow = _workflow;
        params.bustype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        params.isCasetype = _isCasetype;
        params.leftsource = _leftsource;
        var url = "/pmkpi/case/report/check.page";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, _scrWidth * 0.9, _scrHeight * 0.9, "选择案例-" + _lefttreename);
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
        params.viewtype = "query";
        params.workflow = _workflow;
        params.bustype = _lefttabtype;
        var url = "";
        if (_lefttabtype && "PM001" == _lefttabtype) { //项目支出
            url = "/pmkpi/setting/caseinfo/edit.page";
        } else if (_lefttabtype && "DEPT" == _lefttabtype) { //部门整体
            url = "/pmkpi/case/deptedit.page";
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, _scrWidth, _scrHeight, "案例明细-" + _lefttreename);
    }

    cmp.del = function () {
        var datas = datatable.getSelected();
        if (!datas || datas.size() <= 0) {
            Ext.lt.ui.alert('请选择要删除的数据！',function(){
            });
            return;
        }
        Ext.lt.ui.confirm('是否删除已选中数据？', null, function (is) {
            if (is) {
                Ext.lt.ui.loadingShow();
                var params = {};
                params.datas = datas;
                params.tablecode = _tablecode;
                params.bustype = _lefttabtype;
                Ext.lt.RCP.call(service, "del", params, function (rs) {
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

    //送审情况
    cmp.queryaudit = function () {
        common.auditquery(datatable);
    }

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
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

    //导入
    cmp["impindex"] = function(obj){
        var importcode = "";
        var vchtypeid = "";
        if (_lefttabtype == "PM001") { //项目案例
            importcode = "case_programindex";
            vchtypeid = "FCCFD316AFC43C1FE0533315A8C071B6";
        } else if (_lefttabtype == "DEPT") { //部门整体案例
            importcode = "case_deptindex";
            vchtypeid = "FCCFD316AFC73C1FE0533315A8C071B6";
        }
        var tokenid = Ext.lt.getparam("tokenid");
        // 调用导入接口，需要参数有tokenid,模板编码，单据id，args组合传给后台的参数
        var params = {};
        params.vchtypeid = vchtypeid;
        params.lefttabtype = _lefttabtype;
        params.workflow = _workflow;
        window.importparam = params;
        Ext.lt.importdata.imports(tokenid,importcode,vchtypeid,Object.toJSON(params),function(){
            window.parent.Ext.lt.outfile.window.close();
            parent.Ext.lt.pmkpi.impsucess();
        });
    }

    Ext.lt.pmkpi.impsucess = function (){
        Ext.lt.ui.alert("导入成功！",function(){
        });
    }

    return cmp;
}