if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.protrace){
    Ext.lt.pmkpi.protrace = {};
}

var _isSX;
Ext.lt.pmkpi.protrace.tjfundservice = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};

    var _menuid = config.menuid,//菜单id
        _proguid = config.proguid,//项目guid
        _procode= config.procode,//项目guid
        _mainguid = config.mainguid,//
        _taskguid = config.taskguid,//任务guid
        _prolev = config.prolev,//项目级次
        _saveAgency = config.saveAgency,//单位
        _busguid = config.busguid,//审核定义guid
        _bustype = config.bustype,//审核定义guid
        _viewtype = config.viewtype,
        _isHbei = config.isHbei,
        _isZJ = config.isZJ,
        _queryYear = config.queryYear,//跨年查询查询年度
        _queryProvince = config.queryProvince,//跨年查询查询区划
        _defquery,//列表查询条件
        _orderby,//排序
        _tablecode;//表名
        _isSX = config.isSX;

    $(function (){
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        if (_viewtype == "query") {
            try{
                $("div[compid='toolbutton']").hide();
            }catch (e){
                //document.getElementsByClassName("winfooter")[0].style.display = "none";
            }
            if(document.getElementById("add")){
                document.getElementById("add").style.display = "none";
            }
            if(document.getElementById("del")){
                document.getElementById("del").style.display = "none";
            }
        }
        Ext.lt.pmkpi.query(true);
    })

    Ext.lt.pmkpi.query = function(isquery){
        Ext.lt.ui.loadingShow();
        var params = {};
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.menuid = _menuid;
        params.prolev = _prolev;
        params.proguid = _proguid;
        params.procode = _procode
        params.mainguid = _mainguid;
        params.taskguid = _taskguid;
        params.bustype = _bustype;
        params.saveAgency = _saveAgency;
        params.compconfigid = "datatable";
        params.url = datatable.config.pageurl;
        params.viewtype = _viewtype;
        params.queryYear = _queryYear;
        params.queryProvince = _queryProvince;
        if(_isSX == '1' && _bustype == "depttrace"){
            params.bgtsource = "1";
        }
        Ext.lt.RCP.call(service , "getDatas", params, function(data){
            datatable.setDatas(data);
            if(data[0]){
                setMidSaveHidButtons(data[0]);
            }else{
                var btnobj;
                var btnobj2;
                if(parent.$("#暂存").length > 0){
                    btnobj = parent.$("#暂存");
                    btnobj2 = parent.$("#清除暂存");
                    btnobj.show();
                    btnobj2.show();
                    parent._issavetmp = true;
                }else if($("#暂存").length > 0){
                    btnobj = $("#暂存");
                    btnobj2 = $("#清除暂存");
                    btnobj.show();
                    btnobj2.show();
                    parent._issavetmp = true;
                }
            }
            Ext.lt.ui.loadingClose();
            /*setTimeout(function(){
                //datatable.resetSum();
                amtTotal(datatable);
            },300);*/
            if (isquery) {
                setTimeout(function(){
                    parent._isQuery = true;
                },500);
            }
            setTimeout(function () {
                var superid = "";
                for (var i = 0; i < data.length; i++) {
                    var d = data[i];
                    if (d.levelno == 3) {
                        if (d.superguid != superid) {
                            getFundAll(d.superguid);
                        }
                        superid = d.superguid;
                    }
                }
            }, 500);
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
            if(col["colcode"] == "amt1" || col["colcode"] == "amt3" || col["colcode"] == "amt4"){
                col.oneditstart = function(table,el,l,c,d){
                    //是否可编辑 1是2否
                    if (d.isedit != "1") {
                        return false;
                    }
                }
            }
            if(col["colcode"] == "amt1" || col["colcode"] == "amt3" || col["colcode"] == "amt4"){
                col.oneditend = function(table,el,l,c,d){
                    var amt4 = d.amt4;
                    var amt3 = d.amt3;
                    if ((amt3 == 0 || amt3 == null) || (amt4 == 0 || amt4 == null)){
                        d.bgtget = "0";
                    }else{
                        d.bgtget = ((amt4/amt3)*100).toFixed(2);
                    }
                    getFundAll(d.superguid);
                }
            }

            if(col["colcode"]=="amt5") {
                col.oneditstart = function (table, el, l, c, d) {
                    //是否可编辑 1是2否
                    if (d.isedit != null && d.isedit == "1" && d.levelno != "1") {
                        return true;
                    } else {
                        return false;
                    }
                }

                col.oneditend = function(table,el,l,c,d){
                    getFundAll(d.superguid);
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
        if (!datatable.checkAll()) return false;//先校验
        var params = {};
        var datas = datatable.getRecordSet().toArray();
        if(!datas || datas.length == 0) {
            params.success = true;
            return params;
        }
        params.datas = datas;
        if(_isSX == '1' && _bustype == "depttrace" && typeof(dirdatatable) != "undefined" && dirdatatable != null){
            params.datas = params.datas.concat(dirdatatable.getRecordSet().toArray());
        }
        params.tablecode = _tablecode;
        params.busguid = _busguid;
        params.mainguid = _mainguid;
        params.saveAgency = _saveAgency;
        params.taskguid = _taskguid;
        params.proguid = _proguid;
        params.procode = _procode;
        params.compconfigid = "datatable";
        params.url = datatable.config.pageurl;
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
        var datas = datatable.getRecordSet().toArray();
        if(!datas || datas.length == 0) {
            params.success = true;
            return params;
        }
        params.data = datatable.getRecordSet().toArray();
        params.url = datatable.config.pageurl;
        params.mainguid = _mainguid;
        params.componentid = datatable.config.server;
        params.compconfigid = "datatable";
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(service , "midsave", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            Ext.lt.pmkpi.query();
        }
        return rs;
    }

    /**
     * 清除暂存
     */
    cmp.savetmpdel = function (obj){
        var params = {};
        params.url = datatable.config.pageurl;
        params.mainguid = _mainguid;
        params.componentid = datatable.config.server;
        params.compconfigid = "datatable";
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(service , "midsavedel", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            Ext.lt.pmkpi.query();
        }
        return rs;
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
        //amtTotal(datatable);
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
        //amtTotal(datatable);
    })

    Ext.lt.pmkpi.warn = function (d){
        var datas = datatable.getRecordSet().toArray();
        for(var i = 0;i<=datas.length;i++){
            var params = {};
            params.warmtype = "bgtgetwarn";
            params.targetvalue = datas[i].amt5+"";
            params.indexval = datas[i].amt4+"";
            var warndata = Ext.lt.RCP.asyncall(service , "getWarn", params);
            var parent_sel_rows = datatable.getRecordset().query({code:datas[i].code});
            var parent_sel_obj = parent_sel_rows[0];
            var _sortid = parent_sel_obj._sortid;
            parent_sel_obj["bgtget"] = warndata;
            datatable.reflash(_sortid);
        }
    }
    Ext.lt.pmkpi.fund = function (params){
        var params = params;
        params.proguid = _proguid;
        params.agencyguid = _saveAgency;
        var warndata = Ext.lt.RCP.asyncall(service , "getWarn", params);
        return warndata;
    }

    return cmp;
}

/**
 * 资金数三级汇总二级，二级汇总一级
 * @param superid
 */
function getFundAll(superguid) {
    var datas = datatable.getRecordSet().toArray();
    if (superguid) {
        if (datas != null && datas.length > 0) {
            var supguid = '';
            var guid = '';
            var amt1 = 0;  //年初预算数
            var amt3 = 0;  //调整后预算数
            var amt4 = 0;  //1-X月执行数
            var amt5 = 0;  //全年预计执行数
            var bgtget = 0; //预算执行率  （1-X月执行数 / 调整后预算数）
            for (var i = 0; i < datas.length; i++) { //计算二级年初预算数
                var selectDatas = datas[i];
                if (superguid == selectDatas.code) {
                    supguid = selectDatas.superguid;
                    guid = selectDatas.code;
                }
                if (selectDatas.superguid == superguid && selectDatas.amt1 && !isNaN(selectDatas.amt1)) {
                    amt1 += parseFloat(selectDatas.amt1);
                }
                if (selectDatas.superguid == superguid && selectDatas.amt3 && !isNaN(selectDatas.amt3)) {
                    amt3 += parseFloat(selectDatas.amt3);
                }
                if (selectDatas.superguid == superguid && selectDatas.amt4 && !isNaN(selectDatas.amt4)) {
                    amt4 += parseFloat(selectDatas.amt4);
                }
                if (selectDatas.superguid == superguid && selectDatas.amt5 && !isNaN(selectDatas.amt5)) {
                    amt5 += parseFloat(selectDatas.amt5);
                }
            }
            datas.each(function (data, i) {
                if (data.code == guid) {
                    datas[i]['amt1'] = amt1 == 0.00 ? "" : amt1.toFixed(2);
                    datas[i]['amt3'] = amt3 == 0.00 ? "" : amt3.toFixed(2);
                    datas[i]['amt4'] = amt4 == 0.00 ? "" : amt4.toFixed(2);
                    datas[i]['amt5'] = amt5 == 0.00 ? "" : amt5.toFixed(2);
                    datas[i]['bgtget'] = amt4/amt3*100 == 0 ? "" : ((amt4/amt3)*100).toFixed(2);
                }
            });
            getFundAll(supguid); //递归汇总一级的
        }
    }
    datatable.reflash();
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
            //备用资金字段
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
        totalrs["amt1"] = sumamt1 == 0 ? "" : sumamt1.toFixed(2);        //年初预算
        totalrs["amt2"] = sumamt2 == 0 ? "" : sumamt2.toFixed(2);        //年度调整预算
        totalrs["amt3"] = sumamt3 == 0 ? "" : sumamt3.toFixed(2);        //调整后预算
        totalrs["amt4"] = sumamt4 == 0 ? "" : sumamt4.toFixed(2);        //实际执行数

        totalrs["amt5"] = sumamt5 == 0 ? "" : sumamt5.toFixed(2);        //备用字段
        totalrs["amt6"] = sumamt6 == 0 ? "" : sumamt6.toFixed(2);        //备用字段
        totalrs["amt7"] = sumamt7 == 0 ? "" : sumamt7.toFixed(2);        //备用字段
        totalrs["amt8"] = sumamt8 == 0 ? "" : sumamt8.toFixed(2);        //备用字段
        totalrs["amt9"] = sumamt9 == 0 ? "" : sumamt9.toFixed(2);        //备用字段
        if (sumamt3 != 0){
            totalrs["bgtget"] = sumamt4/sumamt3*100 == 0 ? "" : ((sumamt4/sumamt3)*100).toFixed(2);     //预算执行率(实际执行数/调整后预算)
        }else{
            totalrs["bgtget"] = "0";
        }
        if(_isSX == '1'){
            if (sumamt2 != 0){
                totalrs["amt6"] = sumamt5/sumamt2*100 == 0 ? "" : ((sumamt5/sumamt2)*100).toFixed(2);     //山西：监控期下达率=监控期下达数/本年预算数
            }else{
                totalrs["amt6"] = "0";
            }
        }
        totalrs.datatable_do_sum=true;
        table.getClockRowSet().setData(totalrs,0);
        //if((totalrow.size&&totalrow.size()>0)||(totalrow.length&&totalrow.length>0)){
            table.reflashdata();
        //}
    }
}