if(!Ext)
    Ext = {};
if(!Ext.lt)
    Ext.lt = {};
if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
/**
 * 初始化加载.
 */
var _prolev;
var _saveAgency;
var _curtab = ""; //当前页签.
var tabcomps;
var showtab;
var zcolumns = {};
var _procode;
Ext.lt.pmkpi.transferindex = function(config, serviceid) {
    var perfcommon = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var _proguid = config["proguid"];
    var _viewtype = config["viewtype"]; //修改还是查看
    var state = config["state"];//页面是否可修改 1新增 2修改，3查看
    _saveAgency = config["saveAgency"]; //项目单位
    _procode = config["procode"];//项目编码
    var _isnewapply = config.isnewapply; // 是否新填报方式
    var _signs = config["signs"];//指标符号
    var _kpivals = config["kpivals"]; //合肥定量其他值.
    var _kpicalnotapply = config["kpicalnotapply"];//不适用
    ismergeindex = config["ismergeindex"];//指标值是否合并单位符号
    var ismergeindex = config["ismergeindex"];//指标值是否合并单位符号
    var indexIsAddrow = config.indexIsAddrow;//指标是否是新增行，1是 其他否
    isZJ = config["isZJ"];//标识是否是浙江（1.浙江）
    isGx = config["isGx"];//标识是否是广西（1.浙江）

    var _busguid = config.busguid;//审核定义guid
    _prolev = config["prolev"]; //项目等级123级项目
    var _cmp = {};
    tabcomps = config["indexdata"]; //总体的指标数据.
    tabcomps["del#total"] = []; //总体删除
    tabcomps["del#year"] = []; //年度删除
    var iframeurl = config.iframeurl;//嵌套url
    showtab = config.showtab; //页签展示

    var hideIframeHtml = "";
    height = document.documentElement.clientHeight * 0.9;
    width = document.documentElement.clientWidth * 0.9;
    if (height < 450) {
        height = 450;
    }
    if (width < 800) {
        width = 1000;
    }
    var _isedittotal = config["isedittotal"]; //总体指标是否可编辑
    var tabnum = 0; //页签点击次数
    var pdmsave = config.pdmsave;//暂存方法.
    if (iframeurl && iframeurl != "") {
        var url = document.location.protocol+"//"+ document.location.host +"/"+ iframeurl;
        url = Ext.lt.pmkpi.genPageUrl(url, null);
        hideIframeHtml = "<iframe scrolling='no' frameborder=0 style='display: none' src =' " + url + " '></iframe>";
    }
    var isFirst = true;
    var isfirsttab;

    //页面加载完成后执行
    $(function() {
        perfcommon.initDatatable();
        //_cmp.init();
        if(hideIframeHtml != null && hideIframeHtml != ""){
            $("#datatable").append(hideIframeHtml);
        }
        var tempdata = tabcomps["#"+_curtab];
        datatable.setDatas(tempdata);
        _cmp.setTableColum();
        parent._isQuery = true;
    });

    /**
     * 点击页签.
     */
    _cmp.clickTabpage = function(obj){
        if (isFirst) {
            isfirsttab = obj.code;
            isFirst = false;
        }
        if(tabnum != 0  && _curtab != obj.code && showtab != 3){
            var num = 1;
            if (_curtab == isfirsttab){
                num = 0;
            }
            if ((_viewtype != "query" || state != "3" ) && !_cmp.checkAll()) {
                tabpage.doActiveTab(num);
                return;//先校验
            }
            var tempdata =  datatable.getRecordSet().toArray();
            if (obj.code == "year"){
                tabcomps["#total"] =Ext.lt.cloneobj(tempdata);
            } else {
                tabcomps["#year"] =Ext.lt.cloneobj(tempdata);
            }
            var tempdata = tabcomps["#"+obj.code];
            datatable.setDatas(tempdata);
        }
        _curtab = obj.code;
        tabnum ++;
        $("div[compid='toolbutton']").show();
        if (state == "3" && _curtab == "total" || _viewtype == "query") {
        //if (_viewtype == "query") {
            $("div[compid='toolbutton']").hide();
        }
        if (_isedittotal == "1" && _curtab == "total" || _viewtype == "query") {
            $("div[compid='toolbutton']").hide();
        }
        _cmp.setTableColum();
    }

    /**
     * 复制上年指标.
     */
    _cmp.lastyear = function(){
        //先将页面数据删除
        var olddatas = datatable.getRecordSet().toArray();
        var deldatas = [];
        var fdata = [];
        for(var i=0; i<olddatas.length; i++) {
            if(olddatas[i].levelno ==3){
                deldatas.push(olddatas[i]);
            } else {
                fdata.push(olddatas[i]);
            }
        }
        datatable.removeData(deldatas);
        //查询上年度指标
        var params = {};
        params.saveAgency = _saveAgency; //项目单位
        params.prolev = _prolev;//项目级别 123
        params.proguid = _proguid;
        params.procode = _procode;
        var datas = Ext.lt.RCP.asyncall(serviceid, "lastYearIndex", params);
        for(var i=0; i<datas.length; i++) {
            var data = datas[i];
            data.guid = getCreateguid(serviceid);
            data.rowtype = "add";
            data.levelno = 3;
            data.isleaf = 1;
            data._isleaf = 1;
            tabcomps["#year"].push(data);
        }
        if (_curtab == "year" && datas.length > 0) {
            var zbxs_source = [];
            for(var i=0; i<_signs.length; i++){
                var temparr = [];
                temparr.push(_signs[i]["guid"]);
                temparr.push(_signs[i]["code"]);
                temparr.push(_signs[i]["name"]);
                zbxs_source.push(temparr);
            }
            datatable.addMapperDatas("computesign", zbxs_source);
            datatable.getRecordSet().addData(datas);
        } else {
            tabcomps["#year"] = fdata;
        }

    }


    /**
     * 复制总体指标
     */
    _cmp.copy = function (obj) {
        var btnname = obj.name;
        var btncode = obj.code;
        Ext.lt.ui.confirm("是否" + btnname + "到年度绩效指标？", {icon: "warn"}, function (ret) {
            if (ret) {
                var data = tabcomps["#total"];
                setYeardata(data,btncode);
            }
        });
    }

    function setYeardata(data) {
        var yeardatas = Ext.lt.cloneobj(data);
        var pageindex = datatable.getRecordset().toArray();
        for (var j = 0; j < yeardatas.length; j++) {
            for (var i = 0; i < pageindex.length; i++) {
                if (yeardatas[j].levelno == 3 && pageindex[i].levelno == 3 && yeardatas[j].name == pageindex[i].name) {
                    yeardatas.remove(yeardatas[j]);
                }
            }
        }
        for (var i = 0; i < yeardatas.length; i++) {
            if (yeardatas[i].levelno == 3){
                var params = {};
                for (var key in yeardatas[i]) {
                    params[key] = yeardatas[i][key];
                }
                params.rowtype = "add";
                params.yearflag = "0";
                params.perf_obj_type_code = "2";
                params.perf_obj_type_name = "项目年度绩效";
                params.isfixed = "";
                params['guid'] = createUUID().replace(/-/g, '');
                tabcomps["#year"].push(params);
            }
        }
        Ext.lt.ui.alert("复制成功！", function () {
            if (_curtab == "year") {
                var tempdata = tabcomps["#" + _curtab];
                datatable.setDatas(tempdata);
            }
        });
    }

    /**
     * 保存方法.
     */
    _cmp.save = function(obj){
        if (!_cmp.checkAll()) return;//先校验
        //保存之前存放当前最后一次
        var tempdata =  datatable.getAllData();
        tabcomps["#"+_curtab] =Ext.lt.cloneobj(tempdata);
        var params = {};
        params.projguid = _proguid;
        params.datas = tabcomps;
        params.saveAgency = _saveAgency;
        params.busguid = _busguid;
        params.prolev = _prolev;//项目级别 123
        params.showtab = showtab; //展示的目标数
        params.procode = _procode; //项目编码
        params.isedittotal = _isedittotal;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid , "saveIndex", params);
        Ext.lt.ui.loadingClose();
        if(rs && rs.success){
            //_cmp.init();
        }
        return rs;
    }

    /**
     * 新增
     */
