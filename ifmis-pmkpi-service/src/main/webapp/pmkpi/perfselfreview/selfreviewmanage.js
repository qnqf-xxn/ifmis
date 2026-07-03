if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.perfselfreview) {
    Ext.lt.pmkpi.perfselfreview = {};
}

Ext.lt.pmkpi.perfselfreview.manage = function (config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var _workflow,
        _menuid = config.menuid,
        _lefttreename,//左侧评价对象树名称 默认项目支出
        _lefthidebtn,//左侧树隐藏按钮
        _tabhidtbtn,//右侧页签隐藏按钮
        _lefttab = config.lefttab,//左侧树第一个页签
        _lefttabtype = _lefttab.code,//左侧树页签类型
        _leftmenuid,//隐藏菜单
        _agency, //节点
        _tabcode,
        _name,
        _isfirst = true, // 是否第一次进页面（控制查询方法）
        _whereSql;

    var tab_filters = {};//页签过滤条件集合

    var cmp = {};

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
        params.workflow = _workflow;
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tabfilter = tab_filters[_lefttabtype + "_" + _tabcode];
        params.tabcode = _tabcode; //页签编码
        params.tabsql = _whereSql;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid =_leftmenuid;
        params.beanid = "pmkpi.perfselfreview.PerfSelfReviewManageBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params, function () {
            Ext.lt.ui.loadingClose();
        });
    }


    Ext.lt.message.hook("left", "click", function (obj) {
        var treeNode = obj.node.data;
        if (treeNode) {
            _agency = treeNode.guid;
            _name = treeNode.name;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("perfcommon", "tablequery", function () {
        Ext.lt.pmkpi.query();
    });

    /**
     * 下达
     */
    cmp.add = function (obj) {
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选中至少一条数据进行下达！", function () {
            });
            return;
        }
        Ext.lt.ui.confirm("是否对选择项目进行下达？", null, function (is) {
            if (is) {
                var params = {};
                params.datas = datas;
                params.workflow = _workflow;
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(service, "saveTask", params, function (rs) {
                    Ext.lt.ui.loadingClose();
                    if (rs.flg == "1") {
                        Ext.lt.ui.alert('项目下达成功！', function () {
                            Ext.lt.pmkpi.query();
                        });
                    } else {
                        Ext.lt.ui.alert("项目下达失败！\n失败原因：" + rs.msg, function () {
                        });
                    }
                }, function (resp) {
                    Ext.lt.ui.loadingClose();
                    var alertmsg = "项目下达失败！\n失败原因：" + resp;
                    Ext.lt.ui.alert(alertmsg,{timeout:5},function(){
                    });
                });
            }
        })
        
    }

    /**
     * 删除
     */
    cmp.del = function () {
        var params = {};
        var datas = datatable.getSelected();
        if (!datas || datas.size() <= 0) {
            Ext.lt.ui.alert('请选择要取消的数据！', function () {
            });
            return;
        }
        var message = "是否取消下达已选中项目？";
        Ext.lt.ui.confirm(message, null, function (is) {
            if (is) {
                params.selDatas = datas;
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(service, "delTask", params, function (rs) {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('取消项目成功！', function () {
                        Ext.lt.pmkpi.query();
                    });
                }, function () {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('取消项目失败！', function () {
                    });
                });
            }
        })
    }

    //页签方法
    cmp.clickTabpage = function (obj) {
        _tabhidtbtn = obj.hidebtns;
        _tabcode = obj.code;
        var tabconfig = eval('(' + obj.config + ')');
        if (tabconfig && tabconfig[_lefttabtype + "filter"]) {
            tab_filters[_lefttabtype + "_" + obj.code] = tabconfig[_lefttabtype + "filter"];
        } else {
            tab_filters["program_" + obj.code] = obj["filter"];
        }
        if (!_isfirst) {
            common.changTooltoolbuttontStatus(0, _tabhidtbtn + "," + _lefthidebtn);
            Ext.lt.pmkpi.querytree();
        }
    }

    /**
     * 关闭页面
     */
    cmp.close = function () {
        Ext.lt.ui.closeModalWindow();
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
        if(_tabcode =="waitaudit") {
            params.proguid = data[0].pro_id;
        }else{
            params.proguid = data[0].projguid;
        }
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

    Ext.lt.message.hook("queryform", "doquery", function (obj) {
        Ext.lt.pmkpi.query();
    });

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        tabChange(_lefttab);
        _isfirst = false;
        Ext.lt.pmkpi.query();
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
        var key = '/pmkpi/perfselftaskmanage/index';
        common.changTooltoolbuttontStatus(0,  _lefthidebtn + "," + _tabhidtbtn);
        cmp.setTableColum();
        common.setworkflow(_workflow);
        var treelist = Ext.lt.pmkpi.querytree();
        obj.datas = treelist;
        return obj;
    }

    Ext.lt.pmkpi.querytree = function () {
        var params = {};
        params.menuid = _menuid;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        params.tabcode = _tabcode; //页签编码
        params.tabsql = tab_filters[_lefttabtype + "_" + _tabcode];
        var datalist = Ext.lt.RCP.asyncall(service, "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
        if (!_isfirst) {
            Ext.lt.pmkpi.query();
        }
        return datalist;
    }

    /**
     * 动态配置表格的列.
     *
     * @param data --
     */
    cmp.setTableColum = function () {
        var page = {};
        page.columns = "*";
        datatable.setPage(page);
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw(); //从新绘制表格
    }

    return cmp;
}