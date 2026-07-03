if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.workevaluate){
    Ext.lt.pmkpi.workevaluate = {};
}
Ext.lt.pmkpi.workevaluate.report = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};

    var _menuid = config.menuid,//菜单id
        _workflow = config.workflow,//工作流guid
        _tablecode,
        _lefttreename,//左侧评价对象树名称 默认项目支出
        _lefthidebtn,//左侧树隐藏按钮
        _tabhidtbtn,//右侧页签隐藏按钮
        _lefttab = config.lefttab,//左侧树第一个页签
        _lefttabtype = _lefttab.code,//左侧树页签类型
        _provincescoretype = config.provincescoretype,
        _defquery,//列表查询条件
        _tabcode,//页签编码
        _saveAgency,//左侧树选择单位
        _leftmenuid,//隐藏菜单
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;
    var isfirst = true;
    var ischecktab = true;
    var _displaycols = [];
    var tab_filters = {};//页签过滤条件集合

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
        params.saveAgency = _saveAgency;
        params.isleaf = Ext.lt.pmkpi.isleaf+"";
        params.tabfilter = tab_filters[_lefttabtype + "_" + _tabcode];
        params.workflow = _workflow;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid =_leftmenuid;
        params.beanid = "pmkpi.workevaluate.report.WorkEvaluateReportBOTX";
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
        if(treeNode){
            _saveAgency = treeNode.guid;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("datatable", "drawed",function(obj){
        var uiconfig = obj.uiconfig;
        //表配置
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
    });

    /**
     * 填报/修改. 查看明细
     */
    cmp.addOredit = function (obj){
        var btnconfig = eval('(' + obj.config + ')');
        var params = {};
        var name = "请选中一条数据进行填报/修改！";
        if (obj.code == "querydetailed") {
            params.viewtype = "query";
            name = "请选中一条数据进行查看！";
        }
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert(name, function(){});
            return;
        }
        params.saveAgency = data[0].agencyguid;
        params.mainguid = data[0].guid;
        params.subprovince = data[0].subprovince;
        params.taskguid = data[0].taskguid;//任务guid
        params.tasktype = data[0].tasktype;//任务类型
        if (btnconfig) {
            params.hidetab = btnconfig[data[0].tasktype];
        }
        params.workflow = _workflow;
        params.bustype = _lefttabtype;//业务类型
        var url = "";
        if (_lefttabtype && "dept" == _lefttabtype) { //预算部门
            url = "/pmkpi/workevaluate/report/deptedit.page";
        } else if (_lefttabtype && "subprovince" == _lefttabtype) { //下级财政
            params.provincescoretype = _provincescoretype;
            url = "/pmkpi/workevaluate/report/subprovinceedit.page";
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"预算绩效工作管理考核-" + _lefttreename);
    }

    //送审/审核
    cmp.wfAudit = function (obj){
        var btnname = obj.name;
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + obj.name + "的数据！",function(){});
            return;
        }
        if (!common.checkwfstatus(datas)) return false;//先校验审核状态是否一致
        var params = {};
        params.datas = datas;
        params.tablecode = _tablecode;
        params.bustype = _lefttabtype;
        params.busguid = _leftmenuid + "_" + datas[0]["wfstatus"];
        if (_lefttabtype && "dept" == _lefttabtype) { //预算部门
            var wfstatus;
            for (var i=0; i < datas.length; i++) {
                wfstatus += datas[i].wfstatus;
            }
            if (!wfstatus || wfstatus == "") {
                Ext.lt.ui.alert("请完善基本信息后送审数据！",function(){});
                return;
            }
            // 校验页签参数
            params.checktable = "perf_t_worktaskassign";
            params.checkkey = "/pmkpi/workevaluate/report/deptedit";
            if (obj.code == "sendaudit" && !common.checkTabPageData(params)) return false;//先校验
            common.doAction(obj, params);
        } else if (_lefttabtype && "subprovince" == _lefttabtype) { //区县
            // 校验页签参数
            params.checktable = "perf_t_worktaskassign";
            params.checkkey = "/pmkpi/workevaluate/report/subprovinceedit";
            if (obj.code == "sendaudit" && !common.checkTabPageData(params)) return false;//先校验
            var btnconfig = eval('(' + obj.config + ')');
            var subprostatus = btnconfig['subprostatus'];//获取区划当前数据状态
            params.subprostatus = subprostatus;
            Ext.lt.ui.confirm('是否确定“' + btnname + '”已选择的数据？',null,function(is){
                if(is){
                    Ext.lt.ui.loadingShow();
                    Ext.lt.RCP.call(service, "subProvinceAudit", params, function(rt){
                        if (rt && rt.success == true){
                            Ext.lt.ui.alert( btnname + "成功！",function(){
                                Ext.lt.pmkpi.query();
                            });
                        } else if(rt && rt.success == false){
                            common.openlistdiv(rt);
                        } else {
                            var alertmsg = btnname + "失败，请联系管理员！";
                            Ext.lt.ui.alert(alertmsg,{timeout:5},function(){
                            });
                        }
                        Ext.lt.ui.loadingClose();
                    },function(resp){
                        Ext.lt.ui.loadingClose();
                        var alertmsg = btnname + "失败！\n失败原因：" + resp;
                        Ext.lt.ui.alert(alertmsg,{timeout:5},function(){
                        });
                    });
                }
            });
        }

    }

    //查看任务
    cmp.queryTask = function(){
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据！");
            return
        }
        var params = {};
        params.guid = data[0].taskguid;
        params.viewtype = 'query';
        params.year = data[0].year;
        params.province = data[0].province;
        params.mainguid = data[0].taskguid;
        params.tablecode = "PERF_T_WORKEVALUATETASK";
        var url = '/pmkpi/workevaluate/task/edit.page';
        url = Ext.lt.pmkpi.genPageUrl(url,params);
        Ext.lt.ui.openModalWindow(url, scrWidth*0.95, scrHeight*0.95, "绩效管理工作考核任务查看")
    }

    $(function (){
        tabChange(_lefttab);
        common.initDatatable();
        isfirst = false;
    })

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("perfcommon", "auditquery",function(){
        Ext.lt.pmkpi.query();
        try {
            Ext.lt.ui.closeModalWindow();
        } catch (e) {
            Ext.lt.ui.modalWindow.close();
        }
    });

    //页签方法
    cmp.clickTabpage = function(obj){
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
        cmp.setTableColum();
        common.setworkflow(_workflow);
        common.setTabNum(obj);
        common.changTooltoolbuttontStatus(0,  _lefthidebtn + "," + _tabhidtbtn);
        if(!isfirst && !!_tabcode){
            var tabpagedatas = tabpage.cfg.data;
            var checktabobj;
            for(var i=0;i<tabpagedatas.length;i++) {
                var tabdata = tabpagedatas[i];
                if(_tabcode == tabdata.code){
                    checktabobj = tabdata;
                    break;
                }
            }
            ischecktab = false;
            if(!!checktabobj) cmp.clickTabpage(checktabobj);
        }
        var treedatas = Ext.lt.pmkpi.querytree();
        obj.datas = treedatas;
        return obj;
    }

    Ext.lt.pmkpi.querytree = function (){
        var params = {};
        params.menuid = _menuid;
        params.tablecode = _tablecode;
        params.bustype = _lefttabtype;
        params.leftmenuid =_leftmenuid;
        var datalist = Ext.lt.RCP.asyncall(service , "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
        if(ischecktab) Ext.lt.pmkpi.query();
        return datalist;
    }

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
            if (config && !$.isEmptyObject(config) && col.alias != "序号") {
                if (config.lefttabtype == _lefttabtype) {
                    col.display = true;
                } else {
                    _displaycols.push(col); //隐藏前暂存至sfagency;
                    col.display = false; //display置为false，隐藏
                }
            }
        }
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw(); //从新绘制表格
    }

    return cmp;
}