/*    _cmp.add = function(obj,selguid){
        var data = [];
        if (!selguid) {
            data = _cmp.getSeletdata("1");
            if(data.length != 1){
                Ext.lt.ui.alert("请选择一条二级指标！",function(){});
                return;
            }
        } else {
            data = datatable.getRecordset().query({guid:selguid});
        }
        var _sortid = data[0]._sortid;
        if (data[0][FOLDING_FILED] == 'close') {
            data[0][FOLDING_FILED] = 'open';
            datatable.getViewRecordSet().showChildren(data[0], _sortid);
        }
        var url = '/pmkpi/program/prjindex/editindex.page';
        var params = {};
        params.saveAgency = _saveAgency; //项目单位
        params.prolev = _prolev;//项目级别 123
        params.sindex = data[0].sindex;
        params.upguid = data[0].guid;
        params.type = "add";
        params.fromtype = "tree";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url,width,height,"新增指标");
    }*/

    /**
     * 新增行
     */
/*    _cmp.addrow = function(selguid){
        var data = datatable.getRecordset().query({guid:selguid});
        var _sortid = data[0]._sortid;
        if (data[0][FOLDING_FILED] == 'close') {
            data[0][FOLDING_FILED] = 'open';
            datatable.getViewRecordSet().showChildren(data[0], _sortid);
        }
        var indexdata = {};
        indexdata.guid = createUUID().replace(/-/g, '');
        indexdata.saveAgency = _saveAgency; //项目单位
        indexdata.sindex = data[0].sindex;
        indexdata.findex = data[0].findex;
        indexdata.superid = data[0].sindex;
        indexdata.levelno = 3;
        indexdata.isleaf = 1;
        indexdata._isleaf = 1;
        indexdata.rowtype = "add";
        datatable.getRecordSet().addData(indexdata,_sortid + datatable.getRecordset().toArray().length);
    }*/



    /**
     * 重画表格列.
     */
    Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
        var uiconfig = obj.table.uiconfig;
        zcolumns = uiconfig.columns;
        var cols = obj.cols;
        var upcols = [];
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(col["colcode"]=="indexval"){
                upcols.push(col["colcode"]);
                col.fn = function(l,c,data,col){
                    if(data.computesign == "6"|| data.computesign == "9" || data.computesign == "10" || ismergeindex != "1"){
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
                    if (_isedittotal == "1" && _curtab == "total") {
                        return false;
                    }
                    if(d.levelno != "3"){
                        return false;
                    }
                    if(_isnewapply=="true" && d.value_change == "2"){ // 四个部门是否可编辑规则
                        return false;
                    }
                    if(d.computesign == "9"){ //合肥添加定量其他
                        doMapper(_kpivals,table.getCol(c));
                        this.config.isMulti = false;
                        return;
                    }else if(d.computesign == "10"){
                        doMapper(_kpicalnotapply,table.getCol(c));
                        this.config.isMulti = false;
                        return;
                    } else {
                        el.innerText =  d.indexval!=undefined ? d.indexval : '';
                        table.getCol(c).mapping = null;
                        table.nowtype="input";
                        table.getCol(c).format = "";
                    }
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
                        var computesign = d.computesign;
                        if (!d.computesign) {
                            Ext.lt.ui.alert("请先选择计算符号！",{timeout:1},function(){});
                            d.indexval = '';
                            return false;
                        }
                    }
                    if(d.levelno == "3" && d.rowtype!="add"){
                        d.rowtype ="mod";
                    }
                    if(d.computesign == "9"){
                        d["kpivalsource"] = d["indexval"];
                    }
                }
            }

            if(col["colcode"]=="obligate1"){
                if (_viewtype != "query" || state != "3"){
                    col.style = " text-align:center;";
                    col.fn = function(l,c,data,col){
                        var html = "";
                        if(data.levelno == "2"){
                            if (indexIsAddrow) {
                                html += '<a title = "新增" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:prjtreeindex.add("","'+data.guid+'")\'>新增</a>';
                            } else {
                                html += '<a title = "新增" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:prjtreeindex.addrow("'+data.guid+'")\'>新增</a>';
                            }
                        } else if(data.levelno == "3"){
                            html = '<a title = "删除" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:prjtreeindex.del("","'+data.guid+'")\'>删除</a>';
                        }
                        if((_isedittotal == "1" && _curtab == "total") || _isnewapply=="true"){
                            return "";
                        }else{
                            return html;
                        }
                    }
                } else {
                    col.isvisiable = 0;
                }
            }
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
                    gatherWeight(d.superid);
                    amtTotal(datatable);
                }
            }
            if(col["colcode"]=="computesign"){
                upcols.push(col["colcode"]);
                col.oneditstart = function (table, el, l, c, d) {
                    if(d.levelno != "3" || (_isedittotal == "1" && _curtab == "total")){
                        return false;
                    }
                    if(_isnewapply=="true"){ // 四个部门不可编辑
                        return false;
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                    if(d.computesign && d.computesign != '6' && d.computesign != "9"  && d.computesign != "10"){
                        if(d.indexval && !checkReferencepole(d.indexval)){
                            d.indexval = '';
                            d.meterunit = '';
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
                            d.meterunit = '';
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
                            d.meterunit = '';
                            return false;
                        }
                    } else if (d.computesign && d.computesign == "6") {
                        d.indexval = '';
                        d.meterunit = '';
                        return false;
                    } else if (!d.computesign || d.computesign == "") {
                        d.indexval = '';
                        d.meterunit = '';
                        return false;
                    }
                }
            }
            if(col["colcode"]=="name" || col["colcode"]=="meterunit" || col["colcode"]=="kpi_remark"){
                upcols.push(col["colcode"]);
                col.oneditstart = function (table, el, l, c, d) {
                    if(d.levelno != "3" || (_isedittotal == "1" && _curtab == "total")){
                        return false;
                    }
                    if(_isnewapply=="true"){ // 四个部门不可编辑
                        return false;
                    }
                }
            }
            if (state == "3" && !config[col.colcode]  && col["name"] != "check") {
                col.style = "background-color:#f2f2f2;";
                col.oneditstart = function (table, e, l, c, d) {
                    return false;
                }
            }

        }
        if (_viewtype != 'query' || state != "3") {
            for(var i=0; i<cols.length; i++){
                if (cols[i]["colcode"] && cols[i]["isvisiable"] == 1) {
                    var iscol = false;
                    for (var j=0; j<upcols.length; j++) {
                        if (cols[i]["colcode"] == upcols[j]) {
                            iscol = true;
                            break;
                        }
                    }
                    if (!iscol) {
                        cols[i].oneditstart = function (table, e, l, c, d) {
                            if(d.levelno != "3" || (_isedittotal == "1" && _curtab == "total")){
                                return false;
                            }
                        }
                    }
                }
            }
        }
    })

        function gatherWeight(superid){
            var datas = datatable.getRecordSet().toArray();
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
                    gatherWeight(supguid);
                    amtTotal(datatable);
                }
            }
            datatable.reflash();
        }
        function initgatherWeight(){
            var data = datatable.getRecordSet().toArray();
            var datas = data;
            var superid;
            for(var i = 0; i < data.length; i++){
                var selectData = data[i];
                if(selectData.levelno == '3'){
                    superid = selectData.superid;
                    gatherWeight(superid);
                }
            }
            amtTotal(datatable);
            datatable.reflash();
        }

    /**
     * 表格的选择行.
     * @param type 1:包含二级，2 只有末级
     */
    _cmp.getSeletdata = function(type){
        var _datas = datatable.getRecordSet().toArray();
        var seldata = [];
        var len = _datas.length;
        for ( var i = 0; i < len; i++) {
            if ("1" == type){
                if(_datas[i]["check"] == 1 && _datas[i]["levelno"] != 1){
                    seldata.push(_datas[i]);
                }
            } else if ("2" == type){
                if(_datas[i]["check"] == 1 && _datas[i]["levelno"] == 3){
                    seldata.push(_datas[i]);
                }
            } else {
                seldata.push(_datas[i]);
            }
        }
        return seldata;
    }
    /**
     * 表格填报数据的校验方法.
     * @returns {boolean}
     */
    _cmp.checkAll = function() {
        var datas = datatable.getRecordSet().toArray();
        var cols = datatable.getCols();
        for (var i = 0,leni = datas.length; i < leni; i++) {
            if (datas[i]["levelno"] == 3) {
                if(datas[i].computesign != 6 && datas[i].computesign != 9 && datas[i].computesign != 10 && (!datas[i].meterunit || datas[i].meterunit == "")){
                    Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的计量单位为必录项，必须有值。",{timeout:1},function(){});
                    return;
                }
                if(datas[i]['computesign'] == '9' && (!datas[i].value_remark || datas[i].value_remark == '')){
                    Ext.lt.ui.alert("计算符号选择“定量（其他）”时，指标值说明必填！",{timeout:1},function(){});
                    return;
                }
            }
            for (var j = 0,lenj = cols.length; j < lenj; j++) {
                if (cols[j].requirement == '1' && datas[i]["levelno"] == 3) {
                    // if(_isnewapply=="true" && datas[i]["value_change"] == "2"){ // 四个部门固定值不可更改，所以跳过校验
                    //     return true;
                    // }
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
     *
     * @param superids -- 要判断的二级.
     */
    _cmp.upSuperIslef = function(superids){
        var datas = datatable.getRecordSet().toArray();
        var isUpdate = true;
        if(datas!=null && datas.length > 0){
            var lev2arr = [];
            var seltDatas = {};
            for(var i=0;i<datas.length;i++){
                seltDatas = datas[i];
                if(seltDatas.superid != "" && seltDatas.levelno == 3 && lev2arr.indexOf(seltDatas["superid"]) < 0){
                    lev2arr.push(seltDatas.superid);
                }
            }
            if (superids.length > 0) {
                var suprow = {};
                for(var i=0;i<superids.length;i++){
                    gatherWeight(superids[i]);
                    if (lev2arr.indexOf(superids[i]) < 0){
                        suprow = datatable.getRecordset().query({guid:superids[i]})[0];
                        suprow['isleaf'] = '1';
                        suprow['_isleaf'] = '1';
                        var _sortid = suprow._sortid;
                        datatable.reflash(_sortid);
                    }
                }
                //datatable.reflash();
            }
        }
    }

    Ext.lt.pmkpi.query = function () {
        _cmp.init();
    };


        /**
         * 重新构建表格.
         */
        _cmp.refdrawtable = function(obj){
            // var oldcols = datatable.getColumns();
            var oldcols = zcolumns;
            datatable.columns.checkbox.style = "text-align:center";
            var columns = [datatable.columns.seq,datatable.columns.checkbox];
            $.each(oldcols, function(i, item){
                if(item){
                    if (obj.code == "total"){//实施期
                        if (item.config["columncode"]&&item["config"]["columncode"] == "zqindexval"){
                            item.display = false;
                            item.isvisiable = 0;
                        }
                    }

                    if (obj.code == "year"){//年度
                        if (item.config["columncode"]&&item["config"]["columncode"] == "zqindexval"){
                            item.display = true;
                            item.isvisiable = 1;
                        }
                    }
                    columns.push(item);
                }
            });
            Ext.lt.cache.removeData("dtcolumn_" + datatable.id);
            datatable.setCols(columns);
            datatable.setDatas([]);
            datatable.setSelfdefconfig({config: "{}"});
            datatable.redraw();
        }

        var _displaycols = [];
        /**
         * 动态配置表格的列.
         *
         * @param data --
         */
        _cmp.setTableColum = function(){
            var cols = datatable.getCols(); //获取列表所有列
            cols.push.apply(cols, _displaycols);
            _displaycols = [];
            for (var i = 0, len = cols.length; i < len; i++) {
                var col = cols[i];
                if (col.colcode == "opinion_remark") {
                    col.edit = config[col.colcode];
                }
                if (_viewtype == "query" || state == "3" || (_isedittotal == "1" && _curtab == "total")) {
                    if (col.colcode == "obligate1") {
                        _displaycols.push(col); //隐藏前暂存至sfagency;
                        col.display = false; //display置为false，隐藏
                    }
                } else if (col.colcode == "obligate1") {
                    col.display = true;
                }
            }
            datatable.setSelfdefconfig({config: "{}"});
            datatable.redraw(); //从新绘制表格
        }


        //重画合计行，赋予新颜色
        Ext.lt.message.hook('datatable','buildLineStyle',function(paramobj){
            var rowdata = paramobj.rowdata;
            if(rowdata.levelno != 3 || (_isedittotal == "1" && _curtab == "total")){
                paramobj.style=' style="background: #e9f0f"';
                paramobj.selfdefcolor = true;
            }
        });

    return _cmp;


}

/**
 * 动态改变列的属性.
 * @param rs
 * @param col
 */
function doMapper(rs,col){
    var mapping = [];
    var columns = [];
    for(var i =0; i<rs.size() ; i++){
        var arr = [];
        arr.push(rs[i].guid);
        arr.push(rs[i].code);
        arr.push(rs[i].name);
        columns.push(arr);
        mapping[rs[i].code] = arr;
    }
    col.mapping = mapping;
    col.mapper = {} ;
    col.mapper.columns = ['guid','code','name','supcode','pinyin'];
    col.mapper.datas = columns ;
    col.mapper.regs = ['#guid','#code','#name','#supcode','#pinyin'];
    col.mapper.default_column = 'code';
    col.format = '#name';
}

function amtTotal(table) {
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
