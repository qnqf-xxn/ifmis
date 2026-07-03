if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.tabfreamedit){
    Ext.lt.pmkpi.tabfreamedit = {};
}
Ext.lt.pmkpi.tabfreamedit = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    try{
        window.parent.Ext.lt.pmkpi.childwindow = window;
    }catch (e){}
    var cmp = {};
    var serviceid = service,
        _mainguid = config.mainguid,//主单id
        _projguid = config.projguid,//项目id
        _bustype = config.bustype,//绩效类型
        _tabcode = config.tabcode,//tab表名
        _saveAgency = config.saveAgency,
        _formalval = {},//公式表数据
        _edittablecode,
        _viewtype = config.viewtype,//查询状态;
        _pro_code = config.pro_code,//项目编码
        _pro_id = config.pro_id,//项目id
        _agency_code = config.agency_code,//单位编码
        _filebustype,
        _taskyear = config.taskyear,
        _taskprovince = config.taskprovince,
        _tabData;
    Ext.lt.pmkpi.isadd = false;
    var isfirst = true;
    var tabobj;
    var _isNX = config.isNX;

    $(function (){
        if (_viewtype == "query" && config.pageurl != "/pmkpi/program/auditmark") {
            try{
                $("div[compid='toolbutton']").hide();
                $(".winfooter").hide();
            }catch (e){
                document.getElementsByClassName("winfooter")[0].style.display = "none";
            }
            if(document.getElementById("add"))
                document.getElementById("add").style.display = "none";
            if(document.getElementById("del"))
                document.getElementById("del").style.display = "none";
            if (typeof(deptamtdatatable) != "undefined" && deptamtdatatable != null && $("#deptamtdatatable").length>0){
                for(var i = 2; i<deptamtdatatable.getCols().length; i++){
                    deptamtdatatable.getCols()[i].edit = false;
                }
                deptamtdatatable.redraw();
            }
            if (typeof(deptproexpdatatable) != "undefined" && deptproexpdatatable != null && $("#deptproexpdatatable").length>0){
                for(var i = 2; i<deptproexpdatatable.getCols().length; i++){
                    deptproexpdatatable.getCols()[i].edit = false;
                }
                deptproexpdatatable.redraw();
            }
            if (typeof(perftaskdatatable) != "undefined" && perftaskdatatable != null && $("#perftaskdatatable").length>0){
                for(var i = 2; i<perftaskdatatable.getCols().length; i++){
                    perftaskdatatable.getCols()[i].edit = false;
                }
                perftaskdatatable.redraw();
            }
        }
        if (typeof(deptamtdatatable) != "undefined" && deptamtdatatable != null && $("#deptamtdatatable").length>0){
            common.initDatatable(deptamtdatatable);
        }
        if (typeof(deptproexpdatatable) != "undefined" && deptproexpdatatable != null && $("#deptproexpdatatable").length>0){
            common.initDatatable(deptproexpdatatable);
        }
        if (_isNX && typeof(analysisformaleditform) != "undefined" && analysisformaleditform != null && $("#analysisformaleditform").length>0){
            cmp.setTraceAnalysisEdit();
        }
        isfirst = false;
        common.tabpageOnclick(tabobj, _tabData, toolbutton);
    })

    /**
     * 基础信息保存
     */
    cmp.infosave = function (obj){
        var params= {};
        params.isadd = Ext.lt.pmkpi.isadd;
        if(_isNX && _onclickid == "analysisformaleditform" && !common.checkTraceAnalysisEdit()){// 宁夏监控分析校验
            return;
        }
        var rs = common.savedatas(obj, params);
        if (rs) {
            try{
                window.parent.Ext.lt.pmkpi.query();
            }catch (e){}
        }
    }

    /**
     * 基础信息暂存
     */
    cmp.midsave = function (obj){
        var params= {};
        params.isadd = Ext.lt.pmkpi.isadd;
        var rs = common.savetmp(obj, params);
        if (rs) {
            try{
                window.parent.Ext.lt.pmkpi.query();
            }catch (e){}
        }
    }

    /**
     * 清除暂存
     */
    cmp.delmidsave = function (obj){
        var params= {};
        params.isadd = Ext.lt.pmkpi.isadd;
        Ext.lt.ui.confirm('是否确认清除暂存数据？',null,function(is){
            if(is){
                var rs = common.deltmp(obj, params);
                if (rs) {
                    try{
                        window.parent.Ext.lt.pmkpi.query();
                    }catch (e){}
                }
            }
        })
    }

    /**
     * 保存并送审
     */
    cmp.saveaudit = function (obj){
        // var btnconfig = eval('(' + obj.config + ')');
        var params= {};
        params.isadd = Ext.lt.pmkpi.isadd;
        params.isaudit = "true";
        var rs = common.savedatas(obj, params);
        if (rs) {
            try{
                parent.Ext.lt.pmkpi.wfAudit(obj);
            }catch (e){}
        }
    }

    /**
     * 页签方法
     */
    cmp.clickTabpage = function(obj){
        var config = eval('(' + obj.config + ')');
        if(config.tabcode){
            _tabcode = config.tabcode;
        }
        if (config.filebustype){
            _filebustype = config.filebustype;
        }
        if (!isfirst) {
            common.tabpageOnclick(obj, _tabData, toolbutton);
        } else {
            tabobj = obj;
            _tabData = tabpage.cfg.data;
            //获取组件表中没有展示的页签组件id，隐藏相对应页签内容
            var main = tabpage.cfg.main;
            var hidDiv = [];
            for (var i=0; i<main.length; i++) {
                var isshow = false;
                for (var j=0; j<_tabData.length; j++){
                    if (main[i] == _tabData[j].componentid) {
                        isshow = true;
                        break;
                    }
                }
                if (!isshow && main[i] != 'tabpage') {
                    hidDiv.push(main[i]);
                }
            }
            obj.hiddiv = hidDiv;
        }
    }

    Ext.lt.message.hook("addRow", "uidatatable", function(editdatatable){
        var config = editdatatable.config;
        var componentid = config.id;
        if(_onclickid == componentid){
            var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
            var newdata ={};
            newdata.guid = newguid;
            newdata.mainguid = _mainguid;
            newdata.rowtype = "add";
            Ext.lt.pmkpi.isadd = true;
            eval(_onclickid).getRecordSet().addData(newdata,999);
        }
    });

    Ext.lt.message.hook("delRow", "uidatatable", function(editdatatable){
        var config = editdatatable.config;
        var componentid = config.id;
        if(_onclickid == componentid){
            var selDatas = eval(_onclickid).getSelected();
            if (selDatas.size() <= 0) {
                Ext.lt.ui.alert('请选择要删除的数据！',function(){
                });
                return;
            }
            Ext.lt.ui.confirm('是否删除已选择数据？',null,function(is){
                if(is){
                    eval(_onclickid).removeData(selDatas);
                    if("perftaskdatatable" == componentid){
                        perftaskdatatable.updateAllSumData()
                    }else{
                        common.amtTotal(eval(_onclickid));
                    }
                }
            })
        }
    });
    /**
     *
     */
    Ext.lt.message.hook("busdatatable", "drawed",function (obj) {
        var config = obj.config;
        var componentid = config.id;
        _table_param[componentid] = obj.uiconfig.tablecode;
        _table_param[componentid + "_defquery"] = obj.uiconfig.defquery;
        _table_param[componentid + "_orderby"] = obj.uiconfig.orderby;
        _table_param[componentid + "_totaltag"] = obj.uiconfig.totaltag;
        //审核定义guid，perf_t_busauditdefine表budguid
        _table_param[componentid + "_busguid"] = config.busguid;
    });

    Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
		var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        var componentid = config.id;
        _table_param[componentid] = uiconfig.tablecode;
        _table_param[componentid + "_defquery"] = uiconfig.defquery;
        _table_param[componentid + "_orderby"] = uiconfig.orderby;
        _table_param[componentid + "_totaltag"] = uiconfig.totaltag;
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(col["colcode"]=="weight"){
                col.fn = function(l,c,data,col){
                    if(data.isleaf == "0"){
                        var weight = 0;
                        if(data.weight){
                            weight = data.weight;
                        }
                        return "<b>"+Math.round(weight*100)/100+"</b>";
                    }else{
                        return data.weight ? data.weight : "";
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                    common.amtTotal(table);
                }
            }
            //湖北部门总资金合并
            if (col["key"] == "/pmkpi/deptperformance/report/deptamt" || col["key"] == "/pmkpi/adjust/report/deptamt") {
                if (col["colcode"] == "rate"){
                    col.fn = function(l,c,data,col){
                        if (col !=""){
                            return "<b>"+col+"%</b>";
                        }
                    }
                }
                if (col["colcode"] == "yearamt" || col["colcode"] == "famt" || col["colcode"] == "samt") { //合计行不可编辑
                    col.oneditstart = function(table, e, l, c, d){
                        if(d["fundname"] == "合计"){
                            return false;
                        }
                    }
                    col.oneditend = function (table, el, l, c, d) {
                        cmp.sumamtTotal(table.getCol(c).colcode, d["agencyname"]);
                        if(table.getCol(c).colcode == "yearamt"){
                            cmp.ratecompute(d);
                        }
                    }
                }

                //处理收入支出的合并样式
                if (col["colcode"] == "typename") {
                    var findex = "";
                    var subfindex = "";
                    col.cseditfn = function (i, j, rs, style) { //列的单元格样式.
                        if (j == 1) {
                            var tabledata = deptamtdatatable.getRecordSet().toArray();
                            var statnum = 0;
                            if (i == statnum) {
                                findex = Ext.lt.cloneobj(rs["typename"]);
                            }
                            if (findex == rs["typename"]) {
                                style = 'style="border-bottom-style:none;text-align:center;position:relative;padding-top:5px;';
                            } else {
                                style = 'style="border-top-width:1px;text-align:center;border-top-color:#cccccc;border-bottom-style:none;';
                            }
                            findex = Ext.lt.cloneobj(rs["typename"]);
                            if (i == tabledata.length - 1) {
                                style = style + 'border-bottom-style:solid;"';
                            } else {
                                style = style + '"';
                            }
                        }
                        return style;
                    }
                    col.fn = function (i, c, rs, value) { //行的显示样式.
                        if (rs["typename"]) {
                            subfindex = Ext.lt.cloneobj(rs["typename"]);
                            var seq = showMidleName(subfindex, "typename");
                            if (i == seq) {
                                return value;
                            }
                            return "";
                        }
                    }
                }
            }
            if (col["key"] == "/pmkpi/program/report/mxdatatable"){
                col.oneditstart = function(table, e, l, c, d){
                    cmp.amtSum(table);
                }
            }
            if ((_viewtype == 'query' || _table_param[componentid + "_viewtype"] == "query") && col["name"] != "check") {
                col.style = "background-color:#f2f2f2;";
                col.oneditstart = function (table, e, l, c, d) {
                    return false;
                }
            }
        }
    });

    /**
     *  处理部门资金的合计金额与比例.
     * @param col,那些列需要合计.
     * @param amttype 收入还是支出的合计.
     */
    cmp.sumamtTotal = function (col, amttype) {
        var totalrow = deptamtdatatable.getRecordset();
        var sumamt = 0;
        var rowarr = totalrow.toArray();
        var len = rowarr.length;
        for ( var i = 0; i < len; i++) {
            if (rowarr[i].fundname != "合计" && rowarr[i].agencyname == amttype) {
                var weight = rowarr[i][col] ? rowarr[i][col] : 0;
                sumamt += parseFloat(weight);
            }
        }
        var parent_sel_rows = deptamtdatatable.getRecordset().query({agencyname:amttype+"sum"});
        var parent_sel_obj = parent_sel_rows[0];
        var _sortid = parent_sel_obj._sortid;
        /*parent_sel_obj["projmod"] = 'mod'; //指标对应项目发生变动.
        parent.perfindexdatatable.reflash(_sortid);*/
        var colsumamt = sumamt == 0 ? "0.00" : sumamt.toFixed(2);
        deptamtdatatable.updateData(_sortid,col,colsumamt);
    }
    /**
     * 处理部门资金占比。
     * @param row -- 行数据.
     */
    cmp.ratecompute = function (row){
        var amttype = row["agencyname"];
        var parent_sel_rows = deptamtdatatable.getRecordset().query({agencyname:amttype+"sum"});
        var parent_sel_obj = parent_sel_rows[0];
        var rowarr = deptamtdatatable.getRecordset().toArray();
        var len = rowarr.length;
        for ( var i = 0; i < len; i++) {
            if (rowarr[i].agencyname == amttype) {
                var curamt = rowarr[i]["yearamt"];
                var sumamt = parent_sel_obj["yearamt"];
                if ((curamt == 0 || curamt == null) || (sumamt == 0 || sumamt == null)){
                    rowarr[i].rate = "0";
                }else{
                    rowarr[i].rate = ((curamt/sumamt)*100).toFixed(2);
                }
            }
        }
    }

    /**
     * 复制上年目标
     * @param row -- 行数据.
     */
    cmp.copylastyeargoal = function (obj){
        var params = {};
        params.mainguid = _mainguid;
        params.saveAgency = _saveAgency; //部门编码
        params.copytype = 'goal';//复制目标
        var goaleditform = eval(_onclickid);
        var goaldatamap = goaleditform.getEditFormValues();
        if(goaldatamap["kpi_target"]!=null && goaldatamap["kpi_target"]!=''){
            Ext.lt.ui.confirm("绩效目标已存在，执行该操作后将被覆盖，请确认？",{icon:"warn"},function(ret){
                if(ret){
                    var rs = Ext.lt.RCP.asyncall(serviceid, "copyPerf", params);
                    if(rs.success){
                        eval(_onclickid).synchEditformByObj(rs.data[0]);
                        Ext.lt.ui.alert("复制成功！",function(){});
                    } else {
                        Ext.lt.ui.alert(rs.error,function(){});
                    }
                }
            });
        }else{
            var rs = Ext.lt.RCP.asyncall(serviceid, "copyPerf", params);
            if(rs.success){
                eval(_onclickid).synchEditformByObj(rs.data[0]);
                Ext.lt.ui.alert("复制成功！",function(){});
            } else {
                Ext.lt.ui.alert(rs.error,function(){});
            }
        }

    }

    Ext.lt.message.hook("formaleditformquery", "drawed",function(resp){
        var editfrom = resp.editformpanel;
        var table = editfrom.cfg.tablecode;
        var id = editfrom.cfg.id;
        if (id.indexOf("formal") != -1) {
            _edittablecode = table;
            var params = {};
            params.tablecode = table;
            params.mainguid = _mainguid;
            params.saveAgency = _saveAgency;
            params.proid = _pro_id;
            params.procode = _pro_code;
            params.agencycode = _agency_code;
            var rs = Ext.lt.RCP.asyncall(serviceid , "getEditFormal", params);
            var table_eva = {};
            var colList = rs.colList;
            var sumMap = rs.sumMap;
            _formalval = rs.info;
            var formalform = eval(id);
            for(var i=0; i<colList.length; i++){
                var columncode = colList[i];
                table_eva[columncode] = {
                    change: function(param){
                        var cols = sumMap[param.name];
                        var strs = cols.split("=");
                        var maincol = "";
                        var subvalue;
                        if (strs && strs.length >0 ){
                            maincol = strs[0];
                            subvalue = strs[1];
                        }
                        var editvalue = formalform.getEditFormValues();
                        for (var key in editvalue) {
                            var str = "[" + key + "]";
                            if (subvalue && subvalue.indexOf(str) != -1) {
                                var value = editvalue[key];
                                if (!value) value = 0;
                                subvalue = subvalue.replace(str, value);
                            }
                        }
                        var mainvalue = new Function("return (" + subvalue + ")")().toFixed(2);
                        var values = {};
                        values[maincol] = mainvalue;
                        formalform.getCol(maincol).bind(values);
                    }
                }
            }
            resp.editformpanel.attachEvent(table_eva);
        }
    });

    /**
     * 列表查询前调用消息
     */
    Ext.lt.message.hook("perfcommon", "tableinit",function(obj){
        obj.params.saveAgency = _saveAgency;  //列表查询的是后传递单位.
        common.initDatatable(eval(obj.id));
        if (_table_param[obj.id + "_viewtype"] || _viewtype == "query") {
            if($("#"+obj.id).find("#add")[0]){
                $("#"+obj.id).find("#add")[0].style.display = "none";
            }
            if($("#"+obj.id).find("#del")[0]){
                $("#"+obj.id).find("#del")[0].style.display = "none";
            }
        }
    });

    /**
     * 编辑区查询前调用
     */
    Ext.lt.message.hook("perfcommon", "editinit",function(obj){
        var id = obj.id;
        if (id.indexOf("formal") != -1) {
            var params = {};
            params.tablecode = _edittablecode;
            params.mainguid = _mainguid;
            params.saveAgency = _saveAgency;
            Ext.lt.message.send("formaleditformquery", "drawed", eval(id).form);
        }
        obj.params.formalval = _formalval;
    });

    /**
     * 点击报表类型处理消息
     */
    Ext.lt.message.hook("perfcommon", "reportinit",function(obj){
		var params = obj.params;
        params.mainguid = _mainguid;
        params.projguid = _projguid;
		params.saveAgency = _saveAgency;
    });

    /**
     * 点击嵌套页面类型处理消息
     */
    Ext.lt.message.hook("perfcommon", "iframeinit",function(obj){
        var params = obj.params;
        params.filebustype = _filebustype;
        params.taskyear = _taskyear;
        params.taskprovince = _taskprovince;
        var tst = Object.keys(config);
        for(var j = 0,len=tst.length; j < len; j++) {
            var vualue = config[tst[j]];
            if (isString(vualue) || isNumber((vualue))) {
                params[tst[j]] = vualue;
            }
        }
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
            if (obj.componentid == "mxdatatable"){
                setTimeout(function () {
                    cmp.amtSum(eval(obj.componentid));
                }, 300);
            }else {
                setTimeout(function () {
                    common.amtTotal(eval(obj.componentid));
                }, 100);
            }
        }
    });

    cmp.close = function () {
        try {
            Ext.lt.ui.closeModalWindow();
            window.parent.Ext.lt.pmkpi.query();
        } catch (e) {
            parent.Ext.lt.frame.window.hide();
        }
    }

    //标记已审核
    cmp.checkauditmark = function(){
        var params = {};
        params.pro_id = _pro_id;
        params.pro_code = _pro_code;
        params.agency_code = _agency_code;
        Ext.lt.RCP.call(service, "saveauditDatas", params, function (rs) {
            if (rs && rs.success) {
                Ext.lt.ui.alert('保存成功！', function () {});
            }
        });
    }

    //调用预算关闭方法
    cmp.auditclose = function (){
        try{
            Ext.lt.ui.closeModalWindow();
            window.parent.tabpageService.query();
        } catch (e) {
            parent.Ext.lt.frame.window.hide();
        }
    }

    /**
     * 湖北部门总资金.
     * @param val
     * @param col
     * @returns {number}
     */
    showMidleName = function(val,col){
        var tabledata = deptamtdatatable.getRecordSet().toArray();
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
    cmp.amtSum = function (table) {
        var iscurrentpage = (arguments.length > 0) ? arguments[0] : null;
        if(iscurrentpage===true) {
            l = table.getCheckRecordSet().toArray();
        }else{
            var l = table.getSelected();
            if (l.length == 0 || config.checkbox != true) {
                if (table.sumbak != null && !config.edit) {
                    for (var e in table.sumbak) {
                        table.sumobj[e] = table.sumbak[e];
                    }
                    table.reflashClockRow();
                    return;
                }
                l = table.getCheckRecordSet().toArray();
            }
        }
        if (table.setSumfn != null) {
            for (var e in table.sumobj) {
                table.sumobj[e] = 0;
            }
            table.sumobj.datatable_do_sum = true;
            table.sumobj.datatable_do_count = true;
            table.sumobj = table.setSumfn(l, table.sumobj);
            table.reflashClockRow();
        }
    }


    Ext.lt.message.hook("editform", "drawed",function(resp){
        var table_eva={
            //评价分值
            score : {
                change: function(param){
                    var data = editform.getEditFormValues();
                    var s = data.score;
                    var grade;
                    if(s >= 90){
                        grade = "优";
                    }else if(s >= 80 && s < 90){
                        grade = "良";
                    }else if(s >= 60 && s < 80){
                        grade = "中";
                    }else{
                        grade = "差";
                    }
                    var values = {};
                    values.grade = grade;
                    editform.getCol("grade").bind(values);
                }
            },
            // 监控分析-项目绩效目标执行总体情况
            completepossibility:{
                change: function(param){
                    var data = analysisformaleditform.getEditFormValues();
                    if(data.remark == "1"){
                        var params = {};
                        params.warmtype = "depttaskgoalwarn";
                        params.completepossibility = data.completepossibility;
                        params.depttask = data.remark;
                        Ext.lt.ui.loadingShow();
                        Ext.lt.RCP.call(service , "getWarn", params, function(rs){
                            if(!!rs){
                                var warn;
                                if (rs == "red") {
                                    warn = "红色";
                                } else if (rs == "yellow") {
                                    warn = "黄色";
                                } else if (rs == "green") {
                                    warn = "绿色";
                                } else if (rs == "blue") {
                                    warn = "蓝色";
                                } else {
                                    warn = "";
                                }
                                var values = {};
                                values.goalwarn = warn;
                                analysisformaleditform.getCol("goalwarn").bind(values);
                            }
                            Ext.lt.ui.loadingClose();
                        },function(){
                            Ext.lt.ui.loadingClose();
                        });
                    }
                }
            },
            eval_score : {
                change: function(param){
                    var eval_levlo;
                    var score = param.value;
                    if (score >= 90) {
                        eval_levlo = "优";
                    } else if (score >= 80) {
                        eval_levlo = "良";
                    } else if (score >= 60) {
                        eval_levlo = "中";
                    } else {
                        eval_levlo = "差";
                    }
                    var values = {};
                    values.eval_levlo = eval_levlo;
                    editform.getCol("eval_levlo").bind(values);
                }
            }
            // ,
            // eval_target:{
            //     change:function(param){
            //         var target =param.value == undefined ? '' : param.value;
            //         if(target.length>=200){
            //             var msg='年度目标实际完成情况字数限制200字，请检查！';
            //             resp.editformpanel.showValidate(false,"eval_target","warnning",msg);
            //         }
            //
            //     }
            // }
        }
        resp.editformpanel.attachEvent(table_eva);
    });

    /**
     * 设置监控分析编辑区隐藏显示 显示的列的config中配置了type要根据pageconsolecommonconfig中的type不匹配则隐藏，否则显示
     */
    cmp.setTraceAnalysisEdit = function (){
        var cols = analysisformaleditform.cfg.data;
        var type = analysisformaleditform.cfg.type;
        for (var i=0; i<cols.length; i++) {
            var col = cols[i];
            if(col.isvisiable == '1'){
                if (col.config && col.config!="{}" && JSON.parse(col.config.replace(/'/g, '"'))["type"] && JSON.parse(col.config.replace(/'/g, '"'))["type"] != type) {
                    analysisformaleditform.hide([col.colcode.toLowerCase()],false);
                } else {
                    analysisformaleditform.show([col.colcode.toLowerCase()],false);
                }
            }
        }
    }

    return cmp;
}