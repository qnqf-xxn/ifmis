if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.selfbdgpay){
    Ext.lt.pmkpi.selfbdgpay = {};
}
var serviceid;
var _mainguid;
var _bustype;
var _bgtget;
Ext.lt.pmkpi.selfbdgpay = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var
        _saveAgency = config.saveAgency,
        _tablecode,//表名
        _defquery,//表配置过滤条件
        _orderby,//表排序sql
        _viewtype = config.viewtype,
        _projguid = config.projguid,
        _procode = config.procode,
        _queryYear = config.queryYear,//跨年查询查询年度
        _queryProvince = config.queryProvince,//跨年查询查询区划
        _busguid = config.busguid;
    _isHebei = config.isHebei;
    _isHubei = config.isHubei;
    serviceid = service;
    _mainguid = config.mainguid;
    _bustype = config.bustype;
    _isSX = config.isSX;
    _isZJ = config.isZJ;
    var _isAnHui = config.isAH;
    _is_JiangXi = config.is_JiangXi;

    var cmp = {};
    /**
     * 获取表的查询.
     */
    Ext.lt.message.hook("busdatatable", "drawed",function (obj) {
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
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "getPayDatas", params, function(rs){
            datatable.setDatas(rs.data);
            if(_isSX == '1' && _bustype == "dept" && typeof(dirdatatable) != "undefined" && dirdatatable != null){
                dirdatatable.setDatas(rs.data2);
            }
            setMidSaveHidButtons(rs);
            Ext.lt.ui.loadingClose();
            setTimeout(function(){
                amtTotal(datatable);
                if(_isSX == '1' && _bustype == "dept" && typeof(dirdatatable) != "undefined" && dirdatatable != null){
                    amtTotal(dirdatatable);
                }
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
            if(col["colcode"]=="amt1" || col["colcode"]=="amt2"){
                col.cseditfn = function (i, j, rs, style) {
                    if (rs.isedit == undefined || rs.isedit != "1") {
                        style = 'style="background-color:#f2f2f2;"';
                    }
                    return style;
                }
                col.oneditstart = function (table, el, l, c, d) {
                    //是否可编辑 1
                    if (d.isedit != null && d.isedit != "1") {
                        return false;
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                    var cl = table.getCol(c);
                    if(_isHebei == '1'){
                        hbfundsum(d, cl.colcode);
                    } else if (!_isAnHui && _isSX != '1' && !_isHubei){
                        var amt1 = d.amt1 ? d.amt1 : 0;
                        var amt2 = d.amt2 ? d.amt2 : 0;
                        var amt4 = d.amt4 ? d.amt4 : 0;
                        var amt3 = parseFloat(amt1) + parseFloat(amt2);
                        d.amt3 = amt3;
                        if ((!amt3 || amt3 == 0) && (!amt4 || amt4 == 0) && _isZJ){
                            d.bgtget = "100";
                        }else if (!amt3 || amt3 == 0){
                            d.bgtget = "0";
                        } else{
                            d.bgtget = ((amt4/amt3)*100).toFixed(2);
                        }
                    }
                    setTimeout(function(){
                        var tablecomp = eval(table.config.id);
                        amtTotal(tablecomp);
                    },300);
                }
            }
            if(col["colcode"]=="amt3" || col["colcode"]=="amt4"){
                col.cseditfn = function (i, j, rs, style) {
                    if (rs.isedit == undefined || rs.isedit != "1") {
                        style = 'style="background-color:#f2f2f2;"';
                    }
                    return style;
                }
                col.oneditstart = function (table, el, l, c, d) {
                    //是否可编辑 1
                    if (d.isedit != null && d.isedit != "1") {
                        return false;
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                    var cl = table.getCol(c);
                    if(_isHebei == '1'){
                        hbfundsum(d, cl.colcode);
                    } else {
                        var amt4 = d.amt4 ? d.amt4 : 0;
                        var amt3 = d.amt3 ? d.amt3 : 0;
                        if(_isSX == '1'){
                            d.amt5 = amt3 - amt4;
                        }
                        if ((!amt3 || amt3 == 0) && (!amt4 || amt4 == 0) && _isZJ){
                            d.bgtget = "100";
                        }else if (!amt3 || amt3 == 0){
                            d.bgtget = "0";
                        }else{
                            d.bgtget = ((amt4/amt3)*100).toFixed(2);
                        }

                    }
                    setTimeout(function(){
                        var tablecomp = eval(table.config.id);
                        amtTotal(tablecomp);
                    },300);
                }
            }
            if(col["colcode"]=="amt6"){
                col.cseditfn = function (i, j, rs, style) {
                    if (rs.isedit == undefined || rs.isedit != "1") {
                        style = 'style="background-color:#f2f2f2;"';
                    }
                    return style;
                }
                col.oneditstart = function (table, el, l, c, d) {
                    //是否可编辑 1
                    if (d.isedit != null && d.isedit != "1") {
                        return false;
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                    if (_isZJ){
                        var amt1 = d.amt1 ? d.amt1 : 0;
                        var amt2 = d.amt2 ? d.amt2 : 0;
                        var amt6 = typeof(d.amt6)=="undefined"?0:d.amt6;
                        var amt = d.amt4 ? d.amt4 : 0;//浙江 执行数+执行数（其他）
                        var amt3 = parseFloat(amt1) + parseFloat(amt2);
                        var amt4 = parseFloat(amt) + parseFloat(amt6);
                        d.amt3 = amt3;
                        if ((!amt4 || amt4 == 0) && (!amt3 || amt3 == 0)){
                            d.bgtget = "100";
                        }else{
                            d.bgtget = ((amt4/amt3)*100).toFixed(2);
                        }
                    }
                    setTimeout(function(){
                        var tablecomp = eval(table.config.id);
                        amtTotal(tablecomp);
                    },300);
                }
            }

            if(col["colcode"]=="amt5" || col["colcode"]=="amt7" || col["colcode"]=="amt8" || col["colcode"]=="amt9"){
                col.cseditfn = function (i, j, rs, style) {
                    if (rs.isedit == undefined || rs.isedit != "1") {
                        style = 'style="background-color:#f2f2f2;"';
                    }
                    return style;
                }
                col.oneditstart = function (table, el, l, c, d) {
                    //是否可编辑 1
                    if (d.isedit != null && d.isedit != "1") {
                        return false;
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                    setTimeout(function(){
                        var tablecomp = eval(table.config.id);
                        amtTotal(tablecomp);
                    },300);
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

    cmp.checkBgt = function(){
        var tmprow = datatable.getClockRowSet().toArray()[0];
        var totalrow = dirdatatable.getClockRowSet().toArray()[0];
        if( (tmprow.amt3 != undefined ? tmprow.amt3 : 0) != (totalrow.amt3 != undefined ? totalrow.amt3 : 0)){
            Ext.lt.ui.alert("资金来源和资金方向[全年预算数]合计金额不一致，请检查！",{timeout:1},function(){});
            return false;
        }
        if( (tmprow.amt4 != undefined ? tmprow.amt4 : 0) != (totalrow.amt4 != undefined ? totalrow.amt4 : 0)){
            Ext.lt.ui.alert("资金来源和资金方向[全年执行数]合计金额不一致，请检查！",{timeout:1},function(){});
            return false;
        }
        return true;
    }

    cmp.save = function(){
        var rns = datatable.getEditor();
        if (rns){
            datatable.closeEdit();
        }
        if (!datatable.checkAll()) return false;//先校验
        var params = {};

        var datas = datatable.getRecordSet().toArray();
        params.datas = datas;
        if(_isSX == '1' && _bustype == "dept" && typeof(dirdatatable) != "undefined" && dirdatatable != null){
            if (!dirdatatable.checkAll()) return false;//先校验
            if (!cmp.checkBgt()) return false;//校验两个资金表 amt3,amt4 合计一致
            params.datas = params.datas.concat(dirdatatable.getRecordSet().toArray());
            params.ismidsave2 = "true";
            params.url1 = datatable.config.pageurl;
            params.componentid1 = datatable.config.server;
            params.compconfigid1 = "datatable";
            params.url2 = dirdatatable.config.pageurl;
            params.componentid2 = dirdatatable.config.server;
            params.compconfigid2 = "dirdatatable";
        }else{
            params.url = datatable.config.pageurl;
            params.componentid = datatable.config.server;
            params.compconfigid = "datatable";
        }
        params.updatas = datatable.getUpdataData();
        params.deldatas = datatable.getRemoveData();
        params.tablecode = _tablecode;
        params.busguid = _busguid;
        params.saveAgency = _saveAgency;
        params.pro_code = _procode; //项目code
        params.mainguid = _mainguid;
        params.bustype = _bustype;
        if(datatable.getClockRowSet()!=null){
            params.bgtget =  datatable.getClockRowSet().getData(0).bgtget;
        }else{
            params.bgtget =  datatable.getRecordSet().getData(0).bgtget;
        }
        //校验预算执行率必须小于100
        if (params.bgtget != null && parseFloat(params.bgtget) != NaN){
            if (parseFloat(params.bgtget) > 100 && !_isZJ){ //20240401修改 浙江去掉执行率不能大于100%的校验
                Ext.lt.ui.alert("预算执行率不能超过100%！",{timeout:1},function(){});
                return false;
            }
        }
        var item;
        var bgfalg = true;
        for(var i=0; i<datas.length; i++){
            item = datas[i];
            if (item["bgtget"] && parseFloat(item["bgtget"]) > 100){
                bgfalg = false;
            }
        }
        if (!bgfalg && !_isZJ) {//20240401修改 浙江去掉执行率不能大于100%的校验
            Ext.lt.ui.alert("预算执行率不能超过100%！",{timeout:1},function(){});
            return false;
        }
        var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
        cmp.query();
        return rs;
    }

    /**
     * 暂存
     */
    cmp.savetmp = function (obj){
        var params = {};
        params.mainguid = _mainguid;
        if(_isSX == '1' && _bustype == "dept" && typeof(dirdatatable) != "undefined" && dirdatatable != null){
            params.ismidsave2 = "true";
            params.data1 = datatable.getRecordSet().toArray();
            params.url1 = datatable.config.pageurl;
            params.componentid1 = datatable.config.server;
            params.compconfigid1 = "datatable";
            params.data2 = dirdatatable.getRecordSet().toArray();
            params.url2 = dirdatatable.config.pageurl;
            params.componentid2 = dirdatatable.config.server;
            params.compconfigid2 = "dirdatatable";
        }else{
            params.data = datatable.getRecordSet().toArray();
            params.url = datatable.config.pageurl;
            params.componentid = datatable.config.server;
            params.compconfigid = "datatable";
        }
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
        params.mainguid = _mainguid;
        if(_isSX == '1' && _bustype == "dept" && typeof(dirdatatable) != "undefined" && dirdatatable != null){
            params.ismidsave2 = "true";
            params.url1 = datatable.config.pageurl;
            params.componentid1 = datatable.config.server;
            params.compconfigid1 = "datatable";
            params.url2 = dirdatatable.config.pageurl;
            params.componentid2 = dirdatatable.config.server;
            params.compconfigid2 = "dirdatatable";
        }else{
            params.url = datatable.config.pageurl;
            params.componentid = datatable.config.server;
            params.compconfigid = "datatable";
        }
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
        if (typeof(dirdatatable) != "undefined" && dirdatatable != null){
            common.initDatatable(dirdatatable);
        }
        if (_viewtype == "query") {
            try{
                $("div[compid='toolbutton']").hide();
            }catch (e){
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
            var amt4 = rowarr[i]["amt4"] ? rowarr[i]["amt4"] : 0.00;
            sumamt4 += parseFloat(amt4);
            //备用资金字段
            var amt5 = rowarr[i]["amt5"] ? rowarr[i]["amt5"] : 0;
            sumamt5 += parseFloat(amt5);
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
        totalrs["amt1"] = sumamt1 == 0 ? "0.00" : sumamt1.toFixed(2);        //年初预算
        totalrs["amt2"] = sumamt2 == 0 ? "0.00" : sumamt2.toFixed(2);        //年度调整预算
        totalrs["amt3"] = sumamt3 == 0 ? "0.00" : sumamt3.toFixed(2);        //调整后预算
        totalrs["amt4"] = sumamt4 == 0 ? "0.00" : sumamt4.toFixed(2);        //实际执行数
        totalrs["amt5"] = sumamt5 == 0 ? "0.00" : sumamt5.toFixed(2);        //备用字段
        totalrs["amt6"] = sumamt6 == 0 ? "0.00" : sumamt6.toFixed(2);        //实际执行数（其他）
        totalrs["amt7"] = sumamt7 == 0 ? "0.00" : sumamt7.toFixed(2);        //备用字段
        totalrs["amt8"] = sumamt8 == 0 ? "0.00" : sumamt8.toFixed(2);        //备用字段
        totalrs["amt9"] = sumamt9 == 0 ? "0.00" : sumamt9.toFixed(2);        //备用字段
        var amt = sumamt4;
        if (_isZJ) {
            amt = sumamt4 + sumamt6;
        }
        if (sumamt3 != 0){
            totalrs["bgtget"] = amt/sumamt3 * 100 == 0 ? "0.00" : (amt/sumamt3 * 100).toFixed(2);     //预算执行率(实际执行数+执行回溯/调整后预算)
            if(_isHubei){
                if(totalrs["bgtget"] > 100){
                    totalrs["score"] = "20";
                }else{
                    totalrs["score"] =  (totalrs["bgtget"]/100 * 20).toFixed(2);  //自评得分(预算执行率*20)
                }
            }else if(_is_JiangXi){
                //江西:执行率为100%得10分 执行率小于100%且大于等于80%的得7分；执行率小于80%且大于等于60%的得5分；执行率小于60%的不得分
                if(totalrs["bgtget"] == 100){
                    totalrs["score"] = "10";
                }else if(totalrs["bgtget"] >= 80 && totalrs["bgtget"] < 100){
                    totalrs["score"] = "7";
                }else if(totalrs["bgtget"] >= 60 && totalrs["bgtget"] < 80){
                    totalrs["score"] = "5";
                }else{
                    totalrs["score"] = "0";
                }
            } else {
                if(totalrs["bgtget"] > 100){
                    totalrs["score"] = "10";
                }else{
                    totalrs["score"] = (totalrs["bgtget"]/10).toFixed(2);  //自评得分(预算执行率*10)
                }
            }
        } else {
            // 当调整后预算和全年执行数为0，预算执行率就为100%
            if (_isZJ && amt != 0) {
                totalrs["bgtget"] = 100;
            } else {
                totalrs["bgtget"] = 0;
            }
            totalrs["score"] = "0.00";
        }
        if(_isSX == '1'){
            totalrs["amt5"]= sumamt3 - sumamt4;
        }
        totalrs["scores"] = 10;
        _bgtget = totalrs["bgtget"];
        totalrs.datatable_do_sum=true;
        table.getClockRowSet().setData(totalrs,0);
        table.reflashdata();
    }
}

//河北数值的计算
function hbfundsum (d, col){
    if(d.code == '' || d.code == undefined){
        return;
    }
    var datas;
    if(_bustype == 'program'){
        datas = datatable.getRecordset().query({code: '0'});
        if(d.code == '1' || d.code == '2'){
            //财政资金-本级安排
            var bj_sel_rows = datatable.getRecordset().query({code: '1'});
            var bj_sel_obj = bj_sel_rows[0];
            //财政资金-其中：上级补助
            var sj_sel_rows = datatable.getRecordset().query({code: '2'});
            var sj_sel_obj = sj_sel_rows[0];
            //其他
            var qt_sel_rows = datatable.getRecordset().query({code: '9'});
            var qt_sel_obj = qt_sel_rows[0];
            //财政资金 = 财政资金-本级安排 + 财政资金-其中：上级补助
            var cz_sel_rows = datatable.getRecordset().query({code: '4'});
            var cz_sel_obj = cz_sel_rows[0];
            var cz_sortid = cz_sel_obj._sortid;
            var bj_sel = bj_sel_obj==null ? 0 : bj_sel_obj[col];
            var sj_sel = sj_sel_obj==null ? 0 : sj_sel_obj[col];
            bj_sel = bj_sel==undefined ? 0 : bj_sel;
            sj_sel = sj_sel==undefined ? 0 : sj_sel;
            cz_sel_obj[col] = Number(bj_sel)+Number(sj_sel);
            datatable.reflash(cz_sortid);
            //年度资金总额
            var total_sel_rows = datatable.getRecordset().query({code: '0'});
            var total_sel_obj = total_sel_rows[0];
            var total_sortid = total_sel_obj._sortid;
            var qt_sel = qt_sel_obj==null ? 0 : qt_sel_obj[col];
            qt_sel = qt_sel==undefined ? 0 : qt_sel;
            total_sel_obj[col] = Number(bj_sel)+Number(sj_sel)+Number(qt_sel);
            datatable.reflash(total_sortid);
        }else if(d.code == '9'){
            //其他
            var qt_sel_rows = datatable.getRecordset().query({code: '9'});
            var qt_sel_obj = qt_sel_rows[0];
            //财政资金 = 财政资金-本级安排 + 财政资金-其中：上级补助
            var cz_sel_rows = datatable.getRecordset().query({code: '4'});
            var cz_sel_obj = cz_sel_rows[0];
            //年度资金总额
            var total_sel_rows = datatable.getRecordset().query({code: '0'});
            var total_sel_obj = total_sel_rows[0];
            var total_sortid = total_sel_obj._sortid;
            var cz_sel = cz_sel_obj==null ? 0 : cz_sel_obj[col];
            var qt_sel = qt_sel_obj==null ? 0 : qt_sel_obj[col];
            cz_sel = cz_sel==undefined ? 0 : cz_sel;
            qt_sel = qt_sel==undefined ? 0 : qt_sel;
            total_sel_obj[col] = Number(cz_sel)+Number(qt_sel);
            datatable.reflash(total_sortid);
        }
    }else if(_bustype == 'dept'){
        datas = datatable.getRecordset().query({code: '0'});
        //人员类项目
        var ry_sel_rows = datatable.getRecordset().query({code: '1'});
        var ry_sel_obj = ry_sel_rows[0];
        //运转类共用经费类项目
        var yz_sel_rows = datatable.getRecordset().query({code: '3'});
        var yz_sel_obj = yz_sel_rows[0];
        //其他运转类项目
        var qt_sel_rows = datatable.getRecordset().query({code: '4'});
        var qt_sel_obj = qt_sel_rows[0];
        //特定目标类项目
        var tdmb_sel_rows = datatable.getRecordset().query({code: '5'});
        var tdmb_sel_obj = tdmb_sel_rows[0];
        //资金总额 = 人员类项目 + 运转类共用经费类项目 + 其他运转类项目 + 特定目标类项目
        var total_sel_rows = datatable.getRecordset().query({code: '0'});
        var total_sel_obj = total_sel_rows[0];
        var total_sortid = total_sel_obj._sortid;
        var ry_sel = ry_sel_obj==null ? 0 : ry_sel_obj[col];
        var yz_sel = yz_sel_obj==null ? 0 : yz_sel_obj[col];
        var qt_sel = qt_sel_obj== null ? 0 : qt_sel_obj[col];
        var tdmb_sel = tdmb_sel_obj==null ? 0 : tdmb_sel_obj[col];
        ry_sel = ry_sel==undefined ? 0 : ry_sel;
        yz_sel = yz_sel==undefined ? 0 : yz_sel;
        cz_sel = cz_sel==undefined ? 0 : cz_sel;
        tdmb_sel = tdmb_sel==undefined ? 0 : tdmb_sel;
        total_sel_obj[col] = Number(ry_sel)+Number(yz_sel)+Number(qt_sel)+Number(tdmb_sel);
        datatable.reflash(total_sortid);
    }
    var params = {};
    params.warmtype = "selfbgtget";
    params.targetvalue = datas[0].amt3+"";
    params.indexval = datas[0].amt2+"";
    var selfbgtget = Ext.lt.RCP.asyncall(serviceid , "getWarn", params);
    params.warmtype = "selfscore";
    var selfscore = Ext.lt.RCP.asyncall(serviceid , "getWarn", params);
    var data = datas[0];
    var _sortid = data._sortid;
    data["bgtget"] = selfbgtget;
    data["score"] = selfscore;
    datatable.reflash(_sortid);
}