if(!Ext.lt.pmkpi){
	Ext.lt.pmkpi = {};
}
var serviceid;
var deptcmp;
var tabcomps;//所有页签数据集合.
var _scrWidth,_scrHeight;
Ext.lt.pmkpi.deptTJperfedit = function(config, service){
	comcmp = Ext.lt.pmkpi.perfcommon(config, service);
	window.parent.Ext.lt.pmkpi.childwindow = window;
	var cmp = {};
 	serviceid = service;
 	var _mainguid = config.mainguid,
	_saveAgency = config.saveAgency,
	_workflow = config.workflow,
	_menuid = config.menuid,
    _signs = config.signs,//计算符号
     _busguid = config.busguid,
	_viewtype = config.viewtype;//区分是否查询:query是查询，其他可修改
    _scrWidth =document.body.clientWidth;
    _scrHeight =document.body.clientHeight;
    var _currenttab;
    var _savecurrenttab = config.savecurrenttab;
    var _pagecomcfg = {};
	Ext.lt.pmkpi.isadd = false;

    /**
     * 页面初始化加载，查看的话不显示按钮
     * infoeditform
     * taskdatatable
     * perfgoaldatatable
     * perfindexdatatable
     */
    $(function(){
        cmp.initpage();
    });

    cmp.initpage = function (){
        //关闭自适应宽度
        perfgoaldatatable.setFixColsWidth(false);
        perfindexdatatable.setFixColsWidth(false);
        if (_viewtype == "query") {
            try{
                $("div[compid='toolbutton']").hide();
                $(".winfooter").hide();
            }catch (e){
            	document.getElementsByClassName("winfooter")[0].style.display = "none";
            }
            var cols = infoeditform.cfg.data;
            var c = {};
            for (var i=0; i<cols.length; i++) {
                c[cols[i].colcode.toLowerCase()] = true;
            }
            infoeditform.setdisabled(c);//设置不可编辑
            $("#taskdatatable #add").hide();
            $("#perfgoaldatatable #add").hide();
            $("#taskdatatable #del").hide();
            $("#perfgoaldatatable #del").hide();
            for(var i = 2; i<taskdatatable.getCols().length; i++){
                taskdatatable.getCols()[i].edit = false;
            }
            for(var i = 2; i<perfgoaldatatable.getCols().length; i++){
                perfgoaldatatable.getCols()[i].edit = false;
            }
            for(var i = 2; i<perfindexdatatable.getCols().length; i++){
                perfindexdatatable.getCols()[i].edit = false;
            }
            taskdatatable.redraw();
            perfgoaldatatable.redraw();
            perfindexdatatable.redraw();
        }else{
            // $('#perfgoaldatatable').append("<button title='删除指标' onclick=\"pmkpideptTJedit.del();\" type=\"button\" style=\"float:left;margin:1px 10px 0 15px;background-color:#3472ef;height: 30px;line-height: 30px;\" class=\"layui-btn btn-black\">删除指标</button>");
            // $('#perfgoaldatatable').append("<button title='指标推荐' onclick=\"pmkpideptTJedit.recom();\" type=\"button\" style=\"float:left;margin:1px 10px 0 15px;background-color:#3472ef;height: 30px;line-height: 30px;\" class=\"layui-btn btn-black\">指标推荐</button>");
        }
        comcmp.initDatatable(taskdatatable);
        comcmp.initDatatable(perfgoaldatatable);
        comcmp.initDatatable(perfindexdatatable);
        //初始化组件map用于暂存
        _pagecomcfg["#infocfg"] = {mainguid:_mainguid,compconfigid:"infoeditform",url:infoeditform.cfg.pageurl,componentid:infoeditform.cfg.server};
        _pagecomcfg["#taskcfg"] = {mainguid:_mainguid,compconfigid:"taskdatatable",url:taskdatatable.config.pageurl,componentid:taskdatatable.config.server};
        _pagecomcfg["#goalcfg"] = {mainguid:_mainguid,compconfigid:"perfgoaldatatable",url:perfgoaldatatable.config.pageurl,componentid:perfgoaldatatable.config.server};
        _pagecomcfg["#indexcfg"] = {mainguid:_mainguid,compconfigid:"perfindexdatatablemap",url:perfindexdatatable.config.pageurl,componentid:perfindexdatatable.config.server};
        cmp.resiztable();
        cmp.init();
    }

    /**
     * 删除指标方法.
     */
    cmp.del = function(){
        var selectDatas = perfindexdatatable.getSelected();
        if (selectDatas.size() <= 0) {
            Ext.lt.ui.alert('请选择要删除的数据！',function(){
            });
            return;
        }
        Ext.lt.ui.confirm("你确定删除选定的数据？",{icon:"warn"},function(ret){
            if(ret){
                perfindexdatatable.removeData(selectDatas);
                var afterdatas = perfindexdatatable.getRecordSet().toArray();
                if (afterdatas != null && afterdatas.length > 0) {
                    var goalguid = afterdatas[0].kpi_dep_id;
                    tabcomps["#goalindexmap"][goalguid] =  Ext.lt.cloneobj(afterdatas);//切换目标复制最后一次选中目标的指标
                }
            }
        });
    }

    /**
     * 精准推荐方法.
     */
    cmp.recom = function(){
        var data = perfgoaldatatable.getSelected();
        if(data!=null && data.size()>0){
            var url = '/pmkpi/deptperformance/deptperf/recomindex.page';
            var params = {};
            params.saveAgency = _saveAgency;
            params.tableid = "perfindexdatatable";
            url = Ext.lt.pmkpi.genPageUrl(url, params);
            indexwindow = Ext.lt.ui.openModalWindow(url,_scrWidth-200,_scrHeight-100,"指标推荐");
        }else{
            Ext.lt.ui.alert(("请先选择目标！"),{}, function(ret) {
            });
        }
    }

    cmp.resiztable = function (){
        $("#taskdatatable").wrapAll("<div id=\"taskdatatablediv\" style=\"height: "+(_scrHeight-110)+"px; width: "+_scrWidth+"px; position: relative; overflow:hidden;\"></div>");
        $("#perfgoaldatatable,#perfindexdatatable").wrapAll("<div id=\"perfgoaldatatablediv\" style=\"height: "+(_scrHeight-110)+"px; width: "+_scrWidth+"px; position: relative; overflow:hidden;\"></div>");
        taskdatatable.resize(_scrWidth-20,_scrHeight-90);
        perfgoaldatatable.resize(_scrWidth-20,(_scrHeight-90)*0.4);
        perfindexdatatable.resize(_scrWidth-20,(_scrHeight-90)*0.6);
    }
	/**
	 * 页签方法
	 */
	cmp.clickTabpage = function(obj){
        Ext.lt.ui.loadingShow();
	    if($("#infoeditform") && $("#taskdatatable") && $("#perfgoaldatatable") && $("#perfindexdatatable")) {
            if(obj.code =="deptinfo"){
                $("#infoeditform").show();
                $("#taskdatatablediv").hide();
                $("#perfgoaldatatablediv").hide();
                $("#manceiframe").hide();
            } else if(obj.code =="maintask"){
                $("#infoeditform").hide();
                $("#taskdatatablediv").show();
                $("#perfgoaldatatablediv").hide();
                $("#manceiframe").hide();
                taskdatatable.reflash();
            } else if(obj.code =="deptperf"){
                $("#infoeditform").hide();
                $("#taskdatatablediv").hide();
                $("#perfgoaldatatablediv").show();
                $("#manceiframe").hide();
                perfgoaldatatable.reflash();
                perfindexdatatable.reflash();
            } else if(obj.code =="file"){
                $("#infoeditform").hide();
                $("#taskdatatablediv").hide();
                $("#perfgoaldatatablediv").hide();
                $("#manceiframe").show();
                var tabconfig = eval('(' + obj.config + ')');
                var componentid = obj.componentid;
                if (!tabconfig.url){
                    return;
                }
                var url = tabconfig.url;
                var _params = {};
                _params.saveAgency = _saveAgency;
                _params.busguid = tabconfig.busguid;
                if (tabconfig.viewtype) {
                    _params.viewtype = tabconfig.viewtype;
                }
                _params.filetype = tabconfig.filetype;
                _params.filebustype = tabconfig.filebustype;
                Ext.lt.message.send("perfcommon", "iframeinit",{params : _params});
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
                        // var divobj =  document.getElementById(_oldcomponentid);
                        // $('.bd_main')[0].insertBefore(_viewdiv,divobj);
                        $('.bd_main').append(_viewdiv);
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
            //切换页签复制数据倒tabcomps
            if(_currenttab == "deptinfo"){
                tabcomps["#infomap"] = infoeditform.getEditFormValues();
            }
            if(_currenttab == "maintask" && taskdatatable.getRecordset().toArray().size>0){
                tabcomps["#tasklist"] = Ext.lt.cloneobj(taskdatatable.getRecordset().toArray());//复制任务
            }
            if(_currenttab == "deptperf" && perfgoaldatatable.getRecordset().toArray().size>0){
                tabcomps["#goallist"] = Ext.lt.cloneobj(perfgoaldatatable.getRecordset().toArray());//复制目标
                var selgoal = perfgoaldatatable.getSelected();//复制最后一次选中目标的指标
                var indexdata = perfindexdatatable.getRecordset().toArray();
                if(selgoal.length>0 && indexdata.length>0){
                    var goalguid = selgoal[0].guid;
                    tabcomps["#goalindexmap"][goalguid] = Ext.lt.cloneobj(indexdata);
                }
            }
            setTimeout(function(){
                //刷新目标关联的任务
                var taskdatas =  taskdatatable.getRecordset().toArray();
                var goaldatas = perfgoaldatatable.getRecordset().toArray();
                for(var i = 0; i < goaldatas.length; i++) {
                    for(var j = 0; j < taskdatas.length; j++) {
                        if(goaldatas[i].taskguid == taskdatas[j].guid){
                            goaldatas[i].task_context = taskdatas[j].context;
                        }
                    }
                }
                taskdatatable.reflash();
                perfgoaldatatable.reflash();
                perfindexdatatable.reflash();
                Ext.lt.ui.loadingClose();
            },500);
        }
        _currenttab = obj.code;
    }

    /**
     * 页面初始化.
     * infoeditform
     * taskdatatable
     * perfgoaldatatable
     * perfindexdatatable
     */
    cmp.init = function(){
        var params = {};
        params.mainguid = _mainguid;
        params.saveAgency = _saveAgency;
        params.pagecomcfg = _pagecomcfg;
        params.isloaddefaultline = taskdatatable.getClockRowSet()!=null ? '0':'1';
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid, "getDatas", params, function(data) {
            tabcomps = data;
            if(tabcomps["#infomap"]){
                infoeditform.synchEditformByObj(tabcomps["#infomap"]);
            }else{
                tabcomps["#infomap"] = {};
                tabcomps["#infomap"].mainguid = _mainguid;
                infoeditform.synchEditformByObj(tabcomps["#infomap"]);
            }
            taskdatatable.setDatas(tabcomps["#tasklist"]);
            perfgoaldatatable.setDatas(tabcomps["#goallist"]);
            // if(tabcomps["#goallist"].size()>0){
            //     perfindexdatatable.setDatas(tabcomps["#goalindexmap"][tabcomps["#goallist"][0].guid]);
            // }else{
                perfindexdatatable.setDatas([]);
            // }
            setMidSaveHidButtons(data);
            setTimeout(function(){
                if(_currenttab == "deptinfo"){
                    edittabpage.doActiveTab(0);
                    $("#infoeditform").show();
                    $("#taskdatatablediv").hide();
                    $("#perfgoaldatatablediv").hide();
                    $("#manceiframe").hide();
                }else if(_currenttab == "maintask"){
                    edittabpage.doActiveTab(1);
                    $("#infoeditform").hide();
                    $("#taskdatatablediv").show();
                    $("#perfgoaldatatablediv").hide();
                    $("#manceiframe").hide();
                    taskdatatable.reflash();
                }else if(_currenttab == "deptperf"){
                    edittabpage.doActiveTab(2);
                    $("#infoeditform").hide();
                    $("#taskdatatablediv").hide();
                    $("#perfgoaldatatablediv").show();
                    $("#manceiframe").hide();
                    perfgoaldatatable.reflash();
                    perfindexdatatable.reflash();
                }else if(_currenttab == "file"){
                    $("#infoeditform").hide();
                    $("#taskdatatablediv").hide();
                    $("#perfgoaldatatablediv").hide();
                    $("#manceiframe").show();
                }else{
                    edittabpage.doActiveTab(0);
                    $("#infoeditform").show();
                    $("#taskdatatablediv").hide();
                    $("#perfgoaldatatablediv").hide();
                    $("#manceiframe").hide();
                }
                taskdatatable.resetSum();
            },100);
            Ext.lt.ui.loadingClose();
        })
    }


    /**
     * 编辑区组件保存.
     * infoeditform
     * taskdatatable
     * perfgoaldatatable
     * perfindexdatatable
     */
    cmp.infosave = function (obj){
        if (!infoeditform.check()) {
            edittabpage.doActiveTab(0);
            return;
        }
        if (!cmp.checkAll(taskdatatable)) {
            edittabpage.doActiveTab(1);
            return;
        }
        if (!cmp.checkAll(perfgoaldatatable)) {
            edittabpage.doActiveTab(2);
            return;
        }
        if (!cmp.checktaskbgt()) {
            edittabpage.doActiveTab(1);
            return;
        }
        //保存前复制当前页签数据
        if(_currenttab == "deptinfo"){
            tabcomps["#infomap"] = infoeditform.getEditFormValues();
        }
        if(_currenttab == "maintask" && taskdatatable.getRecordset().toArray().size>0){
            tabcomps["#tasklist"] = Ext.lt.cloneobj(taskdatatable.getRecordset().toArray());//复制任务
        }
        if(_currenttab == "deptperf" && perfgoaldatatable.getRecordset().toArray().size>0){
            tabcomps["#goallist"] = Ext.lt.cloneobj(perfgoaldatatable.getRecordset().toArray());//复制目标
            var selgoal = perfgoaldatatable.getSelected();//复制最后一次选中目标的指标
            var indexdata = perfindexdatatable.getRecordset().toArray();
            if(selgoal.size()>0 && indexdata.length>0){
                var goalguid = selgoal[0].guid;
                tabcomps["#goalindexmap"][goalguid] = Ext.lt.cloneobj(perfindexdatatable.getRecordset().toArray());
            }
        }
        //校验每个目标的指标
        var tempgoaldata =perfgoaldatatable.getRecordset().toArray();
        if(tempgoaldata.size>0){
            for (var i = 0,leni = tempgoaldata.length; i < leni; i++) {
                var tempgoalguid = tempgoaldata[i].guid;
                var tempgoal = tempgoaldata[i].kpi_target;
                var tempindexdata = tabcomps["#goalindexmap"][tempgoalguid];
                if (!cmp.checkperfindex(tempgoal,tempindexdata)) {
                    edittabpage.doActiveTab(2);
                    return;
                }
            }
        }
        var params = {};
        params.workflow = _workflow;
        params.viewtype = _viewtype; //判断是修改还是新增.
        params.mainguid = _mainguid;
        params.datas = tabcomps;
        params.saveAgency = _saveAgency;
        params.busguid = _busguid;
        params.menuid = _menuid;
        var rs = Ext.lt.RCP.asyncall(serviceid , "saveAll", params);
        if(rs && rs.success){
            Ext.lt.ui.alert(("保存成功！"),{}, function(ret) {
                cmp.init();
                // cmp.close();
                // parent.Ext.lt.pmkpi.edit(_mainguid,_currenttab);
            });
        } else if (rs && rs.success == false){
            edittabpage.doActiveTab(0);
            Ext.lt.pmkpi.openlistdiv(rs);
        } else if (rs){
            if (rs && rs.msg) {
                Ext.lt.ui.alert(rs.msg,function(){
                    Ext.lt.ui.loadingClose();
                });
            } else {
                Ext.lt.ui.alert('保存失败！',function(){
                    Ext.lt.ui.loadingClose();
                });
            }
        }
    }

    /**
     * 暂存
     */
    cmp.infosavetmp = function (obj){
        //暂存前复制当前页签数据
        if(_currenttab == "deptinfo"){
            tabcomps["#infomap"] = infoeditform.getEditFormValues();
        }
        if(_currenttab == "maintask" && taskdatatable.getRecordset().toArray().size>0){
            tabcomps["#tasklist"] = Ext.lt.cloneobj(taskdatatable.getRecordset().toArray());//复制任务
        }
        if(_currenttab == "deptperf" && perfgoaldatatable.getRecordset().toArray().size>0){
            tabcomps["#goallist"] = Ext.lt.cloneobj(perfgoaldatatable.getRecordset().toArray());//复制目标
            var selgoal = perfgoaldatatable.getSelected();//复制最后一次选中目标的指标
            var indexdata = perfindexdatatable.getRecordset().toArray();
            if(selgoal.size()>0 && indexdata.length>0){
                var goalguid = selgoal[0].guid;
                tabcomps["#goalindexmap"][goalguid] = Ext.lt.cloneobj(perfindexdatatable.getRecordset().toArray());
            }
        }
        var params = {};
        params.mainguid = _mainguid;
        params.workflow = _workflow;
        params.viewtype = _viewtype; //判断是修改还是新增.
        params.saveAgency = _saveAgency;
        params.busguid = _busguid;
        params.menuid = _menuid;
        params.datas = tabcomps;
        params.pagecomcfg = _pagecomcfg;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(service , "midsave", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            Ext.lt.ui.alert(("暂存成功！"),{}, function(ret) {
                cmp.init();
            });
        }
        return rs;
    }

    cmp.checktaskbgt = function() {
        var datas = taskdatatable.getRecordSet().toArray();
        for (var i = 0,leni = datas.length; i < leni; i++) {
            if(datas[i].context.length > 1000){
                Ext.lt.ui.alert("工作任务第" + (datas[i]["_sortid"] + 1) + "行的主要内容不能大于1000个字！",{timeout:1},function(){});
                return false;
            }
        }
        // var tmprow = taskdatatable.getRecordset().query({_sortid:0})[0];
        // var totalrow = taskdatatable.getRecordset().query({_sortid:1})[0];
        // //totalamt basicfund projectfund otherfund  任务明细XXXX金额合计与预算金额不一致，请检查！
        // if( (tmprow.basicfund != undefined ? tmprow.basicfund : 0) != totalrow.basicfund){
        //     Ext.lt.ui.alert("任务明细[基本支出]金额合计与预算金额不一致，请检查！",{timeout:1},function(){});
        //     return false;
        // }
        // if( (tmprow.projectfund != undefined ? tmprow.projectfund : 0) != totalrow.projectfund){
        //     Ext.lt.ui.alert("任务明细[项目支出]金额合计与预算金额不一致，请检查！",{timeout:1},function(){});
        //     return false;
        // }
        // if( (tmprow.otherfund != undefined ? tmprow.otherfund : 0) != totalrow.otherfund){
        //     Ext.lt.ui.alert("任务明细[其他资金]金额合计与预算金额不一致，请检查！",{timeout:1},function(){});
        //     return false;
        // }
        return true;
    }

    /**
     * 表格填报数据的校验方法.
     * @returns {boolean}
     */
    cmp.checkperfindex = function(goalname,datas) {
        var cols = perfindexdatatable.getCols();
        for (var i = 0,leni = datas.length; i < leni; i++) {
            if (datas[i]["levelno"] == 3) {
                if(datas[i].name.length > 100){
                    Ext.lt.ui.alert("目标["+goalname+"]第" + (datas[i]["_sortid"] + 1) + "行的指标名称不能大于100个字！",{timeout:1},function(){});
                    return;
                }
                if(datas[i].computesign != 6 && datas[i].computesign != 9 && datas[i].computesign != 10 && (!datas[i].meterunit || datas[i].meterunit == "")){
                    Ext.lt.ui.alert("目标["+goalname+"]第" + (datas[i]["_sortid"] + 1) + "行的计量单位为必录项，必须有值。",{timeout:1},function(){});
                    return;
                }
                if(datas[i]['computesign'] == '9' && (!datas[i].value_remark || datas[i].value_remark == '')){
                    Ext.lt.ui.alert("计算符号选择“定量（其他）”时，指标值说明必填！",{timeout:1},function(){});
                    return;
                }
            }
            for (var j = 0,lenj = cols.length; j < lenj; j++) {
                if (cols[j].requirement == '1' && datas[i]["levelno"] == 3) {
                    var value = datas[i][cols[j].colcode];
                    if (value == null || value == "" || ("" + value).trim().length == 0) {
                        Ext.lt.ui.alert("目标["+goalname+"]第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "为必录项，必须有值。",{timeout:1},function(){});
                        return false;
                    }
                    if (cols[j].colcode == 'indexval' && value.match(RegExp("[*_-]")) != null) {
                        Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "不符合规范，请重新填写。",{timeout:1},function(){});
                        return false;
                    }
                }
            }
        }
        return true;
    }

    /**
     * 表格填报数据的校验方法.
     * @returns {boolean}
     */
    cmp.checkAll = function(table) {
        var datas = table.getRecordSet().toArray();
        var cols = table.getCols();
        for (var i = 0,leni = datas.length; i < leni; i++) {
            for (var j = 0,lenj = cols.length; j < lenj; j++) {
                if (cols[j].requirement == '1') {
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
     * 处理附件
     */
    Ext.lt.message.hook("perfcommon", "iframeinit",function (obj) {
        var params = obj.params;
        params.mainguid = _mainguid;
        params.proguid = _mainguid;
        params.saveAgency = _saveAgency;
        params.viewtype = _viewtype; //判断是查看还是可操作
    });

    /**
     * 主表的选中单选事件
     */
    Ext.lt.message.hook("fasp2datatable", "onRadioClick",function(d){
        //查询子表
        var selDatas = perfgoaldatatable.getSelected();//获取选中目标guid
        if(selDatas.size()>0){
            var perfindexdatas = tabcomps["#goalindexmap"][selDatas[0].guid];
            // perfindexdatatable.clear();
            if(perfindexdatas && perfindexdatas.length>0){
                //指标符号翻译
                var zbxs_source = [];
                for(var i=0; i<_signs.length; i++){
                    var temparr = [];
                    temparr.push(_signs[i]["guid"]);
                    temparr.push(_signs[i]["code"]);
                    temparr.push(_signs[i]["name"]);
                    zbxs_source.push(temparr);
                }
                perfindexdatatable.addMapperDatas("computesign",zbxs_source);
                perfindexdatatable.setDatas(perfindexdatas);
                perfindexdatatable.reflash();
            }else{//加载模板
                var tempindex = tabcomps["#tempdatas"];
                for (var i = 0,leni = tempindex.length; i < leni; i++) {
                    tempindex[i].kpi_dep_id=selDatas[0].guid;
                    tempindex[i].mainguid = _mainguid;
                    tempindex[i].agencyguid = _saveAgency;
                }
                //指标符号翻译
                var zbxs_source = [];
                for(var i=0; i<_signs.length; i++){
                    var temparr = [];
                    temparr.push(_signs[i]["guid"]);
                    temparr.push(_signs[i]["code"]);
                    temparr.push(_signs[i]["name"]);
                    zbxs_source.push(temparr);
                }
                perfindexdatatable.addMapperDatas("computesign",zbxs_source);
                perfindexdatatable.setDatas(tempindex);
                perfindexdatatable.reflash();
            }
            //处理子表数据
            var datas = perfindexdatatable.getRecordSet().toArray();
            if (datas != null && datas.length > 0) {
                var goalguid = datas[0].kpi_dep_id;
                tabcomps["#goalindexmap"][goalguid] =  Ext.lt.cloneobj(datas);//切换目标复制最后一次选中目标的指标
            }
        }
    });

	/**
	 * 新增行.
	 */
	Ext.lt.message.hook("addRow", "uidatatable", function(editdatatable){
		var config = editdatatable.config;
		var componentid = config.id;
		if("taskdatatable" == componentid){//任务
			var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
			var newdata ={};
			newdata.guid = newguid;
			newdata.mainguid = _mainguid;
			newdata.rowtype = "add";
			newdata.isedit = "true";
			newdata.agencyguid = _saveAgency;
			newdata.name = "detail";
			newdata.ordernum = taskdatatable.getRecordSet().toArray().length;
            taskdatatable.getRecordSet().addData(newdata,999);
		} else if("perfgoaldatatable" == componentid){//目标
            var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
            var newdata ={};
            newdata.guid = newguid;
            newdata.mainguid = _mainguid;
            newdata.rowtype = "add";
            newdata.agencyguid = _saveAgency;
            perfgoaldatatable.getRecordSet().addData(newdata,999);
            var tempindex = tabcomps["#tempdatas"];
            for (var i = 0,leni = tempindex.length; i < leni; i++) {
                tempindex[i].kpi_dep_id=newguid;
                tempindex[i].mainguid = _mainguid;
                tempindex[i].agencyguid = _saveAgency;
            }
            perfindexdatatable.setDatas(tempindex);
            perfindexdatatable.resize(_scrWidth-20,(_scrHeight-90)*0.6);
        }
	});

	/**
	 * 删除行
	 */
	Ext.lt.message.hook("delRow", "uidatatable", function(editdatatable){
		var config = editdatatable.config;
		var componentid = config.id;
        if("taskdatatable" == componentid){//任务
			var selDatas = taskdatatable.getSelected();
			if (selDatas.size() <= 0) {
				Ext.lt.ui.alert('请选择要删除的数据！',function(){
				});
				return;
			}
            for (var i = 0,leni = selDatas.length; i < leni; i++) {
                if(selDatas[i].isedit == "false"){
                    Ext.lt.ui.alert('合计行不能删除！',function(){
                    });
                    return;
                }
            }
            // var tasklist = tabcomps["#tasklist"];
            var goallist = perfgoaldatatable.getRecordset().toArray();
            var is_linkgoal = false;
            var todeletegoal = [];
            for (var i = 0,leni = selDatas.length; i < leni; i++) {
                for (var j = 0,lenj = goallist.length; j < lenj; j++) {
                    if(selDatas[i].guid == goallist[j].taskguid){
                        is_linkgoal = true;
                        todeletegoal.push(goallist[j]);
                    }
                }
            }
            if(is_linkgoal){
                Ext.lt.ui.confirm('该任务已关联绩效目标，删除任务会同步删除绩效目标数据，请确认？',null,function(is){
                    if(is){
                        taskdatatable.removeData(selDatas);
                        perfgoaldatatable.removeData(todeletegoal);
                        perfindexdatatable.setDatas([]);
                    }
                })
            }else{
                Ext.lt.ui.confirm('是否删除已选择任务数据？',null,function(is){
                    if(is){
                        taskdatatable.removeData(selDatas);
                    }
                })
            }
		} else if("perfgoaldatatable" == componentid) {//目标
            Ext.lt.ui.confirm('是否删除已选择目标数据？',null,function(is){
                if(is){
                    var selDatas = perfgoaldatatable.getSelected();
                    if(selDatas.size()>0){
                        var goalguid = selDatas[0].guid;
                        perfgoaldatatable.removeData(selDatas);
                        tabcomps["#goallist"] = Ext.lt.cloneobj(perfgoaldatatable.getRecordset().toArray());
                        tabcomps["#goalindexmap"][goalguid] = [];
                        perfindexdatatable.setDatas([]);
                    }
                }
            })
        }
	});

	/**
	 * 重画表格
	 */
	Ext.lt.message.hook("busdatatable", "drawed",function (obj) {
		var config = obj.config;
		var componentid = config.id;
		_table_param[componentid] = obj.uiconfig.tablecode;
		_table_param[componentid + "_defquery"] = obj.uiconfig.defquery;
		_table_param[componentid + "_orderby"] = obj.uiconfig.orderby;
		_table_param[componentid + "_busguid"] = config.busguid; //审核定义调用
		_table_param[componentid + "_totaltag"] = obj.uiconfig.totaltag;
		if (_viewtype == "query") {
			config.edit = false;
			config.addrow = false;
		}
	});

	/**
	 * 点击表格类型页签处理消息
	 */
	Ext.lt.message.hook("perfcommon", "tableinit",function(obj){
		var params = obj.params;
		params.menuid = _menuid;
		params.mainguid = _mainguid;
		params.uikey = eval(obj.id)["key"];
        params.componentid = obj.id;
	});

	/**
	 * 点击编辑区类型处页签理消息
	 */
	Ext.lt.message.hook("perfcommon", "editinit",function(obj){
		var params = obj.params;
		params.mainguid = _mainguid;
		params.saveAgency = _saveAgency;
        params.componentid = obj.id;
	});

	/**
	 * 点击报表类型处理消息
	 */
	Ext.lt.message.hook("perfcommon", "reportinit",function(obj){
		var params = obj.params;
		params.mainguid = _mainguid;
		params.saveAgency = _saveAgency;
	});
	
	/**
	 * 保存编辑区之前封装参数
	 */
	Ext.lt.message.hook("perfcommon", "beforeEditsave",function(obj){
		var params = obj.params;
		params.uikey = eval(obj.id).cfg["key"];
		params.pagetype = eval(obj.id).cfg["pagetype"];//区分主编辑区
		params.componentid = obj.id; //区分哪个组件
	});
	/**
	 * 保存表格之前封装参数
	 */
	Ext.lt.message.hook("perfcommon", "beforeTablesave",function(obj){
		var params = obj.params;
		params.uikey = eval(obj.id)["key"];
        params.componentid = obj.id; //区分哪个组件
        params.componentid = obj.id;
	});

	cmp.close = function () {
		Ext.lt.ui.closeModalWindow();
		window.parent.Ext.lt.pmkpi.query();
	}

    /**
     * 行级新增操作
     */
    cmp.addbtnrow = function(obj,selguid){
        var data = [];
        if (!selguid) {
            data = cmp.getSeletdata("1");
            if(data.length != 1){
                Ext.lt.ui.alert("请选择一条二级指标！",function(){});
                return;
            }
        } else {
            data = perfindexdatatable.getRecordset().query({guid:selguid});
        }
        var _sortid = data[0]._sortid;
        if (data[0][FOLDING_FILED] == 'close') {
            data[0][FOLDING_FILED] = 'open';
            perfindexdatatable.getViewRecordSet().showChildren(data[0], _sortid);
        }
        var newdata ={};
        var uuid = getCreateguid(serviceid);
        var indexcols = perfindexdatatable.getCols();
        for (var i = 0, len = indexcols.length; i < len; i++) {
            var col = indexcols[i];
            var colcode = col.colcode;
            newdata[colcode] = "";
        }
        newdata.guid = uuid;
        newdata.levelno = 3;
        newdata.isleaf = 1;
        newdata.superid = data[0].guid;
        newdata.sindex = data[0].guid;
        newdata.findex = data[0].superid;
        newdata.is_deleted = "2";
        newdata.mainguid = _mainguid;
        newdata.agencyguid = _saveAgency;
        newdata.kpi_dep_id = data[0].kpi_dep_id;
        newdata.rowtype = "add";
        newdata.weight = 0;
        perfindexdatatable.getRecordSet().addData(newdata,999);
    }

    /**
	 * 表格重画表格之前.
     */
    Ext.lt.message.hook("datatable", 'beforesetcols',function(obj) {
        var componentid =  obj.table.config.id; //表格组件名称
        var cols = obj.cols;
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
            if ("perfindexdatatable" == componentid){ //部门整体绩效指标
                if(col["colcode"]=="obligate1"){
                    if (_viewtype != "query"){
                        col.style = " text-align:center;";
                        col.fn = function(l,c,data,col){
                            var html = "";
                            if (data.levelno == "2"){
                                html += '<a title = "新增" style="color:#468ac9;cursor:pointer;">新增</a>';
                            } else if(data.levelno == "3"){
                                html = '<a title = "删除" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:indexdel("'+data.guid+'","'+data._locationposition+'","'+data.sindex+'")\'>删除</a>';
                            }
                            return html;
                        }
                        col.onclick = function(td, el, l, c, d) {
                            var levelno = d.levelno;
                            if (levelno == "2"){
                                cmp.addbtnrow("",d.guid);
                            }
                        };
                    }
                }
                if(col["colcode"]=="indexval"){
                    col.fn = function(l,c,data,col){
                        if(data.computesign == "6"|| data.computesign == "9" || data.computesign == "10"){
                            var indexvalue = !data.indexval? "" : data.indexval;
                            return "<font style=\"margin-left:10px;\">" + indexvalue+"</font>";
                        } else {
                            var computesignstr ="";
                            for(var i =0; i<_signs.size() ; i++){
                                if(data.computesign == _signs[i].guid){
                                    computesignstr = _signs[i].name;
                                }
                            }
                            var unit = "";
                            if(data["meterunit"]){
                                unit = data.meterunit;
                            }
                            var returnstr = !data.indexval ? computesignstr + unit :computesignstr + data.indexval + unit;
                            return "<font style=\"margin-left:10px;\">"+returnstr+"</font>";
                        }
                    }
                    col.oneditstart = function (table, el, l, c, d) {
                        if(d.levelno != "3"){
                            return false;
                        }
                        el.innerText =  d.indexval!=undefined ? d.indexval : '';
                        table.getCol(c).mapping = null;
                        table.nowtype="input";
                        table.getCol(c).format = "";
                        // return;
                    }
                    col.oneditend = function (table, el, l, c, d) {
                        if(d.computesign && d.computesign != '6' && d.computesign != '9' && d.computesign != '10'){
                            if(!checkReferencepole(d.indexval)){
                                d.indexval = '';
                                return false;
                            }
                        }
                        if(d.indexval!=''){
                            if (!d.computesign) {
                                Ext.lt.ui.alert("请先选择计算符号！",{timeout:1},function(){});
                                d.indexval = '';
                                return false;
                            }
                        }
                        if(d.computesign == "9"){
                            d["kpivalsource"] = d["indexval"];
                        }
                    }
                }
                if(col["colcode"]=="computesign"){
                    col.oneditend = function (table, el, l, c, d) {
                        if(d.computesign && d.computesign != '6' && d.computesign != "9" && d.computesign != "10"){
                            if(!checkReferencepole(d.indexval)){
                                d.indexval = '';
                                return false;
                            }
                        } else if (d.computesign && d.computesign == "9") {
                            var istrue = false;
                            for (var i=0; i<_kpivals.length; i++) {
                                if (d.indexval == _kpivals[i].guid){
                                    istrue = true;
                                }
                            }
                            if (!istrue) {
                                d.indexval = '';
                                return false;
                            }
                        }else if (d.computesign && d.computesign == "10") {
                            var istrue = false;
                            for (var i=0; i<_kpicalnotapply.length; i++) {
                                if (d.indexval == _kpicalnotapply[i].guid){
                                    istrue = true;
                                }
                            }
                            if (!istrue) {
                                d.indexval = '';
                                return false;
                            }
                        }
                    }
                }
                //一二级指标不可修改
                if(col["colcode"]=="name" || col["colcode"]=="explain" || col["colcode"]=="computesign"
                    || col["colcode"]=="meterunit" || col["colcode"]=="weight" ){
                    col.oneditstart = function(table,el,l,c,d){
                        if(d.levelno != "3"){
                            return false;
                        }
                    }
                }
                if (_viewtype == 'query' && col["name"] != "check") {
                    col.style = "background-color:#f2f2f2;";
                    col.oneditstart = function (table, e, l, c, d) {
                        return false;
                    }
                }
			}

            if ("perfgoaldatatable" == componentid){ //目标  TASK_CONTEXT
                if (col["colcode"] == "seltask") {
                    col.style = " text-align:center;";
                    col.fn = function(l,c,row,val){
                        if (row["datatable_do_sum"] == true){
                            return "";
                        }
                        if(_viewtype == 'query'){
                            return "";
                        }else{
                            var html =  '<a title = "关联任务" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:pmkpideptTJedit.seltasks("'+row.guid+'")\'>关联任务</a>';
                            return html;
                        }
                    }
                }
                if (col["colcode"] == "task_context") { //TASK_CONTEXT
                    col.oneditstart = function(table, e, l, c, d){
                        return false;
                    }
                }
            }

            if ("taskdatatable" == componentid){ //任务
                if(col["colcode"]=="name" || col["colcode"]=="context"){
                    col.cseditfn = function (i, j, rs, style) {
                        if (rs.isedit != undefined && rs.isedit == "false") {
                            style = 'style="background-color:#f2f2f2;"';
                        }
                        return style;
                    }
                    col.oneditstart = function(table, e, l, c, d){
                        if(d.isedit != undefined && d.isedit == "false"){
                            return false;
                        }
                    }
                }
                if(col["colcode"]=="financialfund" || col["colcode"]=="otherfund" || col["colcode"]=="basicfund" || col["colcode"]=="projectfund"){
                    col.cseditfn = function (i, j, rs, style) {
                        if (rs.isedit != undefined && rs.isedit == "false") {
                            style = 'style="background-color:#f2f2f2;"';
                        }
                        return style;
                    }
                    col.oneditstart = function(table, e, l, c, d){
                        if(d.isedit != undefined && d.isedit == "false"){
                            return false;
                        }
                    }
                    col.oneditend = function (table, el, l, c, d) {
                        var otherfund = d.otherfund ? d.otherfund :0;
                        var sumamt1 = parseFloat(otherfund);
                        // var financialfund = d.financialfund ? d.financialfund :0;
                        // var sumamt2 = parseFloat(financialfund);
                        var basicfund = d.basicfund ?d.basicfund :0;
                        var sumamt3 = parseFloat(basicfund);
                        var projectfund = d.projectfund ? d.projectfund :0;
                        var sumamt4 = parseFloat(projectfund);
                        d.totalamt =(sumamt1 + sumamt3 + sumamt4).toFixed(2);
                        if(table.getClockRowSet()==null) {//没配置合计行走自己的合计
                            amtTotal(taskdatatable);
                        }
                    }
                }
            }
        }
    });
    /**
	 * 目标关联任务信息.
     * @param indexguid.
	 * @param projs --项目guids
     */
    cmp.seltasks = function(goalguid){
        var params = {};
        var url = "/pmkpi/deptTJformance/report/seltask.page";
        params.mainguid = _mainguid;
        params.goalguid = goalguid;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,_scrWidth-80,_scrHeight-60,"绩效目标关联任务");
	}


    /**
	 * 行级合并处理函数.
     * @param val
     * @param col
     * @returns {number}
     */
    showMidleName = function(val,col){
        var tabledata = indexprodatatable.getRecordSet().toArray();
        var a = -1,b=-1;
        var atemp = {};
        for ( var i = 0; i < tabledata.length; i++) {
            atemp = tabledata[i];
            if(val == atemp[col]){
                a = atemp["_sortid"]; //首次出现值
                break;
            }
        }
        var btemp = {};
        for ( var i = tabledata.length-1; i >-1; i--) {
            btemp = tabledata[i];
            if(val == btemp[col]){
                b = btemp["_sortid"]; //结束出现值
                break;
            }
        }
        return parseInt((b-a)/2)+a;
    }

    showMidleName2 = function(val){
        var tabledata = indexprodatatable.getRecordSet().toArray();
        var a = -1,b=-1;
        var atemp = {};
        for ( var i = 0; i < tabledata.length; i++) {
            atemp = tabledata[i];
            if(val == (atemp["sname"]+atemp["fun_res_code"])){
                a = atemp["_sortid"]; //首次出现值
                break;
            }
        }
        var btemp = {};
        for ( var i = tabledata.length-1; i >-1; i--) {
            btemp = tabledata[i];
            if(val == (atemp["sname"]+atemp["fun_res_code"])){
                b = btemp["_sortid"]; //结束出现值
                break;
            }
        }
        return parseInt((b-a)/2)+a;
    }

	return cmp;
}

function amtTotal(table) {
    // if(table.getSumobj()){
        var totalrow = table.getRecordset();
        var sumamt1 = 0;
        var sumamt2 = 0;
        var sumamt3 = 0;
        var sumamt4 = 0;
        var rowarr = totalrow.toArray();
        var len = rowarr.length;
        for ( var i = 0; i < len; i++) {
            if(rowarr[i].isedit != undefined && rowarr[i].isedit == "true"){
                var otherfund = rowarr[i]["otherfund"] ? rowarr[i]["otherfund"] : 0;
                sumamt2 += parseFloat(otherfund);
                var basicfund = rowarr[i]["basicfund"] ? rowarr[i]["basicfund"] : 0;
                sumamt3 += parseFloat(basicfund);
                var projectfund = rowarr[i]["projectfund"] ? rowarr[i]["projectfund"] : 0;
                sumamt4 += parseFloat(projectfund);
            }
        }
        // var totalrs = {};
        var sumline = 1;//默认第一行为预算资金规模参考值，第二行为合计，资金合计到第二行
        if(table.getClockRowSet()!=null){//配置了表格合计行时合计到第一行
            sumline = 0;
        }else{
            sumline = 1;
        }
        var totalrs = table.getRecordset().query({_sortid:sumline})[0];
        // totalrs["financialfund"] = sumamt1 == 0 ? "" : sumamt1.toFixed(2);        //年初预算
        totalrs["otherfund"] = sumamt2 == 0 ? 0 : sumamt2.toFixed(2);        //年度调整预算
        totalrs["basicfund"] = sumamt3 == 0 ? 0 : sumamt3.toFixed(2);        //调整后预算
        totalrs["projectfund"] = sumamt4 == 0 ? 0 : sumamt4.toFixed(2);        //实际执行数
        totalrs["totalamt"] =(sumamt2+sumamt3+sumamt4);
        totalrs.datatable_do_sum=true;
        table.getRecordset().setData(totalrs,sumline);
        //if((totalrow.size&&totalrow.size()>0)||(totalrow.length&&totalrow.length>0)){
        table.reflashdata();
        //}
    // }
}


function indexdel(guid,_locationposition) {
    Ext.lt.ui.confirm("你确定删除选定的数据？",{icon:"warn"},function(ret){
        if(ret){
            var datas = perfindexdatatable.getRecordSet().toArray();
            if(datas!=null && datas.length > 0) {
                for (var i = 0; i < datas.length; i++) {
                    var selectDatas = datas[i];
                    if (guid == selectDatas.guid) {
                        perfindexdatatable.removeData(selectDatas);
                        var afterdatas = perfindexdatatable.getRecordSet().toArray();
                        if (afterdatas != null && afterdatas.length > 0) {
                            var goalguid = afterdatas[0].kpi_dep_id;
                            tabcomps["#goalindexmap"][goalguid] =  Ext.lt.cloneobj(afterdatas);//切换目标复制最后一次选中目标的指标
                        }
                    }
                }
            }
        }
    });
}

function _setFrame(obj){
    obj.setAttribute('frameBorder', 0);
    obj.style.cssText = 'border: 0 none;';
    obj.width = _scrWidth;
    obj.height = _scrHeight-55;
}
