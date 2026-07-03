if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.rectification){
    Ext.lt.pmkpi.rectification = {};
}
Ext.lt.pmkpi.rectification.addproj = function(config, service){
    var commoncmp = Ext.lt.pmkpi.perfcommon(config, service);
    try{
        window.parent.Ext.lt.pmkpi.childwindow = window;
    }catch (e){}
    var _guid = config.guid,
        _mainguid = config.mainguid,//主单id
        _projguid = config.projguid,//项目id
        _pro_code = config.pro_code, //项目编码
        _projname = decodeURIComponent(config.projname),
        _isfinadd = config.isfinadd, //是否财政评价新增项目
        _menuid = config.menuid,//菜单id
        _bustype = config.bustype,//绩效类型
        _rectifyType = config.rectifyType,//整改类型
        _tabcode = config.tabcode,//tab表名
        _prolev = config.prolev,//项目级次
        _tablecode = config.tablecode,//table表名
        _saveAgency = config.saveAgency,
        _tabData,//页签数据）
        _viewtype = config.viewtype,//查询状态;
        _isedit = config.isedit,//查询状态;
        _taskguid = config.taskguid,//任务guid
        _workflow = config.workflow,
        _rectype = config.rectype, //整改类型
        _taskguid = config.taskguid, //监控任务guid
        _taskstage = config.taskstage, //监控任务阶段
        _isfinadd = config.isfinadd,  //是否财政评价新增项目
        _rectifys = config.rectifys, // 数据集
        _treeid = config.treeid,
        _queryYear = config.queryYear,//跨年查询查询年度
        _queryProvince = config.queryProvince,//跨年查询查询区划
        _filebustype,
        _lefttreename = "项目支出",
        _finmainguid = config.finmainguid,
        _querytype = config.querytype;
    var cmp = {};

    Ext.lt.pmkpi.isadd = false;
    var isfirst = true;
    var tabobj;

    /**
     * 保存方法
     * @param obj
     */
    cmp.save = function (obj){
        var params= {};
        params.isadd = Ext.lt.pmkpi.isadd;
        var rs = commoncmp.savedatas(obj, params);
    }

    /**
     * 保存并送审
     */
    cmp.saveaudit = function (obj){
        var params= {};
        var actionname = obj.name;
        params.isadd = Ext.lt.pmkpi.isadd;
        params.isaudit = "true";
        Ext.lt.ui.confirm('是否确定“' + actionname + '”已选择的数据？',null,function(is){
            if (is){
                //调用整改通知附件页面中的保存并送审方法
                var childwin = $("#manceiframe_iframe")[0].contentWindow;
                childwin.Ext.lt.pmkpi.saveandaudit(obj);
            }
        });
    }

    /**
     * 页签方法
     */
    cmp.clickTabpage = function(obj){
        var config = eval('(' + obj.config + ')');
        if (config.tabcode) {
            _tabcode = config.tabcode;
        }
        if (config.filebustype) {
            _filebustype = config.filebustype;
        }
        if (!isfirst) {
            commoncmp.tabpageOnclick(obj, _tabData, toolbutton);
        } else {
            _tabData = tabpage.cfg.data;
            tabobj = obj;
        }
    }

    /**
     * 点击嵌套页面类型处理消息
     */
    Ext.lt.message.hook("perfcommon", "iframeinit",function(obj){
        var params = obj.params;
        params.guid =_guid;
        params.mainguid = _mainguid;
        params.projguid = _projguid;
        params.pro_code = _pro_code;
        params.projcode = _pro_code;
        params.projname = _projname;
        params.saveAgency = _saveAgency;
        params.viewtype = _viewtype;
        params.isedit = _isedit;
        params.querytype = _querytype;
        params.rectifyType = _rectifyType;
        params.bustype = _bustype;
        params.rectype = _rectype;
        params.taskguid = _taskguid;
        params.taskstage = _taskstage;
        params.menuid = _menuid;
        params.tabcode = _tabcode;
        params.tablecode = _tablecode;
        params.workflow = _workflow;
		params.prolev = _prolev;
		params.taskguid = _taskguid;
		params.filebustype = _filebustype;
		params.isfinadd = _isfinadd;
        params.rectifys = _rectifys;
        params.treeid = _treeid;
        params.queryYear = _queryYear;//跨年查询查询年度
        params.queryProvince = _queryProvince;//跨年查询查询区划
        params.finmainguid = _finmainguid;
    });

    /**
     * 保存前处理消息
     */
    Ext.lt.message.hook("perfcommon", "beforesave",function(obj){
        obj.params.bustype = _bustype;
    });

    /**
     * 点击嵌套页面类型处理消息
     */
    Ext.lt.message.hook("perfcommon", "tablequery",function(obj){
        if (_table_param[obj.componentid + "_totaltag"] == 1) {
            setTimeout(function(){
                commoncmp.amtTotal(eval(obj.componentid));
            },100);
        }
    });

    //页面加载完成后执行
    $(function(){
        if (isfirst) {
            isfirst = false;
        }
        if (_rectype && config[_rectype]) {
            var tabconfig = eval('(' + tabobj.config + ')');
            tabconfig.url = config[_rectype];
            tabobj.config = JSON.stringify(tabconfig);
        }
        commoncmp.tabpageOnclick(tabobj, _tabData, toolbutton);
        if (_mainguid == "null") {//单独的自评整改反馈详情页面重定向过来，整改主数据id查询不到的情况
            Ext.lt.ui.alert("此项目没有整改信息!", "", function() {
                try{
                    Ext.lt.ui.closeModalWindow();
                }catch(e){
                    parent.Ext.lt.frame.window.hide(); //项目库/预算弹出，关闭页面
                }
            });
        }
        if (_viewtype == "query") {
            try{
                $("div[compid='toolbutton']").hide();
                $(".winfooter").hide();
            }catch (e){
                document.getElementsByClassName("winfooter")[0].style.display = "none";
            }
            var cols = editform.cfg.data;
            var c = {};
            for (var i=0; i<cols.length; i++) {
                c[cols[i].colcode.toLowerCase()] = true;
            }
            editform.setdisabled(c);//设置不可编辑
        }
    })

    /**
     * 返回 ：返回到上一个页面
     */
    cmp.back = function () {
        var params = {};
        params.bustype = _bustype;
        if (_bustype == '1'){//项目
            var url = '/pmkpi/rectification/add/proj.page';
            _lefttreename = "项目支出";
        }else if(_bustype == '3'){ //部门
            var url = '/pmkpi/rectification/add/deptproj.page';
            _lefttreename = "部门整体";
        }
        params.proworkflow = _workflow;
        params.rectifyType = _rectifyType;
        params.menuid = _menuid;
        Ext.lt.ui.closeModalWindow();// 关闭
        window.parent.Ext.lt.pmkpi.query();
    }

    cmp.close = function () {
        try {
            Ext.lt.ui.closeModalWindow();
        } catch (e) {
            parent.Ext.lt.frame.window.hide();//项目库/预算弹出，关闭页面
        }
    }
    return cmp;
}