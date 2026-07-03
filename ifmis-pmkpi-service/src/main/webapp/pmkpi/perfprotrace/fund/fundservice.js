if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.protrace){
    Ext.lt.pmkpi.protrace = {};
}

var _isSX;
var _isGX;
var _isAH;
Ext.lt.pmkpi.protrace.fundservice = function(config, service){
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
        _is_tianjin = config.is_tianjin,
        _isHubei = config.isHubei,
        _queryYear = config.queryYear,//跨年查询查询年度
        _queryProvince = config.queryProvince,//跨年查询查询区划
        _defquery,//列表查询条件
        _orderby,//排序
        _tablecode;//表名
        _isSX = config.isSX;
        _isGX = config.isGX;
        _isAH = config.isAH;

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
        Ext.lt.RCP.call(service , "getDatas", params, function(rs){
            datatable.setDatas(rs.data);
            if (isquery) {
                setTimeout(function () {
                    parent._isQuery = true;
                }, 500);
            }
            if (_isSX == '1' && _bustype == "depttrace" && typeof (dirdatatable) != "undefined" && dirdatatable != null) {
                dirdatatable.setDatas(rs.data2);
            }
            setMidSaveHidButtons(rs);
            Ext.lt.ui.loadingClose();
            setTimeout(function () {
                amtTotal(datatable);
                if (_isSX == '1' && _bustype == "depttrace" && typeof (dirdatatable) != "undefined" && dirdatatable != null) {
                    amtTotal(dirdatatable);
                }
            }, 300);
        }, function () {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！', function () {
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
           /*if( col["colcode"]=="amt1" || col["colcode"]=="amt2" || col["colcode"]=="amt3"
                || col["colcode"]=="amt4" || col["colcode"]=="bgtget" || col["colcode"]=="amt5" || col["colcode"]=="amt6"){
                col.oneditstart = function(table,el,l,c,d){
                    //是否可编辑 1是2否
                    if (d.isedit != "1") {
                        return false;
                    }
                }
           }*/
            if(col["colcode"]=="bgtget"){
                col.fn = function(l,c,data,col){
                    var returnval = !data.bgtget? "" : data.bgtget+"";
                    if(returnval && returnval.indexOf(".") == 0){
                        return "<font style=\"margin-left:10px;\">" + "0"+returnval+"</font>";
                    }else{
                        return "<font style=\"margin-left:10px;\">" + returnval+"</font>";
                    }
                }
            }
            if(col["colcode"]=="amt1" || col["colcode"]=="amt2" ){
                col.cseditfn = function (i, j, rs, style) {
                    if (rs.isedit == undefined || rs.isedit != "1") {
                        style = 'style="background-color:#f2f2f2;"';
                    }
                    return style;
                }
                col.oneditstart = function(table,el,l,c,d){
                    //是否可编辑 1是2否
                    if (d.isedit != null && d.isedit != "1") {
                        return false;
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                    if(_isHbei == '1'){

                    }else if(_isSX == '1'){
                        var amt1 = d.amt1 ? d.amt1 : 0;
                        var amt2 = d.amt2 ? d.amt2 : 0;
                        var amt5 = d.amt5 ? d.amt5 : 0;
                        d.amt3 = parseFloat(amt1)+parseFloat(amt2);
                        var amt4 = d.amt4;
                        var amt3 = d.amt3;
                        //山西：监控期支出进度=监控期支出数/本年预算安排小计
                        if ((amt3 == 0 || amt3 == null) || (amt4 == 0 || amt4 == null)){
                            d.bgtget = "0";
                        }else{
                            d.bgtget = ((amt4/amt3)*100).toFixed(2);
                        }
                        //山西：监控期下达率=监控期下达数/本年预算数
                        if ((amt2 == 0 || amt2 == null) || (amt5 == 0 || amt5 == null)){
                            d.amt6 = "0";
                        }else{
                            d.amt6 = ((amt5/amt2)*100).toFixed(2);
                        }
                        amtTotal(table);
                    }else if (_isHubei =='1'){  //湖北模式，页面可编辑时，调整后预算数不自动计算
                        amtTotal(table);
                    } else if (_isAH){ //安徽模式
                        if (table.getCol(c).colcode == "amt1") {
                            var amt1 = d.amt1 ? d.amt1 : 0;
                            var amt7 = d.amt7 ? d.amt7 : 0;
                            var amt4 = d.amt4;
                            var amt = parseFloat(amt1)+parseFloat(amt7);
                            if ((amt == 0 || amt == null) || (amt4 == 0 || amt4 == null)){
                                d.bgtget = "0";
                            }else{
                                d.bgtget = ((amt4/amt)*100).toFixed(2);
                            }
                            if (_bustype == "protrace") {
                                d.amt3 = amt;
                            }
                        }
                        amtTotal(table);
                    } else {
                        var amt1 = d.amt1 ? d.amt1 : 0;
                        var amt2 = d.amt2 ? d.amt2 : 0;
                        d.amt3 = parseFloat(amt1)+parseFloat(amt2);
                        var amt4 = d.amt4;
                        var amt3 = d.amt3;
                        if ((amt3 == 0 || amt3 == null) || (amt4 == 0 || amt4 == null)){
                            d.bgtget = "0";
                        }else{
                            d.bgtget = ((amt4/amt3)*100).toFixed(2);
                        }
                        amtTotal(table);
                    }
                }
            }
            if(col["colcode"]=="amt3"){
                col.cseditfn = function (i, j, rs, style) {
                    if (rs.isedit == undefined || rs.isedit != "1") {
                        style = 'style="background-color:#f2f2f2;"';
                    }
                    return style;
                }
                col.oneditstart = function(table,el,l,c,d){
                    //是否可编辑 1是2否
                    if (d.isedit != null && d.isedit != "1") {
                        return false;
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                    if(_isHbei == '1'){
                        Ext.lt.pmkpi.fundsum(d, "amt3");
                    }else {
                        var amt4 = d.amt4;
                        var amt3 = d.amt3;
                        if ((amt3 == 0 || amt3 == null) || (amt4 == 0 || amt4 == null)){
                            d.bgtget = "0";
                        }else{
                            d.bgtget = ((amt4/amt3)*100).toFixed(2);
                        }
                        amtTotal(table);
                    }
                }
            }
            if(col["colcode"]=="amt4"){
                col.cseditfn = function (i, j, rs, style) {
                    if (rs.isedit == undefined || rs.isedit != "1") {
                        style = 'style="background-color:#f2f2f2;"';
                    }
                    return style;
                }
                col.oneditstart = function(table,el,l,c,d){
                    //是否可编辑 1是2否
                    if (d.isedit != null && d.isedit != "1") {
                        return false;
                    }

                }
                col.oneditend = function (table, el, l, c, d) {
                    if(_isHbei == '1'){
                        Ext.lt.pmkpi.fundsum(d, "amt4");
                    }else if (_isZJ == '1'){
                        var amt3 = d.amt3 ? d.amt3 : 0;
                        var amt4 = d.amt4 ? d.amt4 : 0;
                        var amt6 = d.amt6 ? d.amt6 : 0;
                        var amt = parseFloat(amt4) + parseFloat(amt6);
                        if ((amt3 == 0 || amt3 == null) || (amt == 0 || amt == null)){
                            d.bgtget = "0";
                        }else{
                            d.bgtget = ((amt/amt3)*100).toFixed(2);
                        }
                        amtTotal(table);
                    } else {
                        var amt4 = d.amt4;
                        var amt3 = d.amt3;
                        if ((amt3 == 0 || amt3 == null) || (amt4 == 0 || amt4 == null)){
                            d.bgtget = "0";
                        }else{
                            d.bgtget = ((amt4/amt3)*100).toFixed(2);
                        }
                        amtTotal(table);
                    }
                }
            }
            if(col["colcode"]=="amt5"){
                col.cseditfn = function (i, j, rs, style) {
                    if (rs.isedit == undefined || rs.isedit != "1") {
                        style = 'style="background-color:#f2f2f2;"';
                    }
                    return style;
                }
                col.oneditstart = function(table,el,l,c,d){
                    //是否可编辑 1是2否
                    if (d.isedit != null && d.isedit != "1") {
                        return false;
                    }
                }
                col.oneditend = function(table,el,l,c,d){
                    if(_isHbei == '1'){
                        Ext.lt.pmkpi.fundsum(d, "amt5");
                        Ext.lt.pmkpi.warn(d);
                    }else if(_isSX == '1'){
                        //山西：监控期下达率=监控期下达数/本年预算数
                        var amt5 = d.amt5;
                        var amt2 = d.amt2;
                        if ((amt2 == 0 || amt2 == null) || (amt5 == 0 || amt5 == null)){
                            d.amt6 = "0";
                        }else{
                            d.amt6 = ((amt5/amt2)*100).toFixed(2);
                        }
                        amtTotal(table);
                    }else{
                        Ext.lt.pmkpi.fundsum(d, "amt5");
                        Ext.lt.pmkpi.warn(d);
                    }
                }
            }
            if(col["colcode"]=="amt6"){
               /* col.fn = function(l,c,data,col){
                    var returnval = !data.amt6? "" : data.amt6+"";
                    if(returnval && returnval.indexOf(".") == 0){
                        return "<font style=\"margin-left:10px;\">" + "0"+returnval+"</font>";
                    }else{
                        return "<font style=\"margin-left:10px;\">" + returnval+"</font>";
                    }
                }*/
                col.cseditfn = function (i, j, rs, style) {
                    if (rs.isedit == undefined || rs.isedit != "1") {
                        style = 'style="background-color:#f2f2f2;"';
                    }
                    return style;
                }
                col.oneditstart = function(table,el,l,c,d){
                    //是否可编辑 1是2否
                    if(_is_tianjin == '1'){  //可编辑
                        if (d.isedit != null && d.isedit == "1" && (d.name != "年度资金总额" || d.name != "财政资金")) {
                            return true;
                        }else {
                            return false;
                        }
                    }else{
                        if (d.isedit != null && d.isedit != "1") {
                            return false;
                        }
                    }
                }
                col.oneditend = function(table,el,l,c,d){
                    if(_isHbei == '1'){
                        Ext.lt.pmkpi.fundsum(d, "amt6");
                    }else if(_isGX == '1'){
                        var amt6 = d.amt6;
                        var amt7 = d.amt7;
                        if ((amt6 == 0 || amt6 == null) || (amt7 == 0 || amt7 == null)){
                            d.amt8 = "0";
                        }else{
                            d.amt8 = ((amt6/amt7)*100).toFixed(2);
                        }
                        amtTotal(table);
                    }else if (_isZJ == '1'){
                        var amt3 = d.amt3 ? d.amt3 : 0;
                        var amt4 = d.amt4 ? d.amt4 : 0;
                        var amt6 = d.amt6 ? d.amt6 : 0;
                        var amt = parseFloat(amt4) + parseFloat(amt6);
                        if ((amt3 == 0 || amt3 == null) || (amt == 0 || amt == null)){
                            d.bgtget = "0";
                        }else{
                            d.bgtget = ((amt/amt3)*100).toFixed(2);
                        }
                        amtTotal(table);
                    }else {
                        amtTotal(table);
                    }
                }
            }

            if(col["colcode"]=="amt7") {
                col.cseditfn = function (i, j, rs, style) {
                    if (rs.isedit == undefined || rs.isedit != "1") {
                        style = 'style="background-color:#f2f2f2;"';
                    }
                    return style;
                }
                col.oneditstart = function (table, el, l, c, d) {
                    //是否可编辑 1是2否
                    if (d.isedit != null && d.isedit != "1") {
                        return false;
                    }
                    amtTotal(table);
                }
                col.oneditend = function(table,el,l,c,d){
                    if(_isGX == '1'){
                        var amt6 = d.amt6;
                        var amt7 = d.amt7;
                        if ((amt6 == 0 || amt6 == null) || (amt7 == 0 || amt7 == null)){
                            d.amt8 = "0";
                        }else{
                            d.amt8 = ((amt6/amt7)*100).toFixed(2);
                        }
                        amtTotal(table);
                    } else if (_isAH){ //安徽模式
                        var amt1 = d.amt1 ? d.amt1 : 0;
                        var amt7 = d.amt7 ? d.amt7 : 0;
                        var amt = parseFloat(amt1)+parseFloat(amt7);
                        var amt4 = d.amt4;
                        if ((amt == 0 || amt == null) || (amt4 == 0 || amt4 == null)){
                            d.bgtget = "0";
                        }else{
                            d.bgtget = ((amt4/amt)*100).toFixed(2);
                        }
                        if (_bustype == "protrace") {
                            d.amt3 = amt;
                        }
                        amtTotal(table);
                    } else {
                        amtTotal(table);
                    }
                }
            }

            if(col["colcode"]=="amt8" || col["colcode"]=="amt9") {
                col.cseditfn = function (i, j, rs, style) {
                    if (rs.isedit == undefined || rs.isedit != "1") {
                        style = 'style="background-color:#f2f2f2;"';
                    }
                    return style;
                }
                col.oneditstart = function (table, el, l, c, d) {
                    //是否可编辑 1是2否
                    if (d.isedit != null && d.isedit != "1") {
                        return false;
                    }
                    amtTotal(table);
                }
                col.oneditend = function(table,el,l,c,d){
                    amtTotal(table);
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
        var rns = datatable.getEditor();
        if (rns){
            datatable.closeEdit();
        }
       if (!cmp.checkAllDatas()){return ;} //先校验
        var params = {};
        var datas = datatable.getRecordSet().toArray();
        if(!datas || datas.length == 0) {
            params.success = true;
            return params;
        }
        params.datas = datas;
        if(_isSX == '1' && _bustype == "depttrace" && typeof(dirdatatable) != "undefined" && dirdatatable != null){
            if (!cmp.checkBgt()) return false;//校验两个资金表 amt1,amt4,amt5,amt7 合计一致
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
        params.tablecode = _tablecode;
        params.busguid = _busguid;
        params.mainguid = _mainguid;
        params.saveAgency = _saveAgency;
        params.taskguid = _taskguid;
        params.proguid = _proguid;
        params.procode = _procode;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(service , "save", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            Ext.lt.pmkpi.query();
        }
        return rs;
    }
    /**
     * 山西校验：预算执行情况资金来源和资金方向合计金额一致
     */
    cmp.checkBgt = function(){
        var tmprow = datatable.getClockRowSet().toArray()[0];
        var totalrow = dirdatatable.getClockRowSet().toArray()[0];
        if( (tmprow.amt1 != undefined ? tmprow.amt1 : 0) != (totalrow.amt1 != undefined ? totalrow.amt1 : 0)){
            Ext.lt.ui.alert("资金来源和资金方向[上年结转]合计金额不一致，请检查！",{timeout:1},function(){});
            return false;
        }
        if( (tmprow.amt4 != undefined ? tmprow.amt4 : 0) != (totalrow.amt4 != undefined ? totalrow.amt4 : 0)){
            Ext.lt.ui.alert("资金来源和资金方向[监控期支出数]合计金额不一致，请检查！",{timeout:1},function(){});
            return false;
        }
        if( (tmprow.amt5 != undefined ? tmprow.amt5 : 0) != (totalrow.amt5 != undefined ? totalrow.amt5 : 0)){
            Ext.lt.ui.alert("资金来源和资金方向[监控期下达数]合计金额不一致，请检查！",{timeout:1},function(){});
            return false;
        }
        if( (tmprow.amt7 != undefined ? tmprow.amt7 : 0) != (totalrow.amt7 != undefined ? totalrow.amt7 : 0)){
            Ext.lt.ui.alert("资金来源和资金方向[全年预计支出数]合计金额不一致，请检查！",{timeout:1},function(){});
            return false;
        }
        return true;
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
        params.mainguid = _mainguid;
        if(_isSX == '1' && _bustype == "depttrace" && typeof(dirdatatable) != "undefined" && dirdatatable != null){
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
        params.mainguid = _mainguid;
        if(_isSX == '1' && _bustype == "depttrace" && typeof(dirdatatable) != "undefined" && dirdatatable != null){
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
        /*var params = {};
        params.warmtype = "bgtgetwarn";
        params.mainguid = d.guid;
        params.targetvalue = d.amt5;
        params.indexval = d.amt4;
        var warndata = Ext.lt.RCP.asyncall(service , "getWarn", params);
        var parent_sel_rows = datatable.getRecordset().query({guid:d.guid});
        var parent_sel_obj = parent_sel_rows[0];
        var _sortid = parent_sel_obj._sortid;
        parent_sel_obj["bgtget"] = warndata;
        datatable.reflash(_sortid);*/
    }

    //河北数值的计算
    Ext.lt.pmkpi.fundsum = function (d, col){
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
            var bj_sel = bj_sel_obj[col]==null ? 0 : bj_sel_obj[col];
            var sj_sel = sj_sel_obj[col]==null ? 0 : sj_sel_obj[col];
            cz_sel_obj[col] = Number(bj_sel)+Number(sj_sel);
            datatable.reflash(cz_sortid);
            //年度资金总额
            var total_sel_rows = datatable.getRecordset().query({code: '3'});
            var total_sel_obj = total_sel_rows[0];
            var total_sortid = total_sel_obj._sortid;
            var qt_sel = qt_sel_obj[col]==null ? 0 : qt_sel_obj[col];
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
            var total_sel_rows = datatable.getRecordset().query({code: '3'});
            var total_sel_obj = total_sel_rows[0];
            var total_sortid = total_sel_obj._sortid;
            var cz_sel = cz_sel_obj[col]==null ? 0 : cz_sel_obj[col];
            var qt_sel = qt_sel_obj[col]==null ? 0 : qt_sel_obj[col];
            total_sel_obj[col] = Number(cz_sel)+Number(qt_sel);
            datatable.reflash(total_sortid);
        }
    }

    Ext.lt.pmkpi.fund = function (params){
        var params = params;
        params.proguid = _proguid;
        params.agencyguid = _saveAgency;
        var warndata = Ext.lt.RCP.asyncall(service , "getWarn", params);
        return warndata;
    }

    //校验必填字段
   cmp.checkAllDatas = function () {
       var datas = datatable.getRecordSet().toArray();
       var cols = datatable.getCols();
       for (var i = 0,leni = datas.length; i < leni; i++) {
           for (var j = 0,lenj = cols.length; j < lenj; j++) {
               if (cols[j].requirement == '1') {
                   var value = datas[i][cols[j].colcode];
                   if (value == null || value === "" || ("" + value).trim().length == 0) {
                       alert("第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "为必录项，必须有值！");
                       return false;
                   }
               }
           }

       }
       return true;
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
        if (_isAH) {
            sumamt3 = sumamt1 + sumamt7;
        }
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
        if(_isGX == '1'){
            if (sumamt7 != 0){
                totalrs["amt8"] = sumamt6/sumamt7*100 == 0 ? "" : ((sumamt6/sumamt7)*100).toFixed(2);     //广西：资金到位率=实际到位资金/计划投入资金*100%
            }else{
                totalrs["amt8"] = "0";
            }
        }
        totalrs.datatable_do_sum=true;
        table.getClockRowSet().setData(totalrs,0);
        //if((totalrow.size&&totalrow.size()>0)||(totalrow.length&&totalrow.length>0)){
            table.reflashdata();
        //}
    }
}