if (Ext.lt.pmkpi == null) {
    Ext.lt.pmkpi = {};
}

var _table_param = {},//根据组件id存放表名1
    _onclickid,//选中页签id
    _tabComponentid=[],//点击的页签
    _btnobj,
    _isQuery,//是否查询成功
    _oldtabnum,//记录上次点击的位置
    _tabnum,
    serviceid;//记录点击的位置
var _issavetmp = false;
Ext.lt.pmkpi.perfcommon = function(config, service){
    var
        _mainguid = config.mainguid,
        _proguid = config.proguid,
        _saveAgency = config.saveAgency,
        _workflow = config.workflow,
        _issaveall = config.issaveall,
        _isGX = config.isGX,
        _isSHANXI = config.isSHANXI,
        _isCheckSpace = config.isCheckSpace,
        _oldcomponentid,
        _viewtype = config.viewtype,//查询状态
        _queryYear = config.queryYear,//跨年查询查询年度
        _queryProvince = config.queryProvince,//跨年查询查询区划
        _menuid = config.menuid,//菜单guid
        _taskguid = config.taskguid,//监控任务guid
        _isnzzj = config.isnzzj, // 是否年中追加
        _scrWidth =document.body.clientWidth,
        _scrHeight =document.body.clientHeight - 1;//高度减去1px边框
    var _tabData;
    var _isTabNum = true;
    var cmp = {};
    serviceid = service;
    var _isNX = config.isNX;
    var _isYANSHI = config.isYANSHI;

    cmp.setworkflow = function (workflow) {
        _workflow = workflow;
    }

    cmp.setIsQuery = function (isQuery) {
        _isQuery = isQuery;
    }

    /**
     * 查询列表
     * @param obj --组件对象
     * @param params --参数
     */
    cmp.querytable = function(params, componentid){
        try{
            if (!queryform)params.queryConfig = queryform.getQueryParam();
            params.querySql = queryform.getQuerySQL();
        }catch (e) {}
        params.tablesql = _table_param[componentid + "_defquery"];
        params.orderby = _table_param[componentid + "_orderby"];
        params.tablecode = _table_param[componentid];
        params.modelguid = _table_param[componentid + "_modelguid"];
        params.urlparameters = Ext.lt.ui.getUrlParameters();
        params.mainguid = _mainguid;
        params.workflow = _workflow;
        params.menuid = _menuid;
        params.querycode = config.querycode;
        params.bustype = config.bustype;
        params.proguid = config["proguid"] == null?config["projguid"]:config["proguid"];
        params.compconfigid = componentid;
        params.url = eval(componentid).config.pageurl;
        params.viewtype = _viewtype;
        params.queryYear = _queryYear;
        params.queryProvince = _queryProvince;
        Ext.lt.ui.loadingShow();
        if(eval(componentid).config.data[0].totaltag == 1) {
            params.beanid = "pmkpi.tabfream.TabfreamBOTX";
            Ext.lt.bus.exportBeanid = params.beanid;
            eval(componentid).queryData(params,function(){
                Ext.lt.ui.loadingClose();
                cmp.setIsQuery(true);
            });
        } else {
            var rs = Ext.lt.RCP.asyncall(serviceid , "getDatas", params);
            Ext.lt.ui.loadingClose();
            if (rs && rs.flg == "1") {
                eval(componentid).setDatas(rs.data);
                setTimeout(function(){
                    rs.isparent = true;
                    setMidSaveHidButtons(rs);
                },500);
                cmp.setIsQuery(true);
                Ext.lt.message.send("perfcommon", "tablequery",{componentid:componentid});
            } else {
                cmp.setIsQuery(false);
                Ext.lt.ui.alert(rs.msg,function(){
                });
            }
        }
    }

    /**
     * 查询编辑区
     * @param obj --组件对象
     * @param params --参数
     */
    cmp.queryedit = function(params, componentid){
        params.mainguid = _mainguid;
        params.saveAgency = _saveAgency;
        params.workflow = _workflow;
        params.menuid = _menuid;
        params.tablecode = _table_param[componentid];
        params.iswf = _table_param[componentid + "_iswf"];
        params.procode = config.procode ? config.procode : config.pro_code;
        if(params.procode && !params.mainguid){
            params.mainguid =config.proguid ? config.proguid : config.pro_id;
        }
        params.querycode = config.querycode;
        params.bustype = config.bustype;
        params.proguid = config.proguid;
        params.isqueryAgency = config.isqueryAgency;
		params.isnzzj = _isnzzj;
		params.compconfigid = componentid;
        params.url = eval(componentid).cfg.pageurl;
        params.viewtype = _viewtype;
        params.queryYear = _queryYear;
        params.queryProvince = _queryProvince;
        //IE不兼容Object.assign方法
        if (typeof Object.assign != 'function') {
            Object.assign = function(target) {
                'use strict';
                if (target == null) {
                    throw new TypeError('Cannot convert undefined or null to object');
                }

                target = Object(target);
                for (var index = 1; index < arguments.length; index++) {
                    var source = arguments[index];
                    if (source != null) {
                        for (var key in source) {
                            if (Object.prototype.hasOwnProperty.call(source, key)) {
                                target[key] = source[key];
                            }
                        }
                    }
                }
                return target;
            };
        }
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid , "editquery", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.flg == "1") {
            var data = rs.editdata;
            var formalmap = params.formalval;
            if (params.formalval) {
                //物理表里面存在读取物理表数据data = Object.assign(data, params.formalval);
                for(var key in formalmap){
                    if(data[key] == undefined || _isGX == 'true' || (_isSHANXI && _isSHANXI == true)){
                        data[key] = formalmap[key];
                    }
                }
            }
            eval(componentid).synchEditformByObj(data);
            if(eval(componentid).cfg.datasecurity && !checkDataHash(params.tablecode,data.guid)){
                Ext.lt.ui.alert(("该数据有篡改风险！"),{}, function(ret) {
                });
            }
            setTimeout(function(){
                rs.isparent = true;
                setMidSaveHidButtons(rs);
            },500);
            cmp.setIsQuery(true);
        } else {
            cmp.setIsQuery(false);
            Ext.lt.ui.alert(rs.msg,{}, function(ret) {
            });
        }
    }

    /**
     * 保存
     * @param obj
     * @param params
     */
    cmp.savedatas = function(obj, params){
        if (_viewtype == "query" || _table_param[_onclickid + "_viewtype"] == "query") {
            _isQuery = false;
            return true;
        }
        params.issavetmp = _issavetmp;
        //console.info("切换页签触发保存");
        var method = "";
        if (_issaveall && _issaveall == "2" && !params.isonclick) { //是否全部保存
            var iseditdata = false;
            var _savecomponentis = [];
            for (var i=0; i<_tabComponentid.length; i++) {
                var issave = false;
                var componentid = _tabComponentid[i];
                var component = eval(componentid);
                if(componentid.indexOf("editform") != -1){
                    if (!component.check()) return false;//先校验
                    if(component.haschange()){
                        issave = true;
                        var editvalue = component.getEditFormValues();
                        editvalue["mainguid"] = editvalue.guid;
                        _table_param[componentid + "_infodata"] = editvalue;
                    }
                }
                if(componentid.indexOf("datatable") != -1 ){
                    if (!component.checkAll()) return false;//先校验
                    if((component.getRemoveData() != null && component.getRemoveData().length > 0)
                        || (component.getUpdataData() != null && component.getUpdataData().length > 0)
                        || params.isadd){
                        issave = true;
                    }
                    _table_param[componentid + "_deldatas"] = component.getRemoveData() || [];
                    _table_param[componentid + "_updatas"] = component.getUpdataData() || [];
                    _table_param[componentid + "_datas"] = component.getRecordSet().toArray() || [];
                }
                if (issave){
                    iseditdata = true;
                    _savecomponentis.push(componentid);
                }
            }
            if (!iseditdata) {
                Ext.lt.ui.alert(("数据无修改"),{}, function(ret) {
                });
                return true;
            }
            method = "saveall";
            params.tableconfig = _table_param;
            params.savecomponentis = _savecomponentis;
        } else {
            _isQuery = false;
            if (_onclickid.indexOf("iframe") != -1) {
                var actionname = _table_param[_onclickid + "_action"];
                var action;
                if (actionname) {
                    action = eval('$("#'+ _onclickid+ '_iframe")[0].contentWindow.' + actionname);
                    var rt;
                    try {
                        rt = action();
                    } catch (e) {
                        console.error("执行保存方法失败，跳过保存");
                        if (params.istabsave != true) {
                            _isQuery = true;
                        }
                        return true;
                    }
                    if (rt && rt.success == true) {
                        if (obj){
                            if(!params.isaudit){
                                Ext.lt.ui.alert(("保存成功！"),{}, function(ret) {
                                    Ext.lt.ui.loadingClose();
                                    if (_onclickid.indexOf("datatable") != -1) {
                                        cmp.querytable(params, _onclickid);
                                    }
                                });
                            } else {
                                Ext.lt.ui.loadingClose();
                                if (_onclickid.indexOf("datatable") != -1) {
                                    cmp.querytable(params, _onclickid);
                                }
                            }
                        }
                        if (params.istabsave != true) {
                            _isQuery = true;
                        }
                        return true;
                    } else {
                        if (rt && rt.success == false){
                            //返回错误的页签id
                            if (rt.componentid) {
                                for (var i=0; i < _tabData.length; i++){
                                    var _index = _tabData[i].ordernum;
                                    if (_tabData[i]["componentid"] == rt.componentid){
                                        _tabData[i].refresh = false;
                                        cmp.tabpageOnclick(_tabData[i], _tabData, _btnobj);
                                        var seltabdiv = $("li[_index = '" + (_index - 1 ) + "']");
                                        seltabdiv[0].className = "choosed";
                                    } else {
                                        var tabdiv = $("li[_index = '" + (_index - 1 ) + "']");
                                        tabdiv[0].className = "nomal";
                                    }
                                }
                            }
                            Ext.lt.pmkpi.openlistdiv(rt);
                            Ext.lt.ui.loadingClose();
                            if(rt.errtype == "tips"){
                                return true;
                            }
                        } else if (rt){
                            if (rt && rt.msg) {
                                Ext.lt.ui.alert(rt.msg,function(){
                                    Ext.lt.ui.loadingClose();
                                });
                            } else {
                                Ext.lt.ui.alert('保存失败！',function(){
                                    Ext.lt.ui.loadingClose();
                                });
                            }
                        }
                        _isQuery = true;
                    }
                    if (!rt || params.istabsave != true) {
                        _isQuery = true;
                    }
                    //console.info("保存失败_isQuery：" + _isQuery);
                    return false;
                } else {
                    Ext.lt.ui.loadingClose();
                    return true;
                }
            } else {
                if (_onclickid.indexOf("editform") != -1){
                    if (!eval(_onclickid).check()) {
                        _isQuery = true;
                        return false;
                    }
                    if(_isNX && _onclickid == "analysisformaleditform" && !cmp.checkTraceAnalysisEdit()){// 宁夏监控分析校验
                        _isQuery = true;
                        return false;
                    }
                    if(!eval(_onclickid).haschange() && !_issavetmp){ //是否进行编辑
                        //console.info("数据无修改");
                        return true;
                    }
                    var infodata = eval(_onclickid).getEditFormValues();
                    if (!cmp.checkSpaceValue(infodata)) return;//校验空格
                    infodata.kpi_target = convertStr(infodata.kpi_target);
                    params.infodata = infodata;
                    params.iswf = _table_param[_onclickid + "_iswf"];
                    Ext.lt.message.send("perfcommon", "beforeEditsave",{params: params,id:_onclickid});
                    method = "infosave";
                } else if (_onclickid.indexOf("datatable") != -1) {
                    if (!eval(_onclickid).checkAll()) {
                        _isQuery = true;
                        return false;
                    }
                    var tabledatas = eval(_onclickid).getRecordSet().toArray();
                    if (tabledatas && tabledatas.length > 0) {
                        for (var a = 0, leni = tabledatas.length; a < leni; a++) {
                            if (!cmp.checkSpaceValue(tabledatas[a],"第" + (tabledatas[a]["_sortid"] + 1) + "行")) return;//校验空格
                            if(tabledatas[a].rowtype && tabledatas[a].rowtype == "add"){
                                tabledatas[a].name = convertStr(tabledatas[a].name);
                                tabledatas[a].indexval = convertStr(tabledatas[a].indexval);
                                tabledatas[a].kpi_val = convertStr(tabledatas[a].kpi_val);
                            }
                            tabledatas[a].adjustindexval = convertStr(tabledatas[a].adjustindexval);
                        }
                    }
                    params.datas = tabledatas;
                    params.updatas = eval(_onclickid).getUpdataData();
                    params.deldatas = eval(_onclickid).getRemoveData();
                    params.deltables = _table_param[_onclickid + "_deltables"];
                    params.delcols = _table_param[_onclickid + "_delcols"];
                    Ext.lt.message.send("perfcommon", "beforeTablesave",{params: params,id:_onclickid});
                    method = "tablesave";
                    if (params.updatas.length <= 0 &&  params.deldatas.length <= 0 && !params.isadd  && !_issavetmp) {
                        //console.info("数据无修改");
                        return true;
                    }
                }
            }
        }
        params.mainguid = _mainguid;
        params.saveAgency = _saveAgency;
        params.busguid = _table_param[_onclickid + "_busguid"];
        params.tablecode = _table_param[_onclickid];
        params.workflow = _workflow;
        Ext.lt.ui.loadingShow();
        Ext.lt.message.send("perfcommon", "beforesave",{params: params});
        var rs = Ext.lt.RCP.asyncall(serviceid , method, params);
        if (rs && rs.success == true) {
            if (obj){
                Ext.lt.ui.alert(("保存成功！"),{}, function(ret) {
                    if (_onclickid.indexOf("datatable") != -1) {
                        cmp.querytable(params, _onclickid);
                    }else if(_onclickid.indexOf("editform") != -1){
                        if(eval(_onclickid).cfg.datasecurity){
                            saveHash(params.tablecode,params.infodata.guid);
                        }
                        cmp.queryedit(params,_onclickid);
                    }
                });
            }
            //console.info("保存完成");
            Ext.lt.ui.loadingClose();
            return true;
        } else {
            if (rs && rs.success == false){
                //返回错误的页签id
                if (rs.componentid) {
                    for (var i=0; i < _tabData.length; i++){
                        var _index = _tabData[i].ordernum;
                        if (_tabData[i]["componentid"] == rs.componentid){
                            _tabData[i].refresh = false;
                            cmp.tabpageOnclick(_tabData[i], _tabData, _btnobj);
                            var seltabdiv = $("li[_index = '" + (_index - 1 ) + "']");
                            seltabdiv[0].className = "choosed layui-this";
                        } else {
                            var tabdiv = $("li[_index = '" + (_index - 1 ) + "']");
                            tabdiv[0].className = "nomal";
                        }
                    }
                }
                Ext.lt.pmkpi.openlistdiv(rs);
                if(rs.errtype == "tips"){
                    return true;
                }
            } else {
                if (rs && rs.msg) {
                    Ext.lt.ui.alert(rs.msg,function(){
                    });
                } else {
                    Ext.lt.ui.alert('保存失败！',function(){
                    });
                }
            }
            _isQuery = true;
        }
        Ext.lt.ui.loadingClose();
        if (params.istabsave != true) {
            _isQuery = true;
        }
        return false;
    }



    /**
     * 清除暂存
     * @param obj
     * @param params
     */
    cmp.deltmp = function(obj, params){
        if (_viewtype == "query" || _table_param[_onclickid + "_viewtype"] == "query") {
            _isQuery = false;
            return true;
        }
        if (_onclickid.indexOf("iframe") != -1) {
            var actionname = _table_param[_onclickid + "_action"]!=undefined ? _table_param[_onclickid + "_action"] + "tmpdel" : undefined;
            var action;
            if (actionname) {
                action = eval('$("#'+ _onclickid+ '_iframe")[0].contentWindow.' + actionname);
                var rt;
                try {
                    rt = action();
                } catch (e) {
                    console.error("执行清除暂存方法失败，跳过");
                    if (params.istabsave != true) {
                        _isQuery = true;
                    }
                    return true;
                }
                if (rt && rt.success == true) {
                    if (obj){
                        if(!params.isaudit){
                            Ext.lt.ui.alert(("清除暂存成功！"),{}, function(ret) {
                                Ext.lt.ui.loadingClose();
                                if (_onclickid.indexOf("datatable") != -1) {
                                    cmp.querytable(params, _onclickid);
                                }
                            });
                        } else {
                            Ext.lt.ui.loadingClose();
                            if (_onclickid.indexOf("datatable") != -1) {
                                cmp.querytable(params, _onclickid);
                            }
                        }
                    }
                    if (params.istabsave != true) {
                        _isQuery = true;
                    }
                    return true;
                } else {
                    if (rt && rt.success == false){
                        //返回错误的页签id
                        if (rt.componentid) {
                            for (var i=0; i < _tabData.length; i++){
                                var _index = _tabData[i].ordernum;
                                if (_tabData[i]["componentid"] == rt.componentid){
                                    _tabData[i].refresh = false;
                                    cmp.tabpageOnclick(_tabData[i], _tabData, _btnobj);
                                    var seltabdiv = $("li[_index = '" + (_index - 1 ) + "']");
                                    seltabdiv[0].className = "choosed";
                                } else {
                                    var tabdiv = $("li[_index = '" + (_index - 1 ) + "']");
                                    tabdiv[0].className = "nomal";
                                }
                            }
                        }
                        Ext.lt.ui.loadingClose();
                    } else if (rt){
                        if (rt && rt.msg) {
                            Ext.lt.ui.alert(rt.msg,function(){
                                Ext.lt.ui.loadingClose();
                            });
                        } else {
                            Ext.lt.ui.alert('清除暂存失败！',function(){
                                Ext.lt.ui.loadingClose();
                            });
                        }
                    }
                    _isQuery = true;
                }
                if (!rt || params.istabsave != true) {
                    _isQuery = true;
                }
                return false;
            } else {
                Ext.lt.ui.loadingClose();
                return true;
            }
        } else {
            if (_onclickid.indexOf("editform") != -1){
                params.url = eval(_onclickid).cfg.pageurl;
                params.mainguid = _mainguid;
                params.componentid = eval(_onclickid).cfg.server;
                params.compconfigid = _onclickid;
            } else if (_onclickid.indexOf("datatable") != -1) {
                params.url = eval(_onclickid).config.pageurl;
                params.mainguid = _mainguid;
                params.componentid = eval(_onclickid).config.server;
                params.compconfigid = _onclickid;
            }
        }
        params.mainguid = _mainguid;
        params.saveAgency = _saveAgency;
        params.busguid = _table_param[_onclickid + "_busguid"];
        params.tablecode = _table_param[_onclickid];
        params.workflow = _workflow;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid , "midsavedel", params);
        if (rs && rs.success == true) {
            if (obj){
                Ext.lt.ui.alert(("清除暂存成功！"),{}, function(ret) {
                    if (_onclickid.indexOf("datatable") != -1) {
                        cmp.querytable(params, _onclickid);
                    }else if(_onclickid.indexOf("editform") != -1){
                        cmp.queryedit(params,_onclickid);
                    }
                });
            }
            Ext.lt.ui.loadingClose();
            return true;
        } else {
            if (rs && rs.success == false){
                //返回错误的页签id
                if (rs.componentid) {
                    for (var i=0; i < _tabData.length; i++){
                        var _index = _tabData[i].ordernum;
                        if (_tabData[i]["componentid"] == rs.componentid){
                            _tabData[i].refresh = false;
                            cmp.tabpageOnclick(_tabData[i], _tabData, _btnobj);
                            var seltabdiv = $("li[_index = '" + (_index - 1 ) + "']");
                            seltabdiv[0].className = "choosed layui-this";
                        } else {
                            var tabdiv = $("li[_index = '" + (_index - 1 ) + "']");
                            tabdiv[0].className = "nomal";
                        }
                    }
                }
            } else {
                if (rs && rs.msg) {
                    Ext.lt.ui.alert(rs.msg,function(){
                    });
                } else {
                    Ext.lt.ui.alert('清除暂存失败！',function(){
                    });
                }
            }
            _isQuery = true;
        }
        Ext.lt.ui.loadingClose();
        if (params.istabsave != true) {
            _isQuery = true;
        }
        return false;
    }

    /**
     * 暂存
     * @param obj
     * @param params
     */
    cmp.savetmp = function(obj, params){
        if (_viewtype == "query" || _table_param[_onclickid + "_viewtype"] == "query") {
            _isQuery = false;
            return true;
        }
        //console.info("切换页签触发暂存");
        _isQuery = false;
        if (_onclickid.indexOf("iframe") != -1) {
            var actionname = _table_param[_onclickid + "_action"]!=undefined ? _table_param[_onclickid + "_action"] + "tmp" : undefined;
            var action;
            if (actionname) {
                action = eval('$("#'+ _onclickid+ '_iframe")[0].contentWindow.' + actionname);
                if(typeof(action)!="function"){
                    action = eval('$("#'+ _onclickid+ '_iframe")[0].contentWindow.' + _table_param[_onclickid + "_action"]);
                }
                var rt;
                try {
                    rt = action();
                } catch (e) {
                    console.error("执行暂存方法失败，跳过暂存");
                    if (params.istabsave != true) {
                        _isQuery = true;
                    }
                    return true;
                }
                if (rt && rt.success == true) {
                    if (obj){
                        if(!params.isaudit){
                            Ext.lt.ui.alert(("暂存成功！"),{}, function(ret) {
                                Ext.lt.ui.loadingClose();
                                if (_onclickid.indexOf("datatable") != -1) {
                                    cmp.querytable(params, _onclickid);
                                }
                            });
                        } else {
                            Ext.lt.ui.loadingClose();
                            if (_onclickid.indexOf("datatable") != -1) {
                                cmp.querytable(params, _onclickid);
                            }
                        }
                    }
                    if (params.istabsave != true) {
                        _isQuery = true;
                    }
                    return true;
                } else {
                    if (rt && rt.success == false){
                        //返回错误的页签id
                        if (rt.componentid) {
                            for (var i=0; i < _tabData.length; i++){
                                var _index = _tabData[i].ordernum;
                                if (_tabData[i]["componentid"] == rt.componentid){
                                    _tabData[i].refresh = false;
                                    cmp.tabpageOnclick(_tabData[i], _tabData, _btnobj);
                                    var seltabdiv = $("li[_index = '" + (_index - 1 ) + "']");
                                    seltabdiv[0].className = "choosed";
                                } else {
                                    var tabdiv = $("li[_index = '" + (_index - 1 ) + "']");
                                    tabdiv[0].className = "nomal";
                                }
                            }
                        }
                        Ext.lt.ui.loadingClose();
                    } else if (rt){
                        if (rt && rt.msg) {
                            Ext.lt.ui.alert(rt.msg,function(){
                                Ext.lt.ui.loadingClose();
                            });
                        } else {
                            Ext.lt.ui.alert('暂存失败！',function(){
                                Ext.lt.ui.loadingClose();
                            });
                        }
                    }
                    _isQuery = true;
                }
                if (!rt || params.istabsave != true) {
                    _isQuery = true;
                }
                //console.info("暂存失败_isQuery：" + _isQuery);
                return false;
            } else {
                Ext.lt.ui.loadingClose();
                return true;
            }
        } else {
            if (_onclickid.indexOf("editform") != -1){
                params.url = eval(_onclickid).cfg.pageurl;
                params.mainguid = _mainguid;
                params.componentid = eval(_onclickid).cfg.server;
                params.compconfigid = _onclickid;
                params.data = eval(_onclickid).getEditFormValues();
                Ext.lt.message.send("perfcommon", "beforeEditsave",{params: params,id:_onclickid});
                if(!eval(_onclickid).haschange()){ //是否进行编辑
                    //console.info("数据无修改");
                    if (params.istabsave != true) {
                        Ext.lt.ui.alert(("暂存成功！"),{}, function(ret) {});
                    }
                    return true;
                }
            } else if (_onclickid.indexOf("datatable") != -1) {
                params.url = eval(_onclickid).config.pageurl;
                params.mainguid = _mainguid;
                params.componentid = eval(_onclickid).config.server;
                params.compconfigid = _onclickid;
                params.data = eval(_onclickid).getRecordSet().toArray();
                params.updatas = eval(_onclickid).getUpdataData();
                params.deldatas = eval(_onclickid).getRemoveData();
                Ext.lt.message.send("perfcommon", "beforeTablesave",{params: params,id:_onclickid});
                if (params.updatas.length <= 0 &&  params.deldatas.length <= 0 && !params.isadd) {
                    //console.info("数据无修改");
                    if (params.istabsave != true) {
                        Ext.lt.ui.alert(("暂存成功！"),{}, function(ret) {});
                    }
                    return true;
                }
            }
        }
        params.mainguid = _mainguid;
        params.saveAgency = _saveAgency;
        params.busguid = _table_param[_onclickid + "_busguid"];
        params.tablecode = _table_param[_onclickid];
        params.workflow = _workflow;
        Ext.lt.ui.loadingShow();
        Ext.lt.message.send("perfcommon", "beforesave",{params: params});
        var rs = Ext.lt.RCP.asyncall(serviceid , "midsave", params);
        if (rs && rs.success == true) {
            if (obj){
                Ext.lt.ui.alert(("暂存成功！"),{}, function(ret) {
                    if (_onclickid.indexOf("datatable") != -1) {
                        cmp.querytable(params, _onclickid);
                    }else if(_onclickid.indexOf("editform") != -1){
                        cmp.queryedit(params,_onclickid);
                    }
                });
            }
            //console.info("暂存完成");
            Ext.lt.ui.loadingClose();
            return true;
        } else {
            if (rs && rs.success == false){
                //返回错误的页签id
                if (rs.componentid) {
                    for (var i=0; i < _tabData.length; i++){
                        var _index = _tabData[i].ordernum;
                        if (_tabData[i]["componentid"] == rs.componentid){
                            _tabData[i].refresh = false;
                            cmp.tabpageOnclick(_tabData[i], _tabData, _btnobj);
                            var seltabdiv = $("li[_index = '" + (_index - 1 ) + "']");
                            seltabdiv[0].className = "choosed layui-this";
                        } else {
                            var tabdiv = $("li[_index = '" + (_index - 1 ) + "']");
                            tabdiv[0].className = "nomal";
                        }
                    }
                }
            } else {
                if (rs && rs.msg) {
                    Ext.lt.ui.alert(rs.msg,function(){
                    });
                } else {
                    Ext.lt.ui.alert('暂存失败！',function(){
                    });
                }
            }
            _isQuery = true;
        }
        Ext.lt.ui.loadingClose();
        if (params.istabsave != true) {
            _isQuery = true;
        }
        return false;
    }

    Ext.lt.pmkpi.openlistdiv = function (rt){
        Ext.lt.pmkpi.errordata = rt.redata;
        var url = '/pmkpi/auditdefine/error.page';
        var params = {};
        params.menuid = "";
        // var errorDatas = encodeURI(JSON.stringify(rt.redata), "utf-8");
        // params.errorDatas = errorDatas;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        //开发环境无遮罩，生产没问题
        // Ext.lt.ui.openModalWindow(url,_scrWidth * 0.80,_scrHeight * 0.85,"审核定义信息")
        Ext.lt.ui.openModalWindow(url,_scrWidth * 0.80,_scrHeight * 0.85,"审核定义信息");
    }

    /**
     * 删除
     * @param obj --组件对象
     * @param params --参数
     */
    cmp.deltable = function(tableobj, params){
        var datas;
        if (tableobj && tableobj.id && tableobj.id.indexOf("datatable") != -1) {
            datas = tableobj.getSelected();
        }
        if (!datas || datas.size() <= 0) {
            Ext.lt.ui.alert('请选择要删除的数据！',function(){
            });
            return;
        }
        params.selDatas = datas;
        Ext.lt.ui.confirm('是否删除已选择数据？',{icon: "warn"},function(is){
            if(is){
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(serviceid , "del", params, function(rs){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('删除成功！',function(){
                        Ext.lt.message.send("perfcommon", "tablequery",{});
                    });
                },function(){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('删除失败！',function(){
                    });
                });
            }
        })
    }

    //切换页签
    cmp.tabpageOnclick = function(tabobj,tabData, btnobj) {
        _tabData = tabData;
        var showid = tabobj.componentid;
        var config = tabobj.config;
        var refreshdata = tabobj.refresh;
        var isquerydata = tabobj.isquerydata;
        _btnobj = btnobj;
        var _params = {};
        var tabconfig = eval('(' + config + ')');
        if(config.flg != "query") {
            if (showid != _onclickid){
                //console.info("切换页签_isQuery：" + _isQuery);
                if (_isQuery == true) {//查询数据成功切换页签
                    if (_onclickid && (_onclickid.indexOf("file") == -1 && _onclickid.indexOf("report") == -1)) {
                        //切换页签保存数据
                        Ext.lt.message.send("perfcommon", "clicktabpage",{params: _params, id : showid});
                        _params.isonclick=true;
                        _params.istabsave = true;//是否页签切换
                        var savers;
                        if(!_issavetmp){//调用保存
                            savers = cmp.savedatas(null, _params);
                        }else{//调用暂存
                            savers = cmp.savetmp(null, _params);
                        }
                        if (!savers){
                            _tabnum = tabobj.ordernum;
                            setTimeout(function () {
                                var seltabdiv = $("li[_index = '" + (_oldtabnum -1 ) + "']");
                                var tabdiv = $("li[_index = '" + (_tabnum - 1 ) + "']");
                                tabdiv[0].className = "nomal";
                                seltabdiv[0].className = "choosed layui-this";
                            }, 200);
                            return;
                        } else {
                            var tabdiv = $("li[_index = '" + (_oldtabnum - 1 ) + "']");
                            tabdiv[0].className = "nomal";
                        }
                    }
                }
                for (var i=0; i < _tabData.length; i++){
                    var id = _tabData[i].componentid;
                    if (id == showid){
                        _onclickid = showid;
                        _oldtabnum = tabobj.ordernum;
                        if (document.getElementById(showid)){
                            document.getElementById(showid).style.display = "block";
                        }
                    } else {
                        if (document.getElementById(id)){
                            document.getElementById(id).style.display = "none";
                        }
                    }
                }
                if (tabobj.hiddiv && tabobj.hiddiv.length > 0) {
                    for (var i=0; i < tabobj.hiddiv.length; i++){
                        var id = tabobj.hiddiv[i];
                        if (document.getElementById(id)){
                            document.getElementById(id).style.display = "none";
                        }
                    }
                }
            }
            changToolbuttonStatus(btnobj, parseInt(tabobj.ordernum), tabobj.hidebtns);
            if (refreshdata != false) {
                tabconfig.isquerydata = isquerydata;
                cmp.tabinitpage(showid,tabconfig);
            }
        }
    }

    /**
     * 初始化页签相应内容
     * @param componentid
     * @param tabconfig
     */
    cmp.tabinitpage = function(componentid,tabconfig){
        _table_param[componentid + "_busguid"] = tabconfig.busguid;
        _table_param[componentid + "_viewtype"] = tabconfig.viewtype;
        _table_param[componentid + "_filetype"] = tabconfig.filetype;
        var isquerydata = tabconfig.isquerydata;
        var _params = {};
        if (componentid.indexOf("editform") != -1){ //编辑区
            if (_viewtype == "query" || tabconfig.viewtype == "query") {
                setTimeout(function (){
                    cmp.editSetdisabled(eval(componentid));//设置基本信息不可编辑
                },1000);
            }
            _tabComponentid.remove(componentid);
            _tabComponentid.push(componentid);
            _table_param[componentid] = eval(componentid).cfg.tablecode;
            _table_param[componentid + "_iswf"] = eval(componentid).cfg.iswf;
            //编辑区展示后调用消息
            Ext.lt.message.send("perfcommon", "editinit",{params: _params, id : componentid});
            if (!isquerydata) {
                cmp.queryedit(_params, componentid);
            }
        } else if (componentid.indexOf("datatable") != -1){ //列表
            _tabComponentid.remove(componentid);
            _tabComponentid.push(componentid);
            Ext.lt.message.send("perfcommon", "tableinit",{params: _params, id : componentid});
            if (!isquerydata) {
                cmp.querytable(_params, componentid);
            }
        } else if (componentid.indexOf("file") != -1) {
        } else if (componentid.indexOf("report") != -1){
            Ext.lt.message.send("perfcommon", "reportinit",{params: _params});
            var url = "";
            if (tabconfig.reporttype == "excel"){
                _params.reportId = tabconfig.reportid;
                url = "/hqreport/show.htm";
            } else if (tabconfig.reporttype == "word") {
                _params.docxId = tabconfig.reportid;
                url = "/hqreport/wordshow.htm";
            }
            var appid = tabconfig.appid;
            if (appid && appid != "") {
                _params.sysId = appid;
            } else {
                _params.sysId = "pmkpi";
            }
            _params.year = config.year;
            url = Ext.lt.pmkpi.genPageUrl(url, _params);
            var divdoc =  document.getElementById(componentid);
            if (!divdoc) {
                var divhtml = '<div id="' + componentid + '" style="width:'
                    + (_scrWidth -10) + 'px; height:' + (_scrHeight - 90) + 'px;"><iframe src="'
                    + url + '" scrolling="yes" style="width:'
                    + (_scrWidth -10) + 'px; height:' + (_scrHeight - 90) + 'px"></iframe></div>';
                $('.bd_main').append(divhtml);
            }
        } else if (componentid.indexOf("iframe") != -1){
            if (!tabconfig.url){
                return;
            }
            Ext.lt.message.send("perfcommon", "iframeinit",{params : _params});
            var url = tabconfig.url;
            _params.saveAgency = _saveAgency;
            _params.busguid = tabconfig.busguid;
            if (tabconfig.viewtype) {
                _params.viewtype = tabconfig.viewtype;
            }
            _params.filetype = tabconfig.filetype;
            _params.workflow = _workflow;
            _params.taskguid = _taskguid;
            _params.filebustype = tabconfig.filebustype;
            url = Ext.lt.pmkpi.genPageUrl(url, _params);
            var divdoc =  document.getElementById(componentid);
            if (!divdoc) {
                if (_viewtype == "query") {
                    var _viewdiv = document.createElement("div");
                    _setFrame(_viewdiv);
                    _viewdiv.id = componentid;
                    var _viewiframe = document.createElement("iframe");
                    _setFrame(_viewiframe);
                    _viewiframe.id = componentid + "_iframe";
                    _viewiframe.src = url;
                    _viewdiv.appendChild(_viewiframe);
                    var divobj =  document.getElementById(_oldcomponentid);
                    $('.bd_main')[0].insertBefore(_viewdiv,divobj);
                } else {
                    var divhtml = '<div id="' + componentid + '" style="width:'
                        + (_scrWidth -10) + 'px; height:' + (_scrHeight - 110) + 'px;"><iframe id="' + componentid + '_iframe" src="'
                        + url + '" scrolling="yes" style="width:'
                        + (_scrWidth -10) + 'px; height:' + (_scrHeight - 110) + 'px"></iframe></div>';
                    $('.bd_main').append(divhtml);
                }
                _table_param[componentid + "_action"] = tabconfig.action;
            } else {
                document.getElementById(componentid + '_iframe').src=url;
            }
        }
        _oldcomponentid = componentid;
    }

    function _setFrame(obj){
        obj.setAttribute('frameBorder', 0);
        obj.style.cssText = 'border: 0 none;';
        obj.width = _scrWidth;
        obj.height = _scrHeight-55;
    }

    /**
     * 工作流
     * @param obj
     * @param params
     */
    cmp.doAction = function(btnobj, params) {
        var actioncode = btnobj.code;
        var actionname = btnobj.name;
        var tooltabconfig = eval('(' + btnobj.config + ')');
        var isremark = '';
        var jxback = '';
        if (tooltabconfig && tooltabconfig.remark){
            isremark = tooltabconfig.remark;
            jxback = tooltabconfig.jxback;
        }
        params.actionname = actionname;
        params.actioncode = actioncode;
        params.isremark = isremark;
        if (tooltabconfig && tooltabconfig.aisupportaudit){
            cmp.aisupportaudittask(params);
        }
        //是否走意见，送审/审核/退回
        if(isremark == true && (actioncode == "sendaudit" || actioncode == "audit" || actioncode || "back" || actioncode == "auditbatch")){
            params.serviceid = serviceid;
            params.workflow = _workflow;
            params.jxback = jxback;
            cmp.auditopinion(params);
        }else{
            if (actioncode != "audit" && actioncode != "back") {
                Ext.lt.pmkpi.auditdata = null;
            }
            Ext.lt.pmkpi.sendWFAction(params);
        }
    }

    Ext.lt.pmkpi.sendWFAction = function (params){
        var actionname = params.actionname;
        if(Ext.lt.pmkpi.auditdata && Ext.lt.pmkpi.auditdata.maindata){
            var remarkmap = Ext.lt.pmkpi.auditdata.maindata;
            if (remarkmap.type == "perfconreview") {
                params.audittype = remarkmap.conaudittype;
            }
            params.remark = remarkmap.remark;
        }
        if (!params.remark && Ext.lt.pmkpi.auditdata) {
            //console.info("审核问题对象：" + Ext.lt.pmkpi.auditdata.toString());
        }
        params.urlparameters = Ext.lt.ui.getUrlParameters();
        params.mainguid = _mainguid;
        params.workflow = _workflow;
        params.menuid = _menuid;
        var modeltype = params.modeltype;
        var isconts = params.isconts;
        var message = '是否确定“' + actionname + '”已选择的数据？';
        //年中追加、绩效目标修订、绩效目标调整数据终审时提示不能取消终审
        if (modeltype == "1" && isconts ){
            message = '数据终审后无法取消！是否确定“终审”已选择的数据？';
        }
        Ext.lt.ui.confirm(message,{icon: "warn"},function(is){
            if(is){
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(serviceid, "wfAudit", params, function(rt){
                    if (rt && rt.success == true){
                        Ext.lt.ui.alert( actionname + "成功！",function(){
                            Ext.lt.message.send("perfcommon", "auditquery",{});
                        });
                        if (params.isremark && params.isremark == "true") {
                            try {
                                window.parent.Ext.lt.ui.closeModalWindow();
                            } catch (e) {
                                try {
                                    window.parent.Ext.lt.ui.modalWindow.close();
                                } catch (e) {
                                    Ext.lt.ui.modalWindow.close();
                                }
                            }
                        }
                    } else if(rt && rt.success == false){
                        if (params.isremark && params.isremark == "true") {
                            try {
                                window.parent.Ext.lt.ui.closeModalWindow();
                            } catch (e) {
                                try {
                                    window.parent.Ext.lt.ui.modalWindow.close();
                                } catch (e) {
                                    Ext.lt.ui.modalWindow.close();
                                }
                            }
                        }
                        if (rt.errtype == "tips") {
                            Ext.lt.message.send("perfcommon", "auditquery",{});
                        }
                        Ext.lt.pmkpi.openlistdiv(rt);
                    } else {
                        var alertmsg = "";
                        if(rt && rt.msg) {
                            alertmsg = rt.msg;
                        } else {
                            alertmsg = actionname + "失败，请检查工作流！";
                        }
                        Ext.lt.ui.alert(alertmsg,{timeout:5},function(){
                        });
                    }
                    Ext.lt.ui.loadingClose();
                },function(resp){
                    Ext.lt.ui.loadingClose();
                    var alertmsg = actionname + "失败！\n失败原因：" + resp;
                    Ext.lt.ui.alert(alertmsg,{timeout:5},function(){
                    });
                });
            }
        });
    }

    /**
     * 纳入ai辅助审核的任务队列，后台定时生成辅助审核结果
     * @param params
     */
    cmp.aisupportaudittask = function(params) {
        var procodes = [];
        for(var i=0;i<params.datas.length;i++){
            procodes.push(params.datas[i].pro_code);
        }
        Ext.lt.RCP.call(serviceid, "aiSupportAuditTask", params, function(rt){
            if (rt && rt.success == true){
                console.info(procodes+"纳入ai辅助审核的任务队列成功");
            }else{
                console.info(procodes+"纳入ai辅助审核的任务队列失败："+rt.msg);
            }
        });
    }

    /**
     * 查看审核流程
     * @param obj --组件对象
     */
    cmp.auditquery = function(tableobj){
        Ext.lt.pmkpi.auditquery(tableobj);
    }

    Ext.lt.pmkpi.auditquery = function (tableobj) {
        if (!datatable) {
            datatable = tableobj;
        }
        if (datatable.getRecordset().size() != 0) {
            var selectDatas = datatable.getSelected();
            if (selectDatas.length == 0) {
                Ext.lt.ui.alert("未选中数据！",{timeout:1},function(){});
                return;
            } else if (selectDatas.length > 1) {
                Ext.lt.ui.alert("查看日志只能选择一条数据！",{timeout:1},function(){});
                return;
            }else {
                var row = selectDatas[0];
                var url = _APPID_PATH_+"/datacommon/wf/log/index.page";
                var params = {};
                params.billid = selectDatas[0].guid;
                params.wfid = selectDatas[0].wfid;
                url = Ext.lt.pmkpi.genPageUrl(url, params);
                Ext.lt.ui.openModalWindow(url+ Ext.lt.token.getAuthorization(), Math.floor(_scrWidth*0.9), Math.floor(_scrHeight*0.8), "业务流转情况");
            }
        } else {
            Ext.lt.ui.alert("页面无数据！",{timeout:1},function(){});
            return;
        }
    }

    cmp.gatherWeight = function(superid){
        var datas = eval(_onclickid).getRecordSet().toArray();
        if(superid){
            if(datas!=null && datas.length > 0){
                var supguid = '';
                var sortid = 0;
                var result = 0;
                var guid = '';
                for(var i=0;i<datas.length;i++){
                    var selectDatas = datas[i];
                    if(superid == selectDatas.guid){
                        supguid = selectDatas.superid;
                        guid = selectDatas.guid;
                    }
                    if(selectDatas.superid == superid && selectDatas.weight && !isNaN(selectDatas.weight)){
                        result += parseFloat(selectDatas.weight);
                    }
                }
                datas.each(function(data,i){
                    if(data.guid == guid){
                        datas[i]['weight'] = result==0 ? "" : result.toFixed(2);
                    }
                });
                cmp.gatherWeight(supguid);
            }
        }
        eval(_onclickid).reflash();
    }

    cmp.amtTotal = function (table) {
        if(table.getSumobj()){
            var totalrow = table.getRecordset();
            var sumamt = 0;
            var rowarr = totalrow.toArray();
            var len = rowarr.length;
            for ( var i = 0; i < len; i++) {
                if (rowarr[i].isleaf == "1" && rowarr[i].levelno == "3") {
                    var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0;
                    sumamt += parseFloat(weight);
                } else if (rowarr[i].isleaf == undefined && rowarr[i].levelno == undefined) {
                    var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0;
                    sumamt += parseFloat(weight);
                }
            }
            var totalrs = {};
            totalrs["weight"] = sumamt == 0 ? "" : sumamt.toFixed(2);
            totalrs.datatable_do_sum=true;
            table.getClockRowSet().setData(totalrs,0);
            if((totalrow.size&&totalrow.size()>0)||(totalrow.length&&totalrow.length>0)){
                table.reflashdata();
            }
        }
    }

    var colspross_time = 0;
    Ext.lt.pmkpi.expdoc = function(btn, table){
        var btnconfig = eval('(' + btn.config + ')');
        var _tempatecode = btnconfig.tempatecode;
        var isexp = btnconfig.isexp;
        var _rows = [];
        var guids = [];
        var projguids = [];
        if (!isexp) {
            if (table){
                _rows = table.getSelected();
            } else {
                _rows = datatable.getSelected();
            }
            if(_rows.length <= 0){
                Ext.lt.ui.alert("请选择数据！", function () {
                });
                return;
            }
            for (var i=0; i<_rows.length;i++){
                guids.push(_rows[i]["guid"]);
                projguids.push(_rows[i]["proguid"]);
            }
        } else {
            guids.push(_mainguid);
        }
        var param = {};
        param.guids = guids;
        param.projguids = projguids;
        param.templatecode = _tempatecode;
        param.bobeanid = "pmkpi.perfcommon.expdoc.ExpDocBOTX";
        param.rcp = true;
        if (_rows.length >= 5) {
            if (Ext.lt.ui.confirm("当前导出数据较多，需时间较长，导出完成后自行关闭进度窗口，是否确认导出！")) {
                Ext.lt.RCPConsole.processdown("pmkpi.perfcommon.expdoc.ExpDocService",'createWord&rcpconsole=process&noserveranalyselog=true',param,"downframe");
                colspross_time = 1;
                setTimeout(cmp.colspross_function,1000);
            } else {
                return;
            }
        } else {
            param.rcp = false;
            Ext.lt.RCPConsole.processdown("pmkpi.perfcommon.expdoc.ExpDocService",'createWord',param,"downframe");
            var rcpconsole=document.getElementsByClassName('rcpconsole');
            for(i=0;i<rcpconsole.length;i++){
                rcpconsole.item(i).style.display = 'none';
            }
            Ext.lt.ui.loadingClose();
        }
    }

    cmp.colspross_function = function (time) {
        if (time) {
            colspross_time = time;
        }
        if(colspross_time ==0) return;
        var flag = false;
        var rcpconsole=document.getElementsByClassName('rcpconsole');
        for(var i=0;i<rcpconsole.length;i++){
            if (rcpconsole.item(i).style.display != "none"){
                flag = true;
                break;
            }
        }
        if (flag){
            Ext.lt.RCP.server('gov.mof.fasp2.buscore.framework.rpcfw.termial.RCPConsoleComponentService','getProcessMessage',null,function(msg){
                if (msg.process == 0 && msg.text == null){
                    var rcpconsole=document.getElementsByClassName('rcpconsole');
                    for(var i=0;i<rcpconsole.length;i++){
                        rcpconsole.item(i).style.display = 'none';
                    }
                    Ext.lt.ui.loadingClose();
                } else { //继续调用自身
                    setTimeout(cmp.colspross_function,1000);
                }
            });
        } else {
            clearInterval(colspross_time);
            colspross_time = 0;
        }
    }

    //导出列表数据
    cmp.export = function (obj, table) {
        Ext.lt.pmkpi.expdata(obj, table);
    }

    //导出列表数据
    Ext.lt.pmkpi.expdata = function (obj, table) {
        var btnconfig = eval('(' + obj.config + ')');
        var key = btnconfig.key;
        var cfg = {};
        var _rows;
        var _datas;
        var dtable;
        if (table){
            dtable = table;
        } else {
            dtable = datatable;
        }
        _rows = dtable.getSelected();
        _datas = dtable.getRecordset().toArray();
        cfg.bustable = dtable;
        if (key) {
            cfg.key = key;
        } else {
            cfg.key = dtable.key;//datatable的key值
        }
        cfg.downtype = 'xls';
        if (_datas.size > 0) {
            if (_rows.size() == 0) {
                if (Ext.lt.ui.confirm("是否导出当前全部数据？")) {
                    cfg.hassql = 1;
                    if (typeof (queryform) != 'undefined') {
                        cfg.isHaveQueryForm = true;//是否有查询区
                        cfg.queryConfig = queryform.getQueryParam();//查询区条件
                    }
                    if (typeof (tabpage) != 'undefined') {
                        cfg.isHaveTabPage = true;//是否有页签
                    }
                    cfg.filter = " 1=1 ";
                    cfg.beanid = dtable.config.page.queryMap.beanid;//获取beanid用于合计行
                    dataexport.excelexport(cfg);
                } else {
                    return;
                }
            } else {
                dataexport.excelexport(cfg);
            }
        } else {
            Ext.lt.ui.alert("页面无数据！", {timeout: 1}, function () {
            });
            return;
        }
    }

    cmp.changTooltoolbuttontStatus = function(index,hidebtns){
        if(toolbutton){
            var buttons = toolbutton.cfg.data.buttons;
            for(var i=0,length = buttons.length;i<length;i++){
                var btn = buttons[i];
                //修改为隐藏显示
                if((","+hidebtns+",").indexOf(","+btn.name+",")!=-1){
                    toolbutton.hidden(btn.name);
                    btn.isvisiable = 0;
                } else {
                    toolbutton.unHidden(btn.name);
                    btn.isvisiable = 1;
                }
            }
        }
    }

    cmp.changTooltoolbuttontCode = function(hidebtns){
        if(toolbutton){
            var buttons = toolbutton.cfg.data.buttons;
            for(var i=0,length = buttons.length;i<length;i++){
                var btn = buttons[i];
                //修改为隐藏显示
                if((","+hidebtns+",").indexOf(","+btn.code+",")!=-1){
                    toolbutton.hidden(btn.code);
                    btn.isvisiable = 0;
                } else {
                    toolbutton.unHidden(btn.code);
                    btn.isvisiable = 1;
                }
            }
        }
    }

    cmp.changToolShowbuttont = function(showbtns){
        if(toolbutton){
            var buttons = toolbutton.cfg.data.buttons;
            for(var i=0,length = buttons.length;i<length;i++){
                var btn = buttons[i];
                //修改为隐藏显示
                if((","+showbtns+",").indexOf(","+btn.code+",")!=-1){
                    toolbutton.unHidden(btn.code);
                    btn.isvisiable = 1;
                } else {
                    toolbutton.hidden(btn.code);
                    btn.isvisiable = 0;
                }
            }
        }
    }

    cmp.setColMapper = function (cols) {
        for (var i=0; i<cols.length; i++) {
            var col = cols[i];
            var type = col.type;
            if (type == "tree") {
                col.mapper = {} ;
                col.mapper.columns = ['guid','code','name','supcode','pinyin'];
                col.mapper.datas = [] ;
            }
        }
    }

    cmp.setColDatasource = function (_datasource, datatable) {
        if (_datasource) {
            for(var key in _datasource){
                var datatype_source = [];
                var datas = _datasource[key];
                for(var i=0; i<datas.length; i++){
                    var temparr = [];
                    temparr.push(datas[i]["guid"]);
                    temparr.push(datas[i]["code"]);
                    temparr.push(datas[i]["name"]);
                    datatype_source.push(temparr);
                }
                datatable.addMapperDatas(key, datatype_source);
            }
        }
    }

    /**
     * 审核意见弹出
     */
    cmp.auditopinion = function (params){
        var url = "/pmkpi/audit/opinion.page";
        var actionname = params.actionname;
        var enname = encodeURI(params.actionname);
        params.actionname = enname;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,_scrWidth * 0.75,_scrHeight * 0.75,actionname + "意见");
    }

    /**
     * 设置编辑区不可编辑
     */
    cmp.editSetdisabled = function (editfrom){
        var cols = editfrom.cfg.data;
        var c = {};
        for (var i=0; i<cols.length; i++) {
            c[cols[i].colcode.toLowerCase()] = true;
        }
        editfrom.setdisabled(c);//设置基本信息不可编辑
    }

    /**
     * 组装校验字典-（校验目标、指标数据数据map的值是否包含空格）
     */
    cmp.checkSpaceValueDetail = function (datamap, onclickid) {
        // 定义需要检查的字段及其标签
        var fieldsToCheck = [
            { key: "perf_ind_name", label: "【指标名称】" },
            { key: "lv3_perf_ind_name", label: "【指标名称】" },
            { key: "kpi_val", label: "【指标值】" },
            { key: "indexval", label: "【指标值】" },
            { key: "indexvalue", label: "【指标值】" },
            { key: "adjustindexval", label: "【调整后指标值】" },
            { key: "kpi_target", label: "【绩效目标】" },
            { key: "zqgoal", label: "【绩效目标】" },
            { key: "adjustndgoal", label: "【调整后绩效目标】" }
        ];
        if(!onclickid){
            onclickid = _onclickid;
        }
        var isCheckName = false;// 是否根据字段名为name校验指标名称: colcode='name'并且字段名包含'指标'判定为指标名称

        if (onclickid && onclickid.indexOf("editform") != -1){
            isCheckName = checkColumnContainsIndicator(eval(onclickid).cfg.data, "name");
        } else if (onclickid && onclickid.indexOf("datatable") != -1) {
            var columns = !eval(onclickid).config.data[0] ? [] : eval(onclickid).config.data[0].columns;
            isCheckName = checkColumnContainsIndicator(columns, "alias");
        }
        if (isCheckName) {
            fieldsToCheck.push({ key: "name", label: "【指标名称】" });
        }
        for (var i=0;i<fieldsToCheck.length;i++){
            fieldsToCheck[i].value = datamap[fieldsToCheck[i].key];
        }
        return fieldsToCheck;
    }

    function checkColumnContainsIndicator (data, key){
        var column;
        for (var i = 0; i < data.length; i++) {
            if (data[i] && data[i].colcode && data[i].colcode.toUpperCase() === "NAME") {
                column = data[i];
                break;
            }
        }
        var result = false;
        if (column && column[key] && column[key].indexOf("指标") !== -1) {
            result = true;
        }
        return result;
    };

    /**
     * 校验目标、指标数据数据map的值是否包含空格
     * 返回提示语
     * @param datamap 校验的数据map
     * @param prefixmsg 校验提示语前缀 可为空不拼接前缀
     * @param onclickid 校验的组件 表格或者编辑区 可为空，获取当前点击_onclickid(调用通用保存方法时)
     */
    Ext.lt.pmkpi.checkSpaceValue = function (datamap, prefixmsg, onclickid) {
        // 如果不需要检查空格，直接返回
        if (!_isCheckSpace) {
            return "success";
        }
        prefixmsg = !prefixmsg ? "" : prefixmsg;
        var fieldsToCheck = cmp.checkSpaceValueDetail(datamap, onclickid);
        var errors = [];
        var seenErrors = new Set();
        for (var i=0;i<fieldsToCheck.length;i++) {
            var value = fieldsToCheck[i].value;
            var label = fieldsToCheck[i].label;
            var error = checkSpaceStr(value, label);
            if (error && !seenErrors.has(error)) {
                seenErrors.add(error);
                errors.push(error);
            }
        }
        if (errors.length) {
            var fullMsg = prefixmsg + errors.join("；");
            return "{callsuc:0,callmsg:'" + fullMsg + "'}";
        }
        return "success";
    }

    /**
     * 校验目标、指标数据数据map的值是否包含空格
     * 返回 true false
     * @param datamap 校验的数据map
     * @param prefixmsg 校验提示语前缀 可为空不拼接前缀
     * @param onclickid 校验的组件 表格或者编辑区 可为空，获取当前点击_onclickid(调用通用保存方法时)
     */
    cmp.checkSpaceValue = function (datamap, prefixmsg, onclickid) {
        // 如果不需要检查空格，直接返回 true
        if (!_isCheckSpace) {
            return true;
        }
        prefixmsg = !prefixmsg ? "" : prefixmsg;
        var fieldsToCheck = cmp.checkSpaceValueDetail(datamap, onclickid);
        var errors = [];
        var seenErrors = new Set();
        for (var i=0;i<fieldsToCheck.length;i++) {
            var value = fieldsToCheck[i].value;
            var label = fieldsToCheck[i].label;
            var error = checkSpaceStr(value, label);
            if (error && !seenErrors.has(error)) {
                seenErrors.add(error);
                errors.push(error);
            }
        }
        if (errors.length) {
            var fullMsg = prefixmsg + errors.join("；");
            Ext.lt.ui.alert(fullMsg);
            return false;
        }
        return true;
    }

    /**
     * 下移
     * @param datatable --列表组件名称
     * @param pkcol--唯一值字段
     */
    cmp.setdown = function(datatable, pkcol) {
        var selectDatas = datatable.getRecordset().query({check:1});
        if (selectDatas.length == 0) {
            Ext.lt.ui.alert('请选择一条记录');
            return;
        }
        _moveUpDown("down", datatable, pkcol);
    }

    /**
     * 上移
     * @param datatable --列表组件名称
     * @param pkcol--唯一值字段
     */
    cmp.setup = function(datatable,pkcol) {
        var selectDatas = datatable.getRecordset().query({check:1});
        if (selectDatas.length == 0) {
            Ext.lt.ui.alert('请选择一条记录');
            return;
        }
        _moveUpDown("up", datatable,pkcol);
    }

    /**
     * 置顶
     * @param datatable --列表组件名称
     * @param pkcol--唯一值字段
     */
    cmp.settop = function (datatable,pkcol){
        var selectDatas = datatable.getRecordset().query({check:1});
        if (selectDatas.length == 0) {
            Ext.lt.ui.alert('请选择一条记录');
            return;
        }
        if (selectDatas.length>1) {
            Ext.lt.ui.alert('只能选中一条进行操作');
            return;
        }
        _moveUpDown("top", datatable,pkcol);
    }
    /**
     * 置尾
     * @param datatable --列表组件名称
     * @param pkcol--唯一值字段
     */
    cmp.setend = function (datatable,pkcol){
        var selectDatas = datatable.getRecordset().query({check:1});
        if (selectDatas.length == 0) {
            Ext.lt.ui.alert('请选择一条记录');
            return;
        }
        if (selectDatas.length>1) {
            Ext.lt.ui.alert('只能选中一条进行操作');
            return;
        }
        _moveUpDown("end", datatable,pkcol);
    }

    /**
     * 上下移动
     * @param type -类型
     */
    function _moveUpDown(type,datatable,pkcol) {
        var _rowobj = datatable.getRecordset().query({check:1});
        if (!_rowobj) {
            alert("请选择要移动数据！");
            return;
        }
        var _rs = datatable.getRecordSet();
        if(type != "down"){
            for(var i = 0; i < _rowobj.length;i++){
                if (type == "up") { //上移
                    for(var j = 0; j < _rs.toArray().length;j++ ){
                        var obj = _rs.toArray()[j];
                        var obj1 = _rs.toArray()[j-1];
                        if(_rowobj[i][pkcol] == obj[pkcol]){
                            if(obj._sortid ==0)break;
                            //先互换序号
                            var n = obj._sortid;
                            var m = obj._locationposition;
                            obj._sortid = obj1._sortid;
                            obj._locationposition = obj1._locationposition;
                            obj1._sortid = n;
                            obj1._locationposition =m;
                            //在互换在数组中的位置
                            _rs.toArray()[j] = obj1;
                            _rs.toArray()[j-1] =obj;
                            break;
                        }
                    }
                    continue;
                }
                if (type == "down") { //下移
                    for(var j = 0; j < _rs.toArray().length;j++ ){
                        var obj = _rs.toArray()[j];
                        var obj1 = _rs.toArray()[j+1];
                        if(_rowobj[i][pkcol] == obj[pkcol]){
                            if(obj._sortid ==(_rs.toArray().length-1))break;
                            //先互换序号
                            var n = obj._sortid;
                            var m = obj._locationposition;
                            obj._sortid = obj1._sortid;
                            obj._locationposition = obj1._locationposition;
                            obj1._sortid = n;
                            obj1._locationposition =m;
                            //在互换在数组中的位置
                            _rs.toArray()[j] = obj1;
                            _rs.toArray()[j+1] =obj;
                            break;
                        }
                    }
                    continue;
                }
                var guids = [];
                guids[0] = _rowobj[i][pkcol];
                var params = {};
                params[pkcol] = guids;
                datatable.remove(params);
                var _tmpobj = _rowobj[i];
                var l = ~~(_rowobj[i]._sortid);
                var tmpL = 0;
                if(type == "top"){//置项
                    l = -1;
                }
                if(type == "end"){//置尾
                    l = l+_rs.toArray().length;
                }
                _rs.addData(_tmpobj, l);
                _tmpobj._locationposition = l;
            }
        }else{
            for(var i = (_rowobj.length-1); i > -1;i--){
                if (type == "down") { //下移
                    for(var j = 0; j < _rs.toArray().length;j++ ){
                        var obj = _rs.toArray()[j];
                        var obj1 = _rs.toArray()[j+1];
                        if(_rowobj[i][pkcol] == obj[pkcol]){
                            if(obj._sortid ==(_rs.toArray().length-1))break;
                            //先互换序号
                            var n = obj._sortid;
                            var m = obj._locationposition;
                            obj._sortid = obj1._sortid;
                            obj._locationposition = obj1._locationposition;
                            obj1._sortid = n;
                            obj1._locationposition =m;
                            //在互换在数组中的位置
                            _rs.toArray()[j] = obj1;
                            _rs.toArray()[j+1] =obj;
                            break;
                        }
                    }
                    continue;
                }
                var guids = [];
                guids[0] = _rowobj[i][pkcol];
                var params = {};
                params[pkcol] = guids;
                datatable.remove(params);
                var _tmpobj = _rowobj[i];
                var l = ~~(_rowobj[i]._sortid);
                var tmpL = 0;
                _rs.addData(_tmpobj, l);
                _tmpobj._locationposition = l;
            }
        }
        datatable.reflash();
    }

    /**
     * 查看项目明细
     */
    cmp.proinfoview = function (datatable,obj){
        Ext.lt.pmkpi.proinfoview(obj, datatable);
    }

    Ext.lt.pmkpi.proinfoview = function (obj, table) {
        var data;
        if (table) {
            data = table.getSelected();
        } else {
            data = datatable.getSelected();
        }
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据查看项目明细！",function(){});
            return;
        }
        var params = [];
        params.push('noguidflag=1');
        if (obj.submenu){
            params.push('submenu=' + obj.submenu );  //菜单ID请传外部系统当前页面的菜单ID
        } else {
            params.push('submenu=' + _menuid );  //菜单ID请传外部系统当前页面的菜单ID
        }
        if (obj.pro_code){
            params.push('pro_code='+ obj.pro_code);
        } else {
            params.push('pro_code='+ data[0].pro_code);
        }
        params.push('vchtypeid=7EB7DFB2BC71875A1B7C50130CD8388F');
        params.push('pagetype=detailinfo');
        var url = Ext.lt.token.urlAddToken('/pdm/prodetail/detailinfo.page') + '&' + params.join('&')  + Ext.lt.token.getAuthorization();
        Ext.lt.pdm = {};
        Ext.lt.pdm.common = {};
        Ext.lt.pdm.common.config = {};
        Ext.lt.pdm.common.config.pagetype = 'detailinfo';
        var width = $(window).width()*0.98, height = $(window).height()*0.9;
        Ext.lt.pdm.common.window = new Ext.lt.window({
            title:'',
            pop:true,
            mark:true,
            drag:true,
            close:true,
            w:width,
            h:height,
            fitmode:'content',
            className:'windpblue',
            onclose:function(){
            }
        });
        var framediv = $('<div style="width:'
            + (width) + 'px; height:' + height + 'px;overflow:hidden;"><iframe src="'
            + url + '"  frameborder="0"  style="top:auto;left:auto;scrolling: yes;width:'+(width)+'px'
            + '; height:'+height+'px;'+'"></iframe></div>');
        Ext.lt.pdm.common.window.draw(framediv[0]);
    }

    /**
     * 查看一级项目明细
     */
    cmp.queryPromain = function (datatable,obj) {
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据查看项目明细！",function(){});
            return;
        }
        if (obj.vchtypeid == "" || obj.vchtypeid == undefined) {
            Ext.lt.ui.alert('未找到对应的单据！', function () {
            });
        } else {
            var params = [];
            params.push('noguidflag=1');
            params.push('vchtypeid=' + obj.vchtypeid);      //数据vchtypeid
            params.push('projectkind='+obj.projectkind);
            params.push('selectbillguid=' + obj.proguid);  //项目guid
            params.push('pro_code='+ obj.pro_code);         //项目code
            params.push('submenu=' + obj.submenu);
            params.push('pagetype=detail');
            params.push('iswf=1');
            var url = Ext.lt.token.urlAddToken('/pdm/promain/detail.page') + Ext.lt.token.getAuthorization() + '&' + params.join('&');
            Ext.lt.pdm = {};
            Ext.lt.pdm.common = {};
            Ext.lt.pdm.common.config = {};
            Ext.lt.pdm.common.config.pagetype = 'detail';
            Ext.lt.pdm.leftprojectkinddatas = new Ext.lt.recordset();
            var width = $(window).width() * 0.98, height = $(window).height() * 0.9;
            Ext.lt.pdm.common.window = new Ext.lt.window({
                title: '',
                pop: true,
                mark: true,
                drag: true,
                close: true,
                w: width,
                h: height,
                fitmode: 'content',
                className: 'windpblue',
                onclose: function () {
                }
            });
            var framediv = $('<div style="width:'
                + (width) + 'px; height:' + height + 'px;overflow:hidden;"><iframe src="'
                + url + '"  frameborder="0"  style="top:auto;left:auto;scrolling: yes;width:' + (width) + 'px'
                + '; height:' + height + 'px;' + '"></iframe></div>');
            Ext.lt.pdm.common.window.draw(framediv[0]);
        }
    }

    /**
     * 修改一级项目
     */
    cmp.editPromain = function (datatable,obj) {
        if (obj.vchtypeid == "" || obj.vchtypeid == undefined) {
            Ext.lt.ui.alert('未找到对应的单据！', function () {
            });
        } else {
            var params = [];
            params.push('noguidflag=1');
            params.push('vchtypeid=' + obj.vchtypeid);      //数据vchtypeid
            params.push('projectkind='+obj.projectkind);
            params.push('selectbillguid=' + obj.proguid);  //项目guid
            params.push('pro_code='+ obj.pro_code);
            params.push('submenu=' + obj.submenu);
            params.push('pagetype=mod');
            params.push('wfFuncType=modifyBill');
            params.push('iswf=1');
            var url = Ext.lt.token.urlAddToken('/pdm/promain/mod.page') + Ext.lt.token.getAuthorization() + '&' + params.join('&');
            Ext.lt.pdm = {};
            Ext.lt.pdm.common = {};
            Ext.lt.pdm.common.config = {};
            Ext.lt.pdm.common.config.pagetype = 'mod';
            Ext.lt.pdm.leftprojectkinddatas = new Ext.lt.recordset();
            var width = $(window).width() * 0.98, height = $(window).height() * 0.9;
            Ext.lt.pdm.common.window = new Ext.lt.window({
                title: '',
                pop: true,
                mark: true,
                drag: true,
                close: true,
                w: width,
                h: height,
                fitmode: 'content',
                className: 'windpblue',
                onclose: function () {
                }
            });
            var framediv = $('<div style="width:'
                + (width) + 'px; height:' + height + 'px;overflow:hidden;"><iframe src="'
                + url + '"  frameborder="0"  style="top:auto;left:auto;scrolling: yes;width:' + (width) + 'px'
                + '; height:' + height + 'px;' + '"></iframe></div>');
            Ext.lt.pdm.common.window.draw(framediv[0]);
        }
    }


    /**
     * 修改项目
     */
    cmp.modproinfo = function (datatable,obj){
        Ext.lt.pmkpi.modproinfo(obj, datatable);
    }

    Ext.lt.pmkpi.modproinfo = function (obj, table){
        var data;
        if (table) {
            data = table.getSelected();
        } else {
            data = datatable.getSelected();
        }
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据进行修改！",function(){});
            return;
        }
        var params = [];
        params.push('noguidflag=1');
        if (obj.submenu){
            params.push('submenu=' + obj.submenu );  //菜单ID请传外部系统当前页面的菜单ID
        } else {
            params.push('submenu=' + _menuid );  //菜单ID请传外部系统当前页面的菜单ID
        }
        if (obj.pro_code){
            params.push('pro_code='+ obj.pro_code);
        } else {
            params.push('pro_code='+ data[0].pro_code);
        }
        params.push('pagetype=mod');
        params.push('iswf=1');
        var url = Ext.lt.token.urlAddToken('/pdm/prodetail/mod.page') + '&' + params.join('&')  + Ext.lt.token.getAuthorization();
        Ext.lt.pdm = {};
        Ext.lt.pdm.common = {};
        Ext.lt.pdm.common.config = {};
        Ext.lt.pdm.common.config.pagetype = 'mod';
        var width = $(window).width()*0.98, height = $(window).height()*0.9;
        Ext.lt.pdm.common.window = new Ext.lt.window({
            title:'',
            pop:true,
            mark:true,
            drag:true,
            close:true,
            w:width,
            h:height,
            fitmode:'content',
            className:'windpblue',
            onclose:function(){
            }
        });
        var framediv = $('<div style="width:'
            + (width) + 'px; height:' + height + 'px;overflow:hidden;"><iframe src="'
            + url + '"  frameborder="0"  style="top:auto;left:auto;scrolling: yes;width:'+(width)+'px'
            + '; height:'+height+'px;'+'"></iframe></div>');
        Ext.lt.pdm.common.window.draw(framediv[0]);
    }


    /**
     * 问题整改
     */
    cmp.rectify = function (datatable, obj){
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据进行问题整改！",function(){});
            return;
        }
        var params = {};
        params.projguid = data[0].proguid;
        params.rectifyType = obj.type;
        params.type = obj.type;
        params.viewtype = "rectify";
        params.workflow = 'BD057E3C39B96759E053B11FA8C06040';
        params.bustype = obj.bustype;
        params.tablecode = obj.tablecode;
        var url = '/pmkpi/rectification/program/add.page';
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,_scrWidth,_scrHeight,obj.pagename);
    }

    /**
     * 校验所有三级指标必填
     * @returns {boolean}
     */
    cmp.indexCheckAll = function (){
        var cols = datatable.getCols(); //获取列表所有列
        var datas = datatable.getRecordSet().toArray();
        for (var j = 0,lenj = cols.length; j < lenj; j++) {
            for (var i = 0,leni = datas.length; i < leni; i++) {
                if (cols[j].requirement == '1' && datas[i]["levelno"] == 3) {
                    var value = datas[i][cols[j].colcode];
                    if (value == null || value == "" || ("" + value).trim().length == 0) {
                        Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "为必录项，必须有值。",{timeout:1},function(){});
                        return false;
                    }
                }
            }
        }
        return true;
    }

    /**
     * 河北导出报告
     * @param param
     */
    cmp.hbExpdocFile = function (param) {
        var idObject = document.getElementById("downloadfileform");
        if (idObject != null){
            idObject.parentNode.removeChild(idObject);
        }
        var url = "/pmkpi/export/hbftl.do?tokenid=" + Ext.lt.token.getTokenid();
        var form=$("<form>");//定义一个form表单
        form.attr("id","downloadfileform");
        form.attr("style","display:none");
        form.attr("target","");
        form.attr("method","post"); //请求类型
        form.attr("action",url); //请求地址
        $("body").append(form);//将表单放置在web中
        param.forEach(function (value, key, param) {
            var input=$("<input>");
            input.attr("type","hidden");
            input.attr("id",key);
            input.attr("name",key);
            input.attr("value",value);
            form.append(input);
        })
        form.submit();
    }

    /**
     * 初始化加载列表消息
     * @param table
     */
    cmp.initDatatable = function (table) {
        if (!table) {
            table = datatable;
        }
        Ext.lt.message.send("datatable", 'beforesetcols', {
            table: table,
            cols: table.getCols()
        });
        cmp.setTabNum(null);
    }

    /**
     * 初始化加载编辑区消息
     * @param table
     */
    cmp.initEditForm = function (editf) {

    }


    /**
     * 处理首页代办点击后跳转页签问题
     */
    cmp.pendingtasktab = function (config){
        //处理首页代办点击后跳转页签问题
        var waittabcode = getUrlParam("waittabcode");//页面页签code
        if (typeof (tabpage) != 'undefined') {
            if (typeof (waittabcode) != 'undefined' && waittabcode) {
                var datas = tabpage.cfg.data;
                for (var i = 0, j = datas.length; i < j; i++) {
                    if (datas[i].code == waittabcode) {
                        tabpage.doActiveTab(i);
                    }
                }
            } else {
                tabpage.doActiveTab(0);
            }
        }
    }

    /**
     * 页签数据必填校验
     */
    cmp.checkTabPageData = function (params) {
        var flag = true;
        var warndata = Ext.lt.RCP.asyncall(serviceid, "checkTabPageData", params);
        var datas = warndata.esg;
        if (datas.length > 0) {
            var str = "";
            for (var i = 0; i < datas.length; i++) {
                str += datas[i] + "\n";
            }
            Ext.lt.ui.alert(str, function () {
            });
            flag = false;
        }
        return flag;
    }

    /**
     * 获取代办页签总数量
     */
    Ext.lt.message.hook("busdatatable", "queryDataPageInfo", function (param) {
        var isShowTabPendingTask = config.isShowTabPendingTask;
        if(isShowTabPendingTask == '1'){
            try {
                if (!datatable || !tabpage || !tabpage.cfg || !tabpage.cfg.data || tabpage.cfg.data.length == 0) {
                    return;
                }
            } catch (e) {
                return;
            }
            var rs = param[0];
            var pageobj = rs.pageobj;
            for (var i = 0; i < tabpage.cfg.data.length; i++) {
                var tabData = tabpage.cfg.data[i];
                if (tabData.code == datatable.config.page.queryMap.tabcode) {//当前选中的页签code
                    if (-1 != $.inArray(tabData.code, ['waitaudit', "back"]) && pageobj.totalrows != '0') {//当前选中的页签code为待送审或被退回且总数大于0
                        $('.tabpanelbt li')[i].innerHTML = '<span class="leftspan"></span>' + tabData.name + '<span class="rightspan"></span><span class="numberspan">' + pageobj.totalrows + '</span>';
                    } else {
                        $('.tabpanelbt li')[i].innerHTML = '<span class="leftspan"></span>' + tabData.name + '<span class="rightspan">';
                    }
                }
            }
        }
    });

    /**
     * 进入页面后页签数量
     * @param obj
     */
    cmp.setTabNum = function (obj){
        if (!obj && !_isTabNum) {
            return;
        }
        var isShowTabPendingTask = config.isShowTabPendingTask;
        if(isShowTabPendingTask == '1'){
            try {
                if (!tabpage || !tabpage.cfg || !tabpage.cfg.data || tabpage.cfg.data.length == 0) {
                    return;
                }
            } catch (e) {
                return;
            }
            // 页面其他页签待办条数
            var falg = true;
            for (var i = 0; i < tabpage.cfg.data.length; i++) {
                var tabData = tabpage.cfg.data[i];
                if (-1 != $.inArray(tabData.code, ['waitaudit', "back"])) {
                    falg = false;
                    break;
                }
            }
            if (falg) {
                return;
            }
            var params = {};
            params.tabpage = tabpage.cfg.data;//菜单所有页签
            params.key = config.pageurl;
            params.waittabcode = getUrlParam("waittabcode");//待办跳转页签编码
            if (obj && obj.ordernum) {
                params.leftnum = obj.ordernum;
            }
            var resp = Ext.lt.RCP.asyncall(serviceid, "getTabPendingTask", params);
            if (resp) {
                for (var i = 0; i < tabpage.cfg.data.length; i++) {
                    var tabData = tabpage.cfg.data[i];
                    if (-1 != $.inArray(tabData.code, ['waitaudit', "back"]) && resp[tabData.code] != null) {
                        $('.tabpanelbt li')[i].innerHTML = '<span class="leftspan"></span>' + tabData.name + '<span class="rightspan"></span><span class="numberspan">' + resp[tabData.code] + '</span>';
                    } else {
                        $('.tabpanelbt li')[i].innerHTML = '<span class="leftspan"></span>' + tabData.name + '<span class="rightspan">';
                    }
                }
            }
        }
        _isTabNum = false;
    }

    /**
        **
        * 校验列表数据的审核状态是否一致
        * @returns {boolean}
    */
    cmp.checkwfstatus = function (datas){
        if(!datas){
            datas = datatable.getSelected();
        }
        var prewfstatus;
        for (var i = 0,leni = datas.length; i < leni; i++) {
            if(!prewfstatus){
                prewfstatus = datas[i].wfstatus;
            }
            if(prewfstatus != datas[i].wfstatus){
                Ext.lt.ui.alert("所选择列表数据的流程状态不一致！",{timeout:1},function(){});
                return false;
            }
        }
        return true;
    }

    //主要业务绩效配置按钮调用华青报表查询数据。 eg:绩效系统跨库查询可执行指标的数据。
    //通用代码，按钮上可挂接任何Url页面，
    //按钮的config上配置内容：{url:'http://www.baidu.com',tittle:'相似项目',params:'projectId=#guid,year=#year,province=#province'}
    //url必须配置，其它选配，params里配置的Url的参数，#字段，表示取当前数据的哪个字段的值，tokenid默认自己会加上，不用配置。
    Ext.lt.pmkpi.configUrlBut = function () {
        var conf = {};
        var tempconfig = this.config;
        if (typeof(tempconfig) != 'undefined' && tempconfig && /^\{.*\}$/.test(tempconfig)) {
            conf = eval('(' + tempconfig + ')');
        }
        var datas = [];
        if (typeof (datatable) != "undefined") {
            datas = datatable.getSelected();
        } else {
            alert("未找到当前页面的数据组件，请联系管理员");
        }
        if(datas.length == 0){
            Ext.lt.ui.alert("请勾选一行数据再操作!", {timeout : 1}, function() {});
            return false;
        }
        if(datas.length > 1){
            Ext.lt.ui.alert("只能单选一行数据，进行此操作！!", {timeout : 1}, function() {});
            return false;
        }
        var url = '';
        if (typeof(conf.url)!='undefined' && conf.url){
            url = conf.url;
        }
        var open = 0; //打开外部页签的方式，1浏览器打开0弹出窗口
        if (typeof(conf.open)!='undefined' && conf.open){
            open = conf.open;
        }
        if (url==''){
            alert("未配置需要调用的url，请联系管理员并在按钮的config中配置参数如：{url:'http://www.baidu.com',tittle:'',params:''}");
        }
        var tittle = '未定义标题';
        if (typeof(conf.tittle)!='undefined' && conf.tittle){
            tittle = conf.tittle;
        }
        var params = [];
        if (typeof(conf.params)!='undefined' && conf.params) {
            params = conf.params.split(',');
            //这里要判断参数是否有#，如果有#的话，需要将其替换参数进去
            for(var i=0; i<params.length;i++){
                var n = params[i].indexOf('#');
                if(n != -1){//则表示包含# 需要替换参数
                    var colJ = params[i].substr(n,params[i].length);//带#的
                    var col = params[i].substr(n+1,params[i].length);//不带#的
                    if (col == "pro_code"){//guid取数直接写死从数据上取，不要到user上去取。
                        params[i]=params[i].replace(new RegExp(colJ,'g'),datas[0]["pro_code"]?datas[0]["pro_code"]:datas[0]["code"]);
                    } else if (col == "year"){
                        params[i]="year="+config.year;
                    } else if (col == "province") {
                        params[i]="province="+config.province;
                    }else {
                        var colvalue = datas[0][col];
                        if (typeof (colvalue) == "undefined") {
                            colvalue = "";
                        }
                        params[i]=params[i].replace(new RegExp(colJ,'g'),colvalue);
                    }
                }
            }
        }
        var url = Ext.lt.token.urlAddToken(url) + '&' + params.join('&');
        if (Ext.lt.isFunction(Ext.lt.token.getAuthorization)) {
            url = url + Ext.lt.token.getAuthorization();
        }
        if (1==open){
            window.open(url);
        } else {
            Ext.lt.ui.openModalWindow(url,$(window).width()*0.9*0.85,$(window).height()*0.95,tittle);
        }

    }

    /**
     * 查询区根据左侧树页签类型控制展示、隐藏
     * @param data
     */
    cmp.queryformshow = function (data, lefttabtype) {
        for (var i=0; i < data.length; i++) {
            var config = eval("(" + data[i].config + ")");
            if (data[i].isvisiable == 1 && config && config.lefttabtype) {
                if (config.lefttabtype == lefttabtype) {
                    data[i].isvisiable = 1;
                } else {
                    data[i].isvisiable = 0;
                }
            }
        }
    }

    cmp.AIaudit = function (btn, table) {
        var datas = [];
        if (table) {
            datas = table.getSelected();
        } else {
            datas = datatable.getSelected();
        }
        if (!datas || datas.length == 0) {
            Ext.lt.ui.alert('请选择数据进行操作！', function () {
            });
            return;
        }
        var url = "/pmkpi/audit/aisendaudit.page"
        var params = {};
        var btnconfig = eval('(' + btn.config + ')');
        var datacols = btnconfig.datacols.split(",");
        for (var i=0;i<datacols.length; i++) {
            var d = [];
            for (var j=0; j<datas.length; j++) {
                d.push(datas[j][datacols[i]]);
            }
            params[datacols[i]] = d;
        }
        params.api_key = btnconfig.api_key;
        params.api_code = btnconfig.api_code;
        params.datacols = btnconfig.datacols;
        params.queryset = btnconfig.queryset;
        params.bustype = btn.lefttabtype;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindowNew(url, _scrWidth * 0.7, _scrHeight * 0.8, "智能辅助审核");
        $(".head").hide();
        $(".windpblue .wbody").attr("style", "overflow:hidden");
    }

    /**
     * 展示AI弹窗 aipage自带标题
     * @param url 弹窗加载地址
     * @param h_perc 高度百分比
     * @param w_perc 宽度百分比
     */
    Ext.lt.pmkpi.showAiWin = function (url, h_perc, w_perc) {
        h_perc = h_perc || 1;
        w_perc = w_perc || 1;
        var height = $('body')[0].clientHeight;
        var width = $('body')[0].clientWidth;
        var userAgent = navigator.userAgent;
        var isIE = userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1;
        if (isIE) height = height - 55; else height = height - 20;
        height = Math.floor(height * h_perc);
        width = Math.floor(width * w_perc);
        Ext.lt.ui.openModalWindowNew(url, width, height, "");
        $(".windpblue .head").attr("style", "display:none");
        $(".windpblue .wbody").attr("style", "overflow:hidden");
        var _close = Ext.lt.ui.modalWindow.close;
        Ext.lt.ui.modalWindow.close = function(){
            _close.call(this, null);
        }
    }

    /**
     * 智能辅助报告生成
     * @param btn 按钮
     */
    Ext.lt.pmkpi.makeAIReport = function (btn) {
        var datas = datatable.getSelected();
        if (!datas || datas.length != 1) {
            Ext.lt.ui.alert('请选择一条数据进行操作！', function () {
            });
            return;
        }
        // PMKPI_AIDEPTTRACEREPORT  depttrace  month
        eval("var _cfg = " + btn.config || {});
        var message = _cfg.message;
        var param = {api_code: _cfg.api_code, type: _cfg.type, month: _cfg.month, year: datas[0].year, province: datas[0].province, dept_code: datas[0].dept_code, agency_code: datas[0].agency_code, message: message};
        var url = "/aipage/report?pagetitle=智能辅助报告生成&message=" + message + "&type=" + _cfg.type
            + "&params=" + JSON.stringify(param);
        if(_isYANSHI){
            url += "&usercode=3400_admin";
        }else{
            url += "&tokenid=" + Ext.lt.token.getTokenid() + Ext.lt.token.getAuthorization();
        }
        Ext.lt.pmkpi.showAiWin(url, 0.9, 0.85);
    }

    /**
     * 查看项目资金来源
     */
    cmp.queryDataList = function (cols, url, table){
        var data = [];
        if (table) {
            data = table.getSelected();
        } else {
            data = datatable.getSelected();
        }
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据进行查看！",function(){});
            return;
        }
        var params = {};
        for (var i=0; i<cols.length; i++) {
            params[cols[i]] = data[0][cols[i]];
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,_scrWidth * 0.9,_scrHeight * 0.9,"资金来源");
    }

    /**
     * ai辅助审核-通用
     * @param obj
     */
    Ext.lt.pmkpi.aisupportaudit = function(obj) {
        var btnconfig = eval('(' + obj.config + ')');
        var url = '/pmkpi/common/aisupportaudit.page';
        var params = {};
        params.isloadtaskdata = btnconfig.isloadtaskdata;
        params.api_key = btnconfig.api_key;
        params.api_code = btnconfig.api_code;
        params.loadingtips = btnconfig.loadingtips;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        var height = Math.floor(document.documentElement.clientHeight * 0.9);
        var width =  Math.floor(document.documentElement.clientWidth * 0.9);
        Ext.lt.ui.openModalWindow(url,width,height,"绩效智能辅助审核");
    }

    /**
     * ai辅助审核-要点详细规则
     * @param obj
     */
    Ext.lt.pmkpi.aisupportauditdetail = function(obj) {
        var actionname = obj.name;
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据进行【"+actionname+"】！",function(){});
            return;
        }
        var btnconfig = eval('(' + obj.config + ')');
        var url = '/pmkpi/common/aisupportauditdetail.page';
        var params = {};
        params.isloadtaskdata = btnconfig.isloadtaskdata;
        params.isautosave = btnconfig.isautosave;
        params.api_key = btnconfig.api_key;
        params.api_code = btnconfig.api_code;
        params.pro_code = data[0].pro_code;
        params.loadingtips = btnconfig.loadingtips;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        var height = Math.floor(document.documentElement.clientHeight * 0.9);
        var width =  Math.floor(document.documentElement.clientWidth * 0.9);
        Ext.lt.ui.openModalWindow(url,width,height,"绩效智能辅助审核");
    }

    cmp.checkTraceAnalysisEdit = function (){
        var type = analysisformaleditform.cfg.type;
        var infodata = analysisformaleditform.getEditFormValues();
        var bgtwarn = infodata.bgtwarn;
        var goalwarn = infodata.goalwarn;
        if(type == "depttask" && !infodata.deviation){
            Ext.lt.ui.alert("绩效目标执行出现的偏差和原因、存在的问题必填！",function(){});
            return false;
        }else if(type == "provincetask" && (bgtwarn!="绿色" || goalwarn!="绿色") && !infodata.deviation){
            Ext.lt.ui.alert("绩效目标执行出现的偏差和原因、存在的问题必填！",function(){});
            return false;
        }else{
            return true;
        }
    }

    /**
     * ----------------------新UI附件上传页面组件方法 start---------------------------------
     */

    /**
     * 初始化
     * @param params
     * @param setFileNameFunc 设置附件列表文件名方法
     */
    Ext.lt.pmkpi.newfilePanelInit = function(params, setFileNameFunc) {
        filepanel.mainguid = params.mainguid;
        filepanel.filetype =  params.filetype;
        filepanel.viewtype = params.viewtype;
        filepanel.queryYear = params.queryYear;
        filepanel.queryProvince = params.queryProvince;
        filepanel.setFileNameFunc = setFileNameFunc;
        Ext.lt.pmkpi.newfileLoadFileList(params);
    }


    /**
     * 成功回调
     * @param fileobj 组件对象
     * @param editType 编辑类型
     * @param delFileGuid
     * @returns {boolean}
     */
    Ext.lt.pmkpi.newfileSuccessCallback = function (fileobj,editType,delFileGuid) {
        if (editType == 'upload') { //上传
            Ext.lt.pmkpi.newfileConfirmFileList(fileobj, filepanel, false);
        } else if (editType == 'delete') { //删除
            var resp = Ext.lt.pmkpi.newfileDeleteFileList(fileobj, filepanel);
            if ("删除成功" == resp ) {
                try {
                    Ext.lt.pmkpi.newfileConfirmFileList(fileobj, filepanel,true);
                    var type = typeof filepanel.setFileNameFunc === 'function';
                    if(type){
                        var filelist = filepanel.getRecordset().toArray();
                        var filenames = '';
                        for (var i=0; i<filelist.length; i++) {
                            if (fileobj && fileobj.fileguid && filelist[i].fileguid == fileobj.fileguid) {
                                continue;
                            }
                            filenames += filelist[i].filename +"；";
                        }
                        if (filenames != '') {
                            filenames = filenames.substr(0, filenames.length - 1);
                        }
                        //列表显示对回显进行处理
                        filepanel.setFileNameFunc(filenames, filepanel.mainguid, filepanel.filetype);
                    }
                } catch (e) {
                    console.error("文件名回显处理失败：", e);
                }
            }
        }
        return false;
    }

    /**
     * 附件查询展示
     * @param params
     * @returns {[]}
     */
    Ext.lt.pmkpi.newfileLoadFileList  = function (params) {
        if (!isGreyStyle()) {
            return;
        }
        var loadFiles = [];
        params.guid = params.mainguid;
        Ext.lt.RCP.call("/pmkpi/file/index/pmkpifileManageService", "getFileList",[params], function(resp){
            if (resp && resp.length >= 0) {
                for (var i=0; i<resp.length; i++) {
                    var fileItem = {};
                    fileItem.fileguid = resp[i].fileguid;
                    fileItem.filename = resp[i].filename;
                    loadFiles.push(fileItem);
                }
                filepanel.setFiles(loadFiles);
                if (params.viewtype == "query") {
                    filepanel.view();
                } else {
                    filepanel.setSuccessCallback(Ext.lt.pmkpi.newfileSuccessCallback);
                    filepanel.show();
                }
            }
        });
        return loadFiles;
    }

    /**
     * 附件页【确定】按钮 触发保存
     * @param fileobj 附件对象
     * @param table
     * @param isfromdel 删除调用保存，要过滤掉fileobj内的删除数据
     */
    Ext.lt.pmkpi.newfileConfirmFileList = function (fileobj, filepanel, isfromdel) {
        if (!isGreyStyle()) {
            return;
        }
        var filelist = filepanel.getRecordset().toArray();
        var params = {};
        params.guid = filepanel.mainguid;
        params.filetype= filepanel.filetype;
        var savefilelist = [];
        if(isfromdel){
            for (var i=0; i<filelist.length; i++) {
                if (fileobj && fileobj.fileguid && filelist[i].fileguid == fileobj.fileguid) {
                    continue;
                }
                savefilelist.push(filelist[i]);
            }
        }else{
            savefilelist = filelist;
        }
        params.fileobj = savefilelist;
        Ext.lt.RCP.call("/pmkpi/file/index/pmkpifileManageService", "saveFileDatas", [params] , function(resp){
            if(!isfromdel){
                try {
                    var type = typeof filepanel.setFileNameFunc === 'function';
                    if(type){
                        var filenames = '';
                        for (var i=0; i<filelist.length; i++) {
                            filenames += filelist[i].filename +"；";
                        }
                        if (filenames != '') {
                            filenames = filenames.substr(0, filenames.length - 1);
                        }
                        //列表显示对回显进行处理
                        filepanel.setFileNameFunc(filenames, filepanel.mainguid, filepanel.filetype);
                    }
                } catch (e) {
                    console.error("文件名回显处理失败：", e);
                }
            }
        }, function(resp){
            console.error("异步请求失败：", resp);
        });
    }

    /**
     * 附件删除 直接确认后删除
     * @param guid 附件的guid
     * @param filename 附件名
     * @param notdel
     * @param table
     */
    Ext.lt.pmkpi.newfileDeleteFileList  = function  (fileobj, filepanel) {
        if (!isGreyStyle()) {
            return;
        }
        if (filepanel.viewtype == "query"){
            alert("查询页面，不能删除附件！")
            return;
        }
        var params = {};
        params.guid = fileobj.fileguid; //附件的guid
        params.billguid = filepanel.mainguid;
        // if(!window.confirm('您确定要删除“'+filename+'”吗？'))return false ;
        var resp = Ext.lt.RCP.asyncall("/pmkpi/file/index/pmkpifileManageService", "deleteFile",[params]);
        return resp;
    }

    /**
     * ----------------------新UI附件上传页面组件方法 end---------------------------------
     */

    return cmp;
}

