if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.hfselfbdgpay){
    Ext.lt.pmkpi.hfselfbdgpay = {};
}
var serviceid;
var _mainguid;
var _bgtget;
Ext.lt.pmkpi.hfselfbdgpay = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var
        _saveAgency = config.saveAgency,
        _bustype = config.bustype,
        _tablecode,//表名
        _defquery,//表配置过滤条件
        _orderby,//表排序sql
        _displaycols = [],
        _viewtype = config.viewtype,
        _projguid = config.projguid,
        _procode = config.procode,
        _queryYear = config.queryYear,//跨年查询查询年度
        _queryProvince = config.queryProvince,//跨年查询查询区划
        _busguid = config.busguid;
    serviceid = service;
    _mainguid = config.mainguid;

    var cmp = {};
    /**
     * 获取表的查询.
     */
    Ext.lt.message.hook("busdatatable", "drawed",function (obj) {
        var config = obj.config;
        _tablecode = obj.uiconfig.tablecode;
        _defquery = obj.uiconfig.defquery;
        _orderby = obj.uiconfig.orderby;
    });

    cmp.query = function(isquery){
        var params = {};
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tablecode = _tablecode;
        params.saveAgency = _saveAgency; //单位.
        params.mainguid = _mainguid;
        params.projguid = _projguid;
        params.procode = _procode; //项目code
        params.bustype = _bustype;
        params.compconfigid = "datatable";
        params.url = datatable.config.pageurl;
        params.viewtype = _viewtype;
        params.queryYear = _queryYear;
        params.queryProvince = _queryProvince;
        cmp.setTableColum();
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "getPayDatas", params, function(rs){
            datatable.setDatas(rs.data);
            setMidSaveHidButtons(rs);
            Ext.lt.ui.loadingClose();
            setTimeout(function(){
                amtTotal(datatable);
            },300);
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
            if(col["colcode"]=="amt1" || col["colcode"]=="amt2" || col["colcode"]=="amt5" ||col["colcode"]=="amt6" ||col["colcode"]=="amt7" ||col["colcode"]=="amt8" ||col["colcode"]=="amt9"){
                col.oneditend = function (table, el, l, c, d) {
                    amtTotal(datatable);
                }
            }
            if(col["colcode"]=="amt3" || col["colcode"]=="amt4"){
                col.oneditend = function (table, el, l, c, d) {
                    var amt4 = d.amt4;
                    var amt3 = d.amt3;
                    if (!amt3 || amt3 == 0){
                        d.bgtget = "0";
                    }else{
                        d.bgtget = ((amt4/amt3)*100).toFixed(2);
                    }
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
        if (!datatable.checkAll()) return false;//先校验
        if(!checkLength()) return false;  //校验长度不超过1000个字
        var params = {};
        params.datas = datatable.getRecordSet().toArray();
        params.updatas = datatable.getUpdataData();
        params.deldatas = datatable.getRemoveData();
        params.tablecode = _tablecode;
        params.busguid = _busguid;
        params.pro_code = _procode; //项目code
        params.mainguid = _mainguid;
        params.bustype = _bustype;
        params.bgtget = _bgtget;
        params.saveAgency = _saveAgency;
        params.compconfigid = "datatable";
        params.url = datatable.config.pageurl;
        var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
        if(rs) {
            cmp.query();
        }
        return rs;
    }

    /**
     * 暂存
     */
    cmp.savetmp = function (obj){
        var params = {};
        params.data = datatable.getRecordSet().toArray();
        params.url = datatable.config.pageurl;
        params.mainguid = _mainguid;
        params.componentid = datatable.config.server;
        params.compconfigid = "datatable";
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid , "midsave", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            cmp.query();
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
        var rs = Ext.lt.RCP.asyncall(serviceid , "midsavedel", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            cmp.query();
        }
        return rs;
    }

    $(function () {
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
        cmp.query(true);
    })

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
     * 刪除表格.
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

    Ext.lt.pmkpi.warn = function (params){
        var params = params;
        params.proguid = _projguid;
        params.procode = _procode; //项目code
        params.agencyguid = _saveAgency;
        var warndata = Ext.lt.RCP.asyncall(service , "getWarn", params);
        return warndata;
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
            if (_bustype == "program") {
                if (config && config.isdept == 1) {
                    _displaycols.push(col); //隐藏前暂存至sfagency;
                    col.display = false; //display置为false，隐藏
                } else {
                    col.display = true;
                }
            } else if (_bustype == "dept") {
                if (config && config.ispro == 1) {
                    _displaycols.push(col); //隐藏前暂存至sfagency;
                    col.display = false; //display置为false，隐藏
                } else {
                    col.display = true;
                }
            }
        }
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw(); //从新绘制表格
    }

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
        var rowarr = totalrow.toArray();
        var len = rowarr.length;
        for ( var i = 0; i < len; i++) {
            var amt1 = rowarr[i]["amt1"] ? rowarr[i]["amt1"] : 0.00;
            sumamt1 += parseFloat(amt1);
            var amt2 = rowarr[i]["amt2"] ? rowarr[i]["amt2"] : 0.00;
            sumamt2 += parseFloat(amt2);
            var amt3 = rowarr[i]["amt3"] ? rowarr[i]["amt3"] : 0.00;
            sumamt3 += parseFloat(amt3);
            var amt5 = rowarr[i]["amt5"] ? rowarr[i]["amt5"] : 0.00;
            sumamt5 += parseFloat(amt5);
            var amt4 = rowarr[i]["amt4"] ? rowarr[i]["amt4"] : 0.00;
            sumamt4 += parseFloat(amt4);
            var amt6 = rowarr[i]["amt6"] ? rowarr[i]["amt6"] : 0.00;
            sumamt6 += parseFloat(amt6);
            var amt7 = rowarr[i]["amt7"] ? rowarr[i]["amt7"] : 0;
            sumamt7 += parseFloat(amt7);
            var amt8 = rowarr[i]["amt8"] ? rowarr[i]["amt8"] : 0;
            sumamt8 += parseFloat(amt8);
            var amt9 = rowarr[i]["amt9"] ? rowarr[i]["amt9"] : 0;
            sumamt9 += parseFloat(amt9);
        }
        var totalrs = {};
        totalrs["scores"] = "10";  //分值固定值 10分
        totalrs["amt1"] = sumamt1 == 0 ? "0.00" : sumamt1.toFixed(2);        //年初预算
        totalrs["amt2"] = sumamt2 == 0 ? "0.00" : sumamt2.toFixed(2);        //全年预算
        totalrs["amt3"] = sumamt3 == 0 ? "0.00" : sumamt3.toFixed(2);        //全年预算
        totalrs["amt5"] = sumamt5 == 0 ? "0.00" : sumamt5.toFixed(2);        //其中：财政拨款
        totalrs["amt4"] = sumamt4 == 0 ? "0.00" : sumamt4.toFixed(2);        //实际执行数
        totalrs["amt6"] = sumamt6 == 0 ? "0.00" : sumamt6.toFixed(2);        //其中：财政拨款
        totalrs["amt7"] = sumamt7 == 0 ? "" : sumamt7.toFixed(2);        //备用字段
        totalrs["amt8"] = sumamt8 == 0 ? "" : sumamt8.toFixed(2);        //备用字段
        totalrs["amt9"] = sumamt9 == 0 ? "" : sumamt9.toFixed(2);        //备用字段
        if (sumamt3 != 0){
            totalrs["bgtget"] = sumamt4/sumamt3*100 == 0 ? "0.00" : ((sumamt4/sumamt3)*100).toFixed(2);     //预算执行率(实际执行数/调整后预算)
            var source = sumamt4/sumamt3*10 == 0 ? "0.00" : (sumamt4/sumamt3*10);  //自评得分(预算执行率*10)
            if (source >= 10) {
                source = 10;
            } else if(source > 0) {
                source = source.toFixed(2);
            }
            totalrs["score"] = source;
        }else{
            totalrs["bgtget"] = "0.00";
            totalrs["score"] = "0.00";
        }
        _bgtget = totalrs["bgtget"];
        totalrs.datatable_do_sum=true;
        table.getClockRowSet().setData(totalrs,0);
        //if((totalrow.size&&totalrow.size()>0)||(totalrow.length&&totalrow.length>0)){
        table.reflashdata();
        //}
    }
}
/**
 * 完成情况校验不能超过1000字
 */
function checkLength() {
    var flag = true;
    var datas = datatable.getRecordSet().toArray();
    if (datas != null && datas.length > 0) {
        for (var i = 0; i < datas.length; i++) {  //
            var tempObj = datas[i];
            var completion = tempObj.completion;
            if(completion && completion.length > 1000){
                Ext.lt.ui.alert("第"+(i+1)+"行，完成情况超过最大长度,请重新填写！", {timeout: 1}, function () { });
                return false;
            }
        }
    }
    return flag;
}