if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.protrace){
    Ext.lt.pmkpi.protrace = {};
}

var _standard;
Ext.lt.pmkpi.protrace.warnservice = function(config, service){
    var perfcommon = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};

    var _menuid = config.menuid,//菜单id
        _proguid = config.proguid,//项目guid
        _mainguid = config.mainguid,//主单guid
        _bustype = config.bustype,//任务类型
        _taskguid = config.taskguid,//任务guid
        _busguid = config.busguid,//审核定义guid
        _saveAgency = config.saveAgency,//单位guid
        _viewtype = config.viewtype,
        _procode = config.procode,
        _protype = config.protype,//项目类型，一般、重点
        _queryYear = config.queryYear,//跨年查询查询年度
        _queryProvince = config.queryProvince,//跨年查询查询区划
        _defquery,//列表查询条件
        _orderby,//排序
        _tablecode;//表名

    $(function (){
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        perfcommon.initDatatable();
        var html = '<div class="conditionDiv" style="position: absolute; width: 493.02px; height: 50px; top: 30px; left: 0px;">';
            html += '<div class="treeselect layui-form-pane">';
            if(_SYSTEMSTYLE_ == "grey"){
                html += '<label class="lab" style="width:170px;height:38px;line-height:38px;">';
            }else{
                html += '<label class="lab" style="width:150px;">';
            }
            html += '<font class="character" style="float: none;" title="达到预计支出进度">达到预计支出进度</font>' +
                '<span class="maohao">:</span>&nbsp;</label>' +
                '<div name="isgoal" id="boolean_1012" class="layui-input-block">' +
                '<input type="radio" style="margin-right:7px;display:none;" name="isgoal" value="0" title="是" lay-filter="isgoal">' +
                '<div id="yes" class="layui-unselect layui-form-radio">' +
                '<i class="layui-anim layui-icon"></i>' +
                '<div>是</div></div>' +
                '<input type="radio" name="isgoal" style="display:none;" value="0" title="否" lay-filter="isgoal">' +
                '<div id="no" class="layui-unselect layui-form-radio"><i class="layui-anim layui-icon"></i><div>否</div>' +
                '</div></div></div>';
            html += '</div>';
        var _viewdiv = document.createElement("div");
        _setFrame(_viewdiv);
        _viewdiv.id = "warn";
        var divobj =  document.getElementById("tablediv");
        if(_SYSTEMSTYLE_ == "grey"){
            divobj = $(".tbtitle")[0];
            setTimeout(function () {
                var datatableheight = $("#datatable").css("height");
                $("#datatable").find("#tablediv").css("height",(parseFloat(datatableheight)-150)+"px");
                datatable.redraw();
                $(".fullscreen").hide();
            }, 500);
        }
        $('.in')[0].insertBefore(_viewdiv,divobj);
        $('#warn').append(html);
        document.getElementById("warn").style.height="80px";
        document.getElementById("goaleditform").style.marginTop="20px";
        // document.getElementById("datatable1022_tablePaginationDiv").style.display="none";
        if (_viewtype == "query") {
            $("#add").hide();
            $("#del").hide();
        }
        Ext.lt.pmkpi.query(true);
    })

    function _setFrame(obj){
        obj.setAttribute('frameBorder', 0);
        obj.style.cssText = 'border: 0 none;';
        obj.style.width = 200;
        obj.style.height = 55;
    }

    Ext.lt.pmkpi.query = function(isquery){
        Ext.lt.ui.loadingShow();
        var params = {};
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.proguid = _proguid;
        params.mainguid = _mainguid;
        params.bustype = _bustype;
        params.taskguid = _taskguid;
        params.saveAgency = _saveAgency;
        params.procode = _procode;
        params.compconfigid1 = "goaleditform";
        params.url1 = goaleditform.cfg.pageurl;
        params.compconfigid2 = "datatable";
        params.url2 = datatable.config.pageurl;
        params.viewtype = _viewtype;
        params.queryYear = _queryYear;
        params.queryProvince = _queryProvince;
        Ext.lt.RCP.call(service , "getDatas", params, function(rt){
            if (rt) {
                if (_viewtype == "query") {
                    perfcommon.editSetdisabled(goaleditform);
                }
                setTimeout(function () {
                    goaleditform.synchEditformByObj(rt.goalinfo);
                    datatable.setDatas(rt.data);
                },100);
                _standard = rt.standard;
            }
            Ext.lt.ui.loadingClose();
            setMidSaveHidButtons(rt);
            setTimeout(function(){
                datatable.resetSum();
                amtTotal(datatable);
            },600);
            if (isquery) {
                setTimeout(function(){
                    parent._isQuery = true;
                },500);
            }
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        _tablecode = uiconfig.tablecode;
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(col["colcode"]=="amt1" || col["colcode"]=="amt7" || col["colcode"]=="amt8"){
                col.oneditend = function (table, el, l, c, d) {
                    var amt1 = d.amt1 ? d.amt1 : 0;
                    var amt7 = d.amt7 ? d.amt7 : 0;
                    var amt8 = d.amt8 ? d.amt8 : 0;
                    var amt4 = d.amt4 ? d.amt4 : 0;
                    var amt3 = floatSub(floatAdd(amt1, amt7), amt8).toFixed(2);
                    d.amt3 = amt3;
                    if (!amt3 || amt3 == 0){
                        d.bgtget = 0;
                    }else{
                        d.bgtget = (floatDiv(amt4,amt3)*100).toFixed(2);
                    }
                    amtTotal(datatable);
                }
            }
            if(col["colcode"]=="amt3" || col["colcode"]=="amt4"){
                col.oneditend = function (table, el, l, c, d) {
                    var amt4 = d.amt4 ? d.amt4 : 0;
                    var amt3 = d.amt3 ? d.amt3 : 0;
                    if (!amt3 || amt3 == 0){
                        d.bgtget = 0;
                    }else{
                        d.bgtget = (floatDiv(amt4,amt3)*100).toFixed(2);
                    }
                    amtTotal(datatable);
                }
            }
            if(col["colcode"]=="amt2" || col["colcode"]=="amt5" || col["colcode"]=="amt6" || col["colcode"]=="amt9"){
                col.oneditend = function (table, el, l, c, d) {
                    amtTotal(datatable);
                }
            }
            //查询时列表不可编辑
            if (_viewtype == 'query' && !config[col.colcode] && col["name"] != "check") {
                col.style = "background-color:#f2f2f2;";
                col.oneditstart = function (table, e, l, c, d) {
                    return false;
                }
            }
        }
    });

    cmp.save = function(){
        if (!goaleditform.check()) return false;//先校验
        var yes = $("#yes").val();
        var no = $("#no").val();
        var isexpfunc;
        var iswarnfunc;
        if (yes == "1") {
            isexpfunc = 1;
            iswarnfunc = "yes";
        } else if (no == "1") {
            isexpfunc = 0;
            iswarnfunc = "no";
        }
        var params = {};
        params.datas = datatable.getRecordSet().toArray();
        params.infodata = goaleditform.getEditFormValues();
        params.tablecode = _tablecode;
        params.busguid = _busguid;
        params.mainguid = _mainguid;
        params.saveAgency = _saveAgency;
        params.taskguid = _taskguid;
        params.proguid = _proguid;
        params.bustype = _bustype;
        params.protype = _protype;
        params.infodata.isexpfunc = isexpfunc;//是否达到预计支出进度
        params.iswarnfunc = iswarnfunc;
        params.compconfigid1 = "goaleditform";
        params.url1 = goaleditform.cfg.pageurl;
        params.compconfigid2 = "datatable";
        params.url2 = datatable.config.pageurl;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(service , "save", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            Ext.lt.pmkpi.query();
        }
        return rs;
    }

    /**
     * 暂存
     */
    cmp.savetmp = function (obj){
        var params = {};
        params.mainguid = _mainguid;
        params.data1 = goaleditform.getEditFormValues();
        params.url1 = goaleditform.cfg.pageurl;
        params.componentid1 = goaleditform.cfg.server;
        params.compconfigid1 = "goaleditform";
        params.data2 = datatable.getRecordSet().toArray();
        params.url2 = datatable.config.pageurl;
        params.componentid2 = datatable.config.server;
        params.compconfigid2 = "datatable";
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(service , "midsave", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            Ext.lt.pmkpi.query();
        }
        return rs;
    }

    /**
     * 暂存
     */
    cmp.savetmpdel = function (obj){
        var params = {};
        params.mainguid = _mainguid;
        params.url1 = goaleditform.cfg.pageurl;
        params.componentid1 = goaleditform.cfg.server;
        params.compconfigid1 = "goaleditform";
        params.url2 = datatable.config.pageurl;
        params.componentid2 = datatable.config.server;
        params.compconfigid2 = "datatable";
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(service , "midsavedel", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            Ext.lt.pmkpi.query();
        }
        return rs;
    }

    Ext.lt.pmkpi.warn = function (params){
        var params = params;
        params.proguid = _proguid;
        params.agencyguid = _saveAgency;
        var warndata = Ext.lt.RCP.asyncall(service , "getWarn", params);
        return warndata;
    }

    /**
     * 新增行.
     */
    Ext.lt.message.hook("addRow", "uidatatable", function(){
        var newguid = Ext.lt.RCP.asyncall(service , "getCreateguid", null);
        var newdata ={};
        newdata.guid = newguid;
        newdata.isedit = '1';
        datatable.getRecordSet().addData(newdata,999);
        amtTotal(datatable);
    });
    /**
     * 刪除行
     */
    Ext.lt.message.hook("delRow", "uidatatable", function() {
        var selDatas = datatable.getSelected();
        if (selDatas.size() <= 0) {
            Ext.lt.ui.alert('请选择要删除的数据！', function () {
            });
            return;
        }
        datatable.removeData(selDatas);
        amtTotal(datatable);
    })

    return cmp;
}
function amtTotal(table) {
    if(table.getSumobj()){
        var totalrow = table.getRecordset();
        var sumamt1 = 0;
        var sumamt2 = 0;
        var sumamt3 = 0;
        var sumamt4 = 0;
        var sumamt5 = 0;
        var sumamt6 = 0;
        var sumamt7 = 0;
        var sumamt8 = 0;
        var sumamt9 = 0;
        var bgtget = 0;
        var rowarr = totalrow.toArray();
        var len = rowarr.length;
        for ( var i = 0; i < len; i++) {
            var amt1 = rowarr[i]["amt1"] ? rowarr[i]["amt1"] : 0;
            sumamt1 += parseFloat(amt1);
            var amt2 = rowarr[i]["amt2"] ? rowarr[i]["amt2"] : 0;
            sumamt2 += parseFloat(amt2);
            var amt3 = rowarr[i]["amt3"] ? rowarr[i]["amt3"] : 0;
            sumamt3 += parseFloat(amt3);
            var amt4 = rowarr[i]["amt4"] ? rowarr[i]["amt4"] : 0;
            sumamt4 += parseFloat(amt4);
            var amt5 = rowarr[i]["amt5"] ? rowarr[i]["amt5"] : 0;
            sumamt5 += parseFloat(amt5);
            var amt6 = rowarr[i]["amt6"] ? rowarr[i]["amt6"] : 0;
            sumamt6 += parseFloat(amt6);
            var amt7 = rowarr[i]["amt7"] ? rowarr[i]["amt7"] : 0;
            sumamt7 += parseFloat(amt7);
            var amt8 = rowarr[i]["amt8"] ? rowarr[i]["amt8"] : 0;
            sumamt8 += parseFloat(amt8);
            var amt9 = rowarr[i]["amt9"] ? rowarr[i]["amt9"] : 0;
            sumamt9 += parseFloat(amt9);

        }
        var totalrs = {};
        totalrs["amt1"] = sumamt1.toFixed(2);        //年初预算
        totalrs["amt2"] = sumamt2.toFixed(2);        //年度调整预算
        totalrs["amt3"] = sumamt3.toFixed(2);        //调整后预算
        totalrs["amt4"] = sumamt4.toFixed(2);        //实际执行数
        totalrs["amt5"] = sumamt5.toFixed(2);        //项目指标结余
        totalrs["amt6"] = sumamt6.toFixed(2);        //备用字段
        totalrs["amt7"] = sumamt7.toFixed(2);        //备用字段
        totalrs["amt8"] = sumamt8.toFixed(2);        //备用字段
        totalrs["amt9"] = sumamt9.toFixed(2);        //备用字段
        if (sumamt3 == 0) {
            totalrs["bgtget"] = "0";
        } else {
            totalrs["bgtget"] = (floatDiv(totalrs["amt4"],totalrs["amt3"])*100).toFixed(2);     //预算执行率(实际执行数/调整后预算)
        }
        if (_standard <= totalrs["bgtget"]) {
            $('#yes').val('1');
            document.getElementById("yes").classList.add("layui-form-radioed");
            document.getElementById("no").classList.remove("layui-form-radioed");
        } else {
            $('#no').val('1');
            document.getElementById("no").classList.add("layui-form-radioed");
            document.getElementById("yes").classList.remove("layui-form-radioed");
        }
        totalrs.datatable_do_sum=true;
        table.getClockRowSet().setData(totalrs,0);
        if((totalrow.size&&totalrow.size()>0)||(totalrow.length&&totalrow.length>0)){
            table.reflashdata();
        }
    }
}