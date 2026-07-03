if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.deptperformance){
    Ext.lt.pmkpi.deptperformance = {};
}

Ext.lt.pmkpi.deptperformance.deptinfos = function(config, service){
    var perfcommon = Ext.lt.pmkpi.perfcommon(config, service);
    window.parent.Ext.lt.pmkpi.childwindow = window;
    var cmp = {};
    var serviceid = service,
        _guid = config.guid,
        _mainguid = config.mainguid,//主单id
        _projguid = config.projguid,//项目id
        _projcode = config.projcode,
        _projname = config.projname,
        _menuid = config.menuid,//菜单id
        _bustype = config.bustype,//绩效类型
        _rectifyType = config.rectifyType,//整改类型
        _tabcode = config.tabcode,//tab表名
        _prolev = config.prolev,//项目级次
        _tablecode = config.tablecode,//table表名
        _saveAgency = config.saveAgency,
        _formalval = {},//公式表数据
        _viewtype = config.viewtype,//查询状态;
        _taskguid = config.taskguid,//任务guid
        _workflow = config.workflow,
        _filebustype,
        _tabData,
        _provincescoretype = config.provincescoretype,//财政评分类型
        _querytype = config.querytype;
    Ext.lt.pmkpi.isadd = false;
    var isfirst = true;
    var tabobj;
    /**
     * 基础信息保存
     */
    cmp.save = function (obj){
        if (!deptmsgeditform.check() || !ysmsgeditform.check() || !rymsgeditform.check()) return false;
        var params = {};
        var deptdata = deptmsgeditform.getEditFormValues();
        var ysmsgdata = ysmsgeditform.getEditFormValues();
        var rymsgdata = rymsgeditform.getEditFormValues();
        rymsgdata = objMerge(deptdata, rymsgdata);
        rymsgdata = objMerge(ysmsgdata, rymsgdata);
        var infodata = rymsgdata;
        params.mainguid = _mainguid;
        params.saveAgency = _saveAgency;
        params.workflow = _workflow;
        params.menuid = _menuid;
        params.tablecode = ysmsgeditform.cfg.tablecode;
        params.iswf =  deptmsgeditform.cfg.iswf;
        params.procode = config.procode;
        params.querycode = config.querycode;
        params.bustype = config.bustype;
        params.proguid = config.proguid;
        params.infodata = infodata;
        var rs = Ext.lt.RCP.asyncall(serviceid , "infosave", params);
        return rs;
    }

    function objMerge(target, source) {
        for (var obj in source) {
            target[obj] = source[obj];
        }
        return target;
    }

    /**
     * 页面初始化加载，查看的话不显示按钮
     */
    $(function(){
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        perfcommon.initEditForm();
        var tablecode = deptmsgeditform.cfg.tablecode;
        var params = {};
        params.mainguid = _mainguid;
        params.saveAgency = _saveAgency;
        params.workflow = _workflow;
        params.menuid = _menuid;
        params.tablecode = tablecode;
        params.iswf =  deptmsgeditform.cfg.iswf;
        params.procode = config.procode;
        params.querycode = config.querycode;
        params.bustype = config.bustype;
        params.proguid = config.proguid;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "editquery", params, function(rs){
            var data = rs.editdata;
            if (_viewtype == "query") {
                perfcommon.editSetdisabled(deptmsgeditform);
                perfcommon.editSetdisabled(ysmsgeditform);
                perfcommon.editSetdisabled(rymsgeditform);
            }
            deptmsgeditform.synchEditformByObj(data);
            ysmsgeditform.synchEditformByObj(data);
            rymsgeditform.synchEditformByObj(data);
            parent._isQuery = true;
            Ext.lt.ui.loadingClose();
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert(("查询失败！"),{}, function(ret) {
            });
        });
    });


    Ext.lt.message.hook("editform", "drawed",function(resp){
        var table_eva={
            //财政拨款收入
            financialfund : {
                change: function(param){
                    var data = ysmsgeditform.getEditFormValues();
                    amtTotal(data)
                }
            },
            //财政专户管理资金收入
            taxranamt : {
                change: function(param){
                    var data = ysmsgeditform.getEditFormValues();
                    amtTotal(data)
                }
            },
            //单位资金收入
            otherfund : {
                change: function(param){
                    var data = ysmsgeditform.getEditFormValues();
                    amtTotal(data)
                }
            },
            //转移支付市县
            govefuncamt : {
                change: function(param){
                    var data = ysmsgeditform.getEditFormValues();
                    amtTotal(data)
                }
            },
            //省本级安排
            budgetamt : {
                change: function(param){
                    var data = ysmsgeditform.getEditFormValues();
                    amtTotal(data)
                }
            },
            //基本支出
            basicexpend : {
                change: function(param){
                    var data = ysmsgeditform.getEditFormValues();
                    amtTotal(data)
                }
            },
            //国有资本经营预算资金
            guoyouamt : {
                change: function(param){
                    var data = ysmsgeditform.getEditFormValues();
                    amtTotal(data)
                }
            },
            //社会保险基金预算资金
            shehuiamt : {
                change: function(param){
                    var data = ysmsgeditform.getEditFormValues();
                    amtTotal(data)
                }
            },
            //专户管理资金
            zhuanhuamt : {
                change: function(param){
                    var data = ysmsgeditform.getEditFormValues();
                    amtTotal(data)
                }
            }
        }
        resp.editformpanel.attachEvent(table_eva);
    });

    function amtTotal(data) {
        //财政拨款收入
        financialfund = data.financialfund?Number(data.financialfund):0;
        //财政专户管理资金收入
        taxranamt = data.taxranamt?Number(data.taxranamt):0;
        //单位资金收入
        otherfund = data.otherfund?Number(data.otherfund):0;

        //国有资本经营预算资金
        guoyouamt = data.guoyouamt?Number(data.guoyouamt):0;
        //社会保险基金预算资金
        shehuiamt = data.shehuiamt?Number(data.shehuiamt):0;
        //专户管理资金
        zhuanhuamt = data.zhuanhuamt?Number(data.zhuanhuamt):0;

        //转移支付市县
        govefuncamt = data.govefuncamt?Number(data.govefuncamt):0;
        //其中:省本级安排
        budgetamt = data.budgetamt?Number(data.budgetamt):0;
        //基本支出
        basicexpend = data.basicexpend?Number(data.basicexpend):0;
        var newvalue = {};
        //按资金来源划分合计(万元)
        var newbudgettotal = financialfund+taxranamt+otherfund+guoyouamt+shehuiamt+zhuanhuamt;
        newvalue.budgettotal=newbudgettotal;
        //项目支出小计
        var newprojexpamt = govefuncamt+budgetamt;
        newvalue.projexpamt = newprojexpamt;
        //按资金方向划分合计(万元)
        var newSumfunds = newprojexpamt+basicexpend;
        newvalue.sumfunds = newSumfunds;
        ysmsgeditform.getCol("budgettotal").bind(newvalue);
        ysmsgeditform.getCol("projexpamt").bind(newvalue);
        ysmsgeditform.getCol("sumfunds").bind(newvalue);
    }

    return cmp;
}