// 查询AI解析需要的数据
function getAIData(param) {
    if (typeof param == "string") {
        param = JSON.parse(param);
    }
    var aidata = {api_code: param.api_code,api_key: param.api_key,message: param.message, type:param.type};
    var params = {};
    var _serviceid = serviceid;
    var _getDataMethodname = "getAIDatas";
    if (param.type == "depttrace" || param.type == "bgt" || param.type == "index") {
        // 生成部门监控报告
        params.type = param.type; // 报告类型
        params.dept_code = param.dept_code;
        params.agency_code = param.agency_code;
        params.month = param.month;
        // _serviceid = "pmkpi.aireport.AIReportService";
        // _getDataMethodname = "getAIReportDatas";
    }else{
        // 辅助审核
        var datacols = JSON.parse(param.datacols);
        for (var i=0;i<datacols.length; i++) {
            params[datacols[i]] = decodeURIComponent(param[datacols[i]]).split(",");
        }
        params.queryset = JSON.parse(param.queryset);
    }
    var aiDatas = Ext.lt.RCP.asyncall(_serviceid , _getDataMethodname, params);
    if (param.type == "depttrace" || param.type == "bgt" || param.type == "index") {
        aidata.data = JSON.stringify(aiDatas[0]);
    }else{
        aidata.data = JSON.stringify(aiDatas);
    }
    return aidata;
}


