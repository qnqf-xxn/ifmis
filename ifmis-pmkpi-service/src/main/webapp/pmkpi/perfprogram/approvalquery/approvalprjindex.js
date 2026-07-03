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
    Ext.lt.pmkpi.approvalprjindex = function(config, serviceid) {
    var perfcommon = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var _proguid = config["proguid"];
    var _viewtype = config["viewtype"]; //修改还是查看
    _saveAgency = config["saveAgency"]; //项目单位
    _procode = config["procode"];//项目编码
    var _isnewapply = config.isnewapply; // 是否新填报方式
    var _signs = config["signs"];//指标符号
    var frametype = config.frametype;//层次分了类型
    var _kpivals = config["kpivals"]; //合肥定量其他值.
    var _kpicalnotapply = config["kpicalnotapply"];//不适用
    var ismergeindex = config["ismergeindex"];//指标值是否合并单位符号
    var indexIsAddrow = config.indexIsAddrow;//指标是否是新增行，1是 其他否
    _prolev = config["prolev"]; //项目等级123级项目
    var _cmp = {};
    tabcomps = config["indexdata"]; //总体的指标数据.
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
        if (_viewtype == "query") {
            $("div[compid='toolbutton']").hide();
        }
        var tempdata = tabcomps["#"+_curtab];
        datatable.setDatas(tempdata);
        _cmp.setTableColum();
        parent._isQuery = true;
        _cmp.bulidTopHead();
    });

        /**
         * tabpage转radio
         */
        _cmp.bulidTopHead = function (){
            var tabpagedatas = tabpage.cfg.data;
            $("#tabpage").hide();
            var topheadHtml = [];
            topheadHtml.push("<div id='tophead' style='display:block;overflow:hidden;font-size:15px;height:45px;'>");
            topheadHtml.push("<div id='topheadcontent' style='width:70%;float:left;padding-top:5px;'>&nbsp;&nbsp;&nbsp;&nbsp;");
            if(tabpagedatas.length == 1){
                var tabdata = tabpagedatas[0];
                topheadHtml.push("<label style='cursor:pointer'><input name='checktab' id='"+tabdata.code+"' value='"+tabdata.name+"' hidebtns='"+tabdata.hidebtns+"' type='radio' checked>&nbsp;"+tabdata.title+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>")
            }else if(tabpagedatas.length > 1){
                for(var i=0;i<tabpagedatas.length;i++) {
                    var tabdata = tabpagedatas[i];
                    var ischecked = tabdata.classname;
                    if(ischecked == "choosed"){
                        topheadHtml.push("<label style='cursor:pointer'><input name='checktab' id='"+tabdata.code+"' value='"+tabdata.name+"' hidebtns='"+tabdata.hidebtns+"' type='radio' checked>&nbsp;"+tabdata.title+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>")
                    }else{
                        topheadHtml.push("<label style='cursor:pointer'><input name='checktab' id='"+tabdata.code+"' value='"+tabdata.name+"' hidebtns='"+tabdata.hidebtns+"' type='radio'>&nbsp;"+tabdata.title+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>")
                    }
                }
            }
            topheadHtml.push("</div>");
            topheadHtml.push("</div>");
            $(".bd_main").children().first().before(topheadHtml.join(''));
            $("input[type='radio'][name='checktab']").click(function () {
                _cmp.checktabRadioClick();
            });
        }

        /**
         * radio点击触发clickTabpage
         */
        _cmp.checktabRadioClick = function(){
            var checktab = $("input[name='checktab']:checked");
            var checkcode = checktab.attr("id");
            var checkname = checktab.attr("value");
            var hidebtns = checktab.attr("hidebtns");
            var tabobj = {};
            tabobj.code = checkcode;
            tabobj.name = checkname;
            tabobj.hidebtns = hidebtns;
            _cmp.clickTabpage(tabobj);
        }

    /**
     * 点击页签.
     */
    _cmp.clickTabpage = function(obj){
        if (isFirst) {
            isfirsttab = obj.code;
            isFirst = false;
        }
        if(_isnewapply=="true"){
            newApplyHideBtns(obj.hidebtns);
        }else{
            perfcommon.changTooltoolbuttontStatus(0,obj.hidebtns+",引用指标,清空指标");
        }
        if (showtab != 1) {
            toolbutton.hidden("lastyear");
        }
        if(tabnum != 0  && _curtab != obj.code && showtab != 3){
            var num = 1;
            if (_curtab == isfirsttab){
                num = 0;
            }
            if (_viewtype != "query" && !_cmp.checkAll()) {
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
        if (_viewtype == "query") {
            $("div[compid='toolbutton']").hide();
        }
        if (_isedittotal == "1" && _curtab == "total") {
            $("div[compid='toolbutton']").hide();
        }
        _cmp.setTableColum();
    }

    /**
     * 页面初始化.
     */
    _cmp.init = function(){
        var params = {};
        params.proguid = _proguid;
        params.showtab = showtab;
        params.prolev = _prolev;
        params.frametype = frametype;
        params.procode = _procode;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid, "findAllIndex", [params], function(data) {
            tabcomps = data;
            var tempdata = tabcomps["#"+_curtab];
            datatable.setDatas(tempdata);
            setTimeout(function(){
                amtTotal(datatable);
            },100);
            Ext.lt.ui.loadingClose();
        })
    }
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
                if (_viewtype != "query"){
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
            if (_viewtype == 'query' && !config[col.colcode]  && col["name"] != "check") {
                col.style = "background-color:#f2f2f2;";
                col.oneditstart = function (table, e, l, c, d) {
                    return false;
                }
            }
        }
        if (_viewtype != 'query') {
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
                if (_viewtype == "query" || (_isedittotal == "1" && _curtab == "total")) {
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