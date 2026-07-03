if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

Ext.lt.pmkpi.hbtracereportedit = function(config, service){
    var commoncmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var serviceid = service,
        _viewtype = config.viewtype,
        _initnum = 1,
        _mod = config.mod,
        _taskchage = true,
        _tablecode,
        _mainguid = config.mainguid,
        _agency = config.agency,
        _tabData = config.tabData;


    /**
     * 页面初始化加载，查看的话不显示按钮
     */
    $(function(){
        if (_viewtype == "query") {
            try{
                $("div[compid='toolbutton']").hide();
            }catch (e){
                document.getElementsByClassName("winfooter")[0].style.display = "none";
            }
            document.getElementById("add").style.display = "none";
            document.getElementById("del").style.display = "none";
        }
        //Ext.lt.pmkpi.queryedit();
    });

    /**
     * 查询编辑区
     */
    Ext.lt.pmkpi.queryedit = function(){
        var params = {};
        params.mainguid = _mainguid;
        params.agency = _agency;
        params.tablecode = _tablecode;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "editquery", params, function(rs){
            var data = rs.editdata;
            formaleditform.synchEditformByObj(data);
            Ext.lt.ui.loadingClose();
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert(("查询失败！"),{}, function(ret) {
            });
        });
    }

    /**
     * 保存
     */
    cmp.infosave = function(){
        if (!formaleditform.check()) return false;
        var params = {};
        var infodata = formaleditform.getEditFormValues();
        params.infodata = infodata;
        params.mainguid = _mainguid;
        params.taskguid = infodata.taskguid;
        params.saveAgency = _agency;
        params.tablecode = _tablecode;
        if(_taskchage){
            Ext.lt.ui.loadingShow();
            var rs = Ext.lt.RCP.asyncall(serviceid , "issave", params);
            if (rs.success == false) {
                Ext.lt.ui.alert(("每个部门每个监控阶段只允许新增一条数据！"),{}, function(ret) {
                });
                _taskchage = true;
                Ext.lt.ui.loadingClose();
                return false;
            }
        }
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid , "infosave", params);
        if (rs && rs.success == true) {
            if (obj){
                Ext.lt.ui.alert(("保存成功！"),{}, function(ret) {
                });
            }
            Ext.lt.ui.loadingClose();
        }
        _taskchage = false;
        Ext.lt.ui.loadingClose();
    }

    /**
     * 页签方法
     */
    cmp.clickTabpage = function(obj){
        if(obj.componentid != "formaleditform"){
            var infodata = formaleditform.getEditFormValues();
            var params = {};
            params.taskguid = infodata.taskguid;
            params.mainguid = _mainguid;
            params.saveAgency = _agency;
            params.tablecode = _tablecode;
            /*if(_mod == "add"){
                Ext.lt.ui.loadingShow();
                var rs = Ext.lt.RCP.asyncall(serviceid , "issave", params);
                if (rs.success == false) {
                    Ext.lt.ui.alert(("每个部门每个监控阶段只允许新增一条数据！"),{}, function(ret) {
                    });
                    Ext.lt.ui.loadingClose();
                    return ;
                }
            }else {

            }*/
            if(_taskchage){
                Ext.lt.ui.loadingShow();
                var rs = Ext.lt.RCP.asyncall(serviceid , "issave", params);
                if (rs.success == false) {
                    Ext.lt.ui.alert(("每个部门每个监控阶段只允许新增一条数据！"),{}, function(ret) {
                    });
                    _taskchage = true;
                    Ext.lt.ui.loadingClose();
                    return false;
                }
            }
        }
        Ext.lt.ui.loadingClose();
        _taskchage = false;
        _initnum = 1;
        commoncmp.tabpageOnclick(obj, _tabData, toolbutton);
    }

    Ext.lt.message.hook("editform", "drawed",function(resp){
        _tablecode = formaleditform.cfg.tablecode;
        var table_eva={
            taskguid:{
                change: function(param){
                    if(_initnum == 1){
                        _taskchage = false;
                    }else {
                        _taskchage = true;
                    }
                    _initnum = _initnum + 1;
                }
            }
        }
        resp.editformpanel.attachEvent(table_eva);
    });

    /**
     * 点击编辑区类型处页签理消息
     */
    Ext.lt.message.hook("perfcommon", "editinit",function(obj){
        var params = obj.params;
        params.mainguid = _mainguid;
        params.agency = _agency;
        params.tablecode = _tablecode;
        params.pagetype = eval(obj.id).cfg["pagetype"];
    });

    /**
     * 保存编辑区之前封装参数
     */
    Ext.lt.message.hook("perfcommon", "beforesave",function(obj){
        var params = obj.params;
        params.mainguid = _mainguid;
        params.saveAgency = _agency;
        params.tablecode = _tablecode;
    });

    cmp.close = function () {
        Ext.lt.ui.closeModalWindow();
        window.parent.Ext.lt.pmkpi.query();
    }

    /**
     * 点击嵌套页面类型处理消息
     */
    Ext.lt.message.hook("perfcommon", "iframeinit",function(obj){
        var params = obj.params;
        params.mainguid = _mainguid;
        params.agency = _agency;
        params.tablecode = _tablecode;
        params.viewtype = _viewtype; //判断是查看还是可操作
        params.isprogramiframe = "false";//是否项目库嵌套
    });

    return cmp;